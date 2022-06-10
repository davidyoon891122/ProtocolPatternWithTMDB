//
//  MovieMainViewController.swift
//  ProtocolPatternWithTMDB
//
//  Created by iMac on 2022/06/10.
//

import UIKit
import RxSwift
import SnapKit

final class MovieMainViewController: UIViewController {
    private lazy var movieButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setImage(UIImage(systemName: "button.programmable"), for: .normal)
        return button
    }()

    var viewModel = MovieMainViewModel()
    let disposeBag = DisposeBag()

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
            movieButton
        ]
            .forEach {
                view.addSubview($0)
            }

        movieButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

    func bind() {
        viewModel.outputs.number
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
