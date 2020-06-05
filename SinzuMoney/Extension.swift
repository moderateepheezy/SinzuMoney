//
//  Extension.swift
//  SinzuMoney
//
//  Created by Afees Lawal on 02/05/2020.
//  Copyright © 2020 Afees Lawal. All rights reserved.
//

import Foundation

extension String {
    var withEndSpace: String {
        return self + " "
    }

    static var empty: String {
        return ""
    }

    var separatorNumberConvertible: String {
        return replacingOccurrences(of: String(Locale.current.decimalSeparator?.first ?? ","), with: ".")
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Double {
    var commaSeparatedFromStringAmount: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSize = 3
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: self)) ?? .empty
    }
}

extension Int {
    var commaSeparatedFromStringAmount: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSize = 3
        return numberFormatter.string(from: NSNumber(value: self)) ?? .empty
    }
}
