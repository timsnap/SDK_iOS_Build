//
//  Endpoint.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import Foundation

protocol EndpointProtocol {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: String { get }
}

enum Endpoint: EndpointProtocol {
    
    case startChallenge(data: UserData)
    case uploadChallenge(base64String: String, fileExtension: String)
    case verifyChallenge
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "x2hcjbrp5m.execute-api.eu-west-2.amazonaws.com"
        }
    }
    
    var path: String {
        switch self {
        case .startChallenge(data: _):
            return "/Prod/api/challenge/start"
        case .uploadChallenge(base64String: _, fileExtension: _):
            return "/Prod/api/challenge/upload"
        case .verifyChallenge:
            return "/Prod/api/challenge/verify"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .startChallenge(let data):
            return [
                AppString.phoneNumber.localisedValue: data.phoneNumber,
                AppString.clientCode.localisedValue: data.clientCode,
                AppString.imageHeight.localisedValue: data.imageHeight,
                AppString.imageWidth.localisedValue: data.imageWidth
            ]
        case .uploadChallenge(base64String: let base64String,fileExtension: let fileExtension):
            return [
                "image": base64String,
                "fileExtension": fileExtension
            ]
        case .verifyChallenge:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .verifyChallenge:
            return "GET"
        default:
            return "POST"
        }
    }
    
}
