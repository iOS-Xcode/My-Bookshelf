//
//  BookInfoTableViewCell.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import UIKit

class BookInfoTableViewCell: UITableViewCell {
    static let identifier = "BookInfoTableViewCell"
    
    public let bookImageView: BookImageView = {
        let imageView = BookImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
        
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .semibold)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(title: String, isbn: String, price: String) {
        self.title.text = title
        //bookImageView.image = imageName.image
        self.isbn.text = isbn
        self.price.text = price
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //bookImageView.image = nil
        title.text = nil
        isbn.text = nil
        price.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //print(contentView.bounds.midY, contentView.frame.midY)
        let imageSize = contentView.frame.size.height - 20
        bookImageView.frame = CGRect(x: 10, y: 10, width: imageSize, height: imageSize)
        title.frame = CGRect(x: 20 + bookImageView.frame.size.width, y: contentView.bounds.minY + 10, width: contentView.frame.maxX - bookImageView.frame.width - 30, height: 40)
        isbn.frame = CGRect(x: 20 + bookImageView.frame.size.width, y: title.bounds.maxY + 10, width: contentView.frame.maxX - bookImageView.frame.width - 30, height: 20)
        price.frame = CGRect(x: 20 + bookImageView.frame.size.width, y: contentView.bounds.maxY - 30, width: contentView.frame.maxX - bookImageView.frame.width - 30, height: 20)
    }
}
