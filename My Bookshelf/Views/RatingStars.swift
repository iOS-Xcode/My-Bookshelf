//
//  RatingStars.swift
//  My Bookshelf
//
//  Created by Seokhyun Kim on 2021-02-20.
//
/*
 Five buttons in the alertView to give the user a star rating for the book
 */

import UIKit

let kSpacing: Int = 8 //Spacing of viewStack
let kStatSize: CGFloat = 30.0 //A star size

class RatingStars: UIStackView {
    private var ratingButtons = [UIButton]()
    var rating: Int = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    var starCount: Int = 5 {
        didSet {
            setUpButton()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        spacing = CGFloat(kSpacing)
        setUpButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButton()
    }
    
    private func setUpButton() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for index in 0..<starCount {
            let button = UIButton()
            
            button.setImage(UIImage(named: "emptyStar"), for: .normal)
            button.setImage(UIImage(named: "filledStar"), for: .highlighted)
            button.setImage(UIImage(named: "highlightedStar"), for: .selected)
            button.setImage(UIImage(named: "highlightedStar"), for: [.highlighted, .selected])

            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            button.accessibilityLabel = "Set \(index)+1 Rating"
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero"
            } else {
                hintString = nil
            }
            
            let valueString: String
            switch rating {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    @objc func ratingButtonTapped(button : UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError()
        }
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
}
