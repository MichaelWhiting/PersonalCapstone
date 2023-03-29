//
//  Goal+CoreDataProperties.swift
//  PersonalCapstone
//
//  Created by Michael Whiting on 3/27/23.
//
//

import Foundation
import CoreData


extension Goal {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }
    
    @NSManaged public var creationDate: Date?
    @NSManaged public var goalDescription: String?
    @NSManaged public var id: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var progress: Double
    @NSManaged public var title: String?
    @NSManaged public var steps: NSSet?
    
    public var unwrappedTitle: String {
        title ?? ""
    }
    
    public var stepsArray: [Step] {
        let stepsSet = steps as? Set<Step> ?? []
        
        return stepsSet.sorted {
            $0.stepNum < $1.stepNum
        }
    }

}

// MARK: Generated accessors for steps
extension Goal {

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: Step)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: Step)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSSet)

}

extension Goal : Identifiable {

}
