import 'package:jobapp/lib/forms/field.dart';
import 'package:jobapp/lib/forms/form.dart';

class LoginForm extends Form {
  Field<String> username = TextField();
  Field<String> password = TextField();

  @override
  List<Field> getFields() {
    return [username, password];
  }
}
