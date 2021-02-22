//
//  BookPriceDescTableViewCell.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-18.
//

import UIKit

class BookPriceDescTableViewCell: UITableViewCell {
    static let identifier = "BookPriceDescIdentifier"
    
    private let isbn10: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    private let isbn13: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let rating: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    public let url: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let desc: UITextView = {
        let textView = UITextView()
        textView.textColor = .darkGray
        textView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        textView.font = .systemFont(ofSize: 12, weight: .medium)
        textView.textAlignment = .left
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    
    public let comment: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.text = "Comment"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    public let commentButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("COMMENT", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(isbn10)
        contentView.addSubview(isbn13)
        contentView.addSubview(price)
        contentView.addSubview(rating)
        contentView.addSubview(url)
        contentView.addSubview(desc)
        contentView.addSubview(comment)
        contentView.addSubview(commentButton)
        
        //isbn10
        isbn10.heightAnchor.constraint(equalToConstant: 13).isActive = true
        isbn10.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        isbn10.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        //publisher.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        //isbn13
        isbn13.heightAnchor.constraint(equalToConstant: 13).isActive = true
        isbn13.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        isbn13.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        //authors.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        //price
        price.heightAnchor.constraint(equalToConstant: 18).isActive = true
        price.topAnchor.constraint(equalTo: isbn10.bottomAnchor, constant: 20).isActive = true
        price.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        //authors.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        //rating
        rating.heightAnchor.constraint(equalToConstant: 14).isActive = true
        rating.topAnchor.constraint(equalTo: isbn13.bottomAnchor, constant: 24).isActive = true
        rating.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        //authors.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        //url
        url.heightAnchor.constraint(equalToConstant: 24).isActive = true
        url.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 10).isActive = true
        url.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        //authors.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        //desc
        desc.heightAnchor.constraint(equalToConstant: 100).isActive = true
        desc.topAnchor.constraint(equalTo: url.bottomAnchor, constant: 15).isActive = true
        desc.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        desc.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        
        //comment
        comment.heightAnchor.constraint(equalToConstant: 40).isActive = true
        comment.topAnchor.constraint(equalTo: desc.bottomAnchor).isActive = true
        desc.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        comment.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        //commentButton
        commentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        commentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        commentButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        commentButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(_ bookDetail : BookDetail ) {
        self.isbn10.text = "ISBN10 : " + (bookDetail.isbn10 ?? "")
        self.isbn13.text = "ISBN13 : " + (bookDetail.isbn13 ?? "")
        self.price.text = "Price : " + (bookDetail.price ?? "")
        self.rating.text = "Rating : " + (bookDetail.rating ?? "") + "/5"
        self.url.text = "URL : " + (bookDetail.url ?? "")
        self.url.restorationIdentifier = bookDetail.url
        self.url.isUserInteractionEnabled = true
        self.desc.text = bookDetail.desc
    }
}
