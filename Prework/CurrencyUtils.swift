//
//  CurrencyUtils.swift
//  Prework
//
//  Created by Hong Ha Vo on 10/6/16.
//  Copyright © 2016 Hong Ha Vo. All rights reserved.
//

import Foundation

class CurrencyUtils {
    
    let formatter = NumberFormatter()
    
    
    static func formatNumb()-> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.currencySymbol
    }
    
    static func localeCurrency(_ value:NSNumber)->String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.currencySymbol = ""
        return formatter.string(from: value)!
    }
}
