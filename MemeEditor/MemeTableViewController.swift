//
//  MemeTableViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/15/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
	
	// MARK: Properties
	
	// Get ahold of some memes, for the table
	// This is an array of MemeModel instances
	//let allMemes = MemeModel.allMemes
	
	// MARK: Table View Data Source
	
	var selectedRow = 0
	
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
		selectedRow = (indexPath as NSIndexPath).row
		self.performSegue(withIdentifier: "tableToDetailSegue", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "tableToDetailSegue" {
			let detailController = segue.destination as! MemeDetailViewController
			detailController.currentMeme = MemeModel.allMemes[selectedRow]
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tableView.reloadData()
	}
}
