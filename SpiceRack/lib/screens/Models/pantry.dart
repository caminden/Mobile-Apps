class Pantry {
  static const COLLECTION = 'Pantry';
  static const OWNER = 'Owner';
  static const ITEMS = 'Items';
  static const QUANTITY = 'Quantity';
  static const EXPIRE = 'Expire';

  List<dynamic> items;
  List<dynamic> quantity;
  String owner;
  String docID;

  Pantry({
    this.docID,
    this.owner,
    this.items,
    this.quantity,
  }){
    this.items ??= [];
    this.quantity ??= [];

  }

  Map<String, dynamic> serialize(){
    return <String, dynamic>{
      OWNER: owner,
      ITEMS: items,
      QUANTITY: quantity,
    };
  }

  static Pantry deserialize(Map<String, dynamic> data, String doc){
    return Pantry(
      docID: doc,
      items: data[Pantry.ITEMS],
      owner: data[Pantry.OWNER],
      quantity: data[Pantry.QUANTITY],
    );
  }
}


