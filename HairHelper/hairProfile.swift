//
//  hairProfile.swift
//  HairHelper
//
//  Created by Joseph Young on 4/10/21.
//

import Foundation
import CoreData

public class HairProfile : NSManagedObject{
    
    
    @NSManaged public var hairColor:String?
    @NSManaged public var hairDensity:String?
    @NSManaged public var hairElasticity:String?
    @NSManaged public var hairLength:String?
    @NSManaged public var hairTexture:String?
    @NSManaged public var profileName:String?
}
