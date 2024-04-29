import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Denemap extends StatefulWidget {
  @override
  _DenemapState createState() => _DenemapState();
}

class _DenemapState extends State<Denemap> {
  @override
  void initState() {
    super.initState();
    navigateToNextPage();
  }

  void navigateToNextPage() async {
    // Wait for 2 seconds
    await Future.delayed(Duration(seconds: 2));

    // Navigate to the next page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NextPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color(0xFF1A1A3F),
          rightDotColor: const Color(0xFFEA3799),
          size: 200,
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('This is the next page'),
      ),
    );
  }
}
