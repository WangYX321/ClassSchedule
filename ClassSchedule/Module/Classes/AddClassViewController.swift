//
//  AddClassViewController.swift
//  ClassSchedule
//
//  Created by wyx on 2017/11/11.
//  Copyright © 2017年 wyx. All rights reserved.
//

import UIKit

class AddClassViewController: UIViewController {

    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var teacherNameTf: UITextField!
    @IBOutlet weak var roomNumberTf: UITextField!
    @IBOutlet weak var classNameTf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func colorSelectAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5) {
            self.arrow.center = CGPoint(x: sender.center.x, y: self.arrow.center.y)
        }
        
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
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
