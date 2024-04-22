//
//  ViewController.swift
//  NewsTracker
//
//  Created by Sahil Saxena on 15/09/23.
//

import UIKit
import FirebaseAuth
import CoreData

class HomeViewController: UIViewController {
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(NewsDataTableViewCell.self, forCellReuseIdentifier: NewsDataTableViewCell.identifier)
        return table
    }()
    
    var dataList:[Article] = []
    private var headerView: HeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        navigationController?.navigationBar.isHidden = true
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        homeFeedTable.tableHeaderView = headerView

        fetchNews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userSignedIn()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func userSignedIn() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let nav = UINavigationController(rootViewController: LoginViewController())
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }
    
    private func fetchNews() {
        if Article.articleItemListCount > 0 {
            self.dataList = Article.convertArticleItemToArticle()
            homeFeedTable.reloadData()
        } else {
            getNews { isSuccess, response in
                if isSuccess, let articles = response?.articles {
                    self.dataList = articles
                    Article.saveArticlesToDatabase(self.dataList)
                    //self.DataPersistenceManager.shared.saveDataLocally(self.dataList)
                    self.homeFeedTable.reloadData()
                } else {
                    // Handle error
                    print("Error fetching news")
                }
            }
        }
       
    }
    
    func getNews(completionHandler: @escaping (Bool, NewsResponse?) -> Void) {
        let request = APICaller.shared.createRequest(with: Constants.url, method: .get)
        APICaller.shared.executeRequest(with: request) { (isSuccess: Bool, response: NewsResponse?)in
            completionHandler(isSuccess, response)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsDataTableViewCell.identifier, for: indexPath) as? NewsDataTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: dataList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedArticle = dataList[indexPath.row]

        let vc = NewsFeedViewController()
        vc.selectedArticle = selectedArticle
        navigationController?.pushViewController(vc, animated: true)
    }

    
}

