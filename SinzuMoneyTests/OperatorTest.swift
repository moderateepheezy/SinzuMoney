//
//  OperatorTest.swift
//  SinzuMoneyTests
//
//  Created by Afees Lawal on 26/05/2020.
//  Copyright © 2020 Afees Lawal. All rights reserved.
//

import XCTest
@testable import SinzuMoney

class OperatorTest: XCTestCase {

    let usDollarCurrency = Money.Currency(code: "USD", name: "Dollar", symbol: "$", baseUnit: "US Dollar", decimalUnit: "Cent")

    func testAddtionOperator() {
        let aMoney = Money.from(value: 30.5)
        let bMoney = Money.from(value: 50)

        let sumMoney = aMoney + bMoney
        XCTAssertEqual(sumMoney.orZero.doubleValue, 80.5)

        let addToLiteralValueMoney = bMoney + 20
        XCTAssertEqual(addToLiteralValueMoney.doubleValue, 70)
    }

    func testSubtrationOperator() {
        let aMoney = Money.from(value: 30.5)
        let bMoney = Money.from(value: 50)

        let totalMoney = aMoney - bMoney
        XCTAssertEqual(totalMoney.orZero.doubleValue, -19.5)

        let subtractFromLiteralValueMoney = bMoney - 20
        XCTAssertEqual(subtractFromLiteralValueMoney.doubleValue, 30)
    }

    func testMultiplicatioOperator() {
        let aMoney = Money.from(value: 30.5)
        let bMoney = Money.from(value: 50)

        let totalMoney = aMoney * bMoney
        XCTAssertEqual(totalMoney.orZero.doubleValue, 1525)

        let multiplyByLiteralValueMoney = aMoney * 20
        XCTAssertEqual(multiplyByLiteralValueMoney.doubleValue, 610)
    }

    func testDivisionOperator() {
        let aMoney = Money.from(value: 30.5)
        let bMoney = Money.from(value: 50)

        let totalMoney = aMoney / bMoney
        XCTAssertEqual(totalMoney.orZero.doubleValue.rounded(toPlaces: 2), 0.61)

        let multiplyByLiteralValueMoney = aMoney / 20
        XCTAssertEqual(multiplyByLiteralValueMoney.doubleValue.rounded(toPlaces: 2), 1.53)
    }

    func testModulus() {
        let money = Money.from(value: 30.7)

        let mod1Money = money % 2
        XCTAssertEqual(mod1Money.intValue, 0)

        let mod2Money = money % 4
        XCTAssertEqual(mod2Money.intValue, 2)
    }

    func testComparable() {
        let aMoney = Money.from(value: 30.5)
        let bMoney = Money.from(value: 50)
        XCTAssertEqual(aMoney > bMoney, false)
        XCTAssertEqual(aMoney < bMoney, true)
        XCTAssertEqual(aMoney == bMoney, false)
    }

    func testOperatorForDifferentCurrency() {
        let aMoney = Money.from(value: 30.5)
        let bMoney = Money.from(currency: usDollarCurrency, value: 50)

        let sumMoney = aMoney + bMoney
        XCTAssertNil(sumMoney)

        let subtractionTotalMoney = aMoney - bMoney
        XCTAssertNil(subtractionTotalMoney)

        let multiplicationTotalMoney = aMoney * bMoney
        XCTAssertNil(multiplicationTotalMoney)

        let divisionTotalMoney = aMoney / bMoney
        XCTAssertNil(divisionTotalMoney)
    }

}
