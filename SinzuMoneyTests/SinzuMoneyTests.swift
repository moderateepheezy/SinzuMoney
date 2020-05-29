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

    func testSimpleMoney() {
        let money = Money.from(value: -10)
        let abosuluteMoney = money.absoluteValue
        XCTAssertEqual(abosuluteMoney.doubleValue, 10)

        let zeroMoney = Money.zero
        XCTAssertEqual(zeroMoney.doubleValue, 0)
    }

    func testLocalizeDashableMoney() {
        let money = Money.from(value: 10.32)

        let localizeDashableMoney = money.localizedDashable
        XCTAssertEqual(localizeDashableMoney, "₦10.32")
    }

    func testLocalizeDashableZeroMoney() {
        let localizeDashableZeroMoney = Money.zero.localizedDashable
        XCTAssertEqual(localizeDashableZeroMoney, "-")
    }

    func testIntLocalizedMoney() {
        let localizedMoney = Money.from(value: 10000000.72)
        let localized = localizedMoney.integerLocalized
        XCTAssertEqual(localized, "₦10,000,000")
    }

    func testLocalizedMoney() {
        let localizedMoney = Money.from(value: 10000000.32)
        let localized = localizedMoney.localized
        XCTAssertEqual(localized, "₦10,000,000.32M")
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
}
