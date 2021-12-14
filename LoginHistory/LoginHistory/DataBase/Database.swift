//
//  Database.swift
//  LoginHistory
//
//  Created by Lyvennitha on 14/12/21.
//

import Foundation
import CoreData

class DatabaseController {

    private init() {}
//LoginHistoryResponse
    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }


    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: "LoginHistory")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */

                //TODO: - Add Error Handling for Core Data

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }


        })
        return container
    }()

    // MARK: - Core Data Saving support
    class func saveContext() {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
                print("Data Saved to Context")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                //You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    /* Support for CRUD Operations */
    
   

    // GET / Fetch / Requests
    class func getAllShows() -> [LoginHistoryResponse] {
        let all = NSFetchRequest<LoginHistoryResponse>(entityName: "LoginHistoryResponse")
        var allShows = [LoginHistoryResponse]()
        let nameSort = NSSortDescriptor(key:"date", ascending:true)
        all.sortDescriptors = [nameSort]
        
        do {
            let fetched = try DatabaseController.getContext().fetch(all)
            allShows = fetched
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }
        
        var allShowsNoDup = [LoginHistoryResponse]()
        for item in allShows{
            let filterData = allShowsNoDup.filter({$0.date == item.date})
            if filterData.count == 0{
                allShowsNoDup.append(item)
            }
        }
        
       
//        deleteAllShows()
//        addNewShowsToCoreData(allShowsNoDup)
        print("allShowsNoDup count", allShowsNoDup.count)
        return allShowsNoDup
    }
    class func unique<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
    // Get Show by uuid
    class func getShowWith(uuid: String) -> LoginHistoryResponse? {
        let requested = NSFetchRequest<LoginHistoryResponse>(entityName: "LoginHistoryResponse")
        requested.predicate = NSPredicate(format: "date == %@", uuid)
        
        do {
            let fetched = try DatabaseController.getContext().fetch(requested)

            //fetched is an array we need to convert it to a single object
            if (fetched.count > 1) {
                //TODO: handle duplicate records
            } else {
                return fetched.first //only use the first object..
            }
        } catch {
            let nserror = error as NSError
            //TODO: Handle error
            print(nserror.description)
        }

        return nil
    }

    // REMOVE / Delete
    class func deleteShow(with name: String) -> Bool {
        let success: Bool = true

        let requested = NSFetchRequest<LoginHistoryResponse>(entityName: "LoginHistoryResponse")
        requested.predicate = NSPredicate(format: "date == %@", name)


        do {
            let fetched = try DatabaseController.getContext().fetch(requested)
            for show in fetched {
                DatabaseController.getContext().delete(show)
            }
            return success
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }

        return !success
    }
    class func deleteAllShows() {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginHistoryResponse")
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            try DatabaseController.getContext().execute(deleteALL)
            DatabaseController.saveContext()
        } catch {
            print ("There is an error in deleting records")
        }
    }
    
//    class func addNewShowsToCoreData(_ shows: [LoginHistoryResponse]) {
//
//           for show in shows {
//               let entity = NSEntityDescription.entity(forEntityName: "LoginHistoryResponse", in: DatabaseController.getContext())
//               let newShow = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())
//
//               // Set the data to the entity
//            newShow.setValue(show.name, forKey: "email")
//            newShow.setValue(show.age, forKey: "firstName")
//            newShow.setValue(show.company, forKey: "lastName")
//            newShow.setValue(show.email, forKey: "Date")
//            
//           }
//
//       }

}




