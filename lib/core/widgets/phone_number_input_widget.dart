import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:tasky/core/theme/app_color.dart';

class PhoneNumberInputWidget extends StatelessWidget {
  const PhoneNumberInputWidget(
      {super.key,
      required this.phoneController,
      required this.selectorNavigator});

  final PhoneController phoneController;
  final CountrySelectorNavigator selectorNavigator;

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      controller: phoneController,
      isCountryButtonPersistent: true,
      countrySelectorNavigator: selectorNavigator,
      cursorColor: AppColor.mainColor,
      validator: _getValidator(context),
      autovalidateMode: AutovalidateMode.disabled,
      decoration: const InputDecoration(
        hintText: '123-456-7890',
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.mainColor, width: 3.0),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }

  PhoneNumberInputValidator? _getValidator(BuildContext context) {
    List<PhoneNumberInputValidator> validators = [];
    validators.add(PhoneValidator.validMobile(context));
    return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  }
}
