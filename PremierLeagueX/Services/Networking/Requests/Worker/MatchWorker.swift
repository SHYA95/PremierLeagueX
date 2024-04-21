//
//  MatchWorker.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 19/04/2024.
//

import Foundation
import Alamofire


protocol MatchWorkerProtocol {
    
    
    /// it is the method used to fetch cart products.
    /// - Parameters:
    ///   - completion: that carry a success or failure response.
    ///
    func fetchMatches(completion: @escaping (Result<MatchResponse, AppErrorType>) -> Void)
   
}


class MatchWorker: APIClient<MatchTarget>, MatchWorkerProtocol {
    func fetchMatches(completion: @escaping (Result<MatchResponse, AppErrorType>) -> Void) {
        performRequest(target: .getMatches, param: nil as Empty?, completion: completion)
    }
}


