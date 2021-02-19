//
//  BookDetail.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-17.
//

import Foundation
/*
 {
     "error": "0"
     "title": "Securing DevOps"
     "subtitle": "Security in the Cloud"
     "authors": "Julien Vehent"
     "publisher": "Manning"
     "isbn10": "1617294136"
     "isbn13": "9781617294136"
     "pages": "384"
     "year": "2018"
     "rating": "5"
     "desc": "An application running in the cloud can benefit from incredible efficiencies, but they come with unique security threats too. A DevOps team's highest priority is understanding those risks and hardening the system against them.Securing DevOps teaches you the essential techniques to secure your cloud ..."
     "price": "$26.98"
     "image": "https://itbook.store/img/books/9781617294136.png"
     "url": "https://itbook.store/books/9781617294136"
     "pdf": {
               "Chapter 2": "https://itbook.store/files/9781617294136/chapter2.pdf",
               "Chapter 5": "https://itbook.store/files/9781617294136/chapter5.pdf"
            }
 }
 */
struct BookDetail: Decodable {
    var image : String?
    var title : String?
    var subtitle : String?
    var publisher : String?
    var authors : String?
    var language : String?
    var isbn10 : String?
    var isbn13 : String?
    var pages : String?
    var year : String?
    var rating : String?
    var desc : String?
    var price : String?
    var url : String?
    //var pdf : [String : String]
}

