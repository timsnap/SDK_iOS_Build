import UIKit

public class Snappay_SDK_iOS_Build {
    
    private let userData: UserData
    private lazy var homePageViewController: HomePageViewController = {
        let controller = HomePageViewController(userData: userData)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        controller.attachView(HomePageView())
        return controller
    }()
    
    public init(userData: UserData) {
        self.userData = userData
    }
    
    /// launchSnappaySDK
    /// - Parameter rootVC: pass the root ViewController
    public func launchSnappaySDK(rootVC: UIViewController) {
        rootVC.present(homePageViewController, animated: true)
    }
    
    /// dismissSnappaySDK dismisses the snappay SDK
    public func dismissSnappaySDK() {
        
    }
}
