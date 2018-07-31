//
//  MemeTableViewController.swift
//  MemeEditor
//
//  Created by Jaydev Shah on 7/15/18.
//  Copyright © 2018 Jaydev Shah. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController, SentMemeWithImageViewControllers {
	
	// MARK: Properties
	
	var selectedItem: Int?
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MemeModel.allMemes.count
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedItem = (indexPath as NSIndexPath).row
		tabBarController?.performSegue(withIdentifier: "sentMemesToDetailSegue", sender: self)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let meme = MemeModel.allMemes[(indexPath as NSIndexPath).row]
		var cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
		cell = configureCellImage(cell, withMeme: meme) as! UITableViewCell
		cell.textLabel?.text = meme.topText + "/" + meme.bottomText
		return cell
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tableView.reloadData()
	}
}

extension UITableViewCell: SentMemeViewCell {}
