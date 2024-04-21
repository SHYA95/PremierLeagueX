//
//  MatchResponse.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 19/04/2024.
//

import Foundation

struct MatchResponse: Codable {
    let count: Int?
    let competition: Competition?
    let matches: [Match]?
}
