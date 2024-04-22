//
//  DataPersistenceManager.swift
//  NewsTracker
//
//  Created by Sahil Saxena on 18/04/24.
//

import Foundation
import CoreData
import UIKit

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func saveDataLocally(_ articles: Article) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = ArticleItem(context: context)
        
        item.author = articles.author
        item.title = articles.title
        item.descriptio = articles.description
        item.url = articles.url
        item.urlToImage = articles.urlToImage
        item.publishedAt = articles.publishedAt
        item.content = articles.content
        
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
        
    }
    
    func fetchDataFromLocalDatabase() -> [ArticleItem] {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = ArticleItem.fetchRequest()
            
            do {
                let result = try context.fetch(fetchRequest)
                
                return result
            } catch {
                print("Error fetching data from local database: \(error)")
                return []
            }
    }
}
