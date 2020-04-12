import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget {
		@override
		Widget build(BuildContext context) {
				return Center(
						child: SpinKitDoubleBounce(
								size: 40.0,
								color: Colors.red,
								duration: Duration(seconds: 1),
						),
				);
		}
}