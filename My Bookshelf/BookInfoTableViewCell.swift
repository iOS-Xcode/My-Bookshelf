//
//  BookInfoTableViewCell.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-15.
//

import UIKit

class BookInfoTableViewCell: UITableViewCell {
    static let identifier = "BookInfoTableViewCell"
    
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "book")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Custom CEll"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(bookImageView)
        contentView.addSubview(name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(text: String, imageName: String) {
        bookImageView.image = UIImage(named: imageName)
        name.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
        name.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(contentView.bounds.midY)
        let imageSize = contentView.frame.size.height - 50
        bookImageView.frame = CGRect(x: 10, y: contentView.bounds.midY / 2, width: imageSize, height: imageSize)
        name.frame = CGRect(x: 20 + bookImageView.frame.size.width, y: 10, width: 100, height: 30)
    }
}
