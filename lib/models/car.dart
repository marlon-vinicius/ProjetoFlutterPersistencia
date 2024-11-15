class Car {
  final int id;
  final String modelo;
  final String marca;
  final int ano;
  final String cor;
  final String tipo_combustivel;

  Car(this.id,this.modelo, this.marca, this.ano, this.cor, this.tipo_combustivel);

  @override
  String toString() {
    return 'Car{id: $id, modelo: $modelo, marca: $marca, ano: $ano, cor: $cor, tipo_combustivel: $tipo_combustivel}';
  }
}