//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/12/22.
//

import UIKit

extension UIViewController {
    func customAlert(errorMessage: String, errorTitle: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in completion()})
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

