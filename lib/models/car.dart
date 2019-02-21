class Car {
  int id;
  String title;
  String description;
  double price;
  String imageUrl;

  Car(this.title, this.description, this.price, this.imageUrl);

  Car.withId(this.id, this.title, this.description, this.price, this.imageUrl);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    
    map["title"] = title;
    map["description"] = description;
    map["price"] = price;
    map["imageUrl"] = imageUrl;

    return map;
  }

  Car.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.price = map['price'];
    this.imageUrl = map['imageUrl'];
  }
}
