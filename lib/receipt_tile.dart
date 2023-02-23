import 'package:fib/receipt_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ReceiptTile extends StatelessWidget {
  final ReceiptConfig config;
  const ReceiptTile({Key? key, required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _title = Text(
      config.title.data,
      // fontWeight: config.title.fontWeight,
      textDirection: config.title.textDirection,
      maxLines: 2,
      textAlign: TextAlign.start,
    );
    Widget _oprType = Text(
      config.title.data.contains("نوع العملية") ? config.value.data : "",
      // fontWeight: config.title.fontWeight,
      textDirection: config.title.textDirection,
      maxLines: 2,
      textAlign: TextAlign.start,
    );

    Widget title = config.value.copyable != null && config.value.copyable!
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title,
              GestureDetector(
                onTap: handleCopyToClipboard(context),
                child: Icon(
                  Icons.copy,
                  color: Theme.of(context).primaryColorDark,
                  size: 20,
                ),
              )
            ],
          )
        : _title;
    Widget value = config.value.copyable != null && config.value.copyable!
        ? SelectableText(
            config.value.data,
            textAlign: TextAlign.end,
            textDirection: config.value.textDirection,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: config.value.fontWeight,
                  color: config.value.color,
                ),
          )
        : config.value.amount
            ? RichText(
                textDirection: config.value.textDirection,
                maxLines: 2,
                // textAlign: TextAlign.end,
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                text: TextSpan(children: [
                  TextSpan(
                    text: config.value.data,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          // color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: "sdg",
                    style: Theme.of(context).textTheme.overline?.copyWith(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: config.value.fontWeight,
                        ),
                  ),
                ]))
            : Text(
                config.value.data,
                textDirection: config.value.textDirection,
                // textAlign: TextAlign.end,
                maxLines: 2,
                // color: config.value.color,
                // fontWeight:config.value.data.contains(S.of(context).customerName)?FontWeight.bold: config.value.fontWeight,
                // textAlign: TextAlign.end,
              );
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: config.backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            // color: kcGreyLight,
          )),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(flex: 1, child: title),
              const Text(':'),
              const SizedBox(
                width: 2.0,
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: value,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  VoidCallback handleCopyToClipboard(BuildContext context) {
    return () async {
      await Clipboard.setData(ClipboardData(text: config.value.data));
      // showSnackBar(context,
      //     content: S.of(context).copiedToClipboard,
      //     action: SnackBarAction(
      //       label: S.of(context).dismiss.toUpperCase(),
      //       onPressed: () {},
      //     ));
    };
  }
}
