//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/22/22.
//

import UIKit

public extension UINavigationController {
    func popBackwards(_ nb: Int) {
        let viewControllers: [UIViewController] = self.viewControllers
        guard viewControllers.count < (nb + 1) else {
            self.popToViewController(
                viewControllers[
                    viewControllers.count - (nb + 1)
                ],
                animated:false
            )
            return
        }
    }
}
