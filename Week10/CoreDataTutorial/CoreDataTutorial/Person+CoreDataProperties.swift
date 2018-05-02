//
//  Person+CoreDataProperties.swift
//  CoreDataTutorial
//
//  Created by Yeonhee Lee on 4/7/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
