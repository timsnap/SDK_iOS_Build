//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/16/22.
//

import UIKit

extension UIColor {
    public func loadColor(named name: String) -> UIColor? {
        UIColor(named: name, in: Bundle.module, compatibleWith: nil)
    }
}
