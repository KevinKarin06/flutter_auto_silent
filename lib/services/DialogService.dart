import 'package:autosilentflutter/widgets/AddLocationDialog.dart';
import 'package:dialog_context/dialog_context.dart';

class DialogService {
  void addLocationDialog() {
    DialogContext().showDialog(builder: (context) => AddLocationDialog());
  }

  void deleteDialog() {}
}
