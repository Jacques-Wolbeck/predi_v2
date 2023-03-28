import 'package:flutter/material.dart';

class AppSnackBar {
  final String message;
  final bool isError;
  final bool isLoading;

  const AppSnackBar({
    Key? key,
    required this.message,
    this.isError = false,
    this.isLoading = false,
  });

  SnackBar snack(BuildContext context) {
    return SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 1.0,
      //behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(16.0),
      //margin: EdgeInsets.symmetric(horizontal: 16.0),
      content: Row(
        children: [
          isError
              ? Icon(
                  Icons.error,
                  size: 25.0,
                  color: Theme.of(context).colorScheme.error,
                )
              : isLoading
                  ? Icon(
                      Icons.cloud_upload,
                      size: 25.0,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    )
                  : Icon(
                      Icons.check,
                      size: 25.0,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
          const SizedBox(width: 16.0),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
