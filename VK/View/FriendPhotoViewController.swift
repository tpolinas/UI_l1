//
//  FriendPhotoViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 28.01.2022.
//

import UIKit

class FriendPhotoViewController: UIViewController {
    
    var photos: UserModel?
    var selectedIndex: Int = 0
    var imageScrollView: ImageScrollView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photos?.userPhotos[selectedIndex]
        photoImageView.backgroundColor = view.backgroundColor
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftAction))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightAction))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
}
extension FriendPhotoViewController {
    @objc
    func swipeLeftAction() {
        
        
        guard photos?.userPhotos.count ?? 0 > selectedIndex + 1 else { return }
        
        let nextImage = photos?.userPhotos[selectedIndex + 1]
        
        let newTemporaryImageView = UIImageView()
        newTemporaryImageView.backgroundColor = view.backgroundColor
        newTemporaryImageView.contentMode = .scaleAspectFit
        newTemporaryImageView.image = nextImage
       
        newTemporaryImageView.frame = photoImageView.frame
       
        newTemporaryImageView.frame.origin.x += photoImageView.frame.width
        
        view.addSubview(newTemporaryImageView)
       
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                
                self.photoImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.7) {
               
                newTemporaryImageView.frame.origin.x = 0
            }
        } completion: { _ in
            
            self.selectedIndex += 1
           
            self.photoImageView.image = nextImage
          
            self.photoImageView.transform = .identity
            
            newTemporaryImageView.removeFromSuperview()
        }
    }
    
    @objc
    func swipeRightAction() {
       
        guard selectedIndex > 0 else { return }
        
        let nextImage = photos?.userPhotos[selectedIndex - 1]
      
        let newTemporaryImageView = UIImageView()
        newTemporaryImageView.backgroundColor = view.backgroundColor
        newTemporaryImageView.contentMode = .scaleAspectFit
        newTemporaryImageView.image = nextImage
       
        newTemporaryImageView.frame = photoImageView.frame
      
        newTemporaryImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
       
        view.addSubview(newTemporaryImageView)
      
        view.sendSubviewToBack(newTemporaryImageView)
       
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                self.photoImageView.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3) {
                newTemporaryImageView.transform = .identity
            }
        } completion: { _ in
           
            self.selectedIndex -= 1
        
            self.photoImageView.image = nextImage
            
            self.photoImageView.transform = .identity
            
            newTemporaryImageView.removeFromSuperview()
        }
    }
}

