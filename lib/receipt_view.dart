
import 'package:fib/receipt_args.dart';
import 'package:fib/receipt_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReceiptView extends StatefulWidget {
  final ReceiptArgs args;
  final bool shrinkWrap;
  const ReceiptView({Key? key, required this.args, this.shrinkWrap = false})
      : super(key: key);

  @override
  State<ReceiptView> createState() => _ReceiptViewState();
}

class _ReceiptViewState extends State<ReceiptView> {
 
  @override
  Widget build(BuildContext context) {
    // widget.args.receiptConfig[0].title.data.toString().contains(S.of(context).opType);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child:  Container(
          color: Colors.white,
          // height: double.infinity,
          height: widget.args.receiptConfig.length < 9 &&
                  MediaQuery.of(context).textScaleFactor < 2
              ? MediaQuery.of(context).size.height * 1.1
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 96.0,
                  //   width: 96.0,
                  //   child: RiveAnimation.asset(
                  //     widget.args.isSuccess
                  //         ? 'assets/animation/_check_icon.riv'
                  //         : 'assets/animation/error_icon.riv',
                  //     alignment: Alignment.center,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.args.isSuccess
                          ?"success"
                          : "faild",
                     
                    ),
                    if (!widget.args.isSuccess) ...[
                      Text(
                        widget.args.message,
                      )
                    ],
                    Text(
                      widget.args.transactionType,
                    
                    ),
                  ],
                ),
              ),
              ...widget.args.receiptConfig.map((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ReceiptTile(config: e)],
                  )),
              Center(
                child: Image.asset(
                  'assets/logo/trustpay.png',
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.width * .3,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                CupertinoIcons.home,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
        
          ],
        ),
      ),
    );
  }

 
}
