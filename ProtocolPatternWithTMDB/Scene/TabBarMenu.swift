//
//  TabBarMenu.swift
//  ProtocolPatternWithTMDB
//
//  Created by iMac on 2022/06/14.
//

import Foundation
import UIKit

enum TabBarMenu {
    case movie
    case settings

    var title: String {
        switch self {
        case .movie:
            return "Movie Reviews"
        case .settings:
            return "Settings"
        }
    }

    var icon: (
        default: UIImage?,
        selected: UIImage?
    ) {
        switch self {
        case .movie:
            return (
                UIImage(systemName: ""),
                UIImage(systemName: "")
            )
        case .settings:
            return (
                UIImage(systemName: ""),
                UIImage(systemName: "")
            )
        }
    }
}
