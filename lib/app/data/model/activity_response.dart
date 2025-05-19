class ActivityResponse {
  final String? id;
  final String? activity;
  final String? description;
  final String location;
  final String customerId;
  final String? status;
  final String createdAt;

  ActivityResponse({
    this.id,
    this.activity,
    this.description,
    required this.location,
    required this.customerId,
    this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'activity': activity,
    'description': description,
    'location': location,
    'customer_id': customerId,
    'status': status,
    'created_at': createdAt,
  };

  factory ActivityResponse.fromJson(Map<String, dynamic> json) =>
      ActivityResponse(
        id: json['id'],
        activity: json['activity'],
        description: json['description'],
        location: json['location'],
        customerId: json['customer_id'],
        status: json['status'],
        createdAt: json['created_at'],
      );
}
