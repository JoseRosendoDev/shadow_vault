import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
// ignore: must_be_immutable
class Password extends Equatable {
  @Id()
  int _id; // Campo mutable

  int get id => _id;
  set id(int value) => _id = value;

  final String title;
  final String description;
  final String password;
  final DateTime? created;

  Password({
    int id = 0,
    this.created,
    required this.description,
    required this.title,
    required this.password,
  }) : _id = id;

  @override
  List<Object?> get props => [id, title, description, password, created];
}
