//
//  AppString.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import Foundation

public enum AppString:String {
    public var localisedValue:String {
        return self.rawValue.getLocalizedValue()
    }
    
    case emptyString
    case scanButtonTitle
    case imageWidth
    case imageHeight
    case clientCode
    case phoneNumber
}
