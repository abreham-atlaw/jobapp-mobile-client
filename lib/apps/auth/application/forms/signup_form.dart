import 'package:jobapp/lib/forms/exceptions.dart';
import 'package:jobapp/lib/forms/field.dart';
import 'package:jobapp/lib/forms/form.dart';

class SignupForm extends Form {
  Field<String> fullName = TextField();
  Field<String> phoneNumber = TextField();
  Field<String> password = TextField();
  Field<String> confirmPassword = TextField();

  @override
  List<Field> getFields() {
    return [fullName, phoneNumber, password, confirmPassword];
  }

  @override
  Future<void> validate() async {
    await super.validate();
    if (password.getValue()! != confirmPassword.getValue()!) {
      throw ValidationException("Password Don't Match");
    }
  }
}
