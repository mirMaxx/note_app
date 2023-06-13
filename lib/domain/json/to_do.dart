class ToDo {
  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  ToDo({this.completed, this.id, this.title, this.userId});
  // определение фабричного конструктора
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      completed: json['completed'],
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
    );
  }
}
