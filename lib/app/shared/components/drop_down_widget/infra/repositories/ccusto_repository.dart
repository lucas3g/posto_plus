import 'package:dio/dio.dart';
import 'package:posto_plus/app/core_module/types/my_exception.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/domain/entities/ccusto_entity.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/domain/repositories/ccusto_repository.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/infra/adapters/ccusto_adapter.dart';
import 'package:posto_plus/app/shared/components/drop_down_widget/infra/datasources/ccusto_datasource.dart';
import 'package:result_dart/result_dart.dart';

class CCustoRepository implements ICCustoRepository {
  final ICCustoDataSource dataSource;

  CCustoRepository({required this.dataSource});

  @override
  Future<Result<List<CCusto>, IMyException>> getCCustos() async {
    try {
      final result = await dataSource.getCCustos();

      final List<CCusto> ccustos = [];

      ccustos.addAll(result.map((ccusto) => CCustoAdapter.fromMap(ccusto)));

      return ccustos.toSuccess();
    } on IMyException catch (e) {
      return e.toFailure();
    } on DioError catch (e) {
      return MyException(message: e.message!).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
