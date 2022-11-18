//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/18/22.
//

import Foundation

class CameraViewNetworkService: CameraViewNetworkServiceProtocol {

    let service: NetworkServiceProtocol = NetworkService()
    
    func uploadChallenge(
        image: String,
        fileExtension: String,
        completion: @escaping (Result<UploadChallenge, Error>
        ) -> Void
    ) {
        service.request(
            endpoint: .uploadChallenge(
                base64String: image,
                fileExtension: fileExtension
            ),
            completion: completion
        )
    }
}
