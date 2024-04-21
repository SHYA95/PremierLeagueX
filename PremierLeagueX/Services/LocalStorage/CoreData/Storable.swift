//
//  Storable.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 20/04/2024.
//


import Foundation

protocol Storable {
    func getFavoriteMatches() -> [MatchModel]
    func insertMatch(_ match: MatchModel)
    func removeFavMatche(with id: Int32)
}
