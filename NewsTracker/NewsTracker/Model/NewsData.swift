//
//  NewsData.swift
//  NewsTracker
//
//  Created by Sahil Saxena on 16/04/24.
//

import Foundation
import UIKit
import CoreData

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    static func saveArticlesToDatabase(_ article: [Article]) {    //2
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        article.forEach { article in
            if let articleItem = article.convertArticleToDAO(article) {
                if !(articleItem.source?.hasPrefix(article.source.id ?? "") ?? false) {
                    appDelegate.saveContext()
                }
            }
        }
    }
    
    static var articleItemListCount: Int {
        return Article.getArticleDatabaseList().count
    }
    
    
    static func getArticleDatabaseList() -> [ArticleItem] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        var itemList: [ArticleItem] = []
        let dbrequest = ArticleItem.fetchRequest()
        if let result = try? appDelegate.persistentContainer.viewContext.fetch(dbrequest) {
            itemList = result
        }
        return itemList
    }
    
    func convertArticleToDAO(_ article: Article) ->  ArticleItem? {      //data access object
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let articleItem = ArticleItem(context: appDelegate.persistentContainer.viewContext)
        
        articleItem.source = "\(article.source.id),\(article.source.name)"
        articleItem.author = article.author
        articleItem.title = article.title
        articleItem.descriptio = article.description
        articleItem.url = article.url
        articleItem.urlToImage = article.urlToImage
        articleItem.publishedAt = article.publishedAt
        articleItem.content = article.content


        return articleItem
    }
    
    static func convertArticleItemToArticle() -> [Article] {
        let arrayItemList = Article.getArticleDatabaseList()
        
        var arrayList: [Article] = arrayItemList.map { item in
            var id = ""
            var name = ""
            if let sourceList = item.source?.components(separatedBy: ",") {
                 id = sourceList.count == 2 ? sourceList[0] : ""
                 name = sourceList.count == 2 ? sourceList[1] : ""
            }
           
            let article = Article(source: Source(id: id , name: name), author: item.author , title: item.title ?? "", description: item.descriptio , url: item.url ?? "", urlToImage: item.urlToImage ?? ""  , publishedAt: item.publishedAt ?? "", content: item.content)
            return article
        }
        return arrayList
    }
    
}

struct Source: Codable {
    let id: String?
    let name: String
}

