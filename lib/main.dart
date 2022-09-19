import 'package:qrtesting/promtpay.dart';

void main(List<String> args) {
  // var object = qrcen(account: '0845585884' ,amount: '100000');
  var jj = QrCodePromtpay(account: '0845585884', amount: '1000',size: 200,).createPromtPayCode();
  //  print(object);
    print(jj);
}
