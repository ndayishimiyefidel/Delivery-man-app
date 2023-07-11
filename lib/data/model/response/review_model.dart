class ReviewModel {
  int totalSize;
  String limit;
  String offset;
  List<Review> review;

  ReviewModel({this.totalSize, this.limit, this.offset, this.review});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review.add(Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (review != null) {
      data['review'] = review.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Review {
  int id;
  int productId;
  int customerId;
  int deliveryManId;
  int orderId;
  String comment;
  int rating;
  int status;
  String createdAt;
  String updatedAt;
  Customer customer;
  int isSaved;

  Review(
      {this.id,
        this.productId,
        this.customerId,
        this.deliveryManId,
        this.orderId,
        this.comment,
        this.rating,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.customer,
        this.isSaved,
      });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    if(json['delivery_man_id'] != null){
      deliveryManId = int.parse(json['delivery_man_id'].toString());
    }

    if(json['order_id'] != null){
      orderId = int.parse(json['order_id'].toString());
    }
    comment = json['comment'];
    rating = json['rating'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    isSaved = int.parse(json['is_saved'].toString());

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['customer_id'] = customerId;
    data['delivery_man_id'] = deliveryManId;
    data['order_id'] = orderId;
    data['comment'] = comment;
    data['rating'] = rating;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_saved'] = isSaved;
    if (customer != null) {
      data['customer'] = customer.toJson();
    }

    return data;
  }
}

class Customer {
  int id;
  String fName;
  String lName;
  String image;

  Customer(
      {this.id,
        this.fName,
        this.lName,
        this.image,
        });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['image'] = image;
    return data;
  }
}


