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
}

protocol MovieMainViewModelOutput {
    var number: Observable<Int> { get }
}

protocol MovieMainViewModelType {
    var inputs: MovieMainViewModelInput { get }
    var outputs: MovieMainViewModelOutput { get }
}

final class MovieMainViewModel: MovieMainViewModelType, MovieMainViewModelOutput {
    let disposeBag = DisposeBag()
    var number: Observable<Int>

    let model: MovieModel

    init() {
        model = MovieModel()
        self.number = model.number.asObservable()
    }

    var inputs: MovieMainViewModelInput { return self }

    var outputs: MovieMainViewModelOutput { return self }

}

extension MovieMainViewModel: MovieMainViewModelInput {
    func request1() {
        print("request1")
    }

    func requestMovieTitles() {
        print("requestMovieTitles")
    }

    func sortTitles() {
        print("sortTitles")
    }
}
