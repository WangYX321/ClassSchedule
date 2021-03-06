//
//  ViewController.swift
//  ClassSchedule
//
//  Created by wyx on 2017/10/29.
//  Copyright © 2017年 wyx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var weeks = [String]()
    
    let classes = ["英语", "数学", "语文", "科学", "体育", "音乐", "美术"]
    
    var column = 0
    var row = 0

    @IBOutlet weak var collectionView: UICollectionView!
    
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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.changeNumber), name: NSNotification.Name("Notification_changeNumber"), object: nil)
    }
    
//    @objc func changeNumber() {
//        if let num = UserDefaults.standard.value(forKey: "TableColumn") {
//            column = num as! Int
//        }
//
//        if let num = UserDefaults.standard.value(forKey: "TableRow") {
//            row = num as! Int
//        }
//
//        self.collectionView.reloadData()
//    }
    
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
            
            return cell!
        } else {
            if indexPath.row % (column+1) == 0 {
                cell?.nameLabel.text = "\(1 + indexPath.row/(column+1))"
            } else {
                cell?.nameLabel.text = classes[Int(arc4random_uniform(UInt32(classes.count-1)))]
            }
            
            return cell!        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.size.width/CGFloat(column + 1), height: 40)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

