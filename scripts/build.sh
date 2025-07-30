#!/bin/bash

# Build script for Flutter Flight Compensation App
# This script prepares the app for production deployment

set -e  # Exit on any error

echo "🚀 Starting Flutter Web Build Process..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
APP_DIR="flight_compensation_app"
BUILD_DIR="build/web"
ENV_FILE=".env.production"

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

# Check if we're in the right directory
if [ ! -d "$APP_DIR" ]; then
    print_error "Flutter app directory '$APP_DIR' not found!"
    print_error "Please run this script from the project root directory."
    exit 1
fi

cd "$APP_DIR"

# Check Flutter installation
print_status "Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

FLUTTER_VERSION=$(flutter --version | head -n 1)
print_success "Found: $FLUTTER_VERSION"

# Check if web is enabled
print_status "Enabling Flutter web support..."
flutter config --enable-web

# Clean previous builds
print_status "Cleaning previous builds..."
flutter clean

# Get dependencies
print_status "Getting Flutter dependencies..."
flutter pub get

# Run code generation for Freezed and JSON serialization
print_status "Running code generation (Freezed, JSON serialization)..."
flutter packages pub run build_runner build --delete-conflicting-outputs

# Run static analysis
print_status "Running Flutter analysis..."
if ! flutter analyze; then
    print_warning "Static analysis found issues. Continuing with build..."
fi

# Run tests (optional - comment out if tests are not ready)
print_status "Running tests..."
if flutter test --coverage; then
    print_success "All tests passed!"
else
    print_warning "Some tests failed. Check test results."
fi

# Load environment variables if the file exists
if [ -f "../$ENV_FILE" ]; then
    print_status "Loading production environment variables..."
    export $(cat "../$ENV_FILE" | xargs)
    print_success "Environment variables loaded from $ENV_FILE"
else
    print_warning "No $ENV_FILE file found. Using default build configuration."
fi

# Build for web with optimizations
print_status "Building Flutter web app for production..."
flutter build web \
    --release \
    --web-renderer canvaskit \
    --dart-define=FLUTTER_WEB_USE_SKIA=true \
    --dart-define=FLUTTER_WEB_AUTO_DETECT=false \
    --tree-shake-icons \
    --split-debug-info=build/debug_symbols \
    --obfuscate

# Check if build was successful
if [ -d "$BUILD_DIR" ]; then
    print_success "Flutter web build completed successfully!"
    
    # Show build information
    BUILD_SIZE=$(du -sh "$BUILD_DIR" | cut -f1)
    print_status "Build size: $BUILD_SIZE"
    
    # List main build artifacts
    print_status "Build artifacts:"
    ls -la "$BUILD_DIR"
    
    # Check for important files
    if [ -f "$BUILD_DIR/index.html" ]; then
        print_success "index.html created"
    else
        print_error "index.html not found in build output"
    fi
    
    if [ -d "$BUILD_DIR/assets" ]; then
        print_success "Assets directory created"
    else
        print_error "Assets directory not found in build output"
    fi
    
else
    print_error "Build failed! Build directory not found."
    exit 1
fi

# Return to original directory
cd ..

print_success "🎉 Build process completed successfully!"
print_status "Ready for Docker containerization and Coolify deployment."

echo ""
echo "Next steps:"
echo "1. Test locally: docker-compose up --build"
echo "2. Deploy to Coolify using the provided configuration"
echo "3. Configure your production Supabase credentials in Coolify UI"