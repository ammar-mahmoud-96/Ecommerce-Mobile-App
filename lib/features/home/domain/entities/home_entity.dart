import 'package:equatable/equatable.dart';

/// Home entity - represents the core business object
class HomeEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  const HomeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, description, createdAt];
}
