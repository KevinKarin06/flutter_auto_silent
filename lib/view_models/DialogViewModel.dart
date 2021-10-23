import 'package:autosilentflutter/services/DialogService.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class DialogViewModel extends BaseViewModel {
  final DialogService _dialogService = GetIt.I<DialogService>();
}
