//
//  String+Extension.swift
//
//
//  Created by Timothy Obeisun on 11/9/22.
//

import Foundation

extension String {
    func getLocalizedValue() -> String{
        return NSLocalizedString(
            self,
            comment: ""
        )
    }
}
