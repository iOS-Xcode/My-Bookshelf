//
//  BooksListViewModel.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-19.
//

/*
 ViewModel that connected between SearchViewController and RequestBookInfo
 */
import Foundation

//The protocol to access tableviewReload() 
protocol TableViewReloadDelegate {
    func tableViewReload()
}

//State of loaded data currently
struct VisibleState {
    var currentPage : Int
    var loadedCount : Int
    init() {
        currentPage = 1
        loadedCount = 0
    }
}

//Searched total books
struct TotalItems {
    var totalBooksCount : Int
    init() {
        self.totalBooksCount = 0
    }
}

class BooksListViewModel {
    //Set delegate for tableViewReload.
    var delegate: TableViewReloadDelegate!
    
    var bookInfoList = [BookInfo]()
    var visibleState = VisibleState()
    var totalItems = TotalItems()
    
    var total : Int = 0 {
        willSet(newValue) {
            //newValue is zero that non data from the query.
            totalItems.totalBooksCount = newValue != 0 ? newValue : bookInfoList.count
        }
    }
    
    var currentPage : Int {
        get {
            return visibleState.currentPage
        }
        set {
            //Next page
            visibleState.currentPage += 1
        }
    }
    
    //Array BookInfo.count
    var loadedCount : Int {
        get {
            return visibleState.loadedCount
        }
        set {
            visibleState.loadedCount = bookInfoList.count
        }
    }
    
    //In case of characters are changed on searchBar
    func initializeOfSearchedBooksList() {
        bookInfoList = []
        visibleState = .init()
        totalItems = .init()
    }
    
    //Recevied data from RequestBookInfo that is the model and assign BookInfo
    func requestWithSearchText(_ searchBarText : String) {
        let bookRequest = RequestBookInfo(searchString: searchBarText, currentPage: currentPage)
        bookRequest.fetchBooksList {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success((let bookInfo, let total, let currentPage)):
                self?.bookInfoList.append(contentsOf: bookInfo)
                self?.loadedCount = (self?.bookInfoList.count)!
                guard let total = Int(total), let currentPage = Int(currentPage) else {
                    return
                }
                self?.currentPage = currentPage
                self?.total = total
                self?.delegate.tableViewReload()
            }
        }
    }
    
}
