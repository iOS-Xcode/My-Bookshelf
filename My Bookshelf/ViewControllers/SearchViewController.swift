//
//  ViewController.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import UIKit

class SearchViewController: UIViewController {
    
    var booksList = BooksListViewModel() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
//    var isLoading = false
//    var totalPages : Int = 0
//    var allPages : Int = 10
//    var currentPage : Int = 1
    var searchText = ""
    var searchBar = UISearchBar()
    
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
        //tableView.prefetchDataSource = self
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
        return booksList.bookInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookInfoTableViewCell.identifier, for: indexPath) as? BookInfoTableViewCell else {
            return UITableViewCell()
        }
        let bookInfo = booksList.bookInfoList[indexPath.row]
        if let url = URL(string: bookInfo.image) {
 //           bookTempImage.loadImage(from: url)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                // do here...
                //requestWithSearchText(searchText)
                if indexPath.row >= booksList.bookInfoList.count - 1 && booksList.total > 0 {
//                    booksList.currentPage += 1
                    requestWithSearchText(searchText)
                }
            }
        }
    }
}

//MARK: - UISearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else { return }
        self.searchText = searchBarText
        booksList = BooksListViewModel()
        requestWithSearchText(searchBarText)
    }
    
    func requestWithSearchText(_ searchBarText : String) {
            let bookRequest = RequestBookInfo(searchString: searchBarText, currentPage: booksList.currentPage)
            bookRequest.fetchBookInfo {[weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success((let bookInfo, let total, let currentPage)):
                    self?.booksList.bookInfoList.append(contentsOf: bookInfo)
                    
                    guard let total = Int(total), let currentPage = Int(currentPage) else {
                        return
                    }
                    self?.booksList.isFetchInProgress = false
                    self?.booksList.currentPage = currentPage
                    print("currentPage",currentPage)
                    self?.booksList.total = total
                    print("total",total)
                    self?.booksList.currentPage += 1
                    print("booklistcount",self?.booksList.bookInfoList.count)
                    self?.booksList.currentItems = (self?.booksList.bookInfoList.count)!
                }
            }
        //tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
}
