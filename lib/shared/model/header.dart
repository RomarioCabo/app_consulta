class Header {
  int totalElements;
  int totalPages;

  Header({
    this.totalElements,
    this.totalPages,
  });

  Header.fromJson(Map<String, dynamic> json) {
    totalElements = json.containsKey('totalElements') && json['totalElements'] != null ? int.parse(json['totalElements']) : null;
    totalPages    = json.containsKey('totalPages')    && json['totalPages']    != null ? int.parse(json['totalPages'])    : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    return data;
  }
}
