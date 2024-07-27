class TaskDto {
  late String taskId;
  late String imagePath;
  late String title;
  late String description;
  late String priority;
  late String status;
  late String userId;
  late String timeStampCreatedAt;
  late String timeStampUpdatedAt;

  TaskDto(
      {required this.taskId,
      required this.title,
      required this.description,
      required this.imagePath,
      required this.priority,
      required this.status,
      required this.userId,
      required this.timeStampCreatedAt,
      required this.timeStampUpdatedAt});

  factory TaskDto.fromJson(Map<String, dynamic> json) => TaskDto(
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

  Map<String, String> toJsonAdd() {
    return {
      "image": imagePath,
      "title": title,
      "desc": description,
      "priority": priority,
      "status": status,
    };
  }

  Map<String, String> toJsonEdit() {
    return {
      "image": imagePath,
      "title": title,
      "desc": description,
      "priority": priority,
      "status": status,
      "user": userId,
    };
  }
}
