//
//  Season.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 19/04/2024.
//

import Foundation

struct Season: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
}
