import 'package:tmdbassignment/consts/consts.dart';

Widget customTextField(context, controller,suffixOnPressed, onChanged,submit){

  return TextFormField(
    controller: controller,
    cursorColor: textDark,

    decoration: InputDecoration(
      hintText: 'TV shows, movies and more',
      hintStyle: const TextStyle(
        color: grayDark,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        height: 0.10,
      ),
      prefixIcon: const Icon(Icons.search, size: 18.9, color: textDark,),
      suffixIcon: const Icon(Icons.close_outlined,size: 30,color: textDark,).onTap(suffixOnPressed),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(30)
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(30)
      ),
    ),
        onChanged: onChanged,
        onFieldSubmitted: submit,
  );

}