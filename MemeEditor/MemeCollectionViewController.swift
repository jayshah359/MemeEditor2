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
	//var itemsAcross: Int = 0
	@IBOutlet weak var flowLayout: MemeCollectionViewFlowLayout!
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//TODO: Update and test flowLayout here.
		//computer itemsAcross
//		print(itemsAcross2())
//		itemsAcross = itemsAcross2()
		//flowLayout.minimumInteritemSpacing = space
		//flowLayout.minimumLineSpacing = space
		
		//flowLayout.itemSize = computeSize(withSpace: space, items: itemsAcross)

//		let xDimension = (view.frame.size.width - (3 * space)) / 4.0
		//let yDimension = (view.frame.size.height - (4 * space)) / 5.0
		
//		flowLayout.minimumInteritemSpacing = space
//		flowLayout.minimumLineSpacing = space
//		flowLayout.itemSize = CGSize(width: xDimension, height: xDimension)
	}
	
//	func computeSize(withSpace space: CGFloat, items: Int) -> CGSize {
//
//		let dimension = (view.frame.size.width - (CGFloat(items-1) * space)) / CGFloat(items)
//		return CGSize(width: dimension, height: dimension)
//	}
	
//	func itemsAcross2() -> Int {
//		print("width: \(Int(view.frame.size.width))")
//		return Int(view.frame.size.width) / 125
//	}
	
//	override func viewWillAppear(_ animated: Bool) {
//		super.viewWillAppear(animated)
//		//self.tabBarController?.tabBar.isHidden = false
//		//collectionView!.reloadData()
//	}
	
//	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//		super.viewWillTransition(to: size, with: coordinator)
//		//computer itemsAcross
//		//print(itemsAcross2())
//		itemsAcross = itemsAcross2()
//		coordinator.animate(alongsideTransition: nil) {
//			_ in
//			self.itemsAcross = self.itemsAcross2()
//			self.collectionView!.collectionViewLayout.invalidateLayout()
//		}
//	}
	
	// ?? move to custom flow layout?
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		return computeSize(withSpace: space, items: itemsAcross)
//	}
	
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
		cell.currentMeme = meme
		cell.setupView(withFontSize: 12)
		if let memedImage = meme.memedImage {
			cell.memeImage.image = memedImage
			cell.bottomTextField.isHidden = true
			cell.topTextField.isHidden = true
		}
		return cell
	}
}
