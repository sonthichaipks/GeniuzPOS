// To parse this JSON data, do
//
//     final vpoSparam = vpoSparamFromJson(jsonString);

import 'dart:convert';

List<VpoSparam> vpoSparamFromJson(String str) =>
    List<VpoSparam>.from(json.decode(str).map((x) => VpoSparam.fromJson(x)));

String vpoSparamToJson(List<VpoSparam> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VpoSparam {
  VpoSparam({
    this.id,
    this.bizName,
    this.bizAddressLine1,
    this.bizAddressLine2,
    this.bizAddressLine3,
    this.telId,
    this.faxId,
    this.email,
    this.regId,
    this.taxId,
    this.bizType,
    this.vatFg,
    this.taxInvName,
    this.taxInvAddrLine1,
    this.taxInvAddrLine2,
    this.taxInvAddrLine3,
    this.posId,
    this.posPermitNo,
    this.shopId,
    this.whsId,
    this.lastReceiptRunNo,
    this.lastRefundRunNo,
    this.cashierPosFg,
    this.posScreenType,
    this.posTouchPanelId,
    this.maxCashInDrawer,
    this.autoChargeFg,
    this.autoChargeRate,
    this.mandatorySalesmanFg,
    this.mandatoryMemberFg,
    this.connectPrinterFg,
    this.connectDrawerFg,
    this.connectVfdfg,
    this.connect2NdDispFg,
    this.connectEdcfg,
    this.connectRfidreaderFg,
    this.sellingPriceNo,
    this.psParaDefault1,
    this.shopLogoOnFrontScreen,
    this.shopLogoOnReceipt,
    this.recptHeadMesg1,
    this.recptHeadMesg2,
    this.recptHeadMesg3,
    this.recptHeadMesg4,
    this.recptHeadMesg5,
    this.recptHeadMesg6,
    this.recptFootMesg1,
    this.recptFootMesg2,
    this.recptFootMesg3,
    this.recptFootMesg4,
    this.recptFootMesg5,
    this.recptFootMesg6,
    this.recptFootMesg7,
    this.recptFootMesg8,
    this.recptFootMesg9,
    this.recptFootMesg10,
    this.recptNoBarcodeFg,
    this.psParaDefault2,
    this.selectSellingPriceFg,
    this.receiptPrinterType,
    this.salesDocFg,
    this.salesVatType,
    this.ejournalFg,
    this.noOfRecptCopy,
    this.printOrderFg,
    this.printQueueFg,
    this.itemOnRecptMethod,
    this.recptSumItemQtyFg,
    this.shopTypeId,
    this.shopGroupId,
    this.shopName,
    this.branchName,
    this.shopAddress,
    this.shopRegName,
    this.shopRegAddressLine1,
    this.shopRegAddressLine2,
    this.shopRegAddressLine3,
    this.shopRegId,
    this.shopTaxId,
    this.chargeVatRate,
    this.posProcessMode,
    this.weightBarcodePrefix,
    this.pointRedeemOneBaht,
    this.discRoundMethod,
    this.cashPayRoundMethod,
    this.mbDiscMethod,
    this.promptPayLink,
    this.qrCodeAccount,
  });

  int id;
  String bizName;
  String bizAddressLine1;
  String bizAddressLine2;
  String bizAddressLine3;
  String telId;
  String faxId;
  String email;
  String regId;
  String taxId;
  String bizType;
  int vatFg;
  String taxInvName;
  String taxInvAddrLine1;
  String taxInvAddrLine2;
  String taxInvAddrLine3;
  String posId;
  String posPermitNo;
  String shopId;
  String whsId;
  double lastReceiptRunNo;
  double lastRefundRunNo;
  int cashierPosFg;
  String posScreenType;
  String posTouchPanelId;
  double maxCashInDrawer;
  int autoChargeFg;
  double autoChargeRate;
  int mandatorySalesmanFg;
  int mandatoryMemberFg;
  int connectPrinterFg;
  int connectDrawerFg;
  int connectVfdfg;
  int connect2NdDispFg;
  int connectEdcfg;
  int connectRfidreaderFg;
  int sellingPriceNo;
  int psParaDefault1;
  String shopLogoOnFrontScreen;
  String shopLogoOnReceipt;
  String recptHeadMesg1;
  String recptHeadMesg2;
  String recptHeadMesg3;
  String recptHeadMesg4;
  String recptHeadMesg5;
  String recptHeadMesg6;
  String recptFootMesg1;
  String recptFootMesg2;
  String recptFootMesg3;
  String recptFootMesg4;
  String recptFootMesg5;
  String recptFootMesg6;
  String recptFootMesg7;
  String recptFootMesg8;
  String recptFootMesg9;
  String recptFootMesg10;
  int recptNoBarcodeFg;
  int psParaDefault2;
  int selectSellingPriceFg;
  int receiptPrinterType;
  int salesDocFg;
  String salesVatType;
  int ejournalFg;
  int noOfRecptCopy;
  int printOrderFg;
  int printQueueFg;
  int itemOnRecptMethod;
  int recptSumItemQtyFg;
  String shopTypeId;
  String shopGroupId;
  String shopName;
  String branchName;
  String shopAddress;
  String shopRegName;
  String shopRegAddressLine1;
  String shopRegAddressLine2;
  String shopRegAddressLine3;
  String shopRegId;
  String shopTaxId;
  double chargeVatRate;
  String posProcessMode;
  String weightBarcodePrefix;
  double pointRedeemOneBaht;
  int discRoundMethod;
  int cashPayRoundMethod;

  int mbDiscMethod;

  String promptPayLink;
  String qrCodeAccount;

  factory VpoSparam.fromJson(Map<String, dynamic> json) => VpoSparam(
        id: json["id"],
        bizName: json["bizName"],
        bizAddressLine1: json["bizAddressLine1"],
        bizAddressLine2: json["bizAddressLine2"],
        bizAddressLine3: json["bizAddressLine3"],
        telId: json["telId"],
        faxId: json["faxId"],
        email: json["email"],
        regId: json["regId"],
        taxId: json["taxId"],
        bizType: json["bizType"],
        vatFg: json["vatFg"],
        taxInvName: json["taxInvName"],
        taxInvAddrLine1: json["taxInvAddrLine1"],
        taxInvAddrLine2: json["taxInvAddrLine2"],
        taxInvAddrLine3: json["taxInvAddrLine3"],
        posId: json["posId"],
        posPermitNo: json["posPermitNo"],
        shopId: json["shopId"],
        whsId: json["whsId"],
        lastReceiptRunNo: json["lastReceiptRunNo"].toDouble(),
        lastRefundRunNo: json["lastRefundRunNo"].toDouble(),
        cashierPosFg: json["cashierPosFg"],
        posScreenType: json["posScreenType"],
        posTouchPanelId: json["posTouchPanelId"],
        maxCashInDrawer: json["maxCashInDrawer"].toDouble(),
        autoChargeFg: json["autoChargeFg"],
        autoChargeRate: json["autoChargeRate"].toDouble(),
        mandatorySalesmanFg: json["mandatorySalesmanFg"],
        mandatoryMemberFg: json["mandatoryMemberFg"],
        connectPrinterFg: json["connectPrinterFg"],
        connectDrawerFg: json["connectDrawerFg"],
        connectVfdfg: json["connectVfdfg"],
        connect2NdDispFg: json["connect2ndDispFg"],
        connectEdcfg: json["connectEdcfg"],
        connectRfidreaderFg: json["connectRfidreaderFg"],
        sellingPriceNo: json["sellingPriceNo"],
        psParaDefault1: json["psParaDefault1"],
        shopLogoOnFrontScreen: json["shopLogoOnFrontScreen"],
        shopLogoOnReceipt: json["shopLogoOnReceipt"],
        recptHeadMesg1: json["recptHeadMesg1"],
        recptHeadMesg2: json["recptHeadMesg2"],
        recptHeadMesg3: json["recptHeadMesg3"],
        recptHeadMesg4: json["recptHeadMesg4"],
        recptHeadMesg5: json["recptHeadMesg5"],
        recptHeadMesg6: json["recptHeadMesg6"],
        recptFootMesg1: json["recptFootMesg1"],
        recptFootMesg2: json["recptFootMesg2"],
        recptFootMesg3: json["recptFootMesg3"],
        recptFootMesg4: json["recptFootMesg4"],
        recptFootMesg5: json["recptFootMesg5"],
        recptFootMesg6: json["recptFootMesg6"],
        recptFootMesg7: json["recptFootMesg7"],
        recptFootMesg8: json["recptFootMesg8"],
        recptFootMesg9: json["recptFootMesg9"],
        recptFootMesg10: json["recptFootMesg10"],
        recptNoBarcodeFg: json["recptNoBarcodeFg"],
        psParaDefault2: json["psParaDefault2"],
        selectSellingPriceFg: json["selectSellingPriceFg"],
        receiptPrinterType: json["receiptPrinterType"],
        salesDocFg: json["salesDocFg"],
        salesVatType: json["salesVatType"],
        ejournalFg: json["ejournalFg"],
        noOfRecptCopy: json["noOfRecptCopy"],
        printOrderFg: json["printOrderFg"],
        printQueueFg: json["printQueueFg"],
        itemOnRecptMethod: json["itemOnRecptMethod"],
        recptSumItemQtyFg: json["recptSumItemQtyFg"],
        shopTypeId: json["shopTypeId"],
        shopGroupId: json["shopGroupId"],
        shopName: json["shopName"],
        branchName: json["branchName"],
        shopAddress: json["shopAddress"],
        shopRegName: json["shopRegName"],
        shopRegAddressLine1: json["shopRegAddressLine1"],
        shopRegAddressLine2: json["shopRegAddressLine2"],
        shopRegAddressLine3: json["shopRegAddressLine3"],
        shopRegId: json["shopRegId"],
        shopTaxId: json["shopTaxId"],
        chargeVatRate: json["chargeVatRate"].toDouble(),
        posProcessMode: json["posProcessMode"],
        weightBarcodePrefix: json["weightBarcodePrefix"],
        pointRedeemOneBaht: json["pointRedeemOneBaht"].toDouble(),
        discRoundMethod: json["discRoundMethod"],
        cashPayRoundMethod: json["cashPayRoundMethod"],
        mbDiscMethod: json["mbDiscMethod"],
        promptPayLink: json["promptPayLink"],
        qrCodeAccount: json["qrCodeAccount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bizName": bizName,
        "bizAddressLine1": bizAddressLine1,
        "bizAddressLine2": bizAddressLine2,
        "bizAddressLine3": bizAddressLine3,
        "telId": telId,
        "faxId": faxId,
        "email": email,
        "regId": regId,
        "taxId": taxId,
        "bizType": bizType,
        "vatFg": vatFg,
        "taxInvName": taxInvName,
        "taxInvAddrLine1": taxInvAddrLine1,
        "taxInvAddrLine2": taxInvAddrLine2,
        "taxInvAddrLine3": taxInvAddrLine3,
        "posId": posId,
        "posPermitNo": posPermitNo,
        "shopId": shopId,
        "whsId": whsId,
        "lastReceiptRunNo": lastReceiptRunNo,
        "lastRefundRunNo": lastRefundRunNo,
        "cashierPosFg": cashierPosFg,
        "posScreenType": posScreenType,
        "posTouchPanelId": posTouchPanelId,
        "maxCashInDrawer": maxCashInDrawer,
        "autoChargeFg": autoChargeFg,
        "autoChargeRate": autoChargeRate,
        "mandatorySalesmanFg": mandatorySalesmanFg,
        "mandatoryMemberFg": mandatoryMemberFg,
        "connectPrinterFg": connectPrinterFg,
        "connectDrawerFg": connectDrawerFg,
        "connectVfdfg": connectVfdfg,
        "connect2ndDispFg": connect2NdDispFg,
        "connectEdcfg": connectEdcfg,
        "connectRfidreaderFg": connectRfidreaderFg,
        "sellingPriceNo": sellingPriceNo,
        "psParaDefault1": psParaDefault1,
        "shopLogoOnFrontScreen": shopLogoOnFrontScreen,
        "shopLogoOnReceipt": shopLogoOnReceipt,
        "recptHeadMesg1": recptHeadMesg1,
        "recptHeadMesg2": recptHeadMesg2,
        "recptHeadMesg3": recptHeadMesg3,
        "recptHeadMesg4": recptHeadMesg4,
        "recptHeadMesg5": recptHeadMesg5,
        "recptHeadMesg6": recptHeadMesg6,
        "recptFootMesg1": recptFootMesg1,
        "recptFootMesg2": recptFootMesg2,
        "recptFootMesg3": recptFootMesg3,
        "recptFootMesg4": recptFootMesg4,
        "recptFootMesg5": recptFootMesg5,
        "recptFootMesg6": recptFootMesg6,
        "recptFootMesg7": recptFootMesg7,
        "recptFootMesg8": recptFootMesg8,
        "recptFootMesg9": recptFootMesg9,
        "recptFootMesg10": recptFootMesg10,
        "recptNoBarcodeFg": recptNoBarcodeFg,
        "psParaDefault2": psParaDefault2,
        "selectSellingPriceFg": selectSellingPriceFg,
        "receiptPrinterType": receiptPrinterType,
        "salesDocFg": salesDocFg,
        "salesVatType": salesVatType,
        "ejournalFg": ejournalFg,
        "noOfRecptCopy": noOfRecptCopy,
        "printOrderFg": printOrderFg,
        "printQueueFg": printQueueFg,
        "itemOnRecptMethod": itemOnRecptMethod,
        "recptSumItemQtyFg": recptSumItemQtyFg,
        "shopTypeId": shopTypeId,
        "shopGroupId": shopGroupId,
        "shopName": shopName,
        "branchName": branchName,
        "shopAddress": shopAddress,
        "shopRegName": shopRegName,
        "shopRegAddressLine1": shopRegAddressLine1,
        "shopRegAddressLine2": shopRegAddressLine2,
        "shopRegAddressLine3": shopRegAddressLine3,
        "shopRegId": shopRegId,
        "shopTaxId": shopTaxId,
        "chargeVatRate": chargeVatRate,
        "posProcessMode": posProcessMode,
        "weightBarcodePrefix": weightBarcodePrefix,
        "pointRedeemOneBaht": pointRedeemOneBaht,
        "discRoundMethod": discRoundMethod,
        "cashPayRoundMethod": cashPayRoundMethod,
        "mbDiscMethod": mbDiscMethod,
        "promptPayLink": promptPayLink,
        "qrCodeAccount": qrCodeAccount,
      };
}
