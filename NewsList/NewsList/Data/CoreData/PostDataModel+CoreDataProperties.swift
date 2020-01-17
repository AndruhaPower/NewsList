//
//  PostDataModel+CoreDataProperties.swift
//  
//
//  Created by Andrew on 18/01/2020.
//
//

import Foundation
import CoreData


extension PostDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostDataModel> {
        return NSFetchRequest<PostDataModel>(entityName: "PostDataModel")
    }

    @NSManaged public var date: String?
    @NSManaged public var image: Data?
    @NSManaged public var source: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
