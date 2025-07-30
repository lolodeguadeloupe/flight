#!/bin/bash

# Deployment script for Flutter Flight Compensation App on Coolify
# This script helps with local testing and Coolify deployment preparation

set -e  # Exit on any error

echo "🚀 Flutter Flight Compensation App - Deployment Helper"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Configuration
DOCKER_IMAGE_NAME="flight-compensation-app"
DOCKER_TAG="latest"
CONTAINER_NAME="flight-app-container"

# Function to show usage
show_usage() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build       - Build the Flutter app and Docker image"
    echo "  test        - Run local Docker container for testing"
    echo "  stop        - Stop and remove local test container"
    echo "  clean       - Clean up Docker images and containers"
    echo "  status      - Show deployment status"
    echo "  logs        - Show container logs"
    echo "  coolify     - Show Coolify deployment instructions"
    echo "  help        - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 build     # Build app and create Docker image"
    echo "  $0 test      # Start local test container"
    echo "  $0 coolify   # Show Coolify deployment steps"
}

# Function to build the application
build_app() {
    print_status "Building Flutter application and Docker image..."
    
    # Run the build script first
    if [ -f "scripts/build.sh" ]; then
        print_status "Running Flutter build script..."
        ./scripts/build.sh
    else
        print_error "Build script not found. Please ensure scripts/build.sh exists."
        exit 1
    fi
    
    # Build Docker image
    print_status "Building Docker image: $DOCKER_IMAGE_NAME:$DOCKER_TAG"
    docker build -t "$DOCKER_IMAGE_NAME:$DOCKER_TAG" .
    
    print_success "Docker image built successfully!"
    docker images | grep "$DOCKER_IMAGE_NAME" || true
}

# Function to test locally
test_local() {
    print_status "Starting local test container..."
    
    # Stop existing container if running
    if docker ps -q -f name="$CONTAINER_NAME" | grep -q .; then
        print_warning "Stopping existing container..."
        docker stop "$CONTAINER_NAME" || true
        docker rm "$CONTAINER_NAME" || true
    fi
    
    # Start new container
    print_status "Starting container on port 8080..."
    docker run -d \
        --name "$CONTAINER_NAME" \
        --restart unless-stopped \
        -p 8080:80 \
        --env-file .env.production \
        "$DOCKER_IMAGE_NAME:$DOCKER_TAG"
    
    # Wait for container to be ready
    print_status "Waiting for container to be ready..."
    sleep 5
    
    # Check container health
    if docker ps | grep -q "$CONTAINER_NAME"; then
        print_success "Container started successfully!"
        print_status "Application available at: http://localhost:8080"
        print_status "Health check: http://localhost:8080/health"
        
        # Show container info
        echo ""
        print_status "Container information:"
        docker ps | grep "$CONTAINER_NAME"
    else
        print_error "Container failed to start!"
        print_status "Checking logs..."
        docker logs "$CONTAINER_NAME" || true
        exit 1
    fi
}

# Function to stop local test
stop_local() {
    print_status "Stopping local test container..."
    
    if docker ps -q -f name="$CONTAINER_NAME" | grep -q .; then
        docker stop "$CONTAINER_NAME"
        docker rm "$CONTAINER_NAME"
        print_success "Container stopped and removed."
    else
        print_warning "No running container found."
    fi
}

# Function to clean up Docker resources
clean_docker() {
    print_status "Cleaning up Docker resources..."
    
    # Stop and remove container
    stop_local
    
    # Remove image
    if docker images -q "$DOCKER_IMAGE_NAME" | grep -q .; then
        print_status "Removing Docker image: $DOCKER_IMAGE_NAME"
        docker rmi "$DOCKER_IMAGE_NAME:$DOCKER_TAG" || true
    fi
    
    # Clean up dangling images
    print_status "Removing dangling images..."
    docker image prune -f || true
    
    print_success "Cleanup completed."
}

# Function to show status
show_status() {
    print_status "Deployment Status:"
    echo ""
    
    # Check Docker image
    if docker images -q "$DOCKER_IMAGE_NAME" | grep -q .; then
        print_success "Docker image exists: $DOCKER_IMAGE_NAME:$DOCKER_TAG"
        docker images | grep "$DOCKER_IMAGE_NAME"
    else
        print_warning "Docker image not found. Run 'deploy.sh build' first."
    fi
    
    echo ""
    
    # Check running container
    if docker ps -q -f name="$CONTAINER_NAME" | grep -q .; then
        print_success "Container is running: $CONTAINER_NAME"
        docker ps | grep "$CONTAINER_NAME"
        echo ""
        print_status "Application URL: http://localhost:8080"
    else
        print_warning "No container running. Use 'deploy.sh test' to start local testing."
    fi
}

# Function to show logs
show_logs() {
    if docker ps -q -f name="$CONTAINER_NAME" | grep -q .; then
        print_status "Showing container logs (press Ctrl+C to exit):"
        docker logs -f "$CONTAINER_NAME"
    else
        print_warning "No running container found."
    fi
}

# Function to show Coolify deployment instructions
show_coolify_instructions() {
    print_status "Coolify Deployment Instructions:"
    echo ""
    echo "1. 📁 Push your code to a Git repository (GitHub, GitLab, etc.)"
    echo ""
    echo "2. 🔐 In Coolify, create a new service and connect your Git repository"
    echo ""
    echo "3. ⚙️  Configure the following in Coolify:"
    echo "   - Build Pack: Docker"
    echo "   - Dockerfile: Use root Dockerfile"
    echo "   - Port: 80"
    echo ""
    echo "4. 🌍 Set Environment Variables in Coolify UI:"
    echo "   - SUPABASE_URL=https://your-project-ref.supabase.co"
    echo "   - SUPABASE_ANON_KEY=your-production-anon-key"
    echo "   - FLUTTER_ENV=production"
    echo ""
    echo "5. 🚀 Deploy your application"
    echo ""
    echo "6. 🔍 Monitor deployment:"
    echo "   - Check build logs for any issues"
    echo "   - Test health endpoint: https://your-domain.com/health"
    echo "   - Verify application functionality"
    echo ""
    echo "📁 Files created for Coolify deployment:"
    echo "   ✅ Dockerfile (multi-stage build)"
    echo "   ✅ coolify.yaml (service configuration)"
    echo "   ✅ docker-compose.yml (local testing)"
    echo "   ✅ .dockerignore (build optimization)"
    echo "   ✅ .env.production (environment template)"
    echo ""
    echo "🔧 Local testing before deployment:"
    echo "   ./scripts/deploy.sh build  # Build the app"
    echo "   ./scripts/deploy.sh test   # Test locally on :8080"
    echo ""
    print_success "Ready for Coolify deployment! 🎉"
}

# Main script logic
case "${1:-help}" in
    "build")
        build_app
        ;;
    "test")
        test_local
        ;;
    "stop")
        stop_local
        ;;
    "clean")
        clean_docker
        ;;
    "status")
        show_status
        ;;
    "logs")
        show_logs
        ;;
    "coolify")
        show_coolify_instructions
        ;;
    "help"|*)
        show_usage
        ;;
esac