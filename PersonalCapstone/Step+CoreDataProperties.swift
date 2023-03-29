//
//  Step+CoreDataProperties.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/27/23.
//
//

import Foundation
import CoreData


extension Step {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Step> {
        return NSFetchRequest<Step>(entityName: "Step")
    }

    @NSManaged public var title: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var stepNum: Int
    @NSManaged public var goal: Goal?

}

extension Step : Identifiable {

}
