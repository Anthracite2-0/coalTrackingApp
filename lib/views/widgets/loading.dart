import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 150,
      width: 150,
      alignment: Alignment.center,
      child: Lottie.asset('assets/images/loading.json', fit: BoxFit.cover),
    );
  }
}
