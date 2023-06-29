import 'package:flutter/material.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/widgets/containers/full_container.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/text/body.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FullContainer(
      child: PercentageContainer(
        width: 0.8,
        child: Column(
          children: [
            PercentageContainer(
              width: 0.8,
              child: Image.asset("assets/images/review.png"),
            ),
            SizedBox(
              height: SpacingConfigs.spacing2,
            ),
            Heading1(
                textAlign: TextAlign.center, "Your account is being reviewed."),
            SizedBox(
              height: SpacingConfigs.spacing2,
            ),
            BodyText(
                textAlign: TextAlign.center,
                "We need to review every application. We'll get back to you in no time.")
          ],
        ),
      ),
    ));
  }
}
