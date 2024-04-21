//
//  MatchStorage.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 20/04/2024.
//


import Foundation
import CoreData

class MatchStorage: Storable {
   
    var managedContext: NSManagedObjectContext
        
    static let shared = MatchStorage(managedContext: CoreDataStack.shared.managedContext)

    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func insertMatch(_ match: MatchModel) {
        let entity = NSEntityDescription.entity(forEntityName: Constants.Fav_Match_ENTITY, in: managedContext)!
        let favoriteMatch = FavoriteMatch(entity: entity, insertInto: managedContext)
        favoriteMatch.id = Int32(match.id ?? 0)
        favoriteMatch.isFav = true
        favoriteMatch.awayScore = Int16(match.awayScore ?? 0)
        favoriteMatch.awayTeam = match.awayTeam
        favoriteMatch.homeTeam =  match.homeTeam
        favoriteMatch.homeScore = Int16(match.homeScore ?? 0)
        favoriteMatch.date = match.date
        favoriteMatch.info = match.info
        favoriteMatch.matchDay = match.date
        favoriteMatch.status = match.status
        try? managedContext.save()
    }

    func removeFavMatche(with id: Int32) {
      let fetchRequest: NSFetchRequest<FavoriteMatch> = FavoriteMatch.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "id == %d", id)

      do {
        let matches = try managedContext.fetch(fetchRequest)

        if let matchSummary = matches.first {
          managedContext.delete(matchSummary)

          do {
            try managedContext.save()
          } catch {
            print("Error deleting item: \(error)")
          }
        }
      } catch {
        print("Error fetching item to delete: \(error)")
      }

    }
    
    func getFavoriteMatches() -> [MatchModel] {
        let request: NSFetchRequest<FavoriteMatch> = FavoriteMatch.fetchRequest()
        do {
            let results = try managedContext.fetch(request)
            // Convert FavoriteMatch entities to MatchModel instances
            let matches = results.map { favoriteMatch -> MatchModel in
                let match = MatchModel(favoriteMatch: favoriteMatch, isFav: true) // Assuming MatchModel initializer takes a FavoriteMatch instance
                return match
            }
            return matches
        } catch let error as NSError {
            print("Could not fetch favorite matches from Core Data: \(error), \(error.userInfo)")
            return []
        }
    }

    func fetchMatchesFromCoreData() -> [FavoriteMatch] {
        let request: NSFetchRequest<FavoriteMatch> = FavoriteMatch.fetchRequest()
        do {
            let matches = try managedContext.fetch(request)
            return matches
        } catch let error as NSError {
            print("Error fetching matches from Core Data: \(error.localizedDescription)")
            return []
        }
    }
}


class CoreDataStack {
    static let shared = CoreDataStack()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PremierLeagueX")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var managedContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

