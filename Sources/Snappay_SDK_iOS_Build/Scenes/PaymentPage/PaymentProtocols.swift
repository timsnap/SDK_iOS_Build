////
////  File.swift
////  
////
////  Created by Timothy Obeisun on 11/22/22.
////
//
//import Foundation
//
//protocol PaymentNetworkServiceProtocol {
//    func verifyChallenge(completion: @escaping (Result<VerifyChallengeData, Error>) -> Void)
//}
//
//protocol PaymentViewConfiguratorProtocol: AnyObject {
//    func configure(
//        with networkService: PaymentNetworkServiceProtocol,
//        viewController: PaymentViewController
//    )
//}
//
//
//protocol PaymentViewModelDelegate: AnyObject {
//    func verifyChallenge()
//    var paymentViewDelegate: PaymentViewDelegate? {set get }
//}
//
//protocol PaymentViewDelegate {
//    func verifyChallengeData(data: VerifyChallengeData)
//    func verifyChallengeError(error: Error)
//}
