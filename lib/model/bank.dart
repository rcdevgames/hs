// To parse this JSON data, do
//
//     final bank = bankFromJson(jsonString);

import 'dart:convert';

List<Bank> bankFromJson(String str) => new List<Bank>.from(json.decode(str).map((x) => Bank.fromJson(x)));

String bankToJson(List<Bank> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Bank {
    String bankName;
    String bankAccountName;
    String bankAccountNumber;
    String bankIcon;

    Bank({
        this.bankName,
        this.bankAccountName,
        this.bankAccountNumber,
        this.bankIcon,
    });

    factory Bank.fromJson(Map<String, dynamic> json) => new Bank(
        bankName: json["bank_name"],
        bankAccountName: json["bank_account_name"],
        bankAccountNumber: json["bank_account_number"],
        bankIcon: json["bank_icon"],
    );

    Map<String, dynamic> toJson() => {
        "bank_name": bankName,
        "bank_account_name": bankAccountName,
        "bank_account_number": bankAccountNumber,
        "bank_icon": bankIcon,
    };
}
