#!/bin/bash

# Code Generation Script for Flutter Flight Compensation App
# Handles Freezed, JSON serialization, and other code generation tasks

set -e  # Exit on any error

echo "🔧 Flutter Code Generation Script"

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
APP_DIR="flight_compensation_app"

# Function to show usage
show_usage() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build       - Run build_runner build (one-time generation)"
    echo "  watch       - Run build_runner watch (continuous generation)"
    echo "  clean       - Clean generated files and rebuild"
    echo "  help        - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 build     # Generate code once"
    echo "  $0 watch     # Watch for changes and regenerate"
    echo "  $0 clean     # Clean and rebuild all generated code"
}

# Check if we're in the right directory
check_directory() {
    if [ ! -d "$APP_DIR" ]; then
        print_error "Flutter app directory '$APP_DIR' not found!"
        print_error "Please run this script from the project root directory."
        exit 1
    fi
    cd "$APP_DIR"
}

# Check Flutter installation
check_flutter() {
    print_status "Checking Flutter installation..."
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed or not in PATH"
        exit 1
    fi
    
    FLUTTER_VERSION=$(flutter --version | head -n 1)
    print_success "Found: $FLUTTER_VERSION"
}

# Get dependencies
get_dependencies() {
    print_status "Getting Flutter dependencies..."
    flutter pub get
    print_success "Dependencies updated"
}

# Run build_runner build
run_build() {
    print_status "Running code generation (build_runner build)..."
    print_status "This will generate:"
    print_status "  • Freezed classes (.freezed.dart files)"
    print_status "  • JSON serialization (.g.dart files)"
    print_status "  • Other generated code"
    
    flutter packages pub run build_runner build --delete-conflicting-outputs
    
    print_success "Code generation completed!"
    
    # Show generated files count
    FREEZED_COUNT=$(find . -name "*.freezed.dart" | wc -l)
    JSON_COUNT=$(find . -name "*.g.dart" | wc -l)
    
    print_status "Generated files:"
    print_status "  • $FREEZED_COUNT Freezed files"
    print_status "  • $JSON_COUNT JSON serialization files"
}

# Run build_runner watch
run_watch() {
    print_status "Starting code generation watch mode..."
    print_warning "This will run continuously. Press Ctrl+C to stop."
    print_status "Watch mode will automatically regenerate code when you:"
    print_status "  • Modify Freezed classes"
    print_status "  • Add/change JSON serializable classes"
    print_status "  • Update any annotated files"
    
    echo ""
    print_status "Starting watch mode in 3 seconds..."
    sleep 3
    
    flutter packages pub run build_runner watch
}

# Clean and rebuild
clean_rebuild() {
    print_status "Cleaning generated files and rebuilding..."
    
    # Clean Flutter
    print_status "Running flutter clean..."
    flutter clean
    
    # Remove generated files
    print_status "Removing generated files..."
    find . -name "*.g.dart" -delete 2>/dev/null || true
    find . -name "*.freezed.dart" -delete 2>/dev/null || true
    find . -name "*.gr.dart" -delete 2>/dev/null || true
    
    # Get dependencies
    get_dependencies
    
    # Run build
    run_build
    
    print_success "Clean rebuild completed!"
}

# Main script logic
main() {
    check_directory
    check_flutter
    
    case "${1:-help}" in
        "build")
            get_dependencies
            run_build
            ;;
        "watch")
            get_dependencies
            run_watch
            ;;
        "clean")
            clean_rebuild
            ;;
        "help"|*)
            show_usage
            ;;
    esac
    
    # Return to original directory
    cd ..
}

# Run main function
main "$@"