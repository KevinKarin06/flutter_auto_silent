import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  SearchField({
    this.hintText,
    this.errorText,
    this.icon,
    this.function,
    this.onClear,
    this.controller,
  });
  final String hintText, errorText;
  final IconData icon;
  final Function function, onClear;
  final TextEditingController controller;

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool isTyping = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.8,
      child: TextField(
        onChanged: (String val) {
          setState(() {
            val.isNotEmpty ? isTyping = true : isTyping = false;
          });
          this.widget.function(val);
        },
        controller: this.widget.controller,
        decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 10.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[300],
            filled: true,
            hintText: this.widget.hintText,
            prefixIcon: this.widget.icon == null
                ? null
                : Icon(
                    this.widget.icon,
                  ),
            suffixIcon: isTyping
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      widget.controller.clear();
                      widget.onClear();
                      // FocusScopeNode currentFocus = FocusScope.of(context);
                      // if (!currentFocus.hasPrimaryFocus) {
                      //   currentFocus.unfocus();
                      // }
                      setState(() {
                        isTyping = false;
                      });
                    },
                  )
                : null),
      ),
    );
  }

  @override
  void dispose() {
    print('Search Field is being Disposed');
    super.dispose();
  }
}
