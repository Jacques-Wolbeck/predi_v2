import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 30.0,
            color: Theme.of(context).colorScheme.primary,
          ),
          RichText(
            text: TextSpan(
              text: 'Pre',
              style: Theme.of(context).textTheme.headlineMedium!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Di',
                  style: Theme.of(context).textTheme.headlineMedium!.merge(
                        TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
