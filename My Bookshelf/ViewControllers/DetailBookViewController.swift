//
//  DetailBookViewController.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-17.
//

import UIKit

class DetailBookViewController: UIViewController {
    
    var isbn : String = ""
    
    var bookDetail = BookDetail() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    lazy var cellForSection1 : BookPriceDescTableViewCell = {
        let indexPath = NSIndexPath(row: 0, section: 1) as IndexPath
        let cell = self.tableView.cellForRow(at: indexPath) as? BookPriceDescTableViewCell
        return cell!
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookPriceDescTableViewCell.self, forCellReuseIdentifier: BookPriceDescTableViewCell.identifier)
        tableView.register(BookDetailImageInfoTableViewCell.self, forCellReuseIdentifier: BookDetailImageInfoTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.prefersLargeTitles = false
        fetchBookDetail()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func fetchBookDetail() {
        let bookRequest = RequestBookInfo(bookDetailString: self.isbn)
        bookRequest.fetchBookDetail {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let bookDetail):
                self?.bookDetail = bookDetail
            }
        }
    }
}

//MARK: - UITableView Delegate
extension DetailBookViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookDetailImageInfoTableViewCell.identifier, for: indexPath) as? BookDetailImageInfoTableViewCell else {
                return UITableViewCell()
            }
            
            if let url = URL(string: bookDetail.image ?? "") {
                cell.bookImageView.loadImage(from: url)
            }
            //      cell.configure(with: viewModel.moderator(at: indexPath.row))

            //language: String, pages: String, year: String
            cell.configure(title: bookDetail.title ?? "", subtitle: bookDetail.subtitle ?? "", publisher: bookDetail.publisher ?? "", authors: bookDetail.authors ?? "", language: bookDetail.language ?? "", pages: bookDetail.pages ?? "", year: bookDetail.year ?? "")
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookPriceDescTableViewCell.identifier, for: indexPath) as? BookPriceDescTableViewCell else {
                return UITableViewCell()
            }

            cell.configure(isbn10: bookDetail.isbn10 ?? "", isbn13: bookDetail.isbn13 ?? "", price: bookDetail.price ?? "", rating: bookDetail.rating ?? "", url: bookDetail.url ?? "", desc: bookDetail.desc ?? "")
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapUrlLable(_:)))
            cell.url.addGestureRecognizer(tap)
            
            cell.commentButton.addTarget(self, action: #selector(didTapCommentButton(_:)), for: .touchUpInside)
            return cell
            
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 300
        default:
            fatalError()
        }
    }
    
    //MARK: - Any perform
    
    @objc func didTapUrlLable(_ sender: UITapGestureRecognizer) {
        
        guard let url = cellForSection1.url.restorationIdentifier else {
            print("The url is nil")
            return
        }
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
    
    @objc func didTapCommentButton(_ button : UIButton) {
        let alert = UIAlertController(title: "Your review", message: nil,
                                      preferredStyle: .alert)
        
        alert.view.tintColor = .blue
        alert.view.backgroundColor = .lightGray
        alert.view.layer.cornerRadius = 25
        
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Let me know your experience"
        }
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let review = alert.textFields![0]
            self.cellForSection1.comment.text = review.text
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                                        print("Cancel")}))
        
        self.present(alert, animated: true)
    }
}
