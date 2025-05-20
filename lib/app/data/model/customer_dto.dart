class CustomerDto {
  String customerName;

  CustomerDto({required this.customerName});

  Map<String, dynamic> toJson() => {'customer_name': customerName};

  factory CustomerDto.fromJson(Map<String, dynamic> json) =>
      CustomerDto(customerName: json['customer_name']);
}

class CustomerResponse {
  String? id;
  String customerName;

  CustomerResponse({required this.id, required this.customerName});

  Map<String, dynamic> toJson() => {'id': id, 'customer_name': customerName};

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      CustomerResponse(id: json['id'], customerName: json['customer_name']);
}
