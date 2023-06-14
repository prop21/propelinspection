import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:InventoryWise/utils/app_theme.dart';
import 'package:InventoryWise/widgets/custom_button.dart';

import 'box_button.dart';

enum DialogType { success, failure, alert }

class ConfirmationDialog extends StatelessWidget {
  ConfirmationDialog({
    Key? key,
    required this.body,
    this.heading = "Confirmation",
    this.isCancelPressed,
    this.isConfirmPressed,
    required this.confirmButtonText,
    required this.cancelButtonText,
  }) : super(key: key);
  final String body;
  final String? heading;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback? isConfirmPressed;
  final VoidCallback? isCancelPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      heading!, //== null ? "confirmation".tr : heading,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.grey,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  body,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 16),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        height: 50,
                        color: Colors.black,
                        text: cancelButtonText,
                        onTap: isCancelPressed ??
                            () {
                              Get.back();
                            }),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Expanded(
                    child: CustomButton(
                      height: 50,
                      color: Colors.red,
                      text: confirmButtonText,
                      onTap: isConfirmPressed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmationDialogWithBoldText extends StatelessWidget {
  const ConfirmationDialogWithBoldText(
      {Key? key,
      required this.message01,
      required this.messageBold,
      required this.message03,
      this.heading,
      this.isOkPressed})
      : super(key: key);
  final String message01;
  final String messageBold;
  final String message03;
  final String? heading;
  final VoidCallback? isOkPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: const EdgeInsets.all(30),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 14.0,
            right: 14.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Text(
                  heading == null ? "confirmation".tr : heading!,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          message01,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          messageBold,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          message03,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: BoxButton(
                        isInverted: true,
                        // color: AppTheme.lightGreyColor,
                        title: 'no'.tr,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        }),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Expanded(
                    child: BoxButton(
                      // color: AppTheme.primaryColor,
                      title: 'yes'.tr,
                      onPressed: isOkPressed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenericAppDialog extends StatelessWidget {
  const GenericAppDialog(
      {Key? key, required this.message, this.isBlocked = false})
      : super(key: key);
  final String? message;
  final bool isBlocked;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        insetPadding: const EdgeInsets.all(30),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topCenter,
          // overflow: Overflow.visible,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 27),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ]),
              padding: const EdgeInsets.only(
                top: 40.0,
                left: 14.0,
                right: 14.0,
                bottom: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Error',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                  ),
                  // SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      message!,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  BoxButton(
                      // color: AppTheme.primaryColor,
                      title: 'ok'.tr,
                      onPressed: () {
                        if (isBlocked) {
                          // navigate to playstore
                          return;
                        }
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 55.0,
                height: 55.0,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 4.0, color: Colors.white),
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor,
                ),
                child: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),

                //     Image.asset(
                //   'assets/icons/cancel.png',
                //   // height: 50.0,
                //   color: Colors.white,
                //   fit: BoxFit.contain,
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputDialog extends StatelessWidget {
  InputDialog({Key? key, required this.message}) : super(key: key);
  final String message;
  final TextEditingController _controller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        insetPadding: EdgeInsets.all(30),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          child: Stack(
            alignment: Alignment.topCenter,
            // overflow: Overflow.visible,
            children: [
              Container(
                margin: EdgeInsets.only(top: 27),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ]),
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 24.0,
                  right: 24.0,
                  bottom: 20.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        message,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 26),
                      ),
                    ),
                    // SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Form(
                        key: formkey,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "required".tr;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    BoxButton(
                        color: AppTheme.primaryColor,
                        title: 'ok'.tr,
                        onPressed: () {
                          if (!formkey.currentState!.validate()) {
                            return null;
                          }
                          Navigator.of(context).pop(_controller.text);
                        }),
                  ],
                ),
              ),
              Container(
                width: 55.0,
                height: 55.0,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 4.0, color: Colors.white),
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor,
                ),
                child: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                //     Image.asset(
                //   'assets/icons/cancel.png',
                //   // height: 50.0,
                //   color: Colors.white,
                //   fit: BoxFit.contain,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String message;
  final DialogType type;
  final Function? onTapRoute;
  final String dialogHeading;

  const SuccessDialog(
      {Key? key,
      required this.message,
      required this.type,
      this.onTapRoute,
      this.dialogHeading = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        insetPadding: EdgeInsets.all(30),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          child: Stack(
            alignment: Alignment.topCenter,
            // overflow: Overflow.visible,
            children: [
              Container(
                margin: EdgeInsets.only(top: 27),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ]),
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 14.0,
                  right: 14.0,
                  bottom: 20.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        type == DialogType.success && dialogHeading != ''
                            ? dialogHeading
                            : type == DialogType.success
                                ? 'success'.tr
                                : 'alert'.tr,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    // SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        message,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    BoxButton(
                      color: type == DialogType.success
                          ? Colors.green
                          : type == DialogType.failure
                              ? AppTheme.primaryColor
                              : HexColor('#f1c40f'),
                      title: 'ok'.tr,
                      onPressed: onTapRoute as dynamic Function()?,
                    ),
                  ],
                ),
              ),
              Container(
                width: 55.0,
                height: 55.0,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 4.0, color: Colors.white),
                  shape: BoxShape.circle,
                  color: type == DialogType.success
                      ? Colors.green
                      : type == DialogType.failure
                          ? AppTheme.primaryColor
                          : HexColor('#f1c40f'),
                ),
                child: Icon(
                  type == DialogType.success
                      ? Icons.thumb_up
                      : type == DialogType.failure
                          ? Icons.cancel
                          : Icons.warning_amber_rounded,
                  color: Colors.white,
                ),

                //     Image.asset(
                //   type == DialogType.success
                //       ? 'assets/icons/like.png'
                //       : type == DialogType.failure
                //           ? 'assets/icons/cancel.png'
                //           : 'assets/icons/alert.png',
                //   // height: 50.0,
                //   color: Colors.white,
                //   fit: BoxFit.contain,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddAccountDialog extends StatelessWidget {
  const AddAccountDialog({Key? key, required this.message, this.onPressed})
      : super(key: key);
  final String message;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: EdgeInsets.all(30),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              left: 15.0,
              right: 15.0,
              bottom: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "addAccount".tr,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.06,
                ),
                Row(
                  children: [
                    Expanded(
                      child: BoxButton(
                          color: AppTheme.caveGreyColor,
                          title: 'cancel'.tr,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Expanded(
                      child: BoxButton(
                        color: AppTheme.primaryColor,
                        title: 'ok'.tr,
                        onPressed: onPressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  final String? message;
  final cancelOnPressed;
  final okOnPressed;

  const DeleteDialog({this.message, this.cancelOnPressed, this.okOnPressed});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        insetPadding: EdgeInsets.all(30),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          child: Stack(
            alignment: Alignment.topCenter,
            // overflow: Overflow.visible,
            children: [
              Container(
                margin: EdgeInsets.only(top: 27),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ]),
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 24.0,
                  right: 24.0,
                  bottom: 20.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "delete".tr,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 26),
                      ),
                    ),
                    // SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        message!,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BoxButton(
                            color: AppTheme.caveGreyColor,
                            title: 'cancel'.tr,
                            onPressed: cancelOnPressed,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        Expanded(
                          child: BoxButton(
                            color: AppTheme.primaryColor,
                            title: 'yes'.tr,
                            onPressed: okOnPressed,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 55.0,
                height: 55.0,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 4.0, color: Colors.white),
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor),
                child: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),

                // Image.asset(
                //   'assets/icons/cancel.png',
                //   // height: 50.0,
                //   color: Colors.white,
                //   fit: BoxFit.contain,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class PasswordDialog extends StatelessWidget {
//   final String message;
//   final cancelOnPressed;
//   final okOnPressed;
//   final passwordValidator;
//   final passwordController;
//   final GlobalKey<FormState> formKey;
//   final key;

//   const PasswordDialog(
//       {this.message,
//       this.cancelOnPressed,
//       this.okOnPressed,
//       this.passwordController,
//       this.passwordValidator,
//       this.formKey,
//       this.key});

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Future.value(false),
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         insetPadding: EdgeInsets.all(30),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
//           child: Form(
//             key: key,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Text(
//                     "verifyPassword".tr,
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                 ),
//                 // SizedBox(height: 16.0),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 15.0),
//                   child: Text(
//                     message,
//                     style: Theme.of(context).textTheme.bodyText1,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Form(
//                   key: formKey,
//                   child: PasswordWidget(
//                     title: 'password'.tr,
//                     prefixImageIconPath: 'assets/icons/password.png',
//                     hintValue: 'password'.tr,
//                     validator: passwordValidator,
//                     controller: passwordController,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(12.0),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: BoxButton(
//                         color: AppTheme.placeHolderColor,
//                         title: 'cancel'.tr,
//                         onPressed: cancelOnPressed,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(5.0),
//                     ),
//                     Expanded(
//                       child: BoxButton(
//                         color: AppTheme.primaryColor,
//                         title: 'ok'.tr,
//                         onPressed: okOnPressed,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class DialogWidget extends StatelessWidget {
  final String? message;
  final okOnPressed;
  DialogWidget({this.message, this.okOnPressed});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: EdgeInsets.all(30),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          child: Form(
            key: key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "Contact Us",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                // SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                  child: Text(
                    message!,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                BoxButton(
                  color: AppTheme.primaryColor,
                  title: 'ok'.tr,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SecurityCodeDialog extends StatelessWidget {
//   final String message;
//   final cancelOnPressed;
//   final okOnPressed;
//   final passwordValidator;
//   final passwordController;
//   final GlobalKey<FormState> formKey;
//   final key;

//   const SecurityCodeDialog(
//       {this.message,
//       this.cancelOnPressed,
//       this.okOnPressed,
//       this.passwordController,
//       this.passwordValidator,
//       this.formKey,
//       this.key});

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Future.value(false),
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         insetPadding: EdgeInsets.all(30),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
//           child: Form(
//             key: key,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Text(
//                     "verifySecurityCode".tr,
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                 ),
//                 // SizedBox(height: 16.0),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
//                   child: Text(
//                     "enterSecurityCode".tr,
//                     style: Theme.of(context).textTheme.bodyText1,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Form(
//                   key: formKey,
//                   child: CCVWidget(
//                     title: "securityCode".tr,
//                     prefixImageIconPath: 'assets/icons/password.png',
//                     hintValue: "***",
//                     maxLength: 3,
//                     validator: passwordValidator,
//                     controller: passwordController,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(12.0),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: BoxButton(
//                         color: AppTheme.placeHolderColor,
//                         title: 'cancel'.tr,
//                         onPressed: cancelOnPressed,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(5.0),
//                     ),
//                     Expanded(
//                       child: BoxButton(
//                         color: AppTheme.primaryColor,
//                         title: 'ok'.tr,
//                         onPressed: okOnPressed,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class PasswordPolicyWidget extends StatelessWidget {
  const PasswordPolicyWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: EdgeInsets.symmetric(
            horizontal: 10, vertical: Get.size.height * 20),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 18.0,
            left: 15.0,
            right: 15.0,
            bottom: 10.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "passwordPolicy".tr,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Expanded(child: child),
                  // Expanded(
                  //     child: ListView(
                  //   children: [
                  //     for (String passwordPolicy in globalCache
                  //         .configurationResponse.passwordPolicyText)
                  //       Padding(
                  //         padding: const EdgeInsets.only(top: 0.0),
                  //         child: bulletPoint(passwordPolicy, context),
                  //       ),
                  //   ],
                  // )),

                  /*SizedBox(
                        height: Get.height * 0.06,
                      ),*/
                ],
              )),
              // SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: BoxButton(
                        color: AppTheme.primaryColor,
                        title: 'ok'.tr,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bulletPoint(String text, context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•',
          // style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 30),
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: AppTheme.secondaryColor),
        ),
        //  buttlet(),
        SizedBox(width: 10),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(text),
        ))
      ],
    );
  }
}

class AppUpdateDialog extends StatelessWidget {
  const AppUpdateDialog({
    Key? key,
    required this.body,
    this.heading = "Update QisstPay",
    this.isCancelPressed,
    this.isConfirmPressed,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.forceUpdate,
  }) : super(key: key);
  final String body;
  final String? heading;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback? isConfirmPressed;
  final VoidCallback? isCancelPressed;
  final bool forceUpdate;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      heading!, //== null ? "confirmation".tr : heading,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    // IconButton(
                    //   icon: const Icon(Icons.close),
                    //   color: Colors.grey,
                    //   onPressed: () {
                    //     Get.back();
                    //   },
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  body,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 16),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (!forceUpdate) ...[
                    Expanded(
                      child: CustomButton(
                          height: 50,
                          color: Colors.black,
                          text: cancelButtonText,
                          onTap: isCancelPressed ??
                              () {
                                Get.back();
                              }),
                    ),
                  ],
                  if (!forceUpdate) ...[
                    const Padding(padding: EdgeInsets.all(8.0)),
                  ],
                  Expanded(
                    child: CustomButton(
                      height: 50,
                      color: Colors.red,
                      text: confirmButtonText,
                      onTap: isConfirmPressed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
