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
        case textStyle3
        case textStyle4
        case textStyle5
    }

    func applyStyle(_ style: LabelStyle) {
        switch style {
        case .textStyle:
            textColor = .white
            font = UIFont.systemFont(ofSize: 28, weight: .medium)
        case .textStyle2:
            textColor = .white
            font = UIFont.systemFont(ofSize: 18, weight: .regular)
        case .textStyle3:
            textColor = .black
            font = UIFont.systemFont(ofSize: 18, weight: .medium)
        case .textStyle4:
            textColor = .purple
            font = UIFont.systemFont(ofSize: 18, weight: .bold)
        case .textStyle5:
            textColor = .gray
            font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
}
