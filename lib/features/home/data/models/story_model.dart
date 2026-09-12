import 'package:equatable/equatable.dart';

/// Story model for home stories
class Story extends Equatable {
  final int id;
  final String name;
  final String? icon;

  const Story({required this.id, required this.name, this.icon});

  @override
  List<Object?> get props => [id, name, icon];

  /// Create a Story from JSON
  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String?,
    );
  }

  /// Convert Story to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon};
  }
}
