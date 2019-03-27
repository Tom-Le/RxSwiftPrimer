//
//  AppDelegate.swift
//  RxSwiftPrimer
//
//  Created by Son Le on 4/18/18.
//  Copyright © 2018 Son Le. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        #if MOCK
        let imageDownloader = MockImageDownloader()
        #else
        let imageDownloader = ImageDownloader()
        #endif
        let viewModel = ImageViewModel(imageDownloader: imageDownloader)
        window?.rootViewController = ImageViewController.newInstance(viewModel: viewModel)
        window?.makeKeyAndVisible()
        return true
    }
}
