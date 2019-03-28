//
//  MainTableViewController.swift
//  DynamicTable
//
//  Created by Faical Sawadogo1212 on 03/01/19.
//  Copyright © 2019 Faical Sawadogo1212 . All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private var rowCount       = 0
    private let sectionCount   = 1
    
    private var itemStore = ItemStore()
    var tableEditingStyle : UITableViewCell.EditingStyle = .delete
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory,
                                                       in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("archive.data")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionCount
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
          return tableEditingStyle
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "numberCell",
                                                 for: indexPath)
        
        // Configure the cell...
        let row  = indexPath.row
        let item = itemStore.getItem(index: row)
        let name = item.name
        
        if name.count != 0 {
            // Use the name from the Item
            cell.textLabel?.text = name
        }
        else {
            // Use the row number
            cell.textLabel?.text = String(format: "Contact%d",
                                          arguments: [row + 1])
        }

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func toggleEditingMode() {
        // Toggle ...
        if self.isEditing
        {
            self.setEditing(false, animated: true)
        }
        else
        {
            self.setEditing(true, animated: true)
        }
    }
    
    func toggleDeleteInsert() {
        // Toggle the editing style
        if tableEditingStyle == .delete
        {
            tableEditingStyle = .insert
            navigationItem.rightBarButtonItems![2].title = "Insert"
        }
        else
        {
            tableEditingStyle = .delete
            navigationItem.rightBarButtonItems![2].title = "Delete"
        }
        
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView,
                            canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            // Remove the item from the itemStore
            itemStore.deleteItem(index: indexPath.row)
            
            // Remove a row from the table
            rowCount -= 1
            
            // Tell the tableView to delete a cell
            tableView.deleteRows(at: [indexPath], with: .middle)
            
            // Cause the rows to get renumbere
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Add an new item in data source container
            itemStore.insertItem(index: indexPath.row)
            
            // Increase the number of rows
            rowCount += 1
            
            // Have the table add a new row
            tableView.insertRows(at: [indexPath], with: .fade)
            
            // Tell the table to update itself
            tableView.reloadData()
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView,
                            moveRowAt fromIndexPath: IndexPath,
                            to: IndexPath) {
        // Keep the correspondence between row and container indexes
        itemStore.moveItem(first: fromIndexPath.row, second: to.row)
        
        
        // So the rows will renumber themselves properly
        tableView.reloadData()
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView,
                           canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
//    override func tableView(_ tableView: UITableView,
//                            titleForHeaderInSection section: Int) -> String? {
//            let title = String(format: "Section: %d",
//                               arguments: [section])
//            return title
//    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get a reference to the upcoming view controller
        let dest = segue.destination as? DetailViewController
        
        //
        let row = tableView.indexPathForSelectedRow?.row
        let item = itemStore.getItem(index: row!)
        
        // Set up the destination property
        dest!.selectedRow = row
        
        // Set the Item for the detail VC, table view VC reference
        dest!.item = item
    }
    
    @IBAction func addRow(_ sender: UIBarButtonItem) {
        rowCount += 1
        itemStore.addItem()
        tableView.reloadData()
    }
    
    @IBAction func toggleEdit(_ sender: UIBarButtonItem) {
        toggleEditingMode()
    }
    @IBAction func doToggleDeleteInsert(_ sender: UIBarButtonItem) {
        toggleDeleteInsert()
    }
    
    func getArchiveURL () -> NSURL {
        // Get the default file manager
        let fileManager = FileManager()// NSFileManager.defaultManager()
        
        // Get an array of URLs
        let urls = fileManager.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        // Get the document directory
        let documentDirectory = urls.last
        let fileWithPath = documentDirectory?.appendingPathComponent("archive.data")
        
        // Debug output
        print(">>>Document Directory: \(documentDirectory!)")
        
        return fileWithPath! as NSURL
    }
    
    func save() {
        // Get the file to save the archive to
        //let archiveFile = MainTableViewController.archiveURL.path
        let archiveFile = getArchiveURL().path!
        
        //Debugging
        print(">>> archiveURL: \(archiveFile)")
        
        // Do the archiving
        let success = NSKeyedArchiver.archiveRootObject(itemStore,
                                                        toFile: archiveFile)
        
        if !success {
            print(">>> Archive failed.")
        }
    }
    
    func load() -> Bool {
        // Get the file to save the archive to
        //let archiveFile = MainTableViewController.archiveURL.path
        let archiveFile = getArchiveURL().path!
        
        // The file will not exist the first time the app is run
        guard FileManager().fileExists(atPath: archiveFile) else {
            print(">>> Does not exist: \(archiveFile)")
            return false
        }
        
        //Debugging
        print(">>> archiveURL: \(archiveFile)")
        
        // Get the archived data
        let unArchivedData = NSKeyedUnarchiver.unarchiveObject(
                                            withFile: archiveFile)
        let unArchivedItemStore = unArchivedData as? ItemStore
        
        guard unArchivedItemStore != nil else {
            return false
        }
        
        // Restore the ItemStore
        itemStore = unArchivedItemStore!
        
        // Restore the table's row count! (See below)
        rowCount  = itemStore.itemCount()
        
        return true
    }
}
