import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../widgets/small_button.dart';

class FullScreenQRView extends StatelessWidget {
  static const String routeName = '/fullscreenimage/';
  const FullScreenQRView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF628ec5),
        title: const Text(
          'Fullscreen mode',
          style: TextStyle(letterSpacing: 1),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Hero(
                  tag: 'qr',
                  child: PrettyQr(
                    data: '',
                    size: 300,
                    roundEdges: true,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: saveAndShareButtons(),
          ),
        ],
      ),
    );
  }

  Row saveAndShareButtons() {
    return Row(
      children: [
        Expanded(
          child: Hero(
            tag: 'b1',
            child: SmallButton(
              onPressed: () {},
              iconData: Icons.save,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Hero(
            tag: 'b2',
            child: SmallButton(
              onPressed: () {},
              iconData: Icons.share,
            ),
          ),
        ),
      ],
    );
  }
}
