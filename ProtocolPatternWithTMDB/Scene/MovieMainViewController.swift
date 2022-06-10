//
//  MovieMainViewController.swift
//  ProtocolPatternWithTMDB
//
//  Created by iMac on 2022/06/10.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa

final class MovieMainViewController: UIViewController {
    private let viewModel = MovieMainViewModel()

    private let disposeBag = DisposeBag()

    private lazy var movieButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()

    private lazy var movieTitleTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        bind()
    }
}

private extension MovieMainViewController {
    func setupViews() {
        [
            movieButton,
            movieTitleTableView
        ]
            .forEach {
                view.addSubview($0)
            }
    }

    func bind() {
        viewModel.outputs.number
            .debug()
            .subscribe(onNext: { number in
                print(number)
            })
            .disposed(by: disposeBag)

        movieButton.rx.tap
            .subscribe(onNext: {
                self.viewModel.inputs.request1()
            })
            .disposed(by: disposeBag)
    }
}
