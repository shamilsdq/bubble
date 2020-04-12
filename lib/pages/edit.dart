import 'package:flutter/material.dart';
import 'package:bubble_diary/models/entry.dart';
import 'package:bubble_diary/services/db.dart';


class Edit extends StatefulWidget {

		final Entry entry;
		Edit({ this.entry });

		@override
		EditState createState() => EditState();

}


class EditState extends State<Edit> {

		bool loading = false;
		bool editMode;
		TextEditingController titleController, contentController;

		@override
		void initState() {
				super.initState();
				if(widget.entry.id == null) {
						editMode = false;
						titleController = new TextEditingController();
						contentController = new TextEditingController();
				} else {
						editMode = true;
						titleController = new TextEditingController(text: widget.entry.title);
						contentController = new TextEditingController(text: widget.entry.content);
				}
		}

		@override
		Widget build(BuildContext context) {
				return WillPopScope(
						onWillPop: backButtonPress,
						child: Scaffold(
								appBar: AppBar(
										title: Text(editMode ? "EDIT ENTRY" : "NEW ENTRY"),
										actions: editMode? <Widget>[deleteButton()] : null,
								),
								body: Padding(
										padding: EdgeInsets.all(5.0),
										child: Column(
												mainAxisSize: MainAxisSize.max,
												mainAxisAlignment: MainAxisAlignment.start,
												children: <Widget>[
														SizedBox(height: 15.0),
														TextField(
																controller: titleController,
																decoration: InputDecoration(hintText: "Title"),
																style: TextStyle(
																		color: light() ? Colors.black : Colors.white,
																),
														),
														SizedBox(height: 10.0),
														Container(height: 2.0, width: double.infinity, color: light() ? Color(0xff555555) : Color(0xff999999)),
														SizedBox(height: 10.0),
														ConstrainedBox(
																constraints: BoxConstraints(maxHeight: 300),
																child: Scrollbar(
																		child: SingleChildScrollView(
																				scrollDirection: Axis.vertical,
																				reverse: true,
																				child: TextField(
																						controller: contentController,
																						maxLines: null,
																						decoration: InputDecoration(hintText: "Description"),
																						style: TextStyle(
																								color: light() ? Colors.black : Colors.white,
																						),
																				),
																		),
																),
														),
												],
										),
								),
						),
				);
		}

		IconButton deleteButton() {
				return IconButton(
						icon: Icon(Icons.delete),
						onPressed: () async {
								bool result = (await showDialog(
										context: context,
										builder: (context) {
												return AlertDialog(
														title: Text("Delete entry?"),
														content: Text("The data cannot be recovered once deleted"),
														elevation: 8.0,
														actions: <Widget>[
																FlatButton(
																		child: Text("Cancel"),
																		onPressed: () {
																				Navigator.of(context).pop(true);
																		},
																),
																FlatButton(
																		child: Text("Delete"),
																		color: Colors.red,
																		onPressed: () async {
																				setState(() => loading = true);
																				await DBService().delete(widget.entry);
																				Navigator.of(context).pop(true);
																				Navigator.pop(context);
																		},
																)
														],
												);
										}
								)) ?? false;
						},
				);
		}

		Future<bool> backButtonPress() async {
				if(!editMode && titleController.text == "" && contentController.text == "") return true;
				if(widget.entry.title == titleController.text && widget.entry.content == contentController.text) return true;
				return (await showDialog(
						context: context,
						builder: (context) {
								return AlertDialog(
										title: Text("Save before exiting?"),
										content: Text("Any unsaved changes cannot be recovered"),
										elevation: 8.0,
										actions: <Widget>[
												FlatButton(
														child: Text("Don't save"),
														onPressed: () => Navigator.of(context).pop(true),
												),
												FlatButton(
														child: Text("Save changes"),
														onPressed: () async {
																setState(() => loading = true);
																await save();
																Navigator.of(context).pop(true);
														},
												),
										],
								);
						}
				)) ?? false;
		}

		Future save() async {
				if(titleController.text == "") {
						return "cannot save";
				}
				widget.entry.title = titleController.text;
				widget.entry.content = contentController.text;
				if(editMode == true) {
						await DBService().update(widget.entry);
						return "saved changes";
				} else {
						await DBService().add(widget.entry);
						return "added entry";
				}
		}

		bool light() => (MediaQuery.platformBrightnessOf(context) == Brightness.light);

}