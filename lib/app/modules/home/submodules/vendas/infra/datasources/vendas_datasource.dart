abstract class IVendasDatasource {
  Future<List> getProjecao();
  Future<List> getGrafico();
  Future<List> getVendas();
}
