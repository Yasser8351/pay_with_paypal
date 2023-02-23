import 'dart:async';
import 'dart:developer';

import 'package:fib/reports_args.dart';
import 'package:fib/splash_screen.dart';
import 'package:fib/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}




class PaymentScreen extends StatefulWidget {
 const PaymentScreen();
 //required this.orderModel

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController controllerGlobal;
  final  orderModel= "";

Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE); 
  }
  @override
  void initState() {
    super.initState();
        secureScreen();


    }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Payment"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed:()=> _exitApp(context),
          ),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            child: Stack(
              children: [
                WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: selectedUrl,
                  gestureNavigationEnabled: true,

                  userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.future.then((value) => controllerGlobal = value);
                    _controller.complete(webViewController);
                    //_controller.future.catchError(onError)
                  },
                  onProgress: (int progress) {
                    log("WebView is loading (progress : $progress%)");
                  },
                  onPageStarted: (String url) {
                    log('Page started loading: $url');
                    setState(() {
                      _isLoading = true;
                    });
                    log("printing urls "+url.toString());
                    _redirect(url);

                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                    setState(() {
                      _isLoading = false;
                    });
                    _redirect(url);

                  },
                ),
                _isLoading ? Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                ) : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _redirect(String url) {
  //  String BASE_URL = "";
    log(" start redirect");
    if(_canRedirect) {
      bool _isSuccess = url.contains('https://docs.flutter.dev/get-started/install') && url.contains(url);
      bool _isFailed = url.contains('fail') && url.contains(url);
      bool _isCancel = url.contains('apps') && url.contains(url);
      if (_isSuccess || _isFailed || _isCancel) {
        _canRedirect = false;
      }
      if (_isSuccess) {

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuccessScreen(),));


                        log("_isSuccess");



        // Get.offNamed(RouteHelper.getOrderSuccessRoute(widget.orderModel.id.toString(), 'success'));
      } else if (_isFailed || _isCancel) {
                log("_isCancel");

        // Get.offNamed(RouteHelper.getOrderSuccessRoute(widget.orderModel.id.toString(), 'fail'));
      }else{
        log("Encountered problem");
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      print("app exited");
      return true;
     // return Get.dialog(PaymentFailedDialog(orderID: widget.orderModel.id.toString()));
    }
  }

}