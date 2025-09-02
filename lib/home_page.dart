import 'package:flutter/material.dart';
import 'qr_scanner_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? scannedData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFDEED0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                "assets/health.png",
                height: 300,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final currentContext = context; // ✅ capture context before await

                  final String? result = await navigator.push(
                    MaterialPageRoute(
                      builder: (ctx) => const QRScannerPage(),
                    ),
                  );

                  if (!mounted) return;

                  if (result != null) {
                    setState(() {
                      scannedData = result;
                    });

                    if (currentContext.mounted) {
                      showDialog(
                        context: currentContext,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: const Text('QR Code Scanned'),
                            content: Text('Scanned data: $result'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF203e4f),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                ),
                child: const Text(
                  "Scan QR Code",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Display scanned data if available
              if (scannedData != null) ...[
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Last Scanned:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF203e4f),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        scannedData!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
