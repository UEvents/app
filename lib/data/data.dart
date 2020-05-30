class Data {
  String uid;
  String title;
  String shortDescription;
  String description;
  String organizer;
  String address;
  String imageSrc = "https://p2.zoon.ru/preview/RPCJpDRsfbksTfEgjTis7Q/884x440x85/1/8/c/original_5a3bd437a24fd9578d27e593_5b05cb44823f9.jpg";

  Data(this.uid, this.title, this.description, this.organizer, this.address,
      this.shortDescription);

  Data copy() {
    return Data(this.uid, this.title, this.description, this.organizer,
        this.address, this.shortDescription);
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "shortDescription": shortDescription,
      "organizer": organizer,
      "uid": uid,
      "address": address,
    };
  }
}
