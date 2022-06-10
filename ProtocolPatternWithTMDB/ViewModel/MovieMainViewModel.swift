//
//  MovieMainViewModel.swift
//  ProtocolPatternWithTMDB
//
//  Created by iMac on 2022/06/10.
//

import RxSwift
import RxRelay
import RxCocoa

protocol MovieMainViewModelInput {
    func requestMovieTitles()
    func sortTitles()
    func request1()
    var userTap: PublishSubject<Void> { get }
}

protocol MovieMainViewModelOutput {
    var number: BehaviorRelay<Int> { get }
    var movieTitleObservable: BehaviorSubject<[String]> { get }
}

protocol MovieMainViewModelType {
    var inputs: MovieMainViewModelInput { get }
    var outputs: MovieMainViewModelOutput { get }
}

final class MovieMainViewModel: MovieMainViewModelType, MovieMainViewModelOutput, MovieMainViewModelInput {
    var userTap: PublishSubject<Void> = .init()

    let disposeBag = DisposeBag()
    var number: BehaviorRelay<Int>

    let model: MovieModel

    var movieTitleObservable: BehaviorSubject<[String]> = .init(value: ["The Apple", "Mac", "Test"])

    init() {
        model = MovieModel()
        number = model.number

        userTap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.number.accept(10)
        })
            .disposed(by: disposeBag)
    }

    var inputs: MovieMainViewModelInput { return self }

    var outputs: MovieMainViewModelOutput { return self }

    func requestMovieTitles() {
        print("requestMovieTitles")

    }

    func sortTitles() {
        print("sortTitles")
    }

    func request1() {
        print("request1")
        self.number.accept(10)
    }

}
