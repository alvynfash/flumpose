## [0.0.9]
Comprehensive update adding list builders, loading states, tooltips, badges, conditional rendering, blur effects, ink interactions, fractional translations, wrap layouts, tables, and custom layout helpers.

### Added
**List Extensions** - Quick Column/Row builders:
- `[widgets].toColumn({spacing, alignment, ...})` - Convert list to Column with spacing
- `[widgets].toRow({spacing, alignment, ...})` - Convert list to Row with spacing

**Loading Extensions** - Shimmer and skeleton effects:
- `.shimmer({baseColor, highlightColor, duration})` - Animated shimmer loading
- `.skeleton({color, borderRadius})` - Static skeleton loading

**Tooltip Extensions** - Easy tooltips:
- `.tooltip(String, {decoration, constraints, ...})` - Wrap widget in Tooltip

**Badge Extensions** - Add badges to widgets:
- `.badge({label, count, backgroundColor, ...})` - Add badge with optional count
- `.dotBadge({color, size, ...})` - Simple dot badge
- `.notificationBadge(count)` - Notification badge with count

**Conditional Extensions** - Conditional widget transformations:
- `.when(condition, transform)` - Apply transformation conditionally
- `.conditional(condition, {onTrue, onFalse})` - Different transformations based on condition
- `.loadingState({isLoading, loadingWidget})` - Show loading state
- `.errorState({hasError, errorWidget})` - Show error state
- `.emptyState({isEmpty, emptyWidget})` - Show empty state
- `.switchState({state, cases, defaultCase})` - Switch between multiple states

**Blur Extensions** - Blur and frosted glass effects:
- `.blur({sigmaX, sigmaY})` - Apply blur effect
- `.backdropBlur({sigma, overlayColor})` - Backdrop blur (frosted glass)
- `.frostedGlass({sigma, color, opacity})` - Frosted glass with overlay
- `.blurRounded({sigma, borderRadius})` - Blur with rounded corners

**Ink Extensions** - Material ink effects:
- `.inkWell({onTap, splashColor, ...})` - Wrap in InkWell
- `.ink({color, decoration, ...})` - Wrap in Ink
- `.inkTap({onTap, color, ...})` - Ink with tap handler
- `.inkDecoration({onTap, decoration, ...})` - Ink with decoration
- `.inkResponse({onTap, splashColor, ...})` - Material ink response

**Fractional Extensions** - Fractional translations and slide animations:
- `.fractionalTranslate({x, y})` - Translate by fraction of widget size
- `.fractionalTranslateX(x)`, `.fractionalTranslateY(y)` - Directional translations
- `.slideFromLeft(progress)`, `.slideFromRight(progress)` - Horizontal slides
- `.slideFromTop(progress)`, `.slideFromBottom(progress)` - Vertical slides

**Wrap Extensions** - Flexible wrapping layouts:
- `[widgets].toWrap({direction, alignment, spacing, runSpacing, ...})` - Convert list to Wrap widget
- `[widgets].toHorizontalWrap({spacing, runSpacing, alignment})` - Quick horizontal wrap
- `[widgets].toVerticalWrap({spacing, runSpacing, alignment})` - Quick vertical wrap
- `[widgets].toFlow({delegate, clipBehavior})` - Convert list to Flow with custom delegate
- `.wrap({direction, alignment, spacing, ...})` - Wrap single widget in Wrap

**Table Extensions** - Tabular layouts and list helpers:
- `[[widgets]].toTable({columnWidths, border, ...})` - Convert 2D list to Table
- `[[widgets]].toBorderedTable({borderColor, borderWidth, ...})` - Quick bordered table
- `.listTile({leading, title, subtitle, trailing, onTap, ...})` - Wrap in ListTile
- `.withDivider({height, thickness, color, ...})` - Add divider after widget
- `[widgets].withDividers({height, thickness, color, ...})` - Insert dividers between list items
- `[widgets].separated(Widget)` - Insert custom separator between list items

**Custom Layout Extensions** - Advanced layout control:
- `.layoutBuilder(builder)` - LayoutBuilder for responsive layouts
- `.customLayout({delegate})` - CustomSingleChildLayout wrapper
- `.offstage({offstage})` - Hide without removing from tree (zero-cost)
- `.overflowBox({alignment, minWidth, maxWidth, ...})` - Overflow control
- `.sizedOverflowBox({size, alignment})` - Sized overflow box
- `.limitedBox({maxWidth, maxHeight})` - Limit size in unconstrained contexts
- `.intrinsicHeight()` - IntrinsicHeight wrapper (use sparingly - expensive)
- `.intrinsicWidth({stepWidth, stepHeight})` - IntrinsicWidth wrapper (use sparingly - expensive)
- `.repaintBoundary()` - Isolate repaints for performance optimization
- `.customPaint({painter, foregroundPainter, ...})` - Custom painting
- `.physicalModel({color, elevation, shadowColor, ...})` - Elevation and shadows
- `.physicalShape({shape, color, elevation, ...})` - Custom shaped elevation
- `[widgets].toListView({scrollDirection, shrinkWrap, ...})` - Convert list to ListView
- `[widgets].toGridView({crossAxisCount, spacing, ...})` - Convert list to GridView

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