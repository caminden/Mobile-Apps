class Pantry {
  static const COLLECTION = 'Pantry';
  static const OWNER = 'Owner';
  static const ITEMS = 'Items';
  static const QUANTITY = 'Quantity';
  static const EXPIRE = 'Expire';

  List<dynamic> items;
  List<dynamic> quantity;
  //List<DateTime> expire;
  String owner;
  String docID;

  Pantry({
    this.docID,
    this.owner,
    this.items,
    //this.expire,
    this.quantity,
  }){
    this.items ??= [];
    this.quantity ??= [];
    //this.expire ??= [];
  }

  Map<String, dynamic> serialize(){
    return <String, dynamic>{
      OWNER: owner,
      ITEMS: items,
      QUANTITY: quantity,
      //EXPIRE: expire,
    };
  }

  static Pantry deserialize(Map<String, dynamic> data, String doc){
    return Pantry(
      docID: doc,
      items: data[Pantry.ITEMS],
      owner: data[Pantry.OWNER],
      quantity: data[Pantry.QUANTITY],
      //expire: data[Pantry.EXPIRE],
    );
  }
}


