//
//  Competesion.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 19/04/2024.
//

import Foundation

struct Competition: Codable {
    let id: Int?
    let area: Area?
    let name, code, plan: String?
    let lastUpdated: String?
}
