class AgendaModel {
  final String? titulo;
  final String? descricao;
  final int? id;
  AgendaModel({
    this.titulo,
    this.descricao,
    this.id,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) {
    return AgendaModel(
      titulo: json['titulo'],
      descricao: json['descricao'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'titulo': titulo,
      'id': id,
    };
  }
}
