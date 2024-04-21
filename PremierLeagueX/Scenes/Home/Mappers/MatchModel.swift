//
//  MatchModel.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 20/04/2024.
//

import Foundation
import UIKit

struct MatchModel {
    let id: Int?
    let status: String?
    let homeTeam: String?
    let awayTeam: String?
    let info: String?
    let matchDay: String?
    let date: String?
    let homeScore: Int?
    let awayScore: Int?
    var isFav: Bool = false
    var statusBackround: UIColor?

    init(match: Match) {
        self.id = match.id
        self.status = match.status?.rawValue.capitalized
        homeScore = match.score?.extraTime?.homeTeam ?? match.score?.fullTime?.homeTeam ?? match.score?.halfTime?.homeTeam
        awayScore = match.score?.extraTime?.awayTeam ?? match.score?.fullTime?.awayTeam ?? match.score?.halfTime?.awayTeam
        date = Utilities.convertUTCtoYYYYMMDD(match.utcDate)
        if match.status == .finished {
            self.info = "\(homeScore ?? 0) - \(awayScore ?? 0)"
        } else {
            self.info = Utilities.convertUTCtoHHMM(match.utcDate)
        }
        self.matchDay = "\(Constants.MATCHDAY)\(match.matchday ?? 0)"
        self.homeTeam = match.homeTeam?.name
        self.awayTeam = match.awayTeam?.name
        if match.status == .finished {
            statusBackround = UIColor.systemIndigo
        } else {
            statusBackround = UIColor.systemGreen
        }
       

    }
    
}

extension MatchModel {
    init(favoriteMatch: FavoriteMatch, isFav: Bool) {
        self.id = Int(favoriteMatch.id)
        self.status = favoriteMatch.status ?? "Pending"
        self.homeTeam = favoriteMatch.homeTeam
        self.awayTeam = favoriteMatch.awayTeam
        self.info = favoriteMatch.info
        self.matchDay = favoriteMatch.matchDay
        self.date = favoriteMatch.date
        self.homeScore = Int(favoriteMatch.homeScore)
        self.awayScore = Int(favoriteMatch.awayScore)
        self.isFav = favoriteMatch.isFav
        if favoriteMatch.status == "finished" {
            self.statusBackround = UIColor.systemIndigo
        } else {
            self.statusBackround = UIColor.systemGreen
        }
    }
}
