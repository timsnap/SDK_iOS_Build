
import UIKit

public protocol SnappaySDKiOSBuildDelegate: AnyObject {
    func backButtonDidTap()
}

public class Snappay_SDK_iOS_Build {
    
    private let userData: UserData
    private var rootVc: UIViewController?
    public weak var delegate: SnappaySDKiOSBuildDelegate?
    private lazy var homePageViewController: HomePageViewController = {
        let controller = HomePageViewController(userData: userData)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        controller.attachView(HomePageView())
        controller.backButtonDidTap = { [weak self] in
            self?.delegate?.backButtonDidTap()
        }
        return controller
    }()
    
    public init(userData: UserData) {
        self.userData = userData
    }
    
    /// launchSnappaySDK
    /// - Parameter rootVC: pass the root ViewController
    public func launchSnappaySDK(rootVC: UIViewController) {
        self.rootVc = rootVC
        rootVC.navigationController?.pushViewController(homePageViewController, animated: true)

    }
    
    /// dismissSnappaySDK dismisses the snappay SDK
    public func dismissSnappaySDK() {
        homePageViewController.navigationController?.popViewController(animated: true)
    }
}
