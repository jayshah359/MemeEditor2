//
//  MemeTabBarViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/29/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

class MemeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "sentMemesToDetailSegue" {
			let detailController = segue.destination as! MemeDetailViewController
			if let selectedItem = (sender as? SentMemeViewControllers)?.selectedItem {
				detailController.currentMeme = MemeModel.allMemes[selectedItem]
			}
		
//			var selectedItem: Int
//			if sender is MemeCollectionViewController {
//				selectedItem = (sender as! MemeCollectionViewController).selectedItem!
//			} else if sender is MemeTableViewController {
//				selectedItem = (sender as! MemeTableViewController).selectedItem
//			} else {
//				return
//			}
//			detailController.currentMeme = MemeModel.allMemes[selectedItem]
			
			
		}
	}
	
	@IBAction func unwindFromEditorVC(_ sender: UIStoryboardSegue) {
		
	}
}

protocol SentMemeViewControllers {
	var selectedItem: Int? { get set }
}

extension SentMemeViewControllers {
	
}
