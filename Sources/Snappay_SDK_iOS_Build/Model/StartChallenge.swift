//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import Foundation

// MARK: - StartChallenge
struct StartChallenge: Codable {
    let errors: [String]?
    let data: StartChallengeData?
    let statusCode: Int
}

// MARK: - StartChallengeData
struct StartChallengeData: Codable {
    let imageWidth,
        imageHeight,
        noseWidth,
        noseHeight,
        areaHeight,
        minFaceAreaPercent,
        noseLeft,
        noseTop: Int
    let areaLeft,
        areaTop,
        areaWidth: Double
    let token: String
}
