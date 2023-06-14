//
//  MusicTrack+CoreDataProperties.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 10.06.2023.
//
//

import Foundation
import CoreData

extension MusicTrack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MusicTrack> {
        return NSFetchRequest<MusicTrack>(entityName: "MusicTrack")
    }

    @NSManaged public var artistName: String?
    @NSManaged public var artistViewURL: String?
    @NSManaged public var artwork100: Data?
    @NSManaged public var previewURL: String?
    @NSManaged public var primaryGenreName: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var trackID: Int64
    @NSManaged public var trackName: String?
    @NSManaged public var trackTimeMillis: Int64
    @NSManaged public var trackViewURL: String?
    @NSManaged public var artworkUrl100: String?

}

//extension MusicTrack : Identifiable {
//
//}
