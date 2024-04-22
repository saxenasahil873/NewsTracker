//
//  ArticleItem+CoreDataProperties.swift
//  
//
//  Created by Sahil Saxena on 19/04/24.
//
//

import Foundation
import CoreData


extension ArticleItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleItem> {
        return NSFetchRequest<ArticleItem>(entityName: "ArticleItem")
    }

    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var descriptio: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var source: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?

}
