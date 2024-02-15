import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:upi_india/upi_india.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;

  PaymentScreen({required this.totalAmount});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvCodeController = TextEditingController();

  UpiIndia upiIndia = UpiIndia();

  bool isLightTheme = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void makePayment(BuildContext context, String paymentMethod) async {
    if (paymentMethod == 'UPI') {
      // Implement UPI payment logic using upiIndia package
      // Example:
      // try {
      //   UpiResponse response = await upiIndia.startTransaction(
      //     app: 'your_upi_app_name',
      //     pa: 'your_upi_id',
      //     pn: 'Your Name',
      //     tr: 'Transaction ID',
      //     tn: 'Transaction Note',
      //     am: widget.totalAmount.toString(),
      //     // Other optional parameters
      //   );
      //   // Handle payment response
      //   if (response.status == UpiPaymentStatus.SUCCESS) {
      //     // Navigate to success screen or perform other actions
      //   } else {
      //     // Handle payment failure
      //   }
      // } catch (error) {
      //   // Handle errors
      // }
    } else if (paymentMethod == 'Card') {
      // Implement card payment logic using your preferred payment gateway
      // Example:
      // try {
      //   // Process card payment using payment gateway SDK
      //   // Handle payment response
      // } catch (error) {
      //   // Handle errors
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CreditCardWidget(
              enableFloatingCard: useFloatingAnimation,
              // glassmorphismConfig: _getGlassmorphismConfig(),
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              bankName: 'Axis Bank',
              frontCardBorder:
                  useGlassMorphism ? null : Border.all(color: Colors.grey),
              backCardBorder:
                  useGlassMorphism ? null : Border.all(color: Colors.grey),
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              // cardBgColor: isLightTheme
              //     ? AppColors.cardBgLightColor
              //     : AppColors.cardBgColor,
              // backgroundImage: useBackgroundImage ? 'assets/card_bg.png' : null,
              isSwipeGestureEnabled: true,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              // customCardTypeIcons: <CustomCardTypeIcon>[
              //   CustomCardTypeIcon(
              //     cardType: CardType.mastercard,
              //     cardImage: Image.asset(n
              //       'assets/mastercard.png',
              //       height: 48,
              //       width: 48,
              //     ),
              //   ),
              // ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      inputConfiguration: const InputConfiguration(
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDateDecoration: InputDecoration(
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          labelText: 'Card Holder',
                        ),
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _onValidate,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius as needed
                ),
                // You can also customize other properties like padding, background color, etc.
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                primary: Colors.amber, // Adjust the button color as needed
              ),
              child: const Text(
                'Validate',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onValidate() {
    if (formKey.currentState?.validate() ?? false) {
      print('valid!');
    } else {
      print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
