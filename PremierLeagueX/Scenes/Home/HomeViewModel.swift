//  HomeViewModel.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class HomeViewModel: HomeViewModelType {
    
    // MARK: - Properties
    
    var matches = BehaviorRelay<[MatchModel]>(value: [])
    private var favMatches: [MatchModel] = []
    // Observables for reloading table view and error messages
    private let reloadTableViewSubject = PublishSubject<Void>()
    var reloadTableViewObservable: Observable<Void> {
        return reloadTableViewSubject.asObservable()
    }
    
    private let errorMessageSubject = PublishSubject<AppErrorType>()
    var errorMessageObservable: Observable<AppErrorType> {
        return errorMessageSubject.asObservable()
    }
    
    private var matchesGroupedByDay: [String: [MatchModel]] = [:]
    
    // MARK: - Public Methods
    
    // Fetch matches from the service
    func fetchMatches() {
        ServiceLocator.matchWorker.fetchMatches { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let matchResponse):
                var matchModels = matchResponse.toMatchModels()
                // Update isFav property for each match
                matchModels = matchModels.map { match in
                    if self.favMatches.contains(where: { $0.id == match.id }) {
                        var mutableMatch = match
                        mutableMatch.isFav = true
                        return mutableMatch
                    }
                    return match
                }
                self.matches.accept(matchModels) // Assigning matchModels after modification
                self.groupMatchesByDay(matchModels)
                self.reloadTableViewSubject.onNext(())
                
            case .failure(let error):
                self.errorMessageSubject.onNext(error)
            }
        }
    }

    
    func updateFavMatches(with matches: [MatchModel]) {
        favMatches = matches
        reloadTableViewSubject.onNext(())
    }

    func addMatchToFavorites(match: MatchModel) {
        guard !favMatches.contains(where: { $0.id == match.id }) else {
            // Match already exists in favorites, no need to add it again
            return
        }
        
        var updatedMatch = match
        updatedMatch.isFav = true
        favMatches.append(updatedMatch)
        let updatedMatches = matches.value.map { $0.id == updatedMatch.id ? updatedMatch : $0 }
        matches.accept(updatedMatches)
        MatchStorage.shared.insertMatch(updatedMatch)
        reloadTableViewSubject.onNext(())
    }


      func removeFavMatches(with id: Int32) {
          if let index = favMatches.firstIndex(where: { $0.id ?? 0 == id }) {
              favMatches.remove(at: index)
              let updatedMatches = matches.value.map { match in
                  var updatedMatch = match
                  if match.id ?? 0 == id {
                      updatedMatch.isFav = false
                  }
                  return updatedMatch
              }
              matches.accept(updatedMatches)
              MatchStorage.shared.removeFavMatche(with: id)
              reloadTableViewSubject.onNext(())
          }
      }

    
  
    // Fetch matches from Core Data and update the view
    func fetchMatchesFromCoreData() {
           let coreDataMatches = MatchStorage.shared.getFavoriteMatches()
           matches.accept(coreDataMatches)
           groupMatchesByDay(coreDataMatches)
           reloadTableViewSubject.onNext(())
       }



    // MARK: - HomeViewModelOutputs
    
    // Get the number of sections based on grouped matches
    func numberOfSections() -> Int {
        return matchesGroupedByDay.count
    }
    
    // Get the number of matches in a section
    func numberOfMatches(inSection section: Int) -> Int {
        let sortedDates = matchesGroupedByDay.keys.sorted()
        guard let matches = matchesGroupedByDay[sortedDates[section]] else { return 0 }
        return matches.count
    }
    
    // Get the section title for a given section
    func sectionTitle(for section: Int) -> String? {
        let sortedDates = matchesGroupedByDay.keys.sorted()
        return sortedDates[section]
    }
    
    // Group matches by day
    func groupMatchesByDay(_ matches: [MatchModel]) {
        matchesGroupedByDay = Dictionary(grouping: matches, by: { $0.date ?? "" })
    }
}

// MARK: - MatchResponse Extension

extension MatchResponse {
    // Convert MatchResponse to an array of MatchModel
    func toMatchModels() -> [MatchModel] {
        guard let matches = self.matches else { return [] }
        return matches.compactMap { MatchModel(match: $0) }
    }
}

// MARK: - Collection Extension

extension Collection {
    // Safe subscript to prevent index out of range crashes
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
