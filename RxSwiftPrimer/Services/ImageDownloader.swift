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
        return Observable.create { (observer) in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    observer.onError(Error.other(error))
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    observer.onError(Error.invalidData)
                    return
                }
                observer.onNext(image)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
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
