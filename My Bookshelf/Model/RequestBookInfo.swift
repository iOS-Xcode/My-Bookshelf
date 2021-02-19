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
    init(searchString: String) {
        let bookSearchString : String = "https://api.itbook.store/1.0/search/\(searchString)/2"
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
    func fetchBookInfo(completion: @escaping(Result<[BookInfo], BookInfoError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL!) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let bookInfoResponse = try decoder.decode(BookInfoResponse.self, from: jsonData)
                let bookDetails = bookInfoResponse.books
                completion(.success(bookDetails))
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
/*
class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var ourCustomValue: String? {
        didSet {
            urlTapped(UITapGestureRecognizer)
        }
    }
    
    //must to be modified in the futer
    @objc func urlTapped(_ sender: UITapGestureRecognizer) {
        //UIApplication.shared.open(sender.text, options: [:], completionHandler: nil)
        guard let url = ourCustomValue else {
            print("The url is nil")
            return
        }
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
}
*/
