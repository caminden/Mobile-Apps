class Recipe {
  static const COLLECTION = 'Recipes';
  static const IMAGE_FOLDER = 'RecipePics';
  static const NAME = 'name';
  static const PREPTIME = 'prepTime';
  static const INGREDIENTS = 'ingredients';
  static const INSTRUCTIONS = 'instructions';
  static const PHOTOPATH = 'photoPath';
  static const PHOTOURL = 'photoUrl';
  static const OWNER = 'Owner';

  String owner;
  String name;
  String prepTime;
  String ingredients;
  String instructions;
  String photoPath;
  String photoUrl;
  String docID;

  Recipe({
    this.owner,
    this.name,
    this.prepTime,
    this.ingredients,
    this.instructions,
    this.photoPath,
    this.photoUrl,
    this.docID,
  }) {
  }

  //when called, will create a firestore doc with information for name, 
  //prep etc... in the corresponding name section, prep section etc...
  Map<String, dynamic> serialize(){
    return <String, dynamic>{
      OWNER: owner,
      NAME: name,
      PREPTIME: prepTime,
      INGREDIENTS: ingredients,
      INSTRUCTIONS: instructions,
      PHOTOPATH: photoPath,
      PHOTOURL: photoUrl,
    };
  }

  static Recipe deserialize(Map<String, dynamic> data, String doc){
    return Recipe(
      docID: doc,
      owner: data[Recipe.OWNER],
      name: data[Recipe.NAME],
      prepTime: data[Recipe.PREPTIME],
      ingredients: data[Recipe.INGREDIENTS],
      instructions: data[Recipe.INSTRUCTIONS],
      photoPath: data[Recipe.PHOTOPATH],
      photoUrl: data[Recipe.PHOTOURL],
    );
  }
}
