/// Support for doing something awesome.
///
/// More dartdocs go here.
library qrtesting;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crclib/crclib.dart';
import 'package:qr_flutter/qr_flutter.dart';

export 'src/promtpay.dart';

const versionID = "00";
const qrTypeID = "01";
const merchantAccountID = "29";
const subMerchantApplicationID = "00";
const subMerchantAccountPhoneID = "01";
const subMerchantAccountIdentityID = "02";
const subMerchantAccountEWalletID = "03";
const countryID = "58";
const currencyID = "53";
const amountID = "54";
const checksumID = "63";
const nowData = '01';

const qrApplicationID = '00';
const qrApplicationIDLength = '16';

const multipaymentType = '11'; //จ่ายหลายครั้ง
const oneTimePaymentType = '12'; //จ่ายครั้งเดียว

const merchentIndendifyType = '02';
// const merchentIndendifyType  = '02';d

const versionLength = "02";
const qrTypeLength = "02";
const merchantAccountLength = "37";
const subMerchantApplicationIDLength = "16";
const subMerchantAccountLength = "13";
const countryLength = "02";
const currencyLength = "03";
const checksumLength = "04";

const phoneLocatioTH = "66";
const phoneLengthLocationTH = "13";
const phoneSubLengthLocationTH = "00";

const phoenVersionData = "01";
const qrMultipleTypeData = "11";
const qrOneTimeTypeData = "12";
const applicationIDData = "A000000677010111";
const countryData = "TH";
const bahtCurrencyData = "764";
var amountLength;

class QrCodePromtpay extends StatelessWidget {
  final String account;
  final double size;
  String? amount;
  QrCodePromtpay({
    // Key? key,
    required this.account,
    this.amount,
    required this.size,
  });
  accont() {
    //TODO : E Wallet and Tax Id
    String accountName = '';
    if (account != null && account != '') {
      if (account.length == 13) {
        accountName =
            merchentIndendifyType + subMerchantAccountLength + account;
        return accountName;
      }
      if (account.length == 10) {
        String _phoneTh = phoenVersionData +
            phoneLengthLocationTH +
            phoneSubLengthLocationTH +
            phoneLocatioTH +
            account.substring(1);
        accountName = _phoneTh;
        return accountName;
      }
    } else {
      return accountName;
    }

    return accountName;
  }

  checkAmont() {
    var amountConvert;
    if (amount != null && amount != '') {
      var convert = double.parse(amount!);

      amountConvert = convert.toStringAsFixed(2);
      // amountLength = amountConvert.length;
      if (amountConvert.length < 10) {
        amountLength = '0' + amountConvert.length.toString();
      } else {
        amountLength = amountConvert.length.toString();
      }

      return amountConvert;
    } else {
      return null;
    }
  }

  createPromtPayCode() {
    var pormtPayCode = '';
    var _amount = checkAmont();
    var _accont = accont();

    if (_amount != null) {
      String code = versionID +
          subMerchantAccountIdentityID +
          nowData +
          qrTypeID +
          qrTypeLength +
          oneTimePaymentType +
          merchantAccountID +
          merchantAccountLength +
          qrApplicationID +
          qrApplicationIDLength +
          applicationIDData +
          _accont +
          countryID +
          countryLength +
          countryData +
          currencyID +
          currencyLength +
          bahtCurrencyData +
          amountID +
          amountLength +
          _amount +
          checksumID +
          checksumLength;

      //  pormtPayCode =  code;
      var genCode = _getCrc16XMODEM()
          .convert(utf8.encode(code))
          .toRadixString(16)
          .toUpperCase();
      pormtPayCode = code + genCode;
      return pormtPayCode;
    } else {
      String code = versionID +
          subMerchantAccountIdentityID +
          nowData +
          qrTypeID +
          qrTypeLength +
          oneTimePaymentType +
          merchantAccountID +
          merchantAccountLength +
          qrApplicationID +
          qrApplicationIDLength +
          applicationIDData +
          _accont +
          countryID +
          countryLength +
          countryData +
          currencyID +
          currencyLength +
          bahtCurrencyData +
          checksumID +
          checksumLength;

      //  pormtPayCode =  code;
      var genCode = _getCrc16XMODEM()
          .convert(utf8.encode(code))
          .toRadixString(16)
          .toUpperCase();
      pormtPayCode = code + genCode;
      return pormtPayCode;
    }
  }

  static ParametricCrc _getCrc16XMODEM() {
    // width=16 poly=0x1021 init=0x0000 refin=false refout=false xorout=0x0000 check=0x31c3 residue=0x0000 name="CRC-16/XMODEM"
    return new ParametricCrc(16, 0x1021, 0xFFFF, 0x0000,
        inputReflected: false, outputReflected: false);
  }

  @override
  Widget build(BuildContext context) {
    var dataCode = createPromtPayCode();
    print(dataCode);
    return QrImage(
      data: dataCode,
      version: QrVersions.auto,
      size: size,
    );
  }
}
