import RxSwift
import RxCocoa

func example(_ description: String, action: () -> Void) {
    print("\n--- \(description) example ---")
    action()
}

example("Observable.just") {
    _ = Observable.just(10)
        .debug("number")
        .subscribe()
}

example("Observable.of") {
    _ = Observable.of(1, 2, 3, 4)
        .debug("numbers")
        .subscribe()
}

example("Observable.create") {
    let task = Observable<Int>.create { (observer) in
        observer.onNext(Int.random(in: 1...100))
        observer.onCompleted()
        return Disposables.create()
    }
    _ = task.debug("random").subscribe()
}

example("map") {
    _ = Observable.from(0...5)
        .map { $0 * 2 }
        .debug("even numbers")
        .subscribe()
}

example("filter") {
    _ = Observable.from(0...10)
        .filter { $0 % 2 != 0 }
        .debug("odd numbers")
        .subscribe()
}

example("scan") {
    _ = Observable.from(1...4)
        .scan("") { (currentString, nextDigit) in "\(currentString)\(nextDigit)" }
        .debug("big number")
        .subscribe()
}

example("flatMap") {
    _ = Observable.of("hello", "world")
        .flatMap { (word) -> Observable<String> in
            let characters = [Character](word)
            return Observable.from(characters).map { "\(word) - \($0)" }
        }
        .debug("characters")
        .subscribe()
}

example("flatMapLatest") {
    _ = Observable.of("hello", "world")
        . flatMapLatest { (word) -> Observable<String> in
            let characters = [Character](word)
            return Observable.from(characters).map { "\(word) - \($0)" }
        }
        .debug("characters")
        .subscribe()
}

example("merge") {
    _ = Observable
        .of(
            Observable.of(0, 2, 4, 6, 8, 10),
            Observable.of(1, 3, 5, 7, 9)
        )
        .merge()
        .debug("merge")
        .subscribe()
}

example("combineLatest") {
    _ = Observable
        .combineLatest(
            Observable.from(0...2),
            Observable.of(true, false)
        )
        .debug("combineLatest")
        .subscribe()
}

example("withLatestFrom") {
    let word = Observable.just("hello")
    _ = Observable.of(0, 1, 2)
        .withLatestFrom(word)
        .debug("withLatestFrom")
        .subscribe()
}

example("subjects") {
    let subject = PublishSubject<Int>()
    _ = subject.debug("subject 1").subscribe()
    subject.onNext(0)
    _ = subject.debug("subject 2").subscribe()
    _ = Observable.from(1...2).bind(to: subject)
}

example("relays") {
    let relay = PublishRelay<Int>()
    _ = relay.debug("relay 1").subscribe()
    relay.accept(0)
    _ = relay.debug("relay 2").subscribe()
    _ = Observable.from(1...2).bind(to: relay)
}
