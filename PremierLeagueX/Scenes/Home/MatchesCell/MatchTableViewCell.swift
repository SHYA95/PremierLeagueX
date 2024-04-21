//
//  MatchTableViewCell.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 20/04/2024.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var matchStatusView: UIView!
    @IBOutlet weak var matchStatusLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var matchInfoLabel: UILabel!
    @IBOutlet weak var matchdayLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    // MARK: Properties
    
    var match: MatchModel!
    var favButtonTapped: ((MatchModel) -> Void)?
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        favButton.addTarget(self, action: #selector(favButtonPressed(_:)), for: .touchUpInside)
        Utilities.makeCellBorderRadius(cell: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 4, right: 16))
    }
    
    // MARK: Updates
    
    func update(match: MatchModel) {
        homeTeamLabel.text = match.homeTeam
        awayTeamLabel.text = match.awayTeam
        matchStatusLabel.text = match.status
        matchInfoLabel.text = match.info
        matchdayLabel.text = match.matchDay
        if match.isFav {
            favButton.setImage(UIImage(systemName: Constants.HEART_FILLED_ICON)?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
            favButton.tintColor = .red
        } else {
            favButton.setImage(UIImage(systemName: Constants.HEART_ICON)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        }
        matchStatusView.backgroundColor = match.statusBackround
        self.match = match
    }

    // MARK: Action
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
        favButtonTapped?(match)
    }
    
    // MARK: Configurations

    private func configureUI() {
        homeTeamLabel.applyStyle(.textStyle3)
        awayTeamLabel.applyStyle(.textStyle3)
        matchStatusLabel.applyStyle(.textStyle2)
        matchInfoLabel.applyStyle(.textStyle4)
        matchdayLabel.applyStyle(.textStyle5)
        matchStatusView.layer.cornerRadius = 10
        matchStatusView.layer.masksToBounds = true
    }
}
