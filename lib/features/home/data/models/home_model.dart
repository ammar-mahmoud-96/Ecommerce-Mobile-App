import '../../domain/entities/home_entity.dart';

/// Data model for home entity
/// Handles JSON serialization/deserialization
class HomeModel extends HomeEntity {
  const HomeModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createdAt,
  });

  /// Create a HomeModel from JSON
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// Convert HomeModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Create a HomeModel from HomeEntity
  factory HomeModel.fromEntity(HomeEntity entity) {
    return HomeModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      createdAt: entity.createdAt,
    );
  }
}
