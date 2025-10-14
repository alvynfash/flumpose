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