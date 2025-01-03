import 'package:calory/src/constants/colors.dart';
import 'package:flutter/material.dart';


class RoundTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  final Widget? rigtIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const RoundTextField({super.key, required this.hitText, required this.icon,this.controller, this.margin, this.keyboardType, this.obscureText = false , this.rigtIcon , this.onTap , this.readOnly = false, this.validator, this.onChanged});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: TColor.lightGray, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        validator: validator,
        onTap: onTap,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hitText,
            suffixIcon: rigtIcon,
            prefixIcon: Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                child: Image(image: AssetImage(icon),
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  color: TColor.gray,
                )),
            hintStyle: TextStyle(color: TColor.gray, fontSize: 12)),
      ),
    );
  }
}