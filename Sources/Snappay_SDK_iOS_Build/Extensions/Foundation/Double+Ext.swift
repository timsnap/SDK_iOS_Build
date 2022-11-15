//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/15/22.
//

import Foundation

extension Double {
    var delimiterRefactored: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        let groupingSeparator = ","
        // formatter.positiveFormat = "###,###"
        // formatter.negativeFormat = "-###,###"
        numberFormatter.groupingSeparator = groupingSeparator
        
        numberFormatter.locale = Locale(identifier: "yo_NG")
        if let value = numberFormatter.string(from: NSNumber(value:  self )){
            if self.isEqual(to: Double(Int(self))){
                let endIndex = value.index(value.endIndex, offsetBy: -3)
                return String(value[..<endIndex])
            }else{
                return  value
            }
            
        }else{
            return "0"
        }
    }
}
