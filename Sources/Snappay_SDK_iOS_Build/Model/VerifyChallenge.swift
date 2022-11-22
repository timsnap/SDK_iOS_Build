//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/21/22.
//

import Foundation

public struct VerifyChallengeData: Codable {
    let errors: [String]?
    let data: String?
    let statusCode: Int
}
