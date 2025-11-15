import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'change_password_model.dart';
import 'package:fire_chat/ui/widgets/button_widget.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ChangePasswordModel>(context);

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Grab bar for bottom sheet
          Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          const Text(
            "Change Password",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Current password
          TextField(
            controller: model.currentController,
            obscureText: !model.showCurrent,
            decoration: InputDecoration(
              labelText: "Current Password",
              suffixIcon: IconButton(
                icon: Icon(model.showCurrent
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: model.toggleCurrent,
              ),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 15),

          // New password
          TextField(
            controller: model.newController,
            obscureText: !model.showNew,
            decoration: InputDecoration(
              labelText: "New Password",
              suffixIcon: IconButton(
                icon:
                Icon(model.showNew ? Icons.visibility : Icons.visibility_off),
                onPressed: model.toggleNew,
              ),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 15),

          // Confirm password
          TextField(
            controller: model.confirmController,
            obscureText: !model.showConfirm,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              suffixIcon: IconButton(
                icon: Icon(
                    model.showConfirm ? Icons.visibility : Icons.visibility_off),
                onPressed: model.toggleConfirm,
              ),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 25),

          // Change Password Button using CustomButton
          CustomButton(
            buttonText: "Change Password",
            onPressed: () async {
              final validationError = model.validate();
              if (validationError != null) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(validationError)));
                return;
              }

              final error = await model.submit();
              if (error == null) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password changed successfully")));
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error)));
              }
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
