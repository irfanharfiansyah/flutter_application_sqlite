
class Item {
  int _id;
  String _name;
  int _price;

 String get name => this._name;

 set name(String value) => this._name = value;

  get price => this._price;

 set price( value) => this._price = value;

 //konstruktor versi 1
 Item(this._name, this._price);

//konstruktor versi 2: konversi dari Map ke Item
 Item.fromMap(Map<String, dynamic> map){
   this._id = map['id'];
   this._name = map['name'];
   this._price = map['price'];
 } 

}