library promptpay;

import 'dart:convert';
import 'dart:core';

import 'package:crclib/crclib.dart';
import 'package:either_option/either_option.dart';
import 'package:promptpay/promptpay_data.dart';

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

const versionLength = "02";
const qrTypeLength = "02";
const merchantAccountLength = "37";
const subMerchantApplicationIDLength = "16";
const subMerchantAccountLength = "13";
const countryLength = "02";
const currencyLength = "03";
const checksumLength = "04";

const versionData = "01";
const qrMultipleTypeData = "11";
const qrOneTimeTypeData = "12";
const applicationIDData = "A000000677010111";
const countryData = "TH";
const bahtCurrencyData = "764";

enum AccountType { phone, identityNumber, eWallet }

/// A PromptPay is a payment method in Thailand
class PromptPay {
  /// Returns [QR Code Data] for PromptPay QR code
  static String generateQRData(String target, {double amount}) {
    AccountType accountType = target.length >= 15
        ? (AccountType.eWallet)
        : target.length >= 13
            ? (AccountType.identityNumber)
            : (AccountType.phone);

    var data = [
      versionID,
      versionLength,
      versionData,
      qrTypeID,
      qrTypeLength,
      qrMultipleTypeData,
      merchantAccountID,
      _getmerchantAccountLength(accountType, target),
      subMerchantApplicationID,
      subMerchantApplicationIDLength,
      applicationIDData,
      _getAccountID(accountType),
      _getAccountLength(accountType, target),
      _formatAccount(accountType, target),
      countryID,
      countryLength,
      countryData,
      currencyID,
      currencyLength,
      bahtCurrencyData,
    ];

    if (amount != null) {
      data.add(amountID);
      data.add(_formatAmount(amount).length.toString().padLeft(2, '0'));
      data.add(_formatAmount(amount));
    }

    data.add(checksumID);
    data.add(checksumLength);

    var checksum = _getCrc16XMODEM()
        .convert(utf8.encode(data.join()))
        .toRadixString(16)
        .toUpperCase();

    return data.join() + checksum;
  }

  static String getPromptPayQRWithNewAmount(String qrData, double amount) {
    Iterable<PromptPayField> data =
        PromptPayData.fromQRData(qrData).asIterable();
    var amountData = amountID +
        _formatAmount(amount).length.toString().padLeft(2, '0') +
        _formatAmount(amount);
    var isAlreadyAddAmount = false;
    var newQRData = data.fold("", (qrData, element) {
      if (element != null && element.typeID == amountID) {
        isAlreadyAddAmount = true;
        return qrData + amountData;
      }

      if (element != null) {
        return qrData +
            element.typeID +
            element.length.toString().padLeft(2, '0') +
            element.data;
      }

      return qrData;
    });

    if (!isAlreadyAddAmount) {
      newQRData = newQRData + amountData;
    }

    newQRData = newQRData + checksumID + checksumLength;

    return newQRData +
        _getCrc16XMODEM()
            .convert(utf8.encode(newQRData))
            .toRadixString(16)
            .toUpperCase();
  }

  static Option<String> getAccountNumberFromQRData(String qrData) {
    var promptPayData = PromptPayData.fromQRData(qrData);

    if (promptPayData.transferring != null) {
      if (promptPayData.transferringPhoneNumber != null) {
        return Option.of(promptPayData.transferringPhoneNumber.data);
      }

      if (promptPayData.transferringIdentityNumber != null) {
        return Option.of(promptPayData.transferringIdentityNumber.data);
      }

      if (promptPayData.transferringEWallet != null) {
        return Option.of(promptPayData.transferringEWallet.data);
      }
    }

    if (promptPayData.billing != null) {
      return Option.of(promptPayData.billingID.data);
    }

    return Option.empty();
  }

  static bool isQRDataValid(String qrData) {
    if (qrData.length < 8) {
      return false;
    }

    final qrDataWithOutChecksum = qrData.substring(0, qrData.length - 4);
    final checksum = qrData.substring(qrData.length - 4, qrData.length);
    final newChecksum = _getCrc16XMODEM()
        .convert(utf8.encode(qrDataWithOutChecksum))
        .toRadixString(16)
        .toUpperCase();

    return newChecksum == checksum;
  }

  static String _getAccountID(AccountType accountType) {
    switch (accountType) {
      case AccountType.eWallet:
        return subMerchantAccountEWalletID;
      case AccountType.identityNumber:
        return subMerchantAccountIdentityID;
      default:
        return subMerchantAccountPhoneID;
    }
  }

  static String _getmerchantAccountLength(
      AccountType accountType, String target) {
    switch (accountType) {
      case AccountType.eWallet:
        return (target.length + 24).toString();
      case AccountType.identityNumber:
        return (target.length + 24).toString();
      default:
        return merchantAccountLength;
    }
  }

  static String _getAccountLength(AccountType accountType, String target) {
    switch (accountType) {
      case AccountType.eWallet:
        return target.length.toString();
      case AccountType.identityNumber:
        return target.length.toString();
      default:
        return ("0066" + target.substring(1, target.length)).length.toString();
    }
  }

  static String _formatAccount(AccountType accountType, String target) {
    switch (accountType) {
      case AccountType.eWallet:
        return target;
      case AccountType.identityNumber:
        return target;
      default:
        return "0066" + target.substring(1, target.length);
    }
  }

  static String _formatAmount(double amount) {
    return amount.toStringAsFixed(2);
  }

  static ParametricCrc _getCrc16XMODEM() {
    // width=16 poly=0x1021 init=0x0000 refin=false refout=false xorout=0x0000 check=0x31c3 residue=0x0000 name="CRC-16/XMODEM"
    return new ParametricCrc(16, 0x1021, 0xFFFF, 0x0000,
        inputReflected: false, outputReflected: false);
  }
}
