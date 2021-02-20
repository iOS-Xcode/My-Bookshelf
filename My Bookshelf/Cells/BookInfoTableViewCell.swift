//
//  BookInfoTableViewCell.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import UIKit

class BookInfoTableViewCell: UITableViewCell {
    static let identifier = "BookInfoTableViewIdentifier"
    
    public let bookImageView: BookImageView = {
        let imageView = BookImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let isbn: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(bookImageView)
        contentView.addSubview(title)
        contentView.addSubview(isbn)
        contentView.addSubview(price)
        
        //bookImageView
        bookImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        bookImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        bookImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        
        //title
        title.heightAnchor.constraint(equalToConstant: 34).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        title.leftAnchor.constraint(equalTo: bookImageView.rightAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        //isbn
        isbn.heightAnchor.constraint(equalToConstant: 16).isActive = true
        isbn.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true
        isbn.leftAnchor.constraint(equalTo: bookImageView.rightAnchor).isActive = true
        isbn.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        //price
        price.heightAnchor.constraint(equalToConstant: 14).isActive = true
        price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        price.leftAnchor.constraint(equalTo: bookImageView.rightAnchor).isActive = true
        price.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(_ bookInfo : BookInfo) {
        self.title.text = bookInfo.title
        //bookImageView.image = imageName.image
        self.isbn.text = bookInfo.isbn13
        self.price.text = bookInfo.price
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //bookImageView.image = nil
        title.text = nil
        isbn.text = nil
        price.text = nil
    }
    
    /*
     override func layoutSubviews() {
     super.layoutSubviews()
     //print(contentView.bounds.midY, contentView.frame.midY)
     let imageSize = contentView.frame.size.height - 20
     bookImageView.frame = CGRect(x: 10, y: 10, width: imageSize, height: imageSize)
     title.frame = CGRect(x: 20 + bookImageView.frame.size.width, y: contentView.bounds.minY + 10, width: contentView.frame.maxX - bookImageView.frame.width - 30, height: 40)
     isbn.frame = CGRect(x: 20 + bookImageView.frame.size.width, y: title.bounds.maxY + 10, width: contentView.frame.maxX - bookImageView.frame.width - 30, height: 20)
     price.frame = CGRect(x: 20 + bookImageView.frame.size.width, y: contentView.bounds.maxY - 30, width: contentView.frame.maxX - bookImageView.frame.width - 30, height: 20)
     }
     */
}
