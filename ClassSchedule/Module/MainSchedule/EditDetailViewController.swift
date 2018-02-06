//
//  EditDetailViewController.swift
//  ClassSchedule
//
//  Created by wyx on 2017/10/29.
//  Copyright © 2017年 wyx. All rights reserved.
//

import UIKit
//用前后传递手机的过程来理解约定协议
protocol SelectedClassToScheduleDelegate {
    func selectedClassToSchedule(classModel:ClassModel)
}

class EditDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var dataArray = [ClassModel]()
    var selectedClassModel = ClassModel()
    
    var delegate : SelectedClassToScheduleDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataArray = CDOption.fetchClazz()
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedClassModel = self.dataArray[indexPath.row]
        self.delegate?.selectedClassToSchedule(classModel: self.selectedClassModel)
        self.navigationController?.popViewController(animated: true)
        return indexPath
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
