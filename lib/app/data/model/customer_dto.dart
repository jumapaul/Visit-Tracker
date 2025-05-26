class CustomerDto {
  String customerName;
  String userId;

  CustomerDto({required this.customerName, required this.userId});

  Map<String, dynamic> toJson() => {'customer_name': customerName, 'user_id': userId};

  factory CustomerDto.fromJson(Map<String, dynamic> json) =>
      CustomerDto(customerName: json['customer_name'], userId: json['user_id']);
}

class CustomerResponse {
  String? id;
  String customerName;

  CustomerResponse({required this.id, required this.customerName});

  Map<String, dynamic> toJson() => {'id': id, 'customer_name': customerName};

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      CustomerResponse(id: json['id'], customerName: json['customer_name']);
}
