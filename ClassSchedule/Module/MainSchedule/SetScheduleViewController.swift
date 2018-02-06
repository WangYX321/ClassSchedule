//
//  SetScheduleViewController.swift
//  ClassSchedule
//
//  Created by wyx on 2017/12/10.
//  Copyright © 2017年 wyx. All rights reserved.
//

import UIKit

class SetScheduleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SelectedClassToScheduleDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var weeks = [String]()
    var selectedRow : Int?
//    var dataDic = [Int:ClassModel]()
    var dataDic = [Int:ClassInScheduleModel]()
    let tableColumn = UserDefaults.standard.integer(forKey: "TableColumn")
    
    var column = 0
    var row = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let num = UserDefaults.standard.value(forKey: "TableColumn") {
            column = num as! Int
            print(column)
        }
        
        if let num = UserDefaults.standard.value(forKey: "TableRow") {
            row = num as! Int
            print(row)
        }
        
        self.collectionView.reloadData()
        
        weeks.removeAll()
        for item in 0...column {
            if item == 0 {
                weeks.append("")
            } else {
                weeks.append("Day"+"\(item)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.dataDic = CDOption.fetchClassesInSchedule()
        self.collectionView.reloadData()
        print(self.dataDic)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return column + 1
        } else {
            return (column + 1) * row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCellId", for: indexPath) as? ClassCell
        if indexPath.section == 0 {
            cell?.nameLabel.text = weeks[indexPath.row]
            cell?.backgroundColor = UIColor.white
            return cell!
        } else {
            if indexPath.row % (column+1) == 0 {
                cell?.nameLabel.text = "\(1 + indexPath.row/(column+1))"
                cell?.backgroundColor = UIColor.white
            } else {
//                let rowTemp = indexPath.row
//                let columnTemp = indexPath.row
                
                if let classModel = self.dataDic[indexPath.row] {
                    cell?.nameLabel.text = classModel.subject
                    cell?.backgroundColor = ColorSelector.getColorFromTag(tag: Int(classModel.bgColor))
                } else {
                    cell?.nameLabel.text = ""
                    cell?.backgroundColor = UIColor.white
                }
                
            }
            
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.size.width/CGFloat(column + 1), height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        } else {
            return indexPath.row % (column+1) == 0 ? false : true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectClassSegue" {
            let vc = segue.destination as? EditDetailViewController
            vc?.delegate = self
        }
    }
    
    func selectedClassToSchedule(classModel: ClassModel) {
        print(classModel.name)
        var oldModel = self.dataDic[self.selectedRow!]
        if oldModel == nil {
            oldModel = ClassInScheduleModel()
        }
        oldModel?.subject = classModel.name
        oldModel?.bgColor = Int32(classModel.bgColor)
        oldModel?.column = Int32(self.selectedRow!%tableColumn)
        oldModel?.row = Int32(self.selectedRow!/tableColumn)
        
        self.dataDic[self.selectedRow!] = oldModel
        self.collectionView.reloadData()
        CDOption.insertClassesInSchedule(model: oldModel!)
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
