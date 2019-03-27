//
//  ImageViewController.swift
//  RxSwiftPrimer
//
//  Created by Son Le on 4/18/18.
//  Copyright © 2018 Son Le. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ImageViewController: UIViewController {

    private var viewModel: ImageViewModel!
    private let bag = DisposeBag()

    // MARK: - Outlets

    @IBOutlet private var urlTextField: UITextField!
    @IBOutlet private var fetchButton: UIButton!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    // MARK: - Init

    static func newInstance(viewModel: ImageViewModel) -> ImageViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ImageViewController
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up bindings from view model observables to UI elements
        // and from UI events to view model observers here.
    }
}
