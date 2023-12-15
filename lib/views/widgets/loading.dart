import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: Lottie.asset('assets/images/loading(2).json',
          repeat: true, width: 150, height: 150, fit: BoxFit.cover),
    );
  }
}
