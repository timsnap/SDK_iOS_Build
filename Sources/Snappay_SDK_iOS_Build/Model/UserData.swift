//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import UIKit

// MARK: - UserData
public struct UserData {
    let logo: UIImage
    let phoneNumber: String
    let clientCode: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let apiKey: String?
    let amount: Double
    let receipientName: String
    let sender: String
    
    public init(
        logo: UIImage,
        phoneNumber: String,
        clientCode: String,
        imageWidth: CGFloat,
        imageHeight: CGFloat,
        apiKey: String?,
        amount: Double,
        receipientName: String,
        sender: String
    ) {
        self.logo = logo
        self.phoneNumber = phoneNumber
        self.clientCode = clientCode
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.apiKey = apiKey
        self.amount = amount
        self.receipientName = receipientName
        self.sender = sender
    }
}
