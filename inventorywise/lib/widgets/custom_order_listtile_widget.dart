import 'package:flutter/material.dart';

import 'package:InventoryWise/widgets/custom_button.dart';
import 'package:InventoryWise/widgets/custom_text_button.dart';

class CustomOrderList extends StatelessWidget {
  var onTapforButton;

  CustomOrderList(
      {Key? key,
      this.storename,
      this.payments,
      this.dates,
      required this.paynow,
      this.cardtype,
      required this.qplogo,
      required this.card,
      required this.pendingpayment,
      required this.amount,
      required this.trailing,
      required this.check,
      this.lastdigits,
      this.onTap,
      this.onTapforButton})
      : super(
          key: key,
        );
  String? lastdigits;
  String? amount;
  bool trailing;
  String? pendingpayment;
  bool? card;
  bool? check;
  bool? qplogo;
  var cardtype;
  bool? paynow;
  var storename;
  var payments;
  var dates;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0.5,
        margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (storename != null) ...[
                              // SizedBox(
                              //   height: Get.height * 0.005,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  Text(
                                    storename,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                          fontSize: 14,
                                        ),
                                    // TextStyle(
                                    //     fontWeight: FontWeight.w400,
                                    //     fontSize: 14,
                                    //     fontFamily: "SFProDisplay",
                                    //     color: Color(0xffA7A7A7)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if (qplogo == true)
                                    Image.asset(
                                      'assets/images/teztag.png',
                                      height: 15,
                                      fit: BoxFit.fill,
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                            Row(
                              children: [
                                // SizedBox(
                                //   width: Get.width * 0.02,
                                // ),
                                Text(
                                  payments,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 18,
                                      ),
                                  // TextStyle(
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 18,
                                  //     fontFamily: "SFProDisplay",
                                  //     color: Color(0xff111111)
                                  // ),
                                ),
                                if (check!) ...[
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ],
                                Spacer(),
                                Text(
                                  amount!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 18,
                                      ),
                                  // TextStyle(
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 18,
                                  //     fontFamily: "SFProDisplay",
                                  //     color: Color(0xff111111)
                                  // ),
                                ),
                                // SizedBox(
                                //   width: 5,
                                // )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                // SizedBox(
                                //   width: Get.width * 0.02,
                                // ),
                                Flexible(flex: 1,fit:FlexFit.tight,child:Text(dates,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 16)
                                    // TextStyle(
                                    //     fontWeight: FontWeight.w400,
                                    //     fontSize: 16,
                                    //     fontFamily: "SFProDisplay",
                                    //     color: Color(0xffA7A7A7)),
                                    ),),
                                Spacer(),
                                if (card!) ...[
                                  if(cardtype.isNotEmpty)
                                  Image.asset(
                                    'assets/images/' + cardtype + '.png',
                                    height: 14,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    lastdigits.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                    // TextStyle(
                                    //     fontWeight: FontWeight.w400,
                                    //     fontSize: 16,
                                    //     fontFamily: "SFProDisplay",
                                    //     color: Color(0xffA7A7A7)),
                                  ),
                                  // SizedBox(
                                  //   width: Get.width * 0.015,
                                  // )
                                ] else ...[
                                  Flexible(fit: FlexFit.loose,flex: 0,child:Text(
                                    pendingpayment!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                    // TextStyle(
                                    //     fontWeight: FontWeight.w400,
                                    //     fontSize: 16,
                                    //     fontFamily: "SFProDisplay",
                                    //     color: Color(0xffA7A7A7)),
                                  ),),
                                  // SizedBox(
                                  //   width: 5,
                                  // )
                                ]
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (trailing) ...[
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                if (paynow!) ...[
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                      color: Color(0xffFDE8EA),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 10),
                    child: Row(
                      children: [
                        Text(
                          "Payment Missed",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                  ),
                          // TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w400,
                          //     fontFamily: "SFProDisplay"),
                        ),
                        Spacer(),
                        Transform.translate(
                          offset: Offset(0.0, 10.0),
                          child: CustomButton(
                            text: "Pay Now",
                            buttonWidth: 120,
                            onTap: onTapforButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
