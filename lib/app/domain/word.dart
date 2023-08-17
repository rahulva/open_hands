
// part 'Word.g.dart';

// @HiveType(typeId: 0)
class Word { //extends HiveObject {
  // @HiveField(0)
  int id;

  // @HiveField(1)
  String name;

  // @HiveField(2)
  int age;

  Word(this.id, this.name, this.age);

  @override
  String toString() {
    return 'Word{name: $name}';
  }
}