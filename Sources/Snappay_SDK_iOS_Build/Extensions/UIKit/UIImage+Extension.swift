//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/11/22.
//

import UIKit

extension UIImage {
    public func loadImage(named name: String) -> UIImage? {
        UIImage(named: name, in: Bundle.module, compatibleWith: nil)
    }
}
