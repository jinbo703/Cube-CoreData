//
//  CoredataManager.swift
//  Cube
//
//  Created by John Nik on 3/31/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit
import CoreData

class CoredataManager: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
        
    }
    
    class func saveData(title: String, intertitle: String, maintext: String) {
        
        let context: NSManagedObjectContext = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let manageObj = NSManagedObject(entity: entity!, insertInto: context)
        
        
        
        manageObj.setValue(title, forKey: "title")
        manageObj.setValue(intertitle, forKey: "intertitle")
        manageObj.setValue(maintext, forKey: "maintext")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    class func fetchData() -> [NoteItems] {
        
        var array = [NoteItems]()
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult{
                
                let item = NoteItems(title: item.title!, intertitle: item.intertitle!, maintext: item.maintext!)
                
                array.append(item)
                
            }
            print(fetchResult)
        } catch {
            
        }
        
        return array
        
    }
    
    class func fetchData(title: String) -> [NoteItems] {
        
        var array = [NoteItems]()
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        

        
        let commentAttributeTitle = "title"
        let commentAttributeIntertitle = "intertitle"
        let commentAttributePost = "maintext"
        
        
        
        let predicateTitle = NSPredicate(format: "%K CONTAINS[cd] %@", commentAttributeTitle, title)
        let predicateIntertitle = NSPredicate(format: "NOT %K CONTAINS[cd] %@ AND %K CONTAINS[cd] %@", commentAttributeTitle, title, commentAttributeIntertitle, title)
        let predicatePost = NSPredicate(format: "NOT %K CONTAINS[cd] %@ AND NOT %K CONTAINS[cd] %@ AND %K CONTAINS[cd] %@", commentAttributeTitle, title, commentAttributeIntertitle, title, commentAttributePost, title)
        
        
        fetchRequest.predicate = predicateTitle
        do {
            
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult{
                
                let item = NoteItems(title: item.title!, intertitle: item.intertitle!, maintext: item.maintext!)
                
                array.append(item)
                
            }
//            print(fetchResult)
        } catch {
            
        }
        
        fetchRequest.predicate = predicateIntertitle
        
        do {
            
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for items in fetchResult{
                
                let item = NoteItems(title: items.title!, intertitle: items.intertitle!, maintext: items.maintext!)
                
                array.append(item)
                
            }
//            print(fetchResult)
        } catch {
            
        }
        
        fetchRequest.predicate = predicatePost
        
        do {
            
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for items in fetchResult{
                
                let item = NoteItems(title: items.title!, intertitle: items.intertitle!, maintext: items.maintext!)
                
                array.append(item)
            }
//            print(fetchResult)
        } catch {
            
        }


        
        return array
        
    }

    
    class func updateData() {
        
        
        
    }
    
    class func deleteData() {
        
        
        
    }
    
}
