//
//  ViewController.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import UIKit

class SearchViewController: UIViewController {
    
    var booksList = [BookInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

//MARK: - setupUI

    func setupUI() {
        
        //TableView
        /*
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
 */
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
        return booksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookInfoTableViewCell.identifier, for: indexPath) as? BookInfoTableViewCell else {
            return UITableViewCell()
        }
        let bookInfo = booksList[indexPath.row]
        if let url = URL(string: bookInfo.image) {
 //           bookTempImage.loadImage(from: url)
            cell.bookImageView.loadImage(from: url)
        }
        cell.configure(title: bookInfo.title, isbn: bookInfo.isbn13, price: bookInfo.price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailBookViewController = DetailBookViewController()
        guard let isbn13 = booksList[indexPath.row].isbn13 else {
            return
        }

        detailBookViewController.isbn = isbn13
        navigationController?.pushViewController(detailBookViewController, animated: true)
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
        guard let searchBarText = searchBar.text else {return}
        let bookRequest = RequestBookInfo(searchString: searchBarText)
        bookRequest.fetchBookInfo {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let bookInfo):
                self?.booksList = bookInfo
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
}
