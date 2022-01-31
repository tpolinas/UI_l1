//
//  PhotosFriendCollectionViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 28.01.2022.
//

import UIKit

class PhotosFriendCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photos: UserModel?
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(
            UINib(
                nibName: "ProfileCollectionCell",
                bundle: nil),
            forCellWithReuseIdentifier: "profileCollectionCell")
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos?.userPhotos.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCollectionCell", for: indexPath) as? ProfileCollectionCell else { return UICollectionViewCell() }
        
        let photo = photos?.userPhotos[indexPath.item]
        
        cell.photo.layer.borderWidth = 3
        cell.photo.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.photo.image = photo
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.width
        let insets = collectionView.contentInset.left + collectionView.contentInset.right
        width -= insets
        width -= 40
        width /= 3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        performSegue(withIdentifier: "toFriendPhoto", sender: selectedIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        
        if segue.identifier == "toFriendPhoto" {
            
            guard let detailVC = segue.destination as? FriendPhotoViewController,
                  let indexPath = self.collectionView.indexPathsForSelectedItems?.first else { return }
            
            detailVC.selectedIndex = indexPath.item
            detailVC.photos = photos
        }
    }
}

