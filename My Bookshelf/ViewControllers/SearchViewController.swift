//
//  ViewController.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy var booksList = BooksListViewModel()
    
    fileprivate var searchText = ""
    
    fileprivate var searchBar = UISearchBar()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookInfoTableViewCell.self, forCellReuseIdentifier: BookInfoTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        booksList.delegate = self
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - setupUI
    
    func setupUI() {
        
        //Search Bar
        view.backgroundColor = .white
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
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
    
    //MARK: - Set searchBar and handle
    
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksList.loadedCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookInfoTableViewCell.identifier, for: indexPath) as? BookInfoTableViewCell else {
            return UITableViewCell()
        }
        let bookInfo = booksList.bookInfoList[indexPath.row]
        //Use cache images
        if let url = URL(string: bookInfo.image) {
            cell.bookImageView.loadImage(from: url)
        }
        cell.configure(bookInfo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailBookViewController = DetailBookViewController()
        guard let isbn13 = booksList.bookInfoList[indexPath.row].isbn13 else {
            return
        }
        detailBookViewController.isbn = isbn13
        navigationController?.pushViewController(detailBookViewController, animated: true)
    }
    
    //To show total books and loaded books count
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Total items : \(String(booksList.totalItems.totalBooksCount)), Loaded items :\(String(booksList.loadedCount))"
    }
    
    //LastVisibleIndexPath that the user is scrolling on the end of tableView row
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            
            if indexPath == lastVisibleIndexPath {
                //Last visible indexpath.row
                if indexPath.row >= booksList.loadedCount - 1 && booksList.total > 0 {
                    booksList.requestWithSearchText(searchText)
                }
            }
        }
    }
}

//MARK: - UISearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else { return }
        if searchBarText.count >= 2 {
            //Init array and structs
            booksList.initializeOfSearchedBooksList()
            self.searchText = searchBarText
            booksList.requestWithSearchText(searchBarText)
        } else {
            booksList.initializeOfSearchedBooksList()
            tableView.reloadData()
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
}

//MARK: - TableViewReloadDelegate

extension SearchViewController: TableViewReloadDelegate {
    func tableViewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
