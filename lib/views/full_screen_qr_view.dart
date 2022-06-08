import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../widgets/big_button.dart';
import '../widgets/small_button.dart';

class FullScreenQRView extends StatelessWidget {
  static const String routeName = '/fullscreenimage/';
  const FullScreenQRView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Hero(
                      tag: 'qr',
                      child: PrettyQr(
                        data: args[0],
                        size: 300,
                        roundEdges: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  args[1].toString().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: saveAndShareButtons(),
          ),
          const SizedBox(height: 15),
          const Hero(
            tag: 'warn',
            child: Text(
              'Make sure you shared it before saving it to the server.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Hero(
              tag: 'bigButton',
              child: BigButton(
                onPressed: () {},
                buttonColor: const Color(0xFF628ec5),
                text: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, letterSpacing: 1),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Row saveAndShareButtons() {
    return Row(
      children: [
        // Expanded(
        //   child: Hero(
        //     tag: 'b1',
        //     child: SmallButton(
        //       onPressed: () {},
        //       icon: Icons.save,
        //     ),
        //   ),
        // ),
        // const SizedBox(width: 10),
        // Expanded(
        //   child: Hero(
        //     tag: 'b2',
        //     child: SmallButton(
        //       onPressed: () {},
        //       iconData: Icons.share,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
