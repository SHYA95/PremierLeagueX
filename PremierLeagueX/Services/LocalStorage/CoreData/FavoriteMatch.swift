//
//  FavoriteMatch.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 20/04/2024.
//

import Foundation
import CoreData

public class FavoriteMatch: NSManagedObject {

}

extension FavoriteMatch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMatch> {
        return NSFetchRequest<FavoriteMatch>(entityName: "FavoriteMatch")
    }

    @NSManaged public var id: Int32
    @NSManaged public var status: String?
    @NSManaged public var homeTeam: String?
    @NSManaged public var awayTeam: String?
    @NSManaged public var info: String?
    @NSManaged public var matchDay: String?
    @NSManaged public var date: String?
    @NSManaged public var homeScore: Int16
    @NSManaged public var awayScore: Int16
    @NSManaged public var isFav: Bool
}

extension FavoriteMatch : Identifiable {

}
