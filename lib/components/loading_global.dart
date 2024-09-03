import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/pages/home.dart';
import 'package:dunder_mifflin/pages/notifications.dart';
import 'package:dunder_mifflin/pages/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingGlobal extends StatefulWidget {
  const LoadingGlobal({
    super.key,
  });

  @override
  State<LoadingGlobal> createState() => _LoadingGlobalState();
}

class _LoadingGlobalState extends State<LoadingGlobal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/loader.png"),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                strokeWidth: 15,
                color: Color(0xFF002E69),
                backgroundColor: Color(0xFF6790DE),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
