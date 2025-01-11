import 'package:flutter/material.dart';

class ElevatedBox extends StatelessWidget {
  final Widget child;

  const ElevatedBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
