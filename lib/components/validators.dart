import 'package:form_field_validator/form_field_validator.dart';

final validateEmail = EmailValidator(errorText: 'enter a valid email address');
final MinLengthValidator validatePassword = MinLengthValidator(8, errorText: 'password must be at least 8 characters long');
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
