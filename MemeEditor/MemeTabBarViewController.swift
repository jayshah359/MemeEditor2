//
//  MemeTabBarViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/29/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

// Defines the Meme tab bar view controller. Will store table and collection views of the Memes
class MemeTabBarViewController: UITabBarController {
	// MARK: Override functions
	// The tab bar handles the segue to the detail view instead of the table or collection view
	// use the selected item saved from before to set the current Meme in the new detail view controller
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "sentMemesToDetailSegue" {
			let detailController = segue.destination as! MemeDetailViewController
			if let selectedItem = (sender as? SentMemeViewControllers)?.selectedItem {
				detailController.currentMeme = MemeModel.allMemes[selectedItem]
			}
		}
	}
	
	// MARK: IBAction functions
	// This is so that we can unwind back to the tab bar view controller
	@IBAction func unwindFromEditorVC(_ sender: UIStoryboardSegue) {
		
	}
}

// Any view controller that goes inside the tab bar view controller should conform to the
// SentMemeViewControllers protocol. It will ensure a place to save the selected Meme so
// we can perform the segue to the detail view controller from the tab bar view controller
protocol SentMemeViewControllers: class {
	// MARK: Properties
	// Used to save the selected Meme before segueing
	var selectedItem: Int? { get set }
	var tabBarController: UITabBarController? { get }
}

// This extension provides a default implementation of a helper function that can be used whenever
// we need to call didSelectItemAt
extension SentMemeViewControllers {
	// The implementation of didSelectItemAt for all controllers conforming to this protocol is
	// the same, so we can use this helper function to perform the segue
	func sentMemeView(didSelectItemAt indexPath: IndexPath) {
		self.selectedItem = (indexPath as NSIndexPath).row
		tabBarController?.performSegue(withIdentifier: "sentMemesToDetailSegue", sender: self)
	}
}

