import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    void ShowToast() {
      Fluttertoast.showToast(
        msg: "This is a toast notification!",
        toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
        gravity: ToastGravity.BOTTOM, // TOP, CENTER, BOTTOM
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF101922) : const Color(0xFFF6F7F8),
            ),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => ShowToast(),

                  icon: Icon(Icons.fingerprint_rounded),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
