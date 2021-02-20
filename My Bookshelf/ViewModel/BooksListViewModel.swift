//
//  BooksListViewModel.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-19.
//

import Foundation

//protocol BooksListViewModelDelegate: class {
//  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
//  func onFetchFailed(with reason: String)
//}

struct BooksListViewModel {
    var bookInfoList = [BookInfo]()
    var currentPage = 1
    var total = 0
    var currentItems = 0
    var isFetchInProgress = false
    
    mutating func calculateIndex() -> Int {
      return total / 10
    }
    
    var currentCount: Int {
      return currentPage + 1
    }
}
