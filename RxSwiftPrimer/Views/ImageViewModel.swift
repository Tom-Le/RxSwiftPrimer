//
//  ImageViewModel.swift
//  RxSwiftPrimer
//
//  Created by Son Le on 4/18/18.
//  Copyright © 2018 Son Le. All rights reserved.
//

import RxSwift
import RxSwiftExt
import RxCocoa

final class ImageViewModel {

    enum Event {
        case started
        case downloaded(UIImage)
        case failed(Error)
    }

    // MARK: - Services

    private let imageDownloader: ImageDownloading

    // MARK: - Observables

    let urlInput = PublishRelay<String?>()
    let image: Observable<UIImage?>
    let isIndicatorActive: Observable<Bool>
    let isInputEnabled: Observable<Bool>

    // MARK: - Init

    init(imageDownloader: ImageDownloading) {
        self.imageDownloader = imageDownloader

        let imageDownloadingEvents = self.urlInput
            .map { (urlString) -> URL? in
                guard let urlString = urlString else { return nil }
                return URL(string: urlString)
            }
            .unwrap()
            .observeOn(SerialDispatchQueueScheduler(qos: .utility))
            .flatMapLatest {
                [imageDownloader = self.imageDownloader]
                (url) -> Observable<Event> in
                return imageDownloader.getImage(at: url)
                    .map { (image) in Event.downloaded(image) }
                    .catchError { (error) in .just(.failed(error)) }
                    .startWith(.started)
            }
            .share()

        image = imageDownloadingEvents
            .map { (event) -> UIImage? in
                guard case .downloaded(let image) = event else { return nil }
                return image
            }
            .observeOn(MainScheduler.instance)

        isIndicatorActive = imageDownloadingEvents
            .map { (event) -> Bool in
                if case .started = event { return true }
                return false
            }
            .observeOn(MainScheduler.instance)

        isInputEnabled = self.isIndicatorActive.map { !$0 }
    }
}
