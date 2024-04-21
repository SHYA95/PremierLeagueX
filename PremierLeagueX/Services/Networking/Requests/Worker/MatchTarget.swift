//
//  MatchTarget.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 19/04/2024.
//

import Foundation
import Alamofire

enum MatchTarget {
    case getMatches
}

extension MatchTarget: TargetType {
    var baseURL: String {
        return Constant.baseURL
    }
    
    var path: String {
        switch self {
      
        case .getMatches:
            return "competitions/2021/matches"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getMatches:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMatches:
            return .requestPlain
        }
    }
    
    var headers: [String : String] {
        return Header.shared.createHeader()
    }
}
