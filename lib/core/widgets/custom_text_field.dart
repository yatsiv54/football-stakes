import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final bool enabled;
  final String? prefixText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextAlign textAlign;

  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.maxLength,
    this.enabled = true,
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: MyColors.grey2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isFocused ? MyColors.yellow : MyColors.grey4,
          width: 1,
        ),
      ),
      child: Center(
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          obscureText: widget.obscureText,
          textAlign: widget.textAlign,
          style: MyStyles.body,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: MyStyles.body.copyWith(
              color: Colors.white.withValues(alpha: 0.6),
            ),
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            prefixStyle: TextStyle(color: Colors.white, fontSize: 16),
            suffixStyle: TextStyle(color: Colors.white, fontSize: 16),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            counterText: '',
          ),
        ),
      ),
    );
  }
}
