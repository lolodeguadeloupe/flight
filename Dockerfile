# Multi-stage Dockerfile for Flutter Web App
# Optimized for Coolify deployment

# Stage 1: Build Environment
FROM ghcr.io/cirruslabs/flutter:3.24.0 AS builder

# Set working directory
WORKDIR /app

# Copy pubspec files
COPY flight_compensation_app/pubspec.yaml flight_compensation_app/pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy source code
COPY flight_compensation_app/ .

# Enable web support
RUN flutter config --enable-web

# Run code generation for Freezed and JSON serialization
RUN flutter packages pub run build_runner build --delete-conflicting-outputs

# Build web app for production with environment variables
ARG SUPABASE_URL=https://flight-supabase.laurent-luce.com
ARG SUPABASE_ANON_KEY=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzdXBhYmFzZSIsImlhdCI6MTc1MzgwMjIyMCwiZXhwIjo0OTA5NDc1ODIwLCJyb2xlIjoiYW5vbiJ9.SnrtmOKddGyC-5jFGajEqZTLb8Qyz9L1IhbxsQ0AfeU

RUN flutter build web --release --web-renderer canvaskit --base-href / \
    --dart-define=FLUTTER_WEB_USE_SKIA=true \
    --dart-define=SUPABASE_URL="${SUPABASE_URL}" \
    --dart-define=SUPABASE_ANON_KEY="${SUPABASE_ANON_KEY}"

# Stage 2: Production Server
FROM nginx:alpine AS production

# Install security updates
RUN apk update && apk upgrade && apk add --no-cache bash

# Copy nginx configuration
COPY <<EOF /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name _;
    
    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Content-Security-Policy "default-src 'self' https://www.gstatic.com https://fonts.gstatic.com; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.gstatic.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; img-src 'self' data: https:; font-src 'self' data: https://fonts.gstatic.com; connect-src 'self' https://api.supabase.co https://*.supabase.co wss://*.supabase.co https://www.gstatic.com https://fonts.gstatic.com; worker-src 'self' blob:;" always;
    
    # Root directory
    root /usr/share/nginx/html;
    index index.html;
    
    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript application/wasm;
    
    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
        add_header X-Content-Type-Options nosniff;
    }
    
    # Handle Flutter web routing
    location / {
        try_files \$uri \$uri/ /index.html;
        add_header Cache-Control "no-cache, no-store, must-revalidate";
        add_header Pragma "no-cache";
        add_header Expires "0";
    }
    
    # Health check endpoint for Coolify
    location /health {
        access_log off;
        return 200 "healthy\n";
        add_header Content-Type text/plain;
    }
    
    # Deny access to sensitive files
    location ~ /\. {
        deny all;
    }
}
EOF

# Copy built web app from builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Create non-root user for security
RUN addgroup -g 1001 -S nginx && \
    adduser -S -D -H -u 1001 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx

# Set proper permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d

# Switch to non-root user
USER nginx

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/health || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]