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


    func testPositiveMoney() {
        let money = Money.from(value: -200.34).positive
        XCTAssertEqual(money.doubleValue, 200.34)
    }

    func testZeroMoney() {
        let money = Money.zero
        XCTAssertEqual(money.doubleValue, 0)
    }
}
