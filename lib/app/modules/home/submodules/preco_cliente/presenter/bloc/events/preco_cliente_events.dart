abstract class PrecoClienteEvents {}

class GetPrecosEvent extends PrecoClienteEvents {}

class PrecoClienteFilterEvent extends PrecoClienteEvents {
  final String filtro;

  PrecoClienteFilterEvent({
    required this.filtro,
  });
}
