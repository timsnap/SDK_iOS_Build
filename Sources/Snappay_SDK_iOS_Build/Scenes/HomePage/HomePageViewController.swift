//
//  HomePageViewController.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import UIKit

class HomePageViewController: UIViewController {
    private let userData: UserData
    var homePageView: HomePageView?
    var viewModel: HomePageViewModelDelegate!
    var backButtonDidTap: (() -> Void)?
    var configurator: HomePageConfiguratorProtocol = HomePageConfigurator()
    
    init(userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configurator.configure(with: HomePageNetworkService(), viewController: self)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.homeVcDelegate = self
        animateImage()
        saveApiKey(apiKey: userData.apiKey ?? "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopAnimation()
    }
    
    func attachView(_ displayView: HomePageView) {
        self.homePageView = displayView
    }
}

extension HomePageViewController {
    func setupViews() {
        view.backgroundColor = .white
        guard let homePageView = homePageView else { return }
        homePageView.backButtonDidTap = backButtonDidTap
        view.addSubview(homePageView)
        homePageView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
        setupImage()
        setupScanDidTap()
    }
    
    func setupImage() {
        homePageView?.logo.image = userData.logo
        homePageView?.setupLabel(text: "\(userData.amount.delimiterRefactored)")
    }
}

extension HomePageViewController: HomeVcDelegate{
    func startChallengeError(error: Error) {
        // TODO: Track Error then display
        if !error.localizedDescription.isEmpty {
            DispatchQueue.main.async {
                self.view.removeSnappayLoader()
                self.stopAnimation()
                self.customAlert(
                    errorMessage: error.localizedDescription,
                    errorTitle: "⚠️"
                )
            }
        }
    }
    
    func startChallengeData(data: StartChallenge) {
        if data.errors == nil {
            let cameraVC = CameraViewController()
            cameraVC.attachView(CameraView())
            self.view.removeSnappayLoader()
            cameraVC.startChallenge = data
            saveToken(token: data.data?.token ?? "")
            self.navigationController?.pushViewController(cameraVC, animated: true)
        } else {
            self.view.removeSnappayLoader()
            self.stopAnimation()
            self.customAlert(
                errorMessage: "Incorrect Api Key",
                errorTitle: data.errors?.first ?? ""
            )
        }
    }
    
    /// saveToken
    /// - Parameter token: token has a type String
    private func saveToken(token: String) {
        do {
            try KeyChainManager.save(
                service: "snappay.com",
                account: "snappayAdmin",
                token: token.data(using: .utf8)
                ?? Data()
            )
        } catch {}
    }
    
    
    /// saveApiKey
    /// - Parameter token: apiKey has a type String
    private func saveApiKey(apiKey: String) {
        do {
            try KeyChainManager.save(
                service: "snappay.com",
                account: "snappayApiKey",
                token: apiKey.data(using: .utf8)
                ?? Data()
            )
        } catch {}
    }
}

private extension HomePageViewController {
    func setupScanDidTap() {
        homePageView?.scanButtonDidTap = {
            self.view.showSnappayLoader()
            self.viewModel?.startChallenge(userData: self.userData)
        }
    }
}


extension HomePageViewController: CAAnimationDelegate {
    private func setupRippleAnimation(to referenceView: UIView?) {
        referenceView?.addRippleAnimation(
            color: UIColor().loadColor(named: "SnappayPrimary") ?? UIColor(),
            startReset: false,
            handler: { animation in
                animation.delegate = self
            }
        )
    }
    
    private func animateImage() {
        setupRippleAnimation(to: homePageView?.scanImageContainer)
    }
    
    private func stopAnimation() {
        DispatchQueue.main.async {
            self.homePageView?.scanImageContainer.removeRippleAnimation()
        }
    }
}
