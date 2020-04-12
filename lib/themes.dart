import 'package:flutter/material.dart';


class AppTheme {

		static final ThemeData light = ThemeData(

				backgroundColor: Colors.white,
				scaffoldBackgroundColor: Colors.white,
				primaryColor: Colors.white,
				accentColor: Colors.black,

				appBarTheme: AppBarTheme(
						elevation: 2.0,
						color: Color(0xffededed),
						textTheme: TextTheme(
								title: TextStyle(color: Color(0xff222222), fontSize: 17.0, fontWeight: FontWeight.w500),
						),
						actionsIconTheme: IconThemeData(
								size: 20.0,
								color: Color(0xff222222),
						),
				),

				textTheme: TextTheme(
						body1: TextStyle(fontSize: 15.0, color: Color(0xff222222)),
				),

				cardTheme: CardTheme(
						color: Color(0xffededed),
						margin: EdgeInsets.all(0),
						elevation: 1.0,
						shape: RoundedRectangleBorder(
								borderRadius: BorderRadius.circular(0.0),
						),
				),

				inputDecorationTheme: InputDecorationTheme(
						filled: true,
						fillColor: Colors.white,
						contentPadding: EdgeInsets.all(15.0),
						hintStyle: TextStyle(color: Color(0xff555555)),
						enabledBorder: OutlineInputBorder(
								borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
								borderRadius: BorderRadius.circular(0),
								gapPadding: 5.0,
						),
						focusedBorder: OutlineInputBorder(
								borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
								borderRadius: BorderRadius.circular(0),
								gapPadding: 5.0,
						),
				),

		);


		static final ThemeData dark = ThemeData(

				backgroundColor: Colors.black,
				scaffoldBackgroundColor: Colors.black,
				primaryColor: Colors.black,
				accentColor: Colors.white,

				appBarTheme: AppBarTheme(
						elevation: 2.0,
						color: Color(0xff121212),
						textTheme: TextTheme(
								title: TextStyle(color: Color(0xffdddddd), fontSize: 17.0, fontWeight: FontWeight.w500),
						),
						actionsIconTheme: IconThemeData(
								size: 20.0,
								color: Color(0xffdddddd),
						),
				),

				textTheme: TextTheme(
						body1: TextStyle(fontSize: 15.0, color: Color(0xffdddddd)),
				),

				cardTheme: CardTheme(
						color: Color(0xff121212),
						margin: EdgeInsets.all(0),
						elevation: 1.0,
						shape: RoundedRectangleBorder(
								borderRadius: BorderRadius.circular(0.0),
						),
				),

				inputDecorationTheme: InputDecorationTheme(
						filled: true,
						fillColor: Colors.black,
						contentPadding: EdgeInsets.all(15.0),
						hintStyle: TextStyle(color: Color(0xffbbbbbb)),
						enabledBorder: OutlineInputBorder(
								borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
								borderRadius: BorderRadius.circular(0),
								gapPadding: 5.0,
						),
						focusedBorder: OutlineInputBorder(
								borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
								borderRadius: BorderRadius.circular(0),
								gapPadding: 5.0,
						),
				),

		);

}