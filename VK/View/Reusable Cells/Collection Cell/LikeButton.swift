//
//  LikeButton.swift
//  VK
//
//  Created by Polina Tikhomirova on 31.01.2022.
//

import UIKit

@IBDesignable class LikeButton: UIControl {
    @IBInspectable var likesCount: Int = 0 {
        didSet {
            updateSelectionState()
        }
    }
    
    @IBInspectable var likeImage: UIImage? = nil {
        didSet {
            likeImageView.image = likeImage
        }
    }
    
    private var stackView: UIStackView!
    private var countLabel: UILabel!
    private var likeImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    private func commonInit() {
        countLabel = UILabel()
        likeImageView = UIImageView()
        likeImageView.contentMode = .scaleAspectFit
        countLabel.textAlignment = .left
        stackView = UIStackView(arrangedSubviews: [countLabel, likeImageView])
        addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        updateSelectionState()
    }
    
    private func updateLabelText() {
        let additionalLikes = isSelected ? 1 : 0
        let totalLikes = likesCount + additionalLikes
        if totalLikes >= 1000 {
            countLabel.text = "1К"
        } else {
            countLabel.text = "\(totalLikes)"
        }
        
    }

    private func updateSelectionState() {
        let color = isSelected ? tintColor : .gray
        countLabel.textColor = color
        likeImageView.tintColor = color
        updateLabelText()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = !isSelected
        updateSelectionState()
        countLabelAnimations()
    }
    
    private func countLabelAnimations() {
        let animatin = CASpringAnimation(keyPath: "transform.scale")
        animatin.fromValue = 1
        animatin.toValue = 2
        animatin.duration = 1
        animatin.beginTime = CACurrentMediaTime()
        animatin.fillMode = .backwards
        animatin.stiffness = 200
        animatin.damping = 0.9
        animatin.mass = 0.5
        countLabel.layer.add(animatin, forKey: nil)
    }
}
