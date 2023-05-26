abstract class TanquesEvents {}

class GetTanquesEvent extends TanquesEvents {}

class TanquesFilterEvent extends TanquesEvents {
  final int ccusto;

  TanquesFilterEvent({required this.ccusto});
}
