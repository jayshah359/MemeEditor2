//
//  MemeCollectionViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/15/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SentMemeViewControllers {
	
	// MARK: Properties
	var selectedItem: Int?
	
	@IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//TODO: Update and test flowLayout here.
		
		let space: CGFloat = 3.0
		let xDimension = (view.frame.size.width - (3 * space)) / 4.0
		//let yDimension = (view.frame.size.height - (4 * space)) / 5.0
		
		flowLayout.minimumInteritemSpacing = space
		flowLayout.minimumLineSpacing = space
		flowLayout.itemSize = CGSize(width: xDimension, height: xDimension)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//self.tabBarController?.tabBar.isHidden = false
		//collectionView!.reloadData()
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		coordinator.animate(alongsideTransition: nil) {
			_ in
			self.collectionView!.collectionViewLayout.invalidateLayout()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let space: CGFloat = 3.0
		let dimension = (view.frame.size.width - (3 * space)) / 4.0
		return CGSize(width: dimension, height: dimension)
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return MemeModel.allMemes.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedItem = (indexPath as NSIndexPath).row
		tabBarController?.performSegue(withIdentifier: "sentMemesToDetailSegue", sender: self)
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let meme = MemeModel.allMemes[(indexPath as NSIndexPath).row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
		cell.imageView?.image = meme.memedImage ?? meme.originalImage
		//TODO: set text enabled if using original image
		if let _ = meme.memedImage {
			cell.textLabel.isHidden = true
		}
		//else set text disabled
		cell.textLabel?.text = meme.topText + "/" + meme.bottomText
		return cell
	}
}
