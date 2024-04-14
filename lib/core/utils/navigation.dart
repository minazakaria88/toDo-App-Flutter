

import 'package:flutter/material.dart';

void goTO({
  required BuildContext context,
  required Widget screen,
})
{
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => screen,)
  );
}