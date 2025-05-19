class AddActivityDto {
  final String activity;
  final String? description;
  final String location;
  final String customerId;
  final String? status;
  final String createdAt;

  AddActivityDto({
    required this.activity,
    this.description,
    required this.location,
    required this.customerId,
    this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'activity': activity,
    'description': description,
    'location': location,
    'customer_id': customerId,
    'status': status,
    'created_at': createdAt,
  };

  factory AddActivityDto.fromJson(Map<String, dynamic> json) => AddActivityDto(
    activity: json['activity'],
    description: json['description'],
    location: json['location'],
    customerId: json['customer_id'],
    status: json['status'],
    createdAt: json['created_at'],
  );
}
