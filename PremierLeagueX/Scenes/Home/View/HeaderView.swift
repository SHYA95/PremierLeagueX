//
//  HeaderView.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 19/04/2024.
//

import UIKit

class HeaderView: UIView {

    // MARK: Init
    
    @IBOutlet var contantView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        loadViewFromNib()
        configureUI()
        configureLocalized()
    }
}


// MARK: Configurations

extension HeaderView {
    private func configureUI() {
        titleLabel.applyStyle(.textStyle)
        contantView.applyGradient(colors: [.purple, .systemIndigo]) 
        contantView.layer.cornerRadius = 12
        contantView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        contantView.layer.shadowColor = UIColor.black.cgColor
        contantView.layer.shadowOpacity = 0.3
        contantView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contantView.layer.shadowRadius = 4
        
        // Add animation
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 0.5
        contantView.layer.add(fadeInAnimation, forKey: "fadeInAnimation")
    }
    
    private func configureLocalized() {
        titleLabel.text = Constants.APP_TITLE
    }
}
