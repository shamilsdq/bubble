class Entry {

		int id, date;
		String title, content;

		Entry({ this.date });

		Entry.fromMap(Map<String, dynamic> query) {
				this.id = query['id'];
				this.date = query['date'];
				this.title = query['title'];
				this.content = query['content'];
		}

		toMap() {
				if(id == null) {
						return <String, dynamic>{
								'date': date,
								'title': title,
								'content': content
						};
				}
				return <String, dynamic>{
						'id': id,
						'date': date,
						'title': title,
						'content': content
				};
		}

}