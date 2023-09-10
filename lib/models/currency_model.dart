class CurrencyModel {
  final int id;
  final String code;
  final String ccy;
  final String ccyNmRU;
  final String ccyNmUZ;
  final String ccyNmUZC;
  final String ccyNmEN;
  final String nominal;
  final String rate;
  final String diff;
  final String date;

  const CurrencyModel({
    required this.id,
    required this.code,
    required this.ccy,
    required this.ccyNmRU,
    required this.ccyNmUZ,
    required this.ccyNmUZC,
    required this.ccyNmEN,
    required this.nominal,
    required this.rate,
    required this.diff,
    required this.date,
  });

  factory CurrencyModel.fromJson(Map<String, Object?> json) {
    if (json
        case {
          "id": final int id,
          "Code": final String code,
          "Ccy": final String ccy,
          "CcyNm_RU": final String ccyNmRU,
          "CcyNm_UZ": final String ccyNmUZ,
          "CcyNm_UZC": final String ccyNmUZC,
          "CcyNm_EN": final String ccyNmEN,
          "Nominal": final String nominal,
          "Rate": final String rate,
          "Diff": final String diff,
          "Date": final String date,
        }) {
      return CurrencyModel(
        id: id,
        code: code,
        ccy: ccy,
        ccyNmRU: ccyNmRU,
        ccyNmUZ: ccyNmUZ,
        ccyNmUZC: ccyNmUZC,
        ccyNmEN: ccyNmEN,
        nominal: nominal,
        rate: rate,
        diff: diff,
        date: date,
      );
    } else {
      throw const FormatException("Invalid JSON data!");
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          code == other.code &&
          ccy == other.ccy &&
          ccyNmRU == other.ccyNmRU &&
          ccyNmUZ == other.ccyNmUZ &&
          ccyNmUZC == other.ccyNmUZC &&
          ccyNmEN == other.ccyNmEN &&
          nominal == other.nominal &&
          rate == other.rate &&
          diff == other.diff &&
          date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      code.hashCode ^
      ccy.hashCode ^
      ccyNmRU.hashCode ^
      ccyNmUZ.hashCode ^
      ccyNmUZC.hashCode ^
      ccyNmEN.hashCode ^
      nominal.hashCode ^
      rate.hashCode ^
      diff.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'CurrencyModel(id: $id, code: $code, ccy: $ccy, ccyNmRU: $ccyNmRU, ccyNmUZ: $ccyNmUZ, ccyNmUZC: $ccyNmUZC, ccyNmEN: $ccyNmEN, nominal: $nominal, rate: $rate, diff: $diff, date: $date)';
  }
}
