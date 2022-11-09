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
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        case .startChallenge(data: _):
            return "cevn50cvtl.execute-api.eu-west-2.amazonaws.com"
        }
    }
    
    var path: String {
        switch self {
        case .startChallenge(data: _):
            return "/Prod/api/challenge/start"
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
        }
    }
    
    var method: String {
        switch self {
        default:
            return "POST"
        }
    }
    
}
