//
//  ViewController.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import UIKit

class ViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookInfoTableViewCell.self, forCellReuseIdentifier: BookInfoTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //tableView.backgroundColor = .lightGray
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

//MARK: - setupUI

    func setupUI() {
        view.backgroundColor = .white
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Navigation bar title
        navigationController?.navigationBar.topItem?.title = "My Bookshelf"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        navigationController?.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = false

        navigationController?.navigationBar.barStyle = .black
        showSearchBarButton(shouldShow: true)
        
        //Navigation bar title color when its standard or scroll up
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGray]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    
    }

//MARK: - Handle and set searchBar

    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))

        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
}

//MARK: - UITableView Delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookInfoTableViewCell.identifier, for: indexPath) as? BookInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(text: "custom + \(indexPath.row+1)", imageName: indexPath.row % 2 == 0 ? "book" : "noImage")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

//MARK: - UISearchBar Delegate

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
}
