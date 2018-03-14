//
//  ClassesTableViewController.swift
//  ClassSchedule
//
//  Created by wyx on 2017/11/11.
//  Copyright © 2017年 wyx. All rights reserved.
//

import UIKit

class ClassesTableViewController: UITableViewController {

    var dataArray = [ClassModel]()
    var selectedClassModel = ClassModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataArray = CDOption.fetchClazz()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "classesCellId", for: indexPath) as? ClassesCell
        
        if cell == nil {
            cell = ClassesCell(style: .default, reuseIdentifier: "classesCellId")
        }
        
        cell?.nameLabel.text = self.dataArray[indexPath.row].name
        cell?.roomLabel.text = self.dataArray[indexPath.row].room
        cell?.teacherLabel.text = self.dataArray[indexPath.row].teacher
        cell?.backgroundColor = ColorSelector.getColorFromTag(tag: Int(self.dataArray[indexPath.row].bgColor))

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//        }
//    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedClassModel = self.dataArray[indexPath.row]
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editClassSegue" {
            let vc = segue.destination as? AddClassViewController
            vc?.classModel = self.selectedClassModel
            vc?.title = "Edit Class"
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let finish = UITableViewRowAction(style: .normal, title: "完成") { (action, index) in
            AlertView.showAlert(message: "完成", inView: self)
        }
        finish.backgroundColor = UIColor.orange
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { (action, index) in
            let alert = UIAlertController(title: "确定要删除么?", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let confirm = UIAlertAction(title: "删除", style: .destructive, handler: { (action) in
                CDOption.deleteClazz(model: self.dataArray[indexPath.row], completion: { success in
                    if success {
                        self.dataArray.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .left)
                        AlertView.showAlert(message: "删除成功", inView: self)
                    }
                })
            })
            alert.addAction(cancel)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
        }
        
        return [finish, delete]
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
