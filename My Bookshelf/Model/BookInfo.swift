//
//  BookInfo.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

/*
 {"title":"iOS Components and Frameworks","subtitle":"Understanding the Advanced Features of the iOS SDK","isbn13":"9780321856715","price":"$23.30","image":"https://itbook.store/img/books/9780321856715.png","url":"https://itbook.store/books/9780321856715"}
 */

struct BookInfo: Decodable {
    var title : String
    var subtitle : String
    var isbn13 : String
    var price : String
    var image : String
    var url : String
}

struct BookInfoResponse: Decodable {
    var books: [BookInfo]
}
