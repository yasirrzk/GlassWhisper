import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iGlasses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: GlassesRecommendation(),
    );
  }
}

class GlassesRecommendation extends StatefulWidget {
  @override
  _GlassesRecommendationState createState() => _GlassesRecommendationState();
}

class _GlassesRecommendationState extends State<GlassesRecommendation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _selectedFaceShape = 'Oval';
  List<String> _faceShapes = ['Oval', 'Round', 'Square', 'Heart', 'Diamond'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 8, 24, 202),
              const Color.fromARGB(232, 19, 2, 247)
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          'iGlasses',
                        ),
                        background: AnimatedBuilder(
                          animation: _controller,
                          builder: (_, child) {
                            return Transform.rotate(
                              angle: _controller.value * 2 * math.pi,
                              child: child,
                            );
                          },
                          child: Icon(Icons.visibility,
                              size: 100,
                              color: const Color.fromARGB(255, 0, 123, 255)),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Find Your Perfect Fit',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Select your face shape:',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              children: _faceShapes
                                  .map((shape) => ChoiceChip(
                                        label: Text(shape),
                                        selected: _selectedFaceShape == shape,
                                        onSelected: (selected) {
                                          setState(() {
                                            _selectedFaceShape = shape;
                                          });
                                        },
                                      ))
                                  .toList(),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              child: Text('Take a Selfie'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .amber, // Changed from primary to backgroundColor
                                foregroundColor: Colors
                                    .black, // Changed from onPrimary to foregroundColor
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                              ),
                              onPressed: () {
                                // Implement camera functionality
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return GlassesCard(index: index);
                        },
                        childCount: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Implement AR try-on functionality
        },
        label: Text('AR Try-On'),
        icon: Icon(Icons.view_in_ar),
        backgroundColor: Colors.amber,
      ),
    );
  }
}

class GlassesCard extends StatelessWidget {
  final int index;

  const GlassesCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://down-id.img.susercontent.com/file/d5e9eda885537922e1bf38a6a5dd27f7"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Model Kacamata ${index + 1}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
