//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Archit Patel on 2022-02-26.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
