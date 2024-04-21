//
//  HomeViewModelType.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//

// HomeViewModelType.swift

import Foundation
import RxSwift
import RxCocoa

typealias HomeViewModelType = HomeViewModelInputs & HomeViewModelOutputs

// MARK: HomeViewModel Inputs

protocol HomeViewModelInputs {
    func fetchMatches()
    func addMatchToFavorites(match: MatchModel) 
    func removeFavMatches(with id: Int32)
    func fetchMatchesFromCoreData()
}

// MARK: HomeViewModel Outputs

protocol HomeViewModelOutputs {
    var reloadTableViewObservable: Observable<Void> { get }
    var errorMessageObservable: Observable<AppErrorType> { get }
    var  matches: BehaviorRelay<[MatchModel]> { get }
    func numberOfSections() -> Int
    func numberOfMatches(inSection section: Int) -> Int
    func sectionTitle(for section: Int) -> String?
    func groupMatchesByDay(_ matches: [MatchModel])
}
