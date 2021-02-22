//
//  BookInfo.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

/*
 This is the Data model that books list when user seached keyword.
 {"error":"0","total":"116","page":"8","books":[{"title":"Expert SQL Server Transactions and Locking","subtitle":"Concurrency Internals for SQL Server Practitioners","isbn13":"9781484239568","price":"$24.23","image":"https://itbook.store/img/books/9781484239568.png","url":"https://itbook.store/books/9781484239568"}
 */

//Dispaly on tableView cell
struct BookInfo: Decodable {
    var title : String
    var subtitle : String
    var isbn13 : String?
    var price : String
    var image : String
    var url : String //Web url
}

struct BookInfoResponse: Decodable {
    var total : String //Total books by search
    var page : String //Current page
//    var error : String
    var books: [BookInfo] //Array of bookInfo
}
