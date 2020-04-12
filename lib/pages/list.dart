import 'package:bubble_diary/pages/edit.dart';
import 'package:flutter/material.dart';
import 'package:bubble_diary/services/db.dart';
import 'package:bubble_diary/models/entry.dart';
import 'package:bubble_diary/shared/loading.dart';


class EntryList extends StatefulWidget {

		final int date;
		EntryList({ this.date });

		@override
		EntryListState createState() => EntryListState();

}


class EntryListState extends State<EntryList> {

		String dateString;
		bool loading = false;

		@override
		void initState() {
			super.initState();
		}

		@override
		Widget build(BuildContext context) {

				dateString = widget.date.toString().substring(6) + " - ";
				dateString = dateString + widget.date.toString().substring(4, 6) + " - ";
				dateString = dateString + widget.date.toString().substring(0, 4);

				return Scaffold(

						appBar: AppBar(
								actions: <Widget>[
										Padding(
												padding: EdgeInsets.all(10.0),
												child: FlatButton.icon(
														icon: Icon(Icons.calendar_today, size: 14, color: light() ? Colors.black : Colors.white),
														label: Text(dateString, style: TextStyle(color: light() ? Colors.black : Colors.white)),
														onPressed: () => showCalender(),
												),
										),
								],
						),

						floatingActionButton: FloatingActionButton(
								child: Icon(Icons.add),
								onPressed: () {
										setState(() => loading = true);
										Entry entry = new Entry(date: widget.date);
										Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(entry: entry)))
													.then((value) => setState(() => loading = false));
								}
						),

						body: loading? Loading() : FutureBuilder(
								future: DBService().getEntries(widget.date),
								builder: (context, snapshot) {
										if(snapshot.connectionState == ConnectionState.waiting) {
												return Loading();
										}
										if(snapshot.hasData) {
												if(snapshot.data.length == 0) {
														return Center(child: Text("No entries", style: TextStyle(fontSize: 25.0)));
												}
												return GridView.builder(
														itemCount: snapshot.data.length,
														padding: EdgeInsets.fromLTRB(20, 35, 50, 35),
														gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 15.0, crossAxisSpacing: 15.0),
														itemBuilder: (context, index) {
																Entry entry = snapshot.data[index];
																return Card(
																		child: ListTile(
																				title: Text(
																						entry.title.length > 25 ? entry.title.substring(0,22) + "...": entry.title,
																						style: TextStyle(
																								fontSize: 20.0,
																								fontWeight: FontWeight.w500,
																								color: light() ? Color(0xff555555) : Color(0xff999999),
																						),
																				),
																				subtitle: Padding(
																						padding: EdgeInsets.only(top: 10.0),
																						child: Text(
																								entry.content.length > 25 ? entry.content.substring(0,22) + "...": entry.content,
																								style: TextStyle(
																										fontSize: 14.0,
																										color: Color(0xff777777),
																								),
																						),
																				),
																				contentPadding: EdgeInsets.all(20.0),
																				isThreeLine: true,
																				onTap: () {
																						setState(() => loading = true);
																						Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(entry: entry)))
																									.then((value) => setState(() => loading = false));
																				},
																		),
																);
														},
												);
										}
										return Center(
												child: Text("No Data", style: TextStyle(fontSize: 25.0)),
										);
								},
						),

				);
		}

		showCalender() async {
				int iyear = int.parse(widget.date.toString().substring(0,4));
				int imonth = int.parse(widget.date.toString().substring(4,6));
				int iday = int.parse(widget.date.toString().substring(6));
				DateTime result = await showDatePicker(
						context: context, 
						initialDate: DateTime(iyear, imonth, iday),
						firstDate: DateTime(2000), 
						lastDate: DateTime(2200),
				);
				if(result == null) return null;

				int date = (result.year * 10000) + (result.month * 100) + result.day;
				if(date != widget.date) {
						Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EntryList(date: date)));
				}
		}

		bool light() => (MediaQuery.platformBrightnessOf(context) == Brightness.light);

}