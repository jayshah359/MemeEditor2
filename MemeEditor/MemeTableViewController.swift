//
//  MemeTableViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/15/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController, SentMemeViewControllers {
	
	// MARK: Properties
	
	// 
	var selectedItem: Int?
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MemeModel.allMemes.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
		let meme = MemeModel.allMemes[(indexPath as NSIndexPath).row]
		
		// Set the name and image
		cell.textLabel?.text = meme.topText + "/" + meme.bottomText
		cell.imageView?.image = meme.originalImage
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedItem = (indexPath as NSIndexPath).row
//		self.performSegue(withIdentifier: "tableToDetailSegue", sender: self)
		tabBarController?.performSegue(withIdentifier: "sentMemesToDetailSegue", sender: self)
	}
	
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if segue.identifier == "tableToDetailSegue" {
//			let detailController = segue.destination as! MemeDetailViewController
//			detailController.currentMeme = MemeModel.allMemes[selectedItem]
//		}
//	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tableView.reloadData()
	}

}
