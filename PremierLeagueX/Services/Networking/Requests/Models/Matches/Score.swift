//
//  Score.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 19/04/2024.
//

import Foundation

struct Score: Codable {
    let winner: Winner?
    let duration: String?
    let fullTime, halfTime, extraTime, penalties: ExtraTime?
}

enum Winner: String, Codable {
    case awayTeam = "AWAY_TEAM"
    case draw = "DRAW"
    case homeTeam = "HOME_TEAM"
}
