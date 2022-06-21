//
//  StorageManager.swift
//  Test_task
//
//  Created by max on 20.06.2022.
//
import UIKit
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var likedPhotos: [LikedPhoto] = []
    
    func saveContext() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch let error as NSError {
            print ("Error: \(error)")
        }
    }
    
    func retieveLikedPhotos(completion: @escaping ([LikedPhoto]) -> Void) {
        do {
            likedPhotos = try context.fetch(LikedPhoto.fetchRequest())
            completion(likedPhotos)
        } catch {
            print ("Error retrieving: \(error)")
        }
    }
    
    func save(author: String?,
              photoUrl: String?,
              downloads: String?,
              location: String?,
              creationDate: String?) {
        
        let likedPhoto = LikedPhoto(context: context)
        likedPhoto.author = author
        likedPhoto.location = location
        likedPhoto.downloads = downloads
        likedPhoto.photo = photoUrl
        likedPhoto.creationDate = creationDate
        
        do {
            try context.save()
            print ("SAVED SUCCESSFULLY")
        } catch {
            print (error)
        }
    }
    
    func delete(photo: LikedPhoto) {
        context.delete(photo)
        do {
            try context.save()
        } catch {
            print (error)
        }
    }
    
    func searchInCoreData(with currentImage: String?) -> Bool {
        guard let searchQuery = currentImage else { return false }
        let fetchRequest: NSFetchRequest<LikedPhoto>
        fetchRequest = LikedPhoto.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "photo == %@", searchQuery)
        
        return ((try? context.count(for: fetchRequest)) ?? 0) > 0
    }
    
    func retrieveSingleObject(with currentImage: String?) -> LikedPhoto? {
        guard let searchQuery = currentImage else { return nil }
        let fetchRequest: NSFetchRequest<LikedPhoto>
        fetchRequest = LikedPhoto.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "photo == %@", searchQuery)
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print (error)
            return nil
        }
    }
}
