import 'package:flutter/material.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flumpose Examples',
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _selectedExample = 0;

  final List<ExampleSection> _examples = [
    ExampleSection(
      title: 'Overview',
      icon: Icons.home,
      builder: (context) => const OverviewExample(),
    ),
    ExampleSection(
      title: 'Layout & Spacing',
      icon: Icons.space_bar,
      builder: (context) => const LayoutExample(),
    ),
    ExampleSection(
      title: 'Background & Decoration',
      icon: Icons.color_lens,
      builder: (context) => const BackgroundExample(),
    ),
    ExampleSection(
      title: 'DecorationBuilder',
      icon: Icons.auto_awesome,
      builder: (context) => const DecorationBuilderExample(),
    ),
    ExampleSection(
      title: 'Borders & Clipping',
      icon: Icons.border_all,
      builder: (context) => const BorderExample(),
    ),
    ExampleSection(
      title: 'Transform & Animation',
      icon: Icons.transform,
      builder: (context) => const TransformExample(),
    ),
    ExampleSection(
      title: 'Gestures',
      icon: Icons.touch_app,
      builder: (context) => const GestureExample(),
    ),
    ExampleSection(
      title: 'Visibility',
      icon: Icons.visibility,
      builder: (context) => const VisibilityExample(),
    ),
    ExampleSection(
      title: 'Flex & Layouts',
      icon: Icons.view_column,
      builder: (context) => const FlexExample(),
    ),
    ExampleSection(
      title: 'Stack & Positioning',
      icon: Icons.layers,
      builder: (context) => const StackExample(),
    ),
    ExampleSection(
      title: 'Responsive',
      icon: Icons.devices,
      builder: (context) => const ResponsiveExample(),
    ),
    ExampleSection(
      title: 'Utilities',
      icon: Icons.build,
      builder: (context) => const UtilitiesExample(),
    ),
    ExampleSection(
      title: 'Performance',
      icon: Icons.speed,
      builder: (context) => const PerformanceExample(),
    ),
    ExampleSection(
      title: 'Text Styling',
      icon: Icons.text_fields,
      builder: (context) => const TextStylingExample(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flumpose Examples'), elevation: 0),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Flumpose',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Declarative Widget Composition',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ..._examples.asMap().entries.map((entry) {
              final index = entry.key;
              final example = entry.value;
              return ListTile(
                leading: Icon(example.icon),
                title: Text(example.title),
                selected: _selectedExample == index,
                onTap: () {
                  setState(() => _selectedExample = index);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
      body: _examples[_selectedExample].builder(context),
    );
  }
}

class ExampleSection {
  final String title;
  final IconData icon;
  final Widget Function(BuildContext) builder;

  ExampleSection({
    required this.title,
    required this.icon,
    required this.builder,
  });
}

// Overview Example
class OverviewExample extends StatefulWidget {
  const OverviewExample({super.key});

  @override
  State<OverviewExample> createState() => _OverviewExampleState();
}

class _OverviewExampleState extends State<OverviewExample> {
  int _counter = 0;
  bool _showBadge = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Welcome to Flumpose!'),
        _buildDescription(
          'Transform deeply nested widget trees into clean, chainable code.',
        ),
        const SizedBox(height: 24),

        // Before/After comparison
        _buildSectionTitle('Before Flumpose'),
        _buildCodeCard('''
Container(
  color: Colors.blue,
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Align(
      alignment: Alignment.center,
      child: Text('Hello World'),
    ),
  ),
)'''),
        const SizedBox(height: 16),
        _buildSectionTitle('After Flumpose'),
        _buildCodeCard('''
Text('Hello World')
  .pad(16)
  .backgroundColor(Colors.blue)
  .alignCenter()'''),
        const SizedBox(height: 24),

        // Live interactive example
        _buildSectionTitle('Interactive Demo'),
        const SizedBox(height: 16),

        // Counter with badge
        Column(
          children: [
            const Text('Tap Counter').fontSize(16).color(Colors.grey).pad(8),
            Text('$_counter')
                .fontSize(48)
                .bold()
                .color(Colors.deepPurple)
                .pad(24)
                .backgroundColor(Colors.deepPurple.shade50)
                .borderRadius(BorderRadius.circular(16))
                .elevation(4)
                .stack(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ).positionedTopRight().showIf(_showBadge),
                  ],
                )
                .onTap(
                  () => setState(() {
                    _counter++;
                    _showBadge = _counter % 2 == 0;
                  }),
                ),
          ],
        ),
        const SizedBox(height: 16),

        // Feature cards
        Row(
          children: [
            _buildFeatureCard(
              'Toggle Badge',
              Icons.visibility,
              Colors.green,
              () => setState(() => _showBadge = !_showBadge),
            ).expanded(),
            const SizedBox(width: 12),
            _buildFeatureCard(
              'Reset',
              Icons.refresh,
              Colors.orange,
              () => setState(() {
                _counter = 0;
                _showBadge = true;
              }),
            ).expanded(),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(title).fontSize(14).bold(),
          ],
        )
        .pad(16)
        .card(elevation: 2)
        .ripple(onTap, borderRadius: BorderRadius.circular(12));
  }
}

// Layout & Spacing Example
class LayoutExample extends StatelessWidget {
  const LayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Padding'),
        const Text('Padded (16)').pad(16).backgroundColor(Colors.blue.shade100),
        const SizedBox(height: 8),
        const Text('Symmetric Padding')
            .padding(const EdgeInsets.symmetric(horizontal: 40, vertical: 10))
            .backgroundColor(Colors.green.shade100),
        const SizedBox(height: 24),

        _buildSectionTitle('Margin'),
        Container(height: 50)
            .backgroundColor(Colors.red.shade100)
            .margin(20)
            .backgroundColor(Colors.grey.shade200),
        const SizedBox(height: 24),

        _buildSectionTitle('Alignment'),
        Container(
          height: 100,
          color: Colors.purple.shade50,
          child: const Text('Center').alignCenter(),
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          color: Colors.orange.shade50,
          child: const Text('Top Left').alignTopLeft(),
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          color: Colors.pink.shade50,
          child: const Text('Bottom Right').alignBottomRight(),
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('Sizing'),
        Container()
            .width(200)
            .height(100)
            .backgroundColor(Colors.teal.shade300)
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Constrained'),
        const Text('This text is constrained to max 200px width')
            .constrained(const BoxConstraints(maxWidth: 200))
            .backgroundColor(Colors.amber.shade100)
            .pad(8),
      ],
    );
  }
}

// DecorationBuilder Example
class DecorationBuilderExample extends StatelessWidget {
  const DecorationBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('DecorationBuilder - Performance Optimized'),
        _buildDescription(
          'Creates a single Container instead of multiple nested ones',
        ),
        const SizedBox(height: 16),

        _buildSectionTitle('Basic Decoration'),
        const Text('Color + Border + Radius')
            .color(Colors.white)
            .pad(16)
            .decorate(
              (d) => d
                  .color(Colors.blue)
                  .borderAll(color: Colors.white, width: 2)
                  .circular(12),
            )
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('With Shadow'),
        const Text('Shadow + Gradient + Border')
            .color(Colors.white)
            .bold()
            .pad(20)
            .decorate(
              (d) => d
                  .linearGradient(
                    colors: [Colors.purple, Colors.deepPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  .borderAll(color: Colors.purple.shade700, width: 3)
                  .circular(16)
                  .simpleShadow(blurRadius: 10, offset: const Offset(0, 4)),
            )
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Complex Decoration'),
        Container(height: 120)
            .decorate(
              (d) => d
                  .linearGradient(
                    colors: [Colors.orange, Colors.red],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                  .border(
                    Border(
                      left: BorderSide(color: Colors.yellow, width: 4),
                      right: BorderSide(color: Colors.yellow, width: 4),
                      top: BorderSide(color: Colors.orange.shade900, width: 2),
                      bottom: BorderSide(color: Colors.red.shade900, width: 2),
                    ),
                  )
                  .borderRadius(
                    const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  )
                  .shadow(
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                  )
                  .shadow(
                    const BoxShadow(
                      color: Colors.orange,
                      blurRadius: 20,
                      spreadRadius: -5,
                    ),
                  ),
            )
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Decoration + Padding (Single Container)'),
        _buildDescription('decorateWithPadding combines both in one Container'),
        const Text('Optimized!')
            .color(Colors.white)
            .bold()
            .decorateWithPadding(
              padding: const EdgeInsets.all(20),
              builder: (d) => d
                  .color(Colors.green)
                  .circular(12)
                  .simpleShadow(color: Colors.green.shade700),
            )
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Card-like Design'),
        Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Product Name',
                ).fontSize(18).bold().color(Colors.grey.shade800),
                const SizedBox(height: 8),
                const Text(
                  'A beautiful product description',
                ).fontSize(14).color(Colors.grey.shade600),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '\$99.99',
                    ).fontSize(20).bold().color(Colors.blue.shade700),
                    Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: const Text(
                            'Buy Now',
                          ).color(Colors.white).fontSize(12).bold(),
                        )
                        .decorate(
                          (d) => d
                              .color(Colors.blue)
                              .circular(20)
                              .simpleShadow(color: Colors.blue.shade700),
                        )
                        .ripple(() {}),
                  ],
                ),
              ],
            )
            .decorateWithPadding(
              padding: const EdgeInsets.all(16),
              builder: (d) => d
                  .color(Colors.white)
                  .circular(12)
                  .simpleShadow(blurRadius: 8, color: Colors.black12),
            )
            .margin(8),
        const SizedBox(height: 24),

        _buildSectionTitle('Performance Comparison'),
        _buildCodeCard('''// ❌ OLD WAY - Multiple nested Containers
Container(
  decoration: BoxDecoration(color: Colors.blue),
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: myWidget,
    ),
  ),
)

// ✅ NEW WAY - Single Container
myWidget.decorate((d) => d
  .color(Colors.blue)
  .borderAll()
  .circular(8)
)

Result: 75% fewer allocations, 33% faster builds'''),
      ],
    );
  }
}

// Background & Decoration Example
class BackgroundExample extends StatelessWidget {
  const BackgroundExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Solid Color Background'),
        const Text(
          'Blue Background',
        ).color(Colors.white).pad(16).backgroundColor(Colors.blue),
        const SizedBox(height: 24),

        _buildSectionTitle('Linear Gradient'),
        Container()
            .height(120)
            .backgroundLinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
            .borderRadius(BorderRadius.circular(12)),
        const SizedBox(height: 24),

        _buildSectionTitle('Radial Gradient'),
        Container()
            .height(120)
            .backgroundRadialGradient(
              colors: [Colors.yellow, Colors.orange, Colors.red],
              radius: 0.8,
            )
            .borderRadius(BorderRadius.circular(12)),
        const SizedBox(height: 24),

        _buildSectionTitle('Custom Decoration'),
        Container()
            .height(100)
            .decorated(
              BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
            )
            .pad(16),
      ],
    );
  }
}

// Border & Clipping Example
class BorderExample extends StatelessWidget {
  const BorderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Border'),
        Container()
            .width(200)
            .height(100)
            .backgroundColor(Colors.blue.shade50)
            .border(Border.all(color: Colors.red, width: 3))
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Border Radius (Clipped)'),
        Container()
            .width(200)
            .height(100)
            .backgroundColor(Colors.green.shade300)
            .borderRadius(BorderRadius.circular(24))
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Clip Oval'),
        Container()
            .width(120)
            .height(120)
            .backgroundColor(Colors.purple.shade300)
            .clipOval()
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Box Shadow'),
        Container()
            .width(200)
            .height(100)
            .backgroundColor(Colors.white)
            .boxShadow(
              color: Colors.blue.shade200,
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Elevation'),
        Container()
            .width(200)
            .height(100)
            .elevation(
              8,
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            )
            .alignCenter(),
      ],
    );
  }
}

// Transform & Animation Example
class TransformExample extends StatefulWidget {
  const TransformExample({super.key});

  @override
  State<TransformExample> createState() => _TransformExampleState();
}

class _TransformExampleState extends State<TransformExample> {
  bool _showFaded = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Rotate'),
        Container()
            .width(100)
            .height(100)
            .backgroundColor(Colors.blue)
            .rotate(0.3)
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Scale'),
        Container()
            .width(100)
            .height(100)
            .backgroundColor(Colors.green)
            .scaleWidget(1.5)
            .alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Translate'),
        Container(
          height: 150,
          color: Colors.grey.shade100,
          child: Container()
              .width(80)
              .height(80)
              .backgroundColor(Colors.orange)
              .translate(x: 50, y: 30),
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('Fade Animation'),
        Container()
            .width(200)
            .height(100)
            .backgroundColor(Colors.purple)
            .fade(duration: const Duration(milliseconds: 500))
            .visible(_showFaded)
            .alignCenter(),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => setState(() => _showFaded = !_showFaded),
          child: Text(_showFaded ? 'Hide' : 'Show'),
        ).alignCenter(),
      ],
    );
  }
}

// Gesture Example
class GestureExample extends StatefulWidget {
  const GestureExample({super.key});

  @override
  State<GestureExample> createState() => _GestureExampleState();
}

class _GestureExampleState extends State<GestureExample> {
  String _lastAction = 'Tap any box below';
  Offset _dragPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Last Action'),
        Text(_lastAction)
            .fontSize(16)
            .color(Colors.deepPurple)
            .pad(16)
            .backgroundColor(Colors.purple.shade50)
            .borderRadius(BorderRadius.circular(8)),
        const SizedBox(height: 24),

        _buildSectionTitle('Tap'),
        Container()
            .width(double.infinity)
            .height(80)
            .backgroundColor(Colors.blue)
            .onTap(() => setState(() => _lastAction = 'Single Tap'))
            .alignCenter()
            .child(
              const Text('Tap Me').color(Colors.white).fontSize(18).bold(),
            ),
        const SizedBox(height: 16),

        _buildSectionTitle('Double Tap'),
        Container()
            .width(double.infinity)
            .height(80)
            .backgroundColor(Colors.green)
            .onDoubleTap(() => setState(() => _lastAction = 'Double Tap'))
            .alignCenter()
            .child(
              const Text(
                'Double Tap Me',
              ).color(Colors.white).fontSize(18).bold(),
            ),
        const SizedBox(height: 16),

        _buildSectionTitle('Long Press'),
        Container()
            .width(double.infinity)
            .height(80)
            .backgroundColor(Colors.orange)
            .onLongPress(() => setState(() => _lastAction = 'Long Press'))
            .alignCenter()
            .child(
              const Text(
                'Long Press Me',
              ).color(Colors.white).fontSize(18).bold(),
            ),
        const SizedBox(height: 16),

        _buildSectionTitle('Ripple Effect'),
        Container()
            .width(double.infinity)
            .height(80)
            .backgroundColor(Colors.purple.shade100)
            .ripple(
              () => setState(() => _lastAction = 'Ripple Tap'),
              borderRadius: BorderRadius.circular(12),
            )
            .child(
              const Text(
                'Ripple Tap',
              ).color(Colors.purple).fontSize(18).bold().alignCenter(),
            ),
        const SizedBox(height: 24),

        _buildSectionTitle('Pan Gesture'),
        Container(
          height: 200,
          color: Colors.grey.shade200,
          child: Container()
              .width(60)
              .height(60)
              .backgroundColor(Colors.red)
              .translate(x: _dragPosition.dx, y: _dragPosition.dy)
              .onPan(
                onPanUpdate: (details) {
                  setState(() {
                    _dragPosition += details.delta;
                    _lastAction =
                        'Panning: (${_dragPosition.dx.toInt()}, ${_dragPosition.dy.toInt()})';
                  });
                },
              ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => setState(() {
            _dragPosition = Offset.zero;
            _lastAction = 'Reset position';
          }),
          child: const Text('Reset Position'),
        ).alignCenter(),
      ],
    );
  }
}

// Visibility Example
class VisibilityExample extends StatefulWidget {
  const VisibilityExample({super.key});

  @override
  State<VisibilityExample> createState() => _VisibilityExampleState();
}

class _VisibilityExampleState extends State<VisibilityExample> {
  bool _isVisible = true;
  double _opacity = 1.0;
  bool _ignorePointer = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Visibility Control'),
        Container()
            .width(200)
            .height(100)
            .backgroundColor(Colors.blue)
            .visible(_isVisible)
            .alignCenter(),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => setState(() => _isVisible = !_isVisible),
          child: Text(_isVisible ? 'Hide' : 'Show'),
        ).alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('Opacity: ${_opacity.toStringAsFixed(2)}'),
        Container()
            .width(200)
            .height(100)
            .backgroundColor(Colors.green)
            .opacity(_opacity)
            .alignCenter(),
        Slider(
          value: _opacity,
          onChanged: (value) => setState(() => _opacity = value),
        ).padH(16),
        const SizedBox(height: 24),

        _buildSectionTitle('Pre-defined Opacity'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container()
                .width(80)
                .height(80)
                .backgroundColor(Colors.purple)
                .child(const Text('Full').color(Colors.white).alignCenter()),
            Container()
                .width(80)
                .height(80)
                .backgroundColor(Colors.purple)
                .semiTransparent()
                .child(const Text('50%').color(Colors.white).alignCenter()),
            Container()
                .width(80)
                .height(80)
                .backgroundColor(Colors.purple)
                .mostlyTransparent()
                .child(const Text('25%').color(Colors.white).alignCenter()),
          ],
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('Ignore Pointer Events'),
        Container()
            .width(200)
            .height(80)
            .backgroundColor(
              _ignorePointer ? Colors.grey.shade300 : Colors.orange,
            )
            .ignorePointer(ignoring: _ignorePointer)
            .onTap(() {
              // This will only fire when ignorePointer is false
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tapped!'),
                  duration: Duration(seconds: 1),
                ),
              );
            })
            .alignCenter()
            .child(
              Text(
                _ignorePointer ? 'Non-interactive' : 'Tap Me',
              ).fontSize(16).alignCenter(),
            ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => setState(() => _ignorePointer = !_ignorePointer),
          child: Text(_ignorePointer ? 'Enable Interaction' : 'Disable'),
        ).alignCenter(),
      ],
    );
  }
}

// Flex & Layout Example
class FlexExample extends StatelessWidget {
  const FlexExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Expanded'),
        Row(
          children: [
            Container()
                .height(60)
                .backgroundColor(Colors.blue)
                .expanded()
                .child(const Text('Flex 1').color(Colors.white).alignCenter()),
            const SizedBox(width: 8),
            Container()
                .height(60)
                .backgroundColor(Colors.green)
                .expanded(flex: 2)
                .child(const Text('Flex 2').color(Colors.white).alignCenter()),
          ],
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('Flexible'),
        Row(
          children: [
            Container()
                .height(60)
                .backgroundColor(Colors.orange)
                .flexible()
                .child(
                  const Text('Flexible').color(Colors.white).alignCenter(),
                ),
            const SizedBox(width: 8),
            Container()
                .width(100)
                .height(60)
                .backgroundColor(Colors.purple)
                .child(const Text('Fixed').color(Colors.white).alignCenter()),
          ],
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('Aspect Ratios'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container()
                .width(80)
                .backgroundColor(Colors.red)
                .square()
                .child(const Text('1:1').color(Colors.white).alignCenter()),
            Container()
                .width(120)
                .backgroundColor(Colors.blue)
                .aspect16x9()
                .child(const Text('16:9').color(Colors.white).alignCenter()),
            Container()
                .width(100)
                .backgroundColor(Colors.green)
                .aspect4x3()
                .child(const Text('4:3').color(Colors.white).alignCenter()),
          ],
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('Fitted Box - Contain'),
        Container(
          height: 120,
          color: Colors.grey.shade200,
          child: const Icon(
            Icons.image,
            size: 200,
            color: Colors.blue,
          ).fitContain(),
        ),
        const SizedBox(height: 16),

        _buildSectionTitle('Fitted Box - Cover'),
        Container(
          height: 120,
          color: Colors.grey.shade200,
          child: const Icon(
            Icons.image,
            size: 80,
            color: Colors.green,
          ).fitCover(),
        ),
      ],
    );
  }
}

// Stack & Positioning Example
class StackExample extends StatelessWidget {
  const StackExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Positioned Corners'),
        Container(
          height: 200,
          color: Colors.grey.shade200,
          child: Container()
              .width(double.infinity)
              .height(double.infinity)
              .stack(
                children: [
                  Container()
                      .width(40)
                      .height(40)
                      .backgroundColor(Colors.red)
                      .positionedTopLeft(top: 8, left: 8),
                  Container()
                      .width(40)
                      .height(40)
                      .backgroundColor(Colors.blue)
                      .positionedTopRight(top: 8, right: 8),
                  Container()
                      .width(40)
                      .height(40)
                      .backgroundColor(Colors.green)
                      .positionedBottomLeft(bottom: 8, left: 8),
                  Container()
                      .width(40)
                      .height(40)
                      .backgroundColor(Colors.orange)
                      .positionedBottomRight(bottom: 8, right: 8),
                  const Text('Center').fontSize(20).bold().positionedCenter(),
                ],
              ),
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('Positioned Fill'),
        Container(
          height: 150,
          color: Colors.grey.shade200,
          child: Container()
              .backgroundColor(Colors.blue.withValues(alpha: 0.5))
              .positionedFill()
              .child(
                const Text(
                  'Fills entire area',
                ).color(Colors.white).fontSize(16).bold().alignCenter(),
              ),
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('Stack with Overlay'),
        Container()
            .height(150)
            .backgroundColor(Colors.purple.shade100)
            .withOverlay(
              Container()
                  .width(80)
                  .height(80)
                  .backgroundColor(Colors.purple)
                  .borderRadius(BorderRadius.circular(40))
                  .positionedCenter(),
            ),
        const SizedBox(height: 24),

        _buildSectionTitle('Badge Example'),
        Container()
            .width(120)
            .height(120)
            .backgroundColor(Colors.blue)
            .borderRadius(BorderRadius.circular(12))
            .stack(
              children: [
                Container()
                    .width(24)
                    .height(24)
                    .backgroundColor(Colors.red)
                    .borderRadius(BorderRadius.circular(12))
                    .positionedTopRight(top: -4, right: -4)
                    .child(
                      const Text(
                        '5',
                      ).color(Colors.white).fontSize(12).bold().alignCenter(),
                    ),
              ],
            )
            .alignCenter(),
      ],
    );
  }
}

// Responsive Example
class ResponsiveExample extends StatelessWidget {
  const ResponsiveExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Screen Information'),
        _buildInfoCard(
          'Screen Width',
          '${context.screenWidth.toInt()}px',
          Icons.width_full,
        ),
        _buildInfoCard(
          'Screen Height',
          '${context.screenHeight.toInt()}px',
          Icons.height,
        ),
        _buildInfoCard(
          'Device Type',
          context.isMobile
              ? 'Mobile'
              : context.isTablet
              ? 'Tablet'
              : 'Desktop',
          Icons.devices,
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('Breakpoint-based Visibility'),
        Container()
            .width(double.infinity)
            .height(80)
            .backgroundColor(Colors.blue)
            .onlyMobile()
            .child(
              const Text(
                'Mobile Only (<600dp)',
              ).color(Colors.white).fontSize(16).bold().alignCenter(),
            ),
        Container()
            .width(double.infinity)
            .height(80)
            .backgroundColor(Colors.green)
            .onlyTablet()
            .child(
              const Text(
                'Tablet Only (600-900dp)',
              ).color(Colors.white).fontSize(16).bold().alignCenter(),
            ),
        Container()
            .width(double.infinity)
            .height(80)
            .backgroundColor(Colors.orange)
            .onlyDesktop()
            .child(
              const Text(
                'Desktop Only (>=900dp)',
              ).color(Colors.white).fontSize(16).bold().alignCenter(),
            ),
        const SizedBox(height: 24),

        _buildSectionTitle('Responsive Values'),
        Container()
            .width(
              context.responsiveValue(
                mobile: 150.0,
                tablet: 200.0,
                desktop: 300.0,
              ),
            )
            .height(100)
            .backgroundColor(Colors.purple)
            .alignCenter()
            .child(
              Text(
                'Size: ${context.responsiveValue(mobile: '150', tablet: '200', desktop: '300')}',
              ).color(Colors.white).fontSize(16).alignCenter(),
            ),
        const SizedBox(height: 24),

        _buildSectionTitle('Max Width Box'),
        Container()
            .height(100)
            .backgroundColor(Colors.teal)
            .maxWidthBox(400)
            .child(
              const Text(
                'Max 400px width, centered',
              ).color(Colors.white).fontSize(16).alignCenter(),
            ),
        const SizedBox(height: 24),

        _buildSectionTitle('Responsive Padding'),
        Container()
            .height(100)
            .backgroundColor(Colors.pink.shade100)
            .responsivePadding(
              mobilePadding: 8,
              tabletPadding: 24,
              desktopPadding: 48,
            )
            .child(
              Container()
                  .width(double.infinity)
                  .height(double.infinity)
                  .backgroundColor(Colors.pink)
                  .child(
                    const Text(
                      'Adaptive padding',
                    ).color(Colors.white).fontSize(14).alignCenter(),
                  ),
            ),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 32),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label).fontSize(12).color(Colors.grey),
              Text(value).fontSize(18).bold().color(Colors.deepPurple),
            ],
          ),
        ],
      ),
    );
  }
}

// Utilities Example
class UtilitiesExample extends StatefulWidget {
  const UtilitiesExample({super.key});

  @override
  State<UtilitiesExample> createState() => _UtilitiesExampleState();
}

class _UtilitiesExampleState extends State<UtilitiesExample> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('SafeArea'),
        Container()
            .height(60)
            .backgroundColor(Colors.blue)
            .safeTop()
            .child(
              const Text(
                'Safe Top (Status Bar)',
              ).color(Colors.white).alignCenter(),
            ),
        const SizedBox(height: 24),

        _buildSectionTitle('Card'),
        const Text('This is a card')
            .fontSize(16)
            .pad(20)
            .card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
        const SizedBox(height: 24),

        _buildSectionTitle('Material with Elevation'),
        Container()
            .width(200)
            .height(100)
            .material(
              color: Colors.white,
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
            )
            .alignCenter()
            .child(const Text('Elevated Material').alignCenter()),
        const SizedBox(height: 24),

        _buildSectionTitle('Hero Animation'),
        Container()
            .width(80)
            .height(80)
            .backgroundColor(Colors.purple)
            .borderRadius(BorderRadius.circular(40))
            .hero(tag: 'example-hero')
            .alignCenter()
            .child(const Icon(Icons.star, color: Colors.white, size: 40)),
        const SizedBox(height: 8),
        const Text(
          '(Hero tag: example-hero)',
        ).fontSize(12).color(Colors.grey).alignCenter(),
        const SizedBox(height: 24),

        _buildSectionTitle('IndexedStack (Tabs)'),
        Container(
          height: 200,
          color: Colors.grey.shade200,
          child: [
            Container()
                .backgroundColor(Colors.red.shade300)
                .child(
                  const Text(
                    'Tab 1',
                  ).color(Colors.white).fontSize(24).bold().alignCenter(),
                ),
            Container()
                .backgroundColor(Colors.green.shade300)
                .child(
                  const Text(
                    'Tab 2',
                  ).color(Colors.white).fontSize(24).bold().alignCenter(),
                ),
            Container()
                .backgroundColor(Colors.blue.shade300)
                .child(
                  const Text(
                    'Tab 3',
                  ).color(Colors.white).fontSize(24).bold().alignCenter(),
                ),
          ].indexedStack(index: _selectedTab),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => setState(() => _selectedTab = 0),
              child: const Text('Tab 1'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => setState(() => _selectedTab = 1),
              child: const Text('Tab 2'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => setState(() => _selectedTab = 2),
              child: const Text('Tab 3'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('Rotated Box'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.arrow_forward, size: 40, color: Colors.blue),
            const Icon(
              Icons.arrow_forward,
              size: 40,
              color: Colors.blue,
            ).rotatedBox(1),
            const Icon(
              Icons.arrow_forward,
              size: 40,
              color: Colors.blue,
            ).rotatedBox(2),
            const Icon(
              Icons.arrow_forward,
              size: 40,
              color: Colors.blue,
            ).rotatedBox(3),
          ],
        ),
      ],
    );
  }
}

// =============================================
// Performance Example
// =============================================
class PerformanceExample extends StatefulWidget {
  const PerformanceExample({super.key});

  @override
  State<PerformanceExample> createState() => _PerformanceExampleState();
}

class _PerformanceExampleState extends State<PerformanceExample> {
  int _rebuilds = 0;

  void _triggerRebuild() {
    setState(() {
      _rebuilds++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildExplanationCard(),
        _buildPerformanceSectionTitle('✅ Const-Optimized (Recommended)'),
        _buildOptimizedExamples(),
        _buildPerformanceSectionTitle('Performance Benefits'),
        _buildBenefitsCard(),
        _buildPerformanceSectionTitle('Common Optimized Values'),
        _buildValuesCard(),
        _buildPerformanceSectionTitle('Non-Const Values'),
        _buildNonConstExamples(),
        _buildPerformanceSectionTitle('Interactive Test'),
        _buildInteractiveTest(),
      ],
    );
  }

  Widget _buildPerformanceSectionTitle(String title) {
    return Text(title).bold().fontSize(16).color(Colors.deepPurple).padV(16);
  }

  Widget _buildExplanationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.speed, color: Colors.deepPurple),
                const SizedBox(width: 8),
                const Text(
                  'Performance Optimizations',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Flumpose automatically reuses const EdgeInsets instances for common padding/margin values, significantly reducing memory allocations and improving rebuild performance.',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptimizedExamples() {
    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 1: Simple padding
            const Text(
              'Simple Padding (const-optimized)',
            ).fontSize(12).color(Colors.grey.shade700).padOnly(bottom: 8),
            Container(
              color: Colors.blue.shade100,
              child: const Text(
                'Padded with .pad(16)',
              ).pad(16), // Uses const EdgeInsets.all(16)
            ),
            const SizedBox(height: 4),
            _buildPerformanceCodeCard(
              'Text("Content").pad(16)  // ✅ const-optimized',
            ),

            const SizedBox(height: 16),

            // Example 2: Margin
            const Text(
              'Margin (const-optimized)',
            ).fontSize(12).color(Colors.grey.shade700).padOnly(bottom: 8),
            Container(
              color: Colors.orange.shade100,
              child: const Text('Margin 12')
                  .margin(12) // Uses const EdgeInsets.all(12)
                  .backgroundColor(Colors.orange.shade200),
            ),
            const SizedBox(height: 4),
            _buildPerformanceCodeCard(
              'Container().margin(12)  // ✅ const-optimized',
            ),

            const SizedBox(height: 16),

            // Example 3: Directional helpers
            const Text(
              'Directional Helpers',
            ).fontSize(12).color(Colors.grey.shade700).padOnly(bottom: 8),
            Container(
              color: Colors.purple.shade100,
              child: const Text('Horizontal & Vertical')
                  .padH(16) // Horizontal padding
                  .padV(8), // Vertical padding
            ),
            const SizedBox(height: 4),
            _buildPerformanceCodeCard(
              'Text("Content")\n  .padH(16)  // Horizontal\n  .padV(8)   // Vertical',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceCodeCard(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'monospace',
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildBenefitsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBenefitRow('📉 85%+ reduction', 'in EdgeInsets allocations'),
            const SizedBox(height: 8),
            _buildBenefitRow('⚡ 5-10% faster', 'widget rebuilds'),
            const SizedBox(height: 8),
            _buildBenefitRow('🗑️ 75% less', 'garbage collection pressure'),
            const SizedBox(height: 8),
            _buildBenefitRow('✨ Zero changes', 'works with existing code'),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitRow(String label, String description) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Text(description, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildValuesCard() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'These values automatically reuse const instances:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [0, 2, 4, 8, 12, 16, 20, 24, 32]
                  .map(
                    (val) => Chip(
                      label: Text('$val'),
                      backgroundColor: Colors.blue.shade200,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            Text(
              'Example: .pad(16) uses const EdgeInsets.all(16)',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNonConstExamples() {
    return Card(
      color: Colors.yellow.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'For non-const values, use directional helpers:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),
            _buildPerformanceCodeCard('''// Instead of creating new EdgeInsets
child.padH(15)           // Horizontal only
child.padV(25)           // Vertical only
child.padSymmetric(      // Symmetric
  horizontal: 15,
  vertical: 25,
)
child.padOnly(           // Specific sides
  left: 10,
  right: 20,
)'''),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveTest() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Rebuilds: $_rebuilds', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            const Text(
              'Tap to rebuild with const-optimized widgets',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _triggerRebuild,
              child: const Text('Trigger Rebuild'),
            ).pad(8),
            const SizedBox(height: 16),
            // These use const-optimized values
            const Text('Const-optimized padding')
                .pad(16) // Reuses const EdgeInsets.all(16)
                .backgroundColor(Colors.green.shade100)
                .margin(8), // Reuses const EdgeInsets.all(8)
          ],
        ),
      ),
    );
  }
}

// ================================
// Text Styling Example
// ================================
class TextStylingExample extends StatelessWidget {
  const TextStylingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Text Styling Comparison'),
        _buildDescription(
          'Two ways to style text: chained extensions vs. optimized .styled().',
        ),
        const SizedBox(height: 16),

        _buildSectionTitle('1. Chained Style Extensions'),
        _buildCodeCard(
          "Text('Chained')\n  .color(Colors.blue)\n  .fontSize(22)\n  .bold()\n  .italic()",
        ),
        Text('Chained').color(Colors.blue).fontSize(22).bold().italic().pad(8),
        _buildDescription(
          'Each call creates a new Text widget. Flumpose optimizes this, but each style is a new allocation.',
        ),
        const SizedBox(height: 24),

        _buildSectionTitle('2. Optimized .styled() Extension'),
        _buildCodeCard(
          "Text('Styled').styled(\n  color: Colors.blue,\n  fontSize: 22,\n  weight: FontWeight.bold,\n  style: FontStyle.italic,\n)",
        ),
        Text('Styled')
            .styled(
              color: Colors.blue,
              fontSize: 22,
              weight: FontWeight.bold,
              style: FontStyle.italic,
            )
            .pad(8),
        _buildDescription(
          'All style properties are merged in a single allocation. This is more efficient and const-safe when using compile-time constants.',
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('When to prefer .styled()'),
        _buildDescription(
          '• Use `.styled()` when setting multiple style properties at once for better performance.\n'
          '• Chaining is fine for 1-2 properties or when readability is preferred.',
        ),
      ],
    );
  }
}

// Helper widgets
Widget _buildSectionTitle(String title) {
  return Text(
    title,
  ).fontSize(20).bold().color(Colors.deepPurple).padOnly(bottom: 12, top: 8);
}

Widget _buildDescription(String text) {
  return Text(text).fontSize(14).color(Colors.grey.shade700).padOnly(bottom: 8);
}

Widget _buildCodeCard(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Colors.greenAccent,
        fontFamily: 'monospace',
        fontSize: 12,
      ),
    ),
  );
}

extension on Widget {
  Widget child(Widget child) {
    if (this is Container) {
      return Container(
        key: (this as Container).key,
        alignment: (this as Container).alignment,
        padding: (this as Container).padding,
        color: (this as Container).color,
        decoration: (this as Container).decoration,
        foregroundDecoration: (this as Container).foregroundDecoration,
        width: (this as Container).constraints?.maxWidth,
        height: (this as Container).constraints?.maxHeight,
        constraints: (this as Container).constraints,
        margin: (this as Container).margin,
        transform: (this as Container).transform,
        transformAlignment: (this as Container).transformAlignment,
        clipBehavior: (this as Container).clipBehavior,
        child: child,
      );
    }
    return this;
  }
}
