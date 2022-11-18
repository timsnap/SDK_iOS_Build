//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/18/22.
//

import Foundation

// MARK: - UploadChallengeRequest
public struct UploadChallengeRequest: Codable {
    let image: String
    let fileExtension: String
}

// MARK: - UploadChallenge
public struct UploadChallenge: Codable {
    let errors: [String]?
    let data: UploadChallengeData?
    let statusCode: Int
}

// MARK: - UploadChallengeData
public struct UploadChallengeData: Codable {
    let successful: String?
    let result: String?
}
