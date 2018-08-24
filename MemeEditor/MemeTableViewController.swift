//
//  MemeTableViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/15/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import UIKit

// Defines the Meme table view controller. Conforms to SentMemeViewControllers protocol
// in order to store the selected item (for segue to the Meme detail view controller)
class MemeTableViewController: UITableViewController, SentMemeViewControllers {
	// MARK: Properties
	// Stores the selected item for segue to the Meme detail view controller
	var selectedItem: Int?
	
	// MARK: Override functions
	// Determines the number of rows simply by counting all the items in the MemeModel
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MemeModel.allMemes.count
	}
	
	// When selecting a row, save it for the segue, and have the containing Tab bar controller do the segue
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		sentMemeView(didSelectItemAt: indexPath)
	}
	
	// To get the cell, look up the specific Meme, deque the cell and setup the image and text from the Meme
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let meme = MemeModel.allMemes[(indexPath as NSIndexPath).row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
		cell.imageView?.image = meme.memedImage ?? meme.originalImage
		cell.textLabel?.text = meme.topText + " / " + meme.bottomText
		return cell
	}
	
	// Allows easy swipe to delete on the Table view. Remove from the MemeModel and delete the row
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			MemeModel.allMemes.remove(at: (indexPath as NSIndexPath).row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	// Call reload data on viewWillAppear
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tableView.reloadData()
	}
}
