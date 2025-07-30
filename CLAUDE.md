# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter application for flight delay/cancellation compensation claims following Clean Architecture principles with Riverpod state management.

**Core Mission**: Simplify the complex process of claiming flight compensation under regulations like EC261 (EU), ANAC400 (Brazil), and other international air passenger rights laws.

## Architecture

### Chosen Architecture: Clean Architecture + Riverpod

**Rationale:**
- **Clean Architecture**: Clear separation of concerns, high testability
- **Riverpod**: Modern, type-safe state management excellent for complex forms
- **Feature-based structure**: Organization by business functionality

### Project Structure
```
lib/
├── core/
│   ├── constants/          # App-wide constants and configurations
│   ├── error/             # Centralized error handling and Failure classes
│   ├── network/           # HTTP client (Dio) and API configuration
│   ├── utils/             # Helper utilities and extensions
│   ├── widgets/           # Reusable UI components
│   ├── theme/             # Material 3 theme and design system
│   ├── router/            # GoRouter navigation configuration
│   └── services/          # Platform services (OCR, location, notifications)
├── features/
│   ├── auth/              # User authentication and registration
│   ├── claim_submission/  # Core claim creation and submission flow
│   ├── document_scanner/  # ML Kit document scanning and OCR
│   ├── flight_search/     # Flight lookup and validation
│   └── dashboard/         # User dashboard and claim tracking
└── shared/
    ├── data/              # Shared data models and repositories
    ├── domain/            # Shared entities and repository interfaces
    └── presentation/      # Shared UI components and providers
```

Each feature follows Clean Architecture layers:
- `data/`: Data sources, models with JSON serialization, repository implementations
- `domain/`: Business entities, repository interfaces, use cases
- `presentation/`: UI pages, widgets, Riverpod providers/notifiers

## Development Commands

### Essential Commands
```bash
# Get dependencies
flutter pub get

# Code generation (Freezed, JSON serialization)
flutter packages pub run build_runner build --delete-conflicting-outputs

# Run app in debug mode
flutter run

# Run tests
flutter test

# Run tests with coverage
flutter test --coverage

# Analyze code
flutter analyze

# Format code
dart format .

# Build release APK
flutter build apk --release

# Build release iOS
flutter build ios --release
```

### Code Generation
Since the project heavily uses Freezed and JSON serialization:
```bash
# Watch mode for development (auto-regenerates on file changes)
flutter packages pub run build_runner watch

# One-time build
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Key Dependencies

### Core Dependencies
- `flutter_riverpod`: State management and dependency injection
- `freezed` + `json_annotation`: Immutable data classes with JSON serialization
- `go_router`: Type-safe navigation with deep linking
- `dio`: HTTP client with interceptors and error handling

### Feature-Specific
- `google_ml_kit`: Document scanning and OCR for boarding passes
- `image_picker`: Camera and gallery access for document capture
- `permission_handler`: Runtime permissions management
- `flutter_secure_storage`: Secure storage for sensitive data
- `cached_network_image`: Optimized image loading and caching

### UI/UX
- Material 3 with custom theme
- `intl`: Internationalization support
- Haptic feedback and accessibility compliance

## Business Logic Core Concepts

### Compensation Calculation Rules
The app implements multiple regulatory frameworks:

1. **EC261 (European Union)**:
   - Short haul (<1500km): €250 for 3h+ delays
   - Medium haul (1500-3500km): €400 for 3h+ delays  
   - Long haul (>3500km): €600 for 4h+ delays

2. **ANAC400 (Brazil)**:
   - Domestic flights: Variable compensation based on delay duration
   - International flights: Follow destination country rules

3. **Other Jurisdictions**: USA (limited), Canada, etc.

### Key Business Entities

**Flight Entity**:
- Flight number, airline, airports (departure/arrival)
- Scheduled vs actual times for departure/arrival
- Delay reason and duration
- Compensation jurisdiction determination

**Claim Entity**:
- Status: PENDING → SUBMITTED → IN_PROGRESS → [ACCEPTED|REJECTED]
- Claim type: DELAY, CANCELLATION, DENIED_BOARDING
- Associated documents (boarding passes, receipts, correspondence)
- Calculated compensation amount

**Document Scanning**:
- Automatic boarding pass detection and cropping
- OCR extraction of flight details (number, date, airports)
- Validation against flight databases
- Support for multiple document formats

## State Management Patterns

### Riverpod Provider Organization

```dart
// Repository providers (singletons)
final flightRepositoryProvider = Provider<FlightRepository>((ref) => ...);
final claimRepositoryProvider = Provider<ClaimRepository>((ref) => ...);

// Use case providers
final calculateCompensationProvider = Provider<CalculateCompensationUseCase>((ref) => ...);
final submitClaimProvider = Provider<SubmitClaimUseCase>((ref) => ...);

// State notifiers for complex UI state
class ClaimFormNotifier extends AutoDisposeAsyncNotifier<ClaimFormState> {
  // Real-time form validation and state management
}
```

### Key Patterns:
- **Repository Pattern**: Interfaces in domain/, implementations in data/
- **Use Cases**: Single responsibility business logic operations
- **Either<Failure, Success>**: Functional error handling (no exceptions)
- **Immutable State**: All data classes using Freezed
- **Auto-dispose**: Automatic cleanup of unused providers

## Navigation Structure

### Route Organization
```dart
// Main navigation shell with persistent bottom nav
ShellRoute(
  builder: (context, state, child) => MainShell(child: child),
  routes: [
    GoRoute(path: '/home', builder: (context, state) => DashboardPage()),
    GoRoute(path: '/claims', builder: (context, state) => ClaimsListPage()),
  ],
)

// Modal/fullscreen routes
GoRoute(path: '/claim/new', builder: (context, state) => ClaimFormPage()),
GoRoute(path: '/claim/scanner', builder: (context, state) => DocumentScannerPage()),
```

### Navigation Features:
- Authentication guards
- Deep linking support
- Form state preservation during navigation
- Custom page transitions
- Type-safe route parameters

## Testing Strategy

### Test Pyramid Structure
1. **Unit Tests (70%)**: Business logic, use cases, repositories
2. **Widget Tests (20%)**: UI components, provider interactions  
3. **Integration Tests (10%)**: End-to-end user flows

### Coverage Requirements
- Minimum 90% code coverage for business logic
- All use cases must have comprehensive test coverage
- Repository implementations with mocked data sources
- UI widgets tested with Riverpod provider scopes

### Test Examples
```dart
// Use case testing
group('CalculateCompensationUseCase', () {
  test('should return €600 for EC261 long haul >4h delay', () async {
    // Arrange, Act, Assert pattern
  });
});

// Widget testing with Riverpod
testWidgets('ClaimForm validates required fields', (tester) async {
  await tester.pumpWidget(
    ProviderScope(child: MaterialApp(home: ClaimFormPage())),
  );
  // Test form validation
});
```

## UI/UX Design System

### Material 3 Theme
- Primary color: Aviation blue (#1976D2)
- Typography: Inter font family with clear hierarchy
- Components: Elevated cards, Material 3 buttons and form fields
- Dark mode support with automatic system detection

### Key UI Components
- `CustomButton`: Loading states and haptic feedback
- `FormFieldWrapper`: Consistent validation UI
- `DocumentUploadWidget`: Drag & drop with progress indicators
- `CompensationCalculator`: Real-time calculation display
- `LoadingOverlay`: Non-blocking loading states

### Accessibility Standards
- WCAG AA compliance
- Screen reader support
- High contrast mode
- Scalable text and touch targets

## Security & Privacy

### Data Protection
- Sensitive data stored in `flutter_secure_storage`
- API keys obfuscated using environment variables
- Certificate pinning for API communications
- GDPR and data privacy compliance

### Document Security
- Local document encryption
- Automatic cleanup of temporary files
- Secure upload with progress tracking
- User consent for data processing

## Performance Standards

### Benchmarks
- Cold app startup: <3 seconds
- Build time (debug): <30 seconds  
- Memory usage: <100MB normal operation
- 60fps UI performance target

### Optimization Strategies
- Image caching and optimization
- Lazy loading of features and providers
- Background sync with intelligent batching
- Battery-conscious background operations

## Development Workflow

### Code Generation Workflow
1. Make changes to Freezed models or add JSON serialization
2. Run `flutter packages pub run build_runner build --delete-conflicting-outputs`
3. Commit both source and generated files

### Feature Development Pattern
1. Create domain entities and repository interfaces
2. Implement use cases with business logic
3. Create data models and repository implementations  
4. Build Riverpod providers and state notifiers
5. Implement UI with provider integration
6. Add comprehensive tests at each layer

### Quality Gates
- All PRs require passing tests and static analysis
- Code coverage must not decrease
- Performance regression testing
- UI consistency checks with golden tests

## Common Patterns

### Error Handling
```dart
// Repository pattern with Either
Future<Either<Failure, Claim>> submitClaim(Claim claim) async {
  try {
    final result = await remoteDataSource.submitClaim(claim.toModel());
    return Right(result.toEntity());
  } on NetworkException catch (e) {
    return Left(NetworkFailure(e.message));
  }
}
```

### Form State Management
```dart
class ClaimFormNotifier extends AutoDisposeAsyncNotifier<ClaimFormState> {
  @override
  Future<ClaimFormState> build() async {
    return ClaimFormState.initial();
  }
  
  Future<void> updateFlightInfo(Flight flight) async {
    state = AsyncData(state.value!.copyWith(flight: flight));
    await _validateEligibility();
  }
}
```

## Deployment

### Mobile Release Pipeline
- Automated testing on PR
- Code signing and certificate management
- Staged rollout with feature flags
- Crash reporting with Sentry integration

### Backend Integration
- RESTful API with proper error codes
- Document upload with progress tracking
- Real-time status updates
- Background job processing for claims

---

*This application implements a comprehensive solution for flight compensation claims with focus on user experience, legal compliance, and technical excellence.*

## Supabase Architecture for FlightClaim

### 🎯 **Recommendation: Hybrid Approach**

#### **Supabase Direct + Edge Functions**
- ✅ **Supabase Client** for simple CRUD (profiles, claims, documents)
- ✅ **Edge Functions** for complex business logic (calculations, integrations)
- ✅ **Row Level Security (RLS)** for data security
- ✅ **Realtime** for real-time notifications

#### **Recommended Architecture**
```
Flutter App (Riverpod)
      ↓
┌─────────────────────────────────────┐
│     Supabase Layer                  │
│                                     │
│  ┌─────────────┐  ┌────────────────┐│
│  │   Direct    │  │ Edge Functions ││
│  │   Client    │  │   (Deno)       ││
│  │             │  │                ││
│  │ • Profiles  │  │ • Calculations ││
│  │ • Claims    │  │ • OCR Process  ││
│  │ • Documents │  │ • Email Send   ││
│  │ • Auth      │  │ • Integrations ││
│  └─────────────┘  └────────────────┘│
└─────────────────────────────────────┘
      ↓
PostgreSQL + Storage + Auth
```

This architecture allows for a rapid start with Supabase direct, progressively adding complexity via Edge Functions based on business needs.