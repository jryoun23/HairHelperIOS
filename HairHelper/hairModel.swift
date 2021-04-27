//
//  hairModel.swift
//  HairHelper
//
//  Created by Joseph Young on 4/10/21.
//

import Foundation
import CoreData

public class hairModel{
    let managedObjectContext:NSManagedObjectContext?
    
    func delete()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HairProfile")
        // performs the batch delete for the profiles
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext!.execute(deleteRequest)
            try managedObjectContext!.save()
            
        }
        catch let _ as NSError {
            // Handle error
        }
        
        
    }
    
   
    
    
    init(context: NSManagedObjectContext)
    {
        managedObjectContext = context
    }
    
    func saveProfile( color:String, density:String, elasticity:String, length:String, texture:String, profileName:String)
    {
        let ent = NSEntityDescription.entity(forEntityName: "HairProfile", in: self.managedObjectContext!)
        
        // create a contact object instance for insert
        let profile = HairProfile(entity: ent!, insertInto: managedObjectContext)
        
        profile.hairColor = color
        profile.hairDensity = density
        profile.hairElasticity = elasticity
        profile.hairLength = length
        profile.hairTexture = texture
        profile.profileName = profileName
        
        do {
            try managedObjectContext!.save()
            print("profile Saved")
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
