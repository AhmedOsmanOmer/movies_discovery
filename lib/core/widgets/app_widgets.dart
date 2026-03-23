import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/core/utils/screen_size.dart';

InputDecoration inputDecoration(Icon icon, String label) {
  return InputDecoration(
    prefixIcon: icon,
    labelText: label,
    labelStyle: const TextStyle(color: Colors.white),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
  );
}

Widget showLoading() {
  return Padding(
    padding: const EdgeInsets.only(top: 400),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpinKitWave(
          size: 40,
          itemBuilder: (context, index) => const DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
          ),
        ),
        const Text(
          'Loading..',
          style: TextStyle(fontSize: 30, color: Colors.red),
        ),
      ],
    ),
  );
}

Widget internetError() {
  return Container(
    height: 200,
    alignment: Alignment.center,
    child: Column(
      children: [
        Icon(Icons.network_wifi_1_bar_outlined, color: Colors.red[900], size: 50),
        const SizedBox(height: 10),
        const Text('No Internet'),
      ],
    ),
  );
}

void showToast(String message, BuildContext context) {
  Fluttertoast.showToast(
    backgroundColor: Colors.red,
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    textColor: Colors.white,
    fontSize: ScreenSize(context: context).fontSize(20),
  );
}

Widget networkImage(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => SpinKitCircle(
      size: 40,
      itemBuilder: (context, index) => const DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
      ),
    ),
    errorWidget: (context, url, error) =>
        const Center(child: Text('No internet')),
    fit: BoxFit.cover,
  );
}
