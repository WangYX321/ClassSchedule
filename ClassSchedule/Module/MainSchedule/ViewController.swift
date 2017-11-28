//
//  ViewController.swift
//  ClassSchedule
//
//  Created by wyx on 2017/10/29.
//  Copyright © 2017年 wyx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let weeks = ["", "周一", "周二", "周三", "周四", "周五"]
    let classes = ["英语", "数学", "语文", "科学", "体育", "音乐", "美术"]

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else {
            return 48
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCellId", for: indexPath) as? ClassCell
        if indexPath.section == 0 {
            cell?.nameLabel.text = weeks[indexPath.row]
            
            return cell!
        } else {
            if indexPath.row % 6 == 0 {
                cell?.nameLabel.text = "\(1 + indexPath.row/6)"
            } else {
                cell?.nameLabel.text = classes[Int(arc4random_uniform(UInt32(classes.count-1)))]
            }
            
            return cell!        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/6, height: (self.view.frame.size.height - 64)/9)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

