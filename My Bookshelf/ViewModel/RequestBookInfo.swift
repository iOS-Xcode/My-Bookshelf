//
//  RequestBookInfo.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import Foundation
import UIKit

enum BookInfoError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct RequestBookInfo {
    var resourceURL : URL? = nil
    //List of books
    init(searchString: String, currentPage : Int) {
        let bookSearchString : String = "https://api.itbook.store/1.0/search/\(searchString)/\(currentPage)"
        print(bookSearchString)
        self.resourceURL = convertUrl(bookSearchString)
        
    }
    //The book detail
    //https://api.itbook.store/1.0/books/9781617294136
    init(bookDetailString: String) {
        let bookDetailString : String = "https://api.itbook.store/1.0/books/\(bookDetailString)"
        print(bookDetailString)
        self.resourceURL = convertUrl(bookDetailString)
    }
    
    //Allow to non-english characters and convert string to url
    func convertUrl(_ resourceString : String) -> URL {
        guard let stringurlfixed = resourceString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let resourceURL = URL(string: stringurlfixed)
         else {
            print(resourceString)
            fatalError()
        }
        return resourceURL
    }
        //self.resourceURL = resourceURL
    func fetchBookInfo(completion: @escaping(Result<([BookInfo], String, String), BookInfoError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL!) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let bookInfoResponse = try decoder.decode(BookInfoResponse.self, from: jsonData)
                let bookDetails = bookInfoResponse.books
                let total = bookInfoResponse.total
                let currentPage = bookInfoResponse.page
                completion(.success((bookDetails, total, currentPage)))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    func fetchBookDetail(completion: @escaping(Result<BookDetail, BookInfoError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL!) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let bookInfoResponse = try decoder.decode(BookDetail.self, from: jsonData)
                let bookDetails = bookInfoResponse
                completion(.success(bookDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
