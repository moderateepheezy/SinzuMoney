//
//  SinzuMoney.swift
//  SinzuMoney
//
//  Created by Afees Lawal on 02/05/2020.
//  Copyright © 2020 Afees Lawal. All rights reserved.
//

import Foundation
import UIKit

struct Money: Codable, Equatable {

    struct Currency: Codable {
        let code: String
        let name: String?
        let symbol: String?
        let baseUnit: String?
        let decimalUnit: String?
    }

    let currency: Currency
    let value: Decimal

    static let defaultCurrency = Money.Currency.nigerianNaira

    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.alwaysShowsDecimalSeparator = true
        return numberFormatter
    }()

    fileprivate init(currency: Currency, value: Decimal) {
        self.currency = currency
        self.value = value
    }
}

extension Money.Currency {

    static let nigerianNaira = Money.Currency(code: "NGN", name: "Nigerian naira", symbol: "₦", baseUnit: "Naira", decimalUnit: "Kobo")

    static func from(code: String) -> Money.Currency {
        switch code {
        case nigerianNaira.code:
            return nigerianNaira
        default:
            return Money.Currency(code: code, name: nil, symbol: code, baseUnit: nil, decimalUnit: nil)
        }
    }

    var localized: String {
        return Money.Currency.nigerianNaira.symbol!
    }

    /// TODO: When different currencies are available we change back to this `symbol ?? String(describing: code.first)`
    var localizedSymbol: String? {
        return Money.Currency.nigerianNaira.symbol
    }
}

/// TODO: When different currencies will be available there should be some check whether we operate on same currencies.
extension Money {

    private enum Constants {
        static let textColor = UIColor.black.withAlphaComponent(0.87)
    }

    static let zero = Money.from(value: 0)

    var positive: Money {
        return self.doubleValue > 0 ? self : self * (-1)
    }

    static func from(currency: Currency = Money.defaultCurrency, value: Double) -> Money {
        return Money(currency: currency, value: Decimal(value))
    }

    static func from(currency: Currency = Money.defaultCurrency, decimalUnitValue: Int) -> Money {
        return Money(currency: currency, value: Decimal(Double(decimalUnitValue) / 100))
    }

    static func from(currency: Currency = Money.defaultCurrency, decimalUnitValue: Double) -> Money {
        return Money(currency: currency, value: Decimal(decimalUnitValue / 100))
    }

    static func from(currency: Currency = Money.defaultCurrency, value: String) -> Money {
        return Money.from(currency: currency, value: Double(value.separatorNumberConvertible) ?? 0)
    }

    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.value.isEqual(to: rhs.value) && lhs.currency.code.elementsEqual(rhs.currency.code)
    }

    static func / (lhs: Money, rhs: Int) -> Money {
        let value = lhs.doubleValue / Double(rhs)
        return Money(currency: lhs.currency, value: Decimal(value))
    }

    static func * (lhs: Money, rhs: Int) -> Money {
        let value = lhs.value * Decimal(rhs)
        return Money(currency: lhs.currency, value: value)
    }

    static func % (lhs: Money, rhs: Int) -> Money {
        let value = lhs.intValue % rhs
        return Money(currency: lhs.currency, value: Decimal(value))
    }

    static func > (lhs: Money, rhs: Money) -> Bool {
        return lhs.doubleValue > rhs.doubleValue
    }

    static func < (lhs: Money, rhs: Money) -> Bool {
        return lhs.doubleValue < rhs.doubleValue
    }

    static func + (lhs: Money, rhs: Money) -> Money? {
        guard lhs.currency.code.elementsEqual(rhs.currency.code) else { return nil }
        return Money(currency: lhs.currency, value: lhs.value + rhs.value)
    }

    static func - (lhs: Money, rhs: Money) -> Money? {
        guard lhs.currency.code.elementsEqual(rhs.currency.code) else { return nil }
        return Money(currency: lhs.currency, value: lhs.value - rhs.value)
    }

    var absoluteValue: Money {
        return Money.from(currency: currency, value: abs(doubleValue))
    }

    var localized: String {
        return "\(currency.localized) " + abbreviateMillions() + unit
    }

    var localizedDashable: String {
        guard self != .zero else { return "-" }
        return "\(currency.localized) \(localizedValue)"
    }

    var integerLocalized: String {
        return "\(currency.localized) \(intValue)"
    }

    var localizedValue: String {
        return String(format: "%.2f", doubleValue)
    }

    var humanReadable: String {
        let doubleFromDecimal = Double(localizedValue) ?? 0
        let nsNumber = NSNumber(value: doubleFromDecimal)
        let value = Money.numberFormatter.string(from: nsNumber) ?? "0"
        return value
    }

    var abbreviated: String {
        guard doubleValue > 9999999 else {
            return localized
        }
        return "\(currency.localized) " + abbreviateMillions() + unit + " "
    }

    var unit: String {
        var num = doubleValue
        num = fabs(num)

        guard num > 9999999 else {
            return .empty
        }

        let exp: Int = Int(log10(num) / 3.0)
        let units = ["K", "M", "G", "T", "P", "E"]
        return units[exp - 1]
    }

    var suffixNumber: String {
        var num = doubleValue
        let sign = ((num < 0) ? "-" : "" )

        num = fabs(num)

        guard num > 999 else {
            return "\(sign)\(String(format: "%.2f", num))"
        }

        let exp: Int = Int(log10(num) / 3.0 )

        let roundedNum: Int = Int(round(10 * num / pow(1000.0, Double(exp))) / 10)
        return "\(sign)\(roundedNum)"
    }

    var doubleValue: Double {
        return NSDecimalNumber(decimal: value).doubleValue
    }

    var intValue: Int {
        return NSDecimalNumber(decimal: value).intValue
    }

    var localizedBalance: String {
        return "Balance " + "\(localized)"
    }

    var attributedString: NSAttributedString {
        let mutableAttributedText = NSMutableAttributedString(
            string: self.currency.code,
            attributes: [
                .font: UIFont.systemFont(ofSize: 18),
                .foregroundColor: Constants.textColor
            ]
        )
        let attributedDescription = NSAttributedString(
            string: localizedValue,
            attributes: [
                .font: UIFont.systemFont(ofSize: 36),
                .foregroundColor: Constants.textColor
            ]
        )
        mutableAttributedText.append(attributedDescription)
        return mutableAttributedText
    }

    var smallLocalizedDigitBalanceAttributedString: NSAttributedString? {
        guard let symbol = currency.localizedSymbol else { return nil }
        let mutableAttributedText = NSMutableAttributedString(
            string: "\(symbol) \(intValue)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: (value.isSignMinus ? UIColor.red : UIColor.black)
            ]
        )
        return mutableAttributedText
    }

    var backendIntegerPostableAmount: Int {
        /// Amount needs to be multiplied by 100 if backend is receiving it without decimal point.
        return intValue * 100
    }

    var backendDecimalPostableAmount: NSDecimalNumber {
        /// Amount needs to be multiplied by 100 if backend is receiving it without decimal point.
        return NSDecimalNumber(decimal: value * 100)
    }

    func newWith(currency: Currency) -> Money {
        return Money(currency: currency, value: value)
    }

    func makeAttributedString(smallFontSize: CGFloat, largeFontSize: CGFloat, textColor: UIColor = .black) -> NSAttributedString {
        let mutableAttributedText = NSMutableAttributedString(
            string: currency.localized,
            attributes: [
                .font: UIFont.systemFont(ofSize: smallFontSize),
                .foregroundColor: textColor
            ]
        )
        let attributedAmount = NSAttributedString(
            string: unit.isEmpty ? humanReadable : abbreviateMillions(),
            attributes: [
                .font: UIFont.systemFont(ofSize: largeFontSize),
                .foregroundColor: textColor
            ]
        )
        let endingAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: smallFontSize),
            .foregroundColor: textColor
        ]
        mutableAttributedText.append(attributedAmount)
        mutableAttributedText.addAttributes(endingAttributes, range: NSRange(location: mutableAttributedText.string.count - 2, length: 2))
        return mutableAttributedText
    }

    func makeAbbreviatedAttributedString(smallFontSize: CGFloat, largeFontSize: CGFloat, textColor: UIColor = .black) -> NSAttributedString {
        let mutableAttributedText = NSMutableAttributedString(
            string: currency.localized,
            attributes: [
                .font: UIFont.systemFont(ofSize: smallFontSize),
                .foregroundColor: textColor
            ]
        )

        let attributedAmount = NSAttributedString(
            string: unit.isEmpty ? humanReadable : abbreviateMillions(),
            attributes: [
                .font: UIFont.systemFont(ofSize: largeFontSize),
                .foregroundColor: textColor
            ]
        )
        let endingAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: smallFontSize),
            .foregroundColor: textColor
        ]
        mutableAttributedText.append(attributedAmount)

        if unit.isEmpty {
            mutableAttributedText.addAttributes(endingAttributes, range: NSRange(location: mutableAttributedText.string.count - 2, length: 2))
        } else {
            let mutableEndingAttributedText = NSMutableAttributedString(
                string: unit,
                attributes: [
                    .font: UIFont.systemFont(ofSize: smallFontSize),
                    .foregroundColor: textColor
                ]
            )
            mutableAttributedText.append(mutableEndingAttributedText)
        }
        return mutableAttributedText
    }

    func makeMillionsAttributedString(smallFontSize: CGFloat, largeFontSize: CGFloat, textColor: UIColor = .black) -> NSAttributedString {
        let mutableAttributedText = NSMutableAttributedString(
            string: currency.localized.withEndSpace,
            attributes: [
                .font: UIFont.systemFont(ofSize: smallFontSize),
                .foregroundColor: textColor
            ]
        )

        let attributedAmount = NSAttributedString(
            string: abbreviateMillions(),
            attributes: [
                .font: UIFont.systemFont(ofSize: largeFontSize),
                .foregroundColor: textColor
            ]
        )
        mutableAttributedText.append(attributedAmount)

        let mutableEndingAttributedText = NSMutableAttributedString(
            string: unit,
            attributes: [
                .font: UIFont.systemFont(ofSize: smallFontSize),
                .foregroundColor: textColor
            ]
        )
        mutableAttributedText.append(mutableEndingAttributedText)

        return mutableAttributedText
    }

    func abbreviateMillions() -> String {
        let amountValue = doubleValue

        guard amountValue > 9999999 else {
            return humanReadable
        }

        let amountInMillion: Double = amountValue / 1000000
        let splitDecimalPoint = "\(amountInMillion)".split(separator: ".")

        guard !splitDecimalPoint.isEmpty else {
            return humanReadable
        }

        let decimalPoint = splitDecimalPoint[1]
        switch decimalPoint.count {
        case  1:
            return "\(amountInMillion.rounded(toPlaces: 1))"
        case 2:
            return "\(amountInMillion.rounded(toPlaces: 2))"
        default:
            return "\(amountInMillion)".split(separator: ".")[0] + "." + String(decimalPoint.prefix(3))
        }
    }
}

extension Optional where Wrapped == Money {

    var orZero: Money {
        return self ?? .zero
    }
}