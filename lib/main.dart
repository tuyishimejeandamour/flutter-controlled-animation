import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedSize Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnimatedSizeScreen(),
    );
  }
}

class AnimatedSizeScreen extends StatefulWidget {
  const AnimatedSizeScreen({super.key});

  @override
  State<AnimatedSizeScreen> createState() => _AnimatedSizeScreenState();
}

class _AnimatedSizeScreenState extends State<AnimatedSizeScreen>
    with TickerProviderStateMixin {
  
  bool _showContent = false;
  

  void _resetAnimations() {
    setState(() {
      _showContent = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedSize Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _resetAnimations,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Animations',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildExampleCard(
              title: 'Magic Box',
              description: 'Tap to show/hide content with size animation',
              child: _buildContentExpansionExample(),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildContentExpansionExample() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showContent = !_showContent;
            });
          },
          child: Text(_showContent ? 'Hide Content' : 'Show Content'),
        ),
        const SizedBox(height: 10),
        AnimatedSize(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: _showContent
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.star,
                          size: 48,
                          color: Colors.amber,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Welcome to AnimatedSize!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'This content appears with a smooth size animation. '
                          'The container grows from zero height to accommodate '
                          'all the content inside it.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ),
      ],
    );
  }
}
