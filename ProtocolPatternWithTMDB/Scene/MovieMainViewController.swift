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

final class MovieMainViewController: UIViewController, UITableViewDelegate {
    private let viewModel = MovieMainViewModel()

    private let disposeBag = DisposeBag()

    private lazy var movieButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()

    private lazy var movieTitleTableView: UITableView = {
        let tableView = UITableView()
        _ = tableView.rx.setDelegate(self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        bind()

        if let information = Bundle.main.infoDictionary {
            if let APIKEY = information["TMDB_API_KEY"] as? String {
                print(APIKEY)
            }
        }
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

        movieTitleTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
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

        viewModel.outputs.movieTitleObservable
            .bind(to: movieTitleTableView.rx.items(
                cellIdentifier: "cell",
                cellType: UITableViewCell.self
            )) { index, element, cell in
                print("\(index), \(element), \(cell)")
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
    }
}
