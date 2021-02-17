//
//  BookInfoDataTest.swift
//  My BookshelfTests
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import XCTest
@testable import My_Bookshelf

class BookInfoDataTest: XCTestCase {

    func testCanRequestBookInfo() throws {
        
        if let url = URL(string: "https://api.itbook.store/1.0/search/ios") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                     let res = try JSONDecoder().decode(BookInfoResponse.self, from: data)
                    XCTAssertEqual("0", res.error)

                  } catch let error {
                     print(error)
                  }
               }
           }.resume()
        }
        
    }
    
    func testCanparseBookInfo() throws {
        let json = """
        {"error":"0","total":"360","page":"1","books":[{"title":"iOS Components and Frameworks","subtitle":"Understanding the Advanced Features of the iOS SDK","isbn13":"9780321856715","price":"$23.30","image":"https://itbook.store/img/books/9780321856715.png","url":"https://itbook.store/books/9780321856715"},{"title":"Learning iOS Development","subtitle":"A Hands-on Guide to the Fundamentals of iOS Programming","isbn13":"9780321862969","price":"$3.99","image":"https://itbook.store/img/books/9780321862969.png","url":"https://itbook.store/books/9780321862969"},{"title":"Beginning iOS Programming","subtitle":"Building and Deploying iOS Applications","isbn13":"9781118841471","price":"$6.35","image":"https://itbook.store/img/books/9781118841471.png","url":"https://itbook.store/books/9781118841471"},{"title":"Beginning iOS 5 Development","subtitle":"Exploring the iOS SDK","isbn13":"9781430236054","price":"$3.65","image":"https://itbook.store/img/books/9781430236054.png","url":"https://itbook.store/books/9781430236054"},{"title":"Beginning iOS 5 Games Development","subtitle":"Using the iOS SDK for iPad, iPhone and iPod touch","isbn13":"9781430237105","price":"$36.31","image":"https://itbook.store/img/books/9781430237105.png","url":"https://itbook.store/books/9781430237105"},{"title":"More iOS 6 Development","subtitle":"Further Explorations of the iOS SDK","isbn13":"9781430238072","price":"$4.95","image":"https://itbook.store/img/books/9781430238072.png","url":"https://itbook.store/books/9781430238072"},{"title":"Beginning iOS 6 Development","subtitle":"Exploring the iOS SDK","isbn13":"9781430245124","price":"$5.34","image":"https://itbook.store/img/books/9781430245124.png","url":"https://itbook.store/books/9781430245124"},{"title":"Beginning iOS 7 Development","subtitle":"Exploring the iOS SDK","isbn13":"9781430260226","price":"$3.65","image":"https://itbook.store/img/books/9781430260226.png","url":"https://itbook.store/books/9781430260226"},{"title":"Developing iOS Applications with Flex 4.5","subtitle":"Building iOS Applications with ActionScript","isbn13":"9781449308360","price":"$12.99","image":"https://itbook.store/img/books/9781449308360.png","url":"https://itbook.store/books/9781449308360"},{"title":"iOS 6 Programming Cookbook","subtitle":"Solutions for iOS Developers","isbn13":"9781449342753","price":"$4.45","image":"https://itbook.store/img/books/9781449342753.png","url":"https://itbook.store/books/9781449342753"}]}
        """
        //greeting[greeting.index(before: greeting.endIndex)] //!

        let jsonData = json.data(using: .utf8)!
        let bookInfoData = try! JSONDecoder().decode(BookInfoResponse.self, from: jsonData)
        XCTAssertEqual("$4.45", bookInfoData.books.last!.price)
        XCTAssertEqual("iOS Components and Frameworks", bookInfoData.books.first?.title)
        XCTAssertEqual("360", bookInfoData.total)

    }

}
