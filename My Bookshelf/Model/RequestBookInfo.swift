//
//  RequestBookInfo.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import Foundation

enum BookInfoError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct RequestBookInfo {
    let resourceURL : URL
    
    init(searchString: String) {
        let resourceString = "https://api.itbook.store/1.0/search/\(searchString)"
        print(resourceString)
        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        self.resourceURL = resourceURL
    }
    
    func fetchBookInfo(completion: @escaping(Result<[BookInfo], BookInfoError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
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
}
