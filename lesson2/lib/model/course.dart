class Course {
  String number;
  String title;
  String prereq;
  String imageUrl;
  Course({this.imageUrl, this.number, this.title, this.prereq});
}

var courseList = [
  Course(
    number: 'CMCS 1613', 
    title : 'Programming I', 
    prereq : 'CMCS 1513',
    imageUrl: 'https://m.media-amazon.com/images/I/51AN4bkudKL._AC_UL320_.jpg',
  ),

  Course(
    number: 'CMSC 3613', 
    title: 'Data Structures',
    prereq: 'CMCS 1613',
    imageUrl: 'https://m.media-amazon.com/images/I/91-C86tJc2L._AC_UY218_.jpg',
  ),

  Course(
    number: 'SE 4283', 
    title: 'Software Engineering 1',
    prereq: 'SE 3103',
    imageUrl: 'https://m.media-amazon.com/images/I/51LBKO81FNL._AC_UY218_.jpg',
  ),

  Course(
    number: 'CMCS 4003', 
    title: 'Database',
    prereq: 'CMCS 3613',
    imageUrl: 'https://m.media-amazon.com/images/I/51yNWUwdO-L._AC_UY218_.jpg',
  ),

  Course(
    number: 'CMCS 4023', 
    title: 'Programming Languages',
    prereq: 'CMCS 3613',
    imageUrl: 'https://m.media-amazon.com/images/I/51T5KoQZqNL._AC_UY218_.jpg',
  )

];