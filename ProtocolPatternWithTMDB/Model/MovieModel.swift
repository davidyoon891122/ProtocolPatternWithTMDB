//
//  MovieModel.swift
//  ProtocolPatternWithTMDB
//
//  Created by iMac on 2022/06/10.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

struct MovieModel {
    let number = BehaviorRelay(value: 100)
}
