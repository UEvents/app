class Data {
  String uid;
  String title;
  String shortDescription;
  String description;
  String organizer;
  String address;
  String imageSrc;
  String date;
  Data(this.uid,this.title, this.description, this.organizer, this.address,
      this.shortDescription, this.imageSrc, this.date);

  Data copy() {
    return Data(this.uid, this.title, this.description, this.organizer,
        this.address, this.shortDescription, this.imageSrc, this.date);
  }

  Data.fromJson(String uid, Map<String, dynamic> data){
    uid = uid;
    title = data['title'];
    shortDescription = data['shortDescription'];
    description = data['description'];
    organizer = data['organizer'];
    address = data['address'];
    imageSrc = data['imageSrc'];
    date = data['date'];
  }

   Map<String, dynamic> toMap(){
    return {
      "title": title,
      "description": description,
      "shortDescription": shortDescription,
      "organizer": organizer,
      "uid": uid,
      "address": address,
      "imageSrc": imageSrc,
      "date": date,
    };
  }
}