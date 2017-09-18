//
//  DataStore.swift
//  CoreDataSwift
//
//  Created by MC-MG57035 on 9/11/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import UIKit
import CoreData
//import Foundation

class DataStore: NSObject {
    
    var persistentStoreCoordinator = NSPersistentStoreCoordinator()
    var context = NSManagedObjectContext()
    var ManagedObjectModel = NSManagedObjectModel()
    


    
    func ManagedObjectContext() -> NSManagedObjectContext{

        
        context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.persistentStoreCoordinator = self.coordinator()
  
        return context
        
    }
    
    
    func managedObjectModel() -> NSManagedObjectModel{
        
        ManagedObjectModel = NSManagedObjectModel.mergedModel(from: nil)!
        
        
        return ManagedObjectModel
    }
    
    
    func coordinator () -> NSPersistentStoreCoordinator{
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: self.managedObjectModel())
        persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.persistentStoreCoordinator
        
        return persistentStoreCoordinator
    }
    
    func saveData(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
    
    
    func UserFromUserID(user_id User_id:NSNumber ,IsAotoCreate isAutoCreate:Bool ,inContext managedObjectContext_:NSManagedObjectContext) -> User?{
        let fetch = NSFetchRequest<NSFetchRequestResult>.init()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext_)
        fetch.entity = entity
        fetch.predicate = NSPredicate(format: "user_id == %d", User_id.int16Value)
        
        var users:User? = nil
        
        do{
            let data = try context.fetch(fetch)
            if data.count > 0 {
                users = data[0] as? User
                
                self.context.delete(users!)
                self.saveData()
                
                users = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedObjectContext_) as? User
                users?.user_id = User_id.int16Value
                self.saveData()
                
            }
            else if isAutoCreate == true{
                users = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedObjectContext_) as? User
                users?.user_id = User_id.int16Value
                self.saveData()
            }
            
        }catch{
            print(error)
        }
        
        return users
    }
    
    
    
    func AddUserforData(username name:String, userid user_id:NSNumber){
        
        let MyUser:User? = self.UserFromUserID(user_id: user_id, IsAotoCreate: true, inContext: self.ManagedObjectContext())
        MyUser?.user_name = name
        self.saveData()
        
        
    }
    
    
    func selectfechUserdata(User_id user_id:NSNumber) -> [User]?{
        
        let fetch = NSFetchRequest<NSFetchRequestResult>.init()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: self.ManagedObjectContext())
        fetch.entity = entity
        fetch.predicate = NSPredicate(format: "user_id == %d", user_id.int16Value)
        
        var user:[User]? = []
        
        do{
            let data = try context.fetch(fetch)
            
            if data.count > 0 {
                user = data as? [User]
            }
        }catch{
            user = []
        }
        
        return user
        
    }
    
    
    func DeleteUserdata(){
        let fetch = NSFetchRequest<NSFetchRequestResult>.init()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: self.ManagedObjectContext())
        fetch.entity = entity
        
        do{
         
            let data = try context.fetch(fetch)
            for  Data in data {
                context.delete(Data as! NSManagedObject)
            }
            
            self.saveData()
            
        } catch{
            
        }
        
    }
    
    
}


