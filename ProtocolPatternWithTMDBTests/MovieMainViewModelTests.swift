//
//  MovieMainViewModelTests.swift
//  ProtocolPatternWithTMDBTests
//
//  Created by iMac on 2022/06/10.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest

@testable import ProtocolPatternWithTMDB

final class MovieMainViewModelTests: XCTestCase {
    private var viewModel: MovieMainViewModelType!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        viewModel = MovieMainViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        disposeBag = nil
        scheduler = nil
    }

    func testNumber() throws {
        // ViewModel output(결과 옵저버블을 테스트 형태로 만들어서 주입)
        scheduler.createHotObservable([
            .next(500, 105),
            .next(1000, 205)
        ])
            .bind(to: viewModel.outputs.number)
            .disposed(by: disposeBag)

        let observer = scheduler.createObserver(Int.self)

        viewModel.outputs.number
            .bind(to: observer)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(observer.events, [
            .next(0, 100),
            .next(500, 105),
            .next(1000, 205)
        ])
    }

    func test_request_function() {
        let tapMovieButton = scheduler.createHotObservable([
            .next(0, Void())
        ])

        tapMovieButton.bind(to: viewModel.inputs.userTap)
            .disposed(by: disposeBag)

        let observer = scheduler.createObserver(Int.self)

        viewModel.outputs.number
            .bind(to: observer)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(observer.events, [
            .next(0, 100),
            .next(0, 10)
        ])
    }
}
