//
//  SettingsViewController.swift
//  ClassSchedule
//
//  Created by wyx on 2017/12/3.
//  Copyright © 2017年 wyx. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var dayTf: UITextField!
    @IBOutlet weak var cycleTf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveAction(_ sender: UIButton) {
        if cycleTf.text?.characters.count == 0 || dayTf.text?.characters.count == 0 {
            AlertView.showAlert(message: "input something", inView: self)
            return;
        }
        
        if Int(cycleTf.text!) != 0 && Int(dayTf.text!) != 0 {
            let alert = UIAlertController(title: "Are you sure to Update", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            let confirm = UIAlertAction(title: "sure", style: .default, handler: { (action) in
                UserDefaults.standard.set(Int(self.cycleTf.text!), forKey: "TableColumn")
                UserDefaults.standard.set(Int(self.dayTf.text!), forKey: "TableRow")
                
                NotificationCenter.default.post(name: NSNotification.Name("Notification_ChangeNumber"), object: nil)
            })
            alert.addAction(cancel)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            AlertView.showAlert(message: "0 is Invalid", inView: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
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
