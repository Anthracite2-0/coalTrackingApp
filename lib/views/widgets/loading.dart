import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: Lottie.asset('images/loading.json',
          width: 100, height: 100, fit: BoxFit.cover),
    );
  }
}
