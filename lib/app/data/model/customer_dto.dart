class CustomerDto {
  String? id;
  String customerName;

  CustomerDto({this.id, required this.customerName});

  Map<String, dynamic> toJson() => {'id': id, 'customer_name': customerName};

  factory CustomerDto.fromJson(Map<String, dynamic> json) =>
      CustomerDto(id: json['id'], customerName: json['customer_name']);
}
