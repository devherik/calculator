import 'package:flutter/material.dart';

class UtilsWidgets {
  void showMessage(String label, BuildContext context) {
    final snack = SnackBar(
      duration: const Duration(milliseconds: 800),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      content: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Widget formFieldSufix(BuildContext context, TextEditingController controller,
      String label, String sufix) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: Theme.of(context).colorScheme.inversePrimary,
      decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          counterStyle: Theme.of(context).textTheme.bodyMedium,
          suffixText: sufix,
          suffixStyle: Theme.of(context).textTheme.bodyMedium),
    );
  }

  Widget formFieldPrefix(BuildContext context, TextEditingController controller,
      String label, String prefix) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: Theme.of(context).colorScheme.inversePrimary,
      decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          counterStyle: Theme.of(context).textTheme.bodyMedium,
          prefixText: prefix,
          prefixStyle: Theme.of(context).textTheme.bodyLarge),
    );
  }

  Widget infoCard(BuildContext context, String info) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Align(
          child: Column(children: [
        const Text('Sobre'),
        Divider(
          color: Theme.of(context).colorScheme.inversePrimary,
          thickness: 0.5,
        )
      ])),
      titleTextStyle: Theme.of(context).textTheme.titleSmall,
      content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            info,
            style: Theme.of(context).textTheme.labelLarge,
          )));
}
