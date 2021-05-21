import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FetchingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitSpinningCircle(
              color: Colors.indigo,
              size: 50.0,
            ),
            SizedBox(height: 12),
            Text(
              'Fetching Prices...',
            ),
          ],
        ),
      );
}
