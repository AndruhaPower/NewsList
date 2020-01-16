//
//  PostDataModel+CoreDataProperties.swift
//  NewsList
//
//  Created by Andrew on 16/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
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
