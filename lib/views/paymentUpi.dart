import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';




class PaymentUpi extends StatefulWidget {
  final double totalAmount;

  PaymentUpi({required this.totalAmount});
  @override
  _PaymentUpiState createState() => _PaymentUpiState();
}

class _PaymentUpiState extends State<PaymentUpi> {
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "9353216323@ybl",
      receiverName: 'Shashank B L',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'This transaction Occurs securely',
      amount: widget.totalAmount,
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return Center(
        child: CircularProgressIndicator(
          // Adjust size and color for visual appeal
          strokeWidth: 4,
          color: Theme.of(context).primaryColor,
        ),
      );
    } else if (apps!.length == 0) {
      return Center(
        child: Text(
          "No UPI apps found to handle the transaction.",
          style: header,
        ),
      );
    } else {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Adjust based on screen size
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: apps!.length,
        itemBuilder: (context, index) {
          final UpiApp app = apps![index];
          return GestureDetector(
            onTap: () {
              _transaction = initiateTransaction(app);
              setState(() {});
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.memory(
                    app.icon,
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    app.name,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }


  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
                body,
                style: value,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose UPI Platforms'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: displayUpiApps(),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Expanded(
                child: FutureBuilder(
                  future: _transaction,
                  builder: (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            _upiErrorHandler(snapshot.error.runtimeType),
                            style: header,
                          ), // Print's text message on screen
                        );
                      }

                      // If we have data then definitely we will have UpiResponse.
                      // It cannot be null
                      UpiResponse _upiResponse = snapshot.data!;

                      // Data in UpiResponse can be null. Check before printing
                      String txnId = _upiResponse.transactionId ?? 'N/A';
                      String resCode = _upiResponse.responseCode ?? 'N/A';
                      String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                      String status = _upiResponse.status ?? 'N/A';
                      String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                      _checkTxnStatus(status);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            displayTransactionData('Transaction Id', txnId),
                            displayTransactionData('Response Code', resCode),
                            displayTransactionData('Reference Id', txnRef),
                            displayTransactionData('Status', status.toUpperCase()),
                            displayTransactionData('Approval No', approvalRef),
                          ],
                        ),
                      );
                    } else
                      return const Center(
                        child: Text(''),
                      );
                  },
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}