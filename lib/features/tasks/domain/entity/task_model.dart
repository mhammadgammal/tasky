class TaskModel {
  late String taskId;
  late String imagePath;
  late String title;
  late String description;
  late String priority;
  late String status;
  late String userId;
  late String timeStampCreatedAt;
  late String timeStampUpdatedAt;

  TaskModel(
      {required this.taskId,
      required this.title,
      required this.description,
      required this.imagePath,
      required this.priority,
      required this.status,
      required this.userId,
      required this.timeStampCreatedAt,
      required this.timeStampUpdatedAt});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      taskId: json['_id'],
      title: json['title'],
      description: json['desc'],
      imagePath: json['image'],
      priority: json['priority'],
      status: json['status'],
      userId: json['user'],
      timeStampCreatedAt: json['createdAt'],
      timeStampUpdatedAt: json['updatedAt']);

  Map<String, String> toJson() {
    return {
      "_id": taskId,
      "image": imagePath,
      "title": title,
      "desc": description,
      "priority": priority,
      "status": status,
      "user": userId,
      "createdAt": timeStampCreatedAt,
      "updatedAt": timeStampUpdatedAt,
    };
  }
}
