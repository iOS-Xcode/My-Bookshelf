//
//  BookDetailImageInfoTableViewCell.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-17.
//

import UIKit

class BookDetailImageInfoTableViewCell: UITableViewCell {
    static let identifier = "BookDetailImageIdentifier"
    
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
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let publisher: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let authors: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let language: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let pages: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let year: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
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
        contentView.addSubview(subTitle)
        contentView.addSubview(publisher)
        contentView.addSubview(authors)
        contentView.addSubview(language)
        contentView.addSubview(pages)
        contentView.addSubview(year)
        
        //bookImageView
        bookImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        bookImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        //title
        title.heightAnchor.constraint(equalToConstant: 36).isActive = true
        title.topAnchor.constraint(equalTo: bookImageView.bottomAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
        //subTitle
        subTitle.heightAnchor.constraint(equalToConstant: 16).isActive = true
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        subTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        subTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
        //publisher
        publisher.heightAnchor.constraint(equalToConstant: 13).isActive = true
        publisher.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 5).isActive = true
        publisher.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        //publisher.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        //authors
        authors.heightAnchor.constraint(equalToConstant: 13).isActive = true
        authors.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 5).isActive = true
        authors.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        //authors.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        //language
        language.heightAnchor.constraint(equalToConstant: 13).isActive = true
        //language.heightAnchor.constraint(equalToConstant: 200).isActive = true
        language.topAnchor.constraint(equalTo: publisher.bottomAnchor, constant: 5).isActive = true
        language.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        //pages
        pages.heightAnchor.constraint(equalToConstant: 13).isActive = true
        pages.topAnchor.constraint(equalTo: publisher.bottomAnchor, constant: 5).isActive = true
        pages.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        pages.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
        //year
        year.heightAnchor.constraint(equalToConstant: 13).isActive = true
        year.topAnchor.constraint(equalTo: authors.bottomAnchor, constant: 5).isActive = true
        //year.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        year.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(title: String, subtitle: String, publisher: String, authors: String, language: String, pages: String, year: String) {
        self.title.text = title
        self.subTitle.text = subtitle
        self.publisher.text = publisher
        self.authors.text = authors
        self.language.text = "Language : " + language
        self.pages.text = "Pages : " + pages
        self.year.text = year
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        subTitle.text = nil
        publisher.text = nil
        authors.text = nil
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

