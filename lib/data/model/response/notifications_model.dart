class NotificationModel {
  int totalSize;
  String limit;
  String offset;
  List<Notifications> notifications;

  NotificationModel(
      {this.totalSize, this.limit, this.offset, this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (notifications != null) {
      data['notifications'] =
          notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int id;
  int deliveryManId;
  int orderId;
  String description;
  String createdAt;
  String updatedAt;
  Notifications(
      {this.id,
        this.deliveryManId,
        this.orderId,
        this.description,
        this.createdAt,
        this.updatedAt,
      });

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryManId = int.parse(json['delivery_man_id'].toString());
    orderId = int.parse(json['order_id'].toString());
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['delivery_man_id'] = deliveryManId;
    data['order_id'] = orderId;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}


