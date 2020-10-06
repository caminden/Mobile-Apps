class PhotoMemo {
  //fieldname for firestore doc
  static const COLLECTION = 'photoMemos';
  static const TITLE = 'title';
  static const MEMO = 'memo';
  static const PHOTO_URL = 'photoURL';
  static const PHOTO_PATH = 'photoPath';
  static const UPDATED_AT = 'updatedAt';
  static const CREATED_BY = 'createdBy';
  static const IMAGE_FOLDER = 'photoMemoPictures';
  static const SHARED_WITH = 'sharedWith';
  static const IMAGE_LABELS = 'imageLabels';
  static const MIN_CONFIDENCE = 0.7;

  String docId; //firestore document id
  String createdBy;
  String title;
  String memo;
  String photoPath; //firebase storage: image file name
  String photoURL; //firebase storage: image url for internet access
  DateTime updatedAt; //created or revised time
  List<dynamic> sharedWith; //list of emails
  List<dynamic> imageLabels; //list of words from ML algorithm

  PhotoMemo({
    this.docId,
    this.createdBy,
    this.title,
    this.memo,
    this.photoPath,
    this.photoURL,
    this.updatedAt,
    this.sharedWith,
    this.imageLabels,
  }){
    this.sharedWith ??= [];
    this.imageLabels ??= [];
  }

  //convert dart object to firestore document (noSQL)
  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      TITLE: title,
      CREATED_BY: createdBy,
      MEMO: memo,
      PHOTO_PATH: photoPath,
      PHOTO_URL: photoURL,
      UPDATED_AT: updatedAt,
      SHARED_WITH: sharedWith,
      IMAGE_LABELS: imageLabels,
      
    };
  }

  //convert firestore doc to dart object
  static PhotoMemo deserialize(Map<String, dynamic> data, String docId){
    return PhotoMemo(
      docId: docId,
      createdBy: data[PhotoMemo.CREATED_BY],
      title: data[PhotoMemo.TITLE],
      memo: data[PhotoMemo.MEMO],
      photoPath: data[PhotoMemo.PHOTO_PATH],
      photoURL: data[PhotoMemo.PHOTO_URL],
      updatedAt: data[PhotoMemo.UPDATED_AT] != null ? 
        DateTime.fromMillisecondsSinceEpoch(data[PhotoMemo.UPDATED_AT].millisecondsSinceEpoch) : null,
      sharedWith: data[PhotoMemo.SHARED_WITH],
      imageLabels: data[PhotoMemo.IMAGE_LABELS],
    );
  }

  @override
  String toString(){
    return '\n$docId, $createdBy, $title, $memo, \n $photoURL';
  }
}
