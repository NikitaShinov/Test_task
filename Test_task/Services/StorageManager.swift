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
    
    func save(photo: Photo) {
        let likedPhoto = LikedPhoto(context: context)
        likedPhoto.author = photo.user.name
        likedPhoto.location = photo.user.location
        likedPhoto.downloads = String(describing: photo.downloads)
        likedPhoto.photo = photo.urls.regular
        likedPhoto.creationDate = photo.created_at
        
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
}
