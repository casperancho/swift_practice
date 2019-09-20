//
//  ShortItem+CoreDataProperties.swift
//  
//
//  Created by 17515726 on 26/06/2019.
//
//

import Foundation
import CoreData


extension ShortItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShortItem> {
        return NSFetchRequest<ShortItem>(entityName: "ShortItem")
    }

    @NSManaged public var date: String?
    @NSManaged public var imageLink: String?
    @NSManaged public var isNewsOfTheDay: Bool
    @NSManaged public var resourceTag: String?
    @NSManaged public var title: String?
    @NSManaged public var imageString: String?
    

}
