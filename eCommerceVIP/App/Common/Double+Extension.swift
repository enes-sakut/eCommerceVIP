//
//  Double+Extension.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 17.04.2023.
//

import Foundation

extension Double {
    var priceFormatted: String {
        let amount = Double(self)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "tr-TR")
        return numberFormatter.string(from: NSNumber(value: amount)) ?? "0"
        
    }
}
