//
//  DetailBookViewController.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-17.
//
/*
 It has two sections, one of the section has book image, title, subtitle and etc, the other has price, desc, comment button and etc.
 */
import UIKit

class DetailBookViewController: UIViewController {
    //Get informatin of book like keyword
    var isbn : String = ""
    
    //StarsRating frame
    lazy var starsRating = RatingStars(frame: CGRect(x: 0, y: 0, width: kStatSize * 4 + (CGFloat(kSpacing) * 5), height: kStatSize))

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
        fetchBookDetail()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //Fetch data by isbn numbers
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

            cell.configure(bookDetail)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookPriceDescTableViewCell.identifier, for: indexPath) as? BookPriceDescTableViewCell else {
                return UITableViewCell()
            }

            cell.configure(bookDetail)

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
            return 350
        case 1:
            return 400
        default:
            fatalError()
        }
    }
    
    //MARK: - Any performance
    
    @objc func didTapUrlLable(_ sender: UITapGestureRecognizer) {
        
        guard let url = cellForSection1.url.restorationIdentifier else {
            print("The url is nil")
            return
        }
        //Open safari by url.
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
    //Show up AlertView
    @objc func didTapCommentButton(_ button : UIButton) {
        let alert = UIAlertController(title: nil, message: "Your review",
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
        
        //For adding AlertView.
        let tempViewController = UIViewController()
        tempViewController.view = starsRating
        alert.setValue(tempViewController, forKey: "contentViewController")
        alert.view.addSubview(starsRating)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let review = alert.textFields![0]
            self.cellForSection1.comment.text = review.text
            tempViewController.view = nil
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                                        print("Cancel")}))
        
        self.present(alert, animated: true)
    }
}
