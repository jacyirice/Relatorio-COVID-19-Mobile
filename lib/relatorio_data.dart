class Relatorio {
  final String data;
  final int casos_novos_confirmados;
  final int obitos_novos_confirmados;
  Relatorio(
      this.data, this.casos_novos_confirmados, this.obitos_novos_confirmados);

  static Relatorio getByData(List<Relatorio> relatorios, String data) {
    return relatorios.firstWhere(
      (relatorio) => relatorio.data == data,
      orElse: () => Relatorio('', 0, 0),
    );
  }
}