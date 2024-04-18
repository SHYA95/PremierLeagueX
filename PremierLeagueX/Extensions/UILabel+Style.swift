//
//  UILabel+Style.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 19/04/2024.
//

import UIKit

extension UILabel {
    enum LabelStyle {
        case textStyle
        case textStyle2
    }

    func applyStyle(_ style: LabelStyle) {
        switch style {
        case .textStyle:
            textColor = .white
            font = UIFont.systemFont(ofSize: 28, weight: .medium)
        case .textStyle2:
            textColor = .black
            font = UIFont.systemFont(ofSize: 18, weight: .regular)
        }
    }
}
