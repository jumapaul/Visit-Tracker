import 'package:flutter/material.dart';

typedef Validator = String? Function(String? value);

class InputTextFieldWidget extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final String? errorText;
  final TextInputType? inputType;
  final TextEditingController editingController;
  final int minLines;
  final VoidCallback? onTap;
  final Validator? validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const InputTextFieldWidget({
    super.key,
    required this.hintText,
    required this.editingController,
    this.labelText,
    this.inputType,
    this.errorText,
    this.minLines = 1,
    this.onTap,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      keyboardType: inputType,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: Icon(suffixIcon),
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        hintStyle: const TextStyle(fontSize: 14),
        labelStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.outline.withOpacity(.5), // Set outline color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary, // Focus color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error, // Error color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error, // Focused error color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      maxLines: 4,
      minLines: minLines,
      style: const TextStyle(fontSize: 14),
      validator: (val) {
        if (validator != null) {
          return validator!(val);
        } else if (errorText?.isNotEmpty == true) {
          return errorText;
        }
        return null;
      },
    );
  }
}

class PasswordTextFieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final String? errorText;
  final TextEditingController passwordTextEditController;

  const PasswordTextFieldWidget({
    super.key,
    required this.hintText,
    required this.passwordTextEditController,
    required this.labelText,
    this.errorText,
  });

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool showPassword = false;

  void _toggleVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !showPassword,
      controller: widget.passwordTextEditController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        errorText: widget.errorText,
        hintStyle: const TextStyle(fontSize: 14),
        labelStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () {
            _toggleVisibility();
          },
          icon:
              showPassword
                  ? const Icon(size: 15, Icons.visibility)
                  : const Icon(size: 15, Icons.visibility_off),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.outline.withOpacity(.5), // Set outline color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary, // Focus color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error, // Error color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error, // Focused error color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      style: const TextStyle(fontSize: 14),
      validator: (val) {
        if (val?.isEmpty == true) {
          return "Please input password";
        }
        return null;
      },
    );
  }
}
