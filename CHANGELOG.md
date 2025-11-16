## [0.0.8]
Adds form and input extensions with chainable FormInput widget.

### Added
**Form Extensions** - Chainable form field composition:
- `FormInput()` - Chainable TextFormField wrapper (works like Text extensions)
- `.label(String)` - Add label text
- `.hint(String)` - Add hint text
- `.prefixIcon(IconData)` - Add prefix icon
- `.suffixIcon(IconData)` - Add suffix icon
- `.withValidator(validator)` - Add validator
- `.form({formKey, autovalidateMode})` - Wrap any widget in Form
- `Validators` class with common validators: `required`, `email`, `phone`, `url`, `minLength`, `maxLength`, `numberRange`, `combine`

## [0.0.7+1]
Adds comprehensive context extensions for cleaner code.

### Added
**Context Extensions** - 60+ BuildContext helpers with performance optimizations:
- Screen: `context.width`, `context.height`, `context.isMobile`, `context.isTablet`, `context.isDesktop`
- Theme: `context.primaryColor`, `context.textTheme`, `context.isDarkMode`
- Text styles: All Material 3 styles (`displayLarge`, `headlineMedium`, `bodySmall`, etc.)
- MediaQuery: Uses `sizeOf`, `paddingOf` for granular rebuilds (better performance)
- Utilities: `context.unfocus()`, `context.showSnackBar()`, `context.showBottomSheet()`
- Responsive: `context.responsiveValue<T>({mobile, tablet, desktop})`

### Changed
- Consolidated all BuildContext extensions into `context_extensions.dart`
- Moved `ResponsiveContext` from `responsive_extensions.dart` (better organization)
- Removed `Breakpoint.isMobile(context)` static methods - use `context.isMobile` instead

## [0.0.7]
Introduces a comprehensive animation system, allowing you to animate widget properties without managing controllers.

## [0.0.6+1]
Adds an MIT license to make Flumpose fully OSI-compliant and open-source friendly.

- Added an MIT License file to the repository.
- Improves visibility and compliance on pub.dev and GitHub.
- Ensures the package meets community standards for open-source distribution.

## [0.0.6]
Removes incorrect `plugin` configuration from `pubspec.yaml` to properly classify **Flumpose** as a pure Dart Flutter package.

- Fixed an issue where Flutter expected a missing Android `FlumposePlugin` class.
- Updated `pubspec.yaml` to remove the unnecessary `plugin:` block.
- Added `uses-material-design: true` for improved example compatibility.
- Cleaned up metadata and improved discoverability for pub.dev (added topics).
- This ensures a cleaner, warning-free setup and smoother installation for all users.

## [0.0.5]
Introduces the new `.styled()` extension for `Text`, optimized for performance and const-safety.

- `.styled()` enables direct, efficient text styling while minimizing allocations and supporting const usage wherever possible.
- README and example documentation have been updated to demonstrate `.styled()` usage, comparisons with previous patterns, and best practices.
- This release improves developer ergonomics by reducing unnecessary widget allocations while retaining the familiar, chainable syntax for composing widgets.

## [0.0.4]
Introduces `DecorationBuilder` and `TextStyleExtensions` for
performance improvements.

`DecorationBuilder` avoids creating multiple nested containers
when applying various decorations.

`TextStyleExtensions` optimizes text styling by accumulating
style changes instead of creating new `Text` widgets.

Adds const-optimized values for common flex, aspect ratio, and
opacity values to reduce memory allocation.

## [0.0.3]
### Changed - Performance Improvements
```dart
// ✅ No changes needed - these work the same
child.pad(16)
child.margin(8)
child.padH(20)
child.marginV(10)

// 📝 Simple rename for EdgeInsets
// Before:
child.pad(const EdgeInsets.symmetric(horizontal: 16))
// After:
child.padding(const EdgeInsets.symmetric(horizontal: 16))

// Before:
child.margin(const EdgeInsets.only(left: 8, right: 8))
// After:
child.marginAll(const EdgeInsets.only(left: 8, right: 8))
```

### Layout Extensions
- `.pad()` intelligently reuses const EdgeInsets for common values (0, 2, 4, 8, 12, 16, 20, 24, 32)
- `.margin()` intelligently reuses const EdgeInsets for common values
- All alignment methods use const Alignment values for better performance

## [0.0.1]
This is the initial release of Flumpose, a declarative widget composition library for Flutter. The package provides 100+ chainable extension methods that transform verbose, deeply-nested Flutter widget trees into clean, readable, and maintainable code.

**Key Features:**
- 🔗 Fluent, chainable API
- 📐 Comprehensive layout helpers
- 🎨 Background and decoration utilities
- 👆 Advanced gesture support
- 📱 Responsive design helpers
- ♿ Accessibility built-in
- 🧪 Fully tested with 66 tests