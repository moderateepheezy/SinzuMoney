//
//  SinzuMoneyTests.swift
//  SinzuMoneyTests
//
//  Created by Afees Lawal on 27/04/2020.
//  Copyright © 2020 Afees Lawal. All rights reserved.
//

import XCTest
@testable import SinzuMoney

class SinzuMoneyTests: XCTestCase {

    let usDollarCurrency = Money.Currency(code: "USD", name: "Dollar", symbol: "$", baseUnit: "US Dollar", decimalUnit: "Cent")

    let noSymbolCurrency = Money.Currency(code: "", name: "SMZ Dallaz", symbol: "", baseUnit: "Dallaz", decimalUnit: "Laz")

    func testPositiveSimpleMoney() {
        let money = Money.from(value: -10)
        let abosuluteMoney = money.absoluteValue
        XCTAssertEqual(abosuluteMoney.doubleValue, 10)

        let zeroMoney = Money.zero
        XCTAssertEqual(zeroMoney.doubleValue, 0)
    }

    func testIntLocalizedMoney() {
        let localizedMoney = Money.from(value: 10000000.72)
        let localized = localizedMoney.integerLocalized
        XCTAssertEqual(localized, "₦10,000,000")
    }

    func testLocalizedNegativeMoney() {
        let localizedMoney = Money.from(value: -10000000.32)
        let localized = localizedMoney.localized
        XCTAssertEqual(localized, "₦-10,000,000.32")
    }

    func testLocalizedPositiveMoney() {
        let localizedMoney = Money.from(value: 10000000.32)
        let localized = localizedMoney.localized
        XCTAssertEqual(localized, "₦10,000,000.32")
    }

    func testLocalizedValueMoney() {
        let localizedMoney = Money.from(value: 1240000.6254204)
        let localized = localizedMoney.localizedValue
        XCTAssertEqual(localized, "1240000.63")
    }

    func testHumanReadableMoneyString() {
        let localizedMoney = Money.from(value: 1240000.6254204)
        let localized = localizedMoney.humanReadable
        XCTAssertEqual(localized, "1,240,000.63")
    }

    func testUnit() {
        let thousandMoney = Money.from(value: 30000.00)
        XCTAssertEqual(thousandMoney.unit, "K")

        let millionMoney = Money.from(value: 3000000.00)
        XCTAssertEqual(millionMoney.unit, "M")

        let billionMoney = Money.from(value: 30000000000.00)
        XCTAssertEqual(billionMoney.unit, "B")

        let thrillionMoney = Money.from(value: 3000000000000.00)
        XCTAssertEqual(thrillionMoney.unit, "T")

        let gazillionMoney = Money.from(value: 3000000000000000.00)
        XCTAssertEqual(gazillionMoney.unit, "G")

        let petillionMoney = Money.from(value: 3000000000000000000.00)
        XCTAssertEqual(petillionMoney.unit, "P")

        let etillionMoney = Money.from(value: 3000000000000000000000.00)
        XCTAssertEqual(etillionMoney.unit, "E")
    }

    func testSuffixAmount() {
        let thousandMoney = Money.from(value: 30000.00)
        XCTAssertEqual(thousandMoney.suffixAmount, "+30K")

        let millionMoney = Money.from(value: 3000000.00)
        XCTAssertEqual(millionMoney.suffixAmount, "+3M")

        let billionMoney = Money.from(value: -30000000000.00)
        XCTAssertEqual(billionMoney.suffixAmount, "-30B")

        let thrillionMoney = Money.from(value: 3000000000000.00)
        XCTAssertEqual(thrillionMoney.suffixAmount, "+3T")

        let gazillionMoney = Money.from(value: -3000000000000000.00)
        XCTAssertEqual(gazillionMoney.suffixAmount, "-3G")

        let petillionMoney = Money.from(value: 3000000000000000000.00)
        XCTAssertEqual(petillionMoney.suffixAmount, "+3P")

        let etillionMoney = Money.from(value: 3000000000000000000000.00)
        XCTAssertEqual(etillionMoney.suffixAmount, "+3E")
    }

    func testValue() {
        let money = Money.from(value: 430.65)

        XCTAssertEqual(money.doubleValue, 430.65)

        XCTAssertEqual(money.intValue, 430)
    }

    func testLocalBalanceText() {
        let money = Money.from(value: 1234.23)
        XCTAssertEqual(money.localizedBalance, "₦1,234.23K")
    }

    func testBalancePostableToBackend() {
        let money = Money.from(value: 1234.23)
        XCTAssertEqual(money.backendDecimalPostableAmount, 123423)
        XCTAssertEqual(money.backendIntegerPostableAmount, 123400)
    }

    func testChangeCurrency() {
        let money = Money.from(value: 1234.23)
        XCTAssertEqual(money.localized, "₦1,234.23")
        XCTAssertEqual(money.currency.symbol, "₦")

        let moneyWithNewCurrency = money.newWith(currency: usDollarCurrency)
        XCTAssertEqual(moneyWithNewCurrency.localized, "$1,234.23")
        XCTAssertEqual(moneyWithNewCurrency.currency.symbol, "$")

        XCTAssertEqual(money.currency.symbol, "₦")

        let moneyWithNoSymbolCurrency = money.newWith(currency: noSymbolCurrency)
        XCTAssertEqual(moneyWithNoSymbolCurrency.localized, "1,234.23")
        XCTAssertEqual(moneyWithNoSymbolCurrency.currency.symbol, .empty)
        XCTAssertEqual(moneyWithNoSymbolCurrency.currency.localizedSymbol, .empty)
    }

    func testChangeCurrencyWithCode() {
        let money = Money.from(value: 1234.23)

        let dollarCurrency = Money.Currency.from(code: "$")
        let newDollarCurrencyMoney = money.newWith(currency: dollarCurrency)
        XCTAssertEqual(newDollarCurrencyMoney.localized, "$1,234.23")

        let nairaCurrency = Money.Currency.from(code: "₦")
        let newNairaCurrencyMoney = money.newWith(currency: nairaCurrency)
        XCTAssertEqual(newNairaCurrencyMoney.localized, "₦1,234.23")
    }
}
