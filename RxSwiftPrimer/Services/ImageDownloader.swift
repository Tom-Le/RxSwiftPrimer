//
//  ImageDownloader.swift
//  RxSwiftPrimer
//
//  Created by Son Le on 4/18/18.
//  Copyright © 2018 Son Le. All rights reserved.
//

import UIKit
import RxSwift

protocol ImageDownloading {
    func getImage(at: URL) -> Observable<UIImage>
}

final class ImageDownloader: ImageDownloading {
    enum Error: Swift.Error {
        case invalidData
        case other(Swift.Error)
    }

    func getImage(at url: URL) -> Observable<UIImage> {
        // Replace this method with one that returns an observable that downloads the image
        // at the given URL on subscription.
        return Observable.error(Error.invalidData)
    }
}

final class MockImageDownloader: ImageDownloading {
    enum Error: Swift.Error {
        case noImage
    }

    var image = UIImage(named: "catloaf")

    func getImage(at: URL) -> Observable<UIImage> {
        guard let image = image else { return .error(Error.noImage) }
        return .just(image)
    }
}
