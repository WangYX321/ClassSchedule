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
    
    var classModel : ClassModel?
    
    var selectedTag: Int16 = 100
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let model = classModel {
            self.classNameTf.text = model.name
            self.roomNumberTf.text = model.room
            self.teacherNameTf.text = model.teacher
            
            let button = self.view.viewWithTag(Int(model.bgColor)) as! UIButton
            UIView.animate(withDuration: 0.5) {
                self.arrow.center = CGPoint(x: button.center.x, y: self.arrow.center.y)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func colorSelectAction(_ sender: UIButton) {
        selectedTag = Int16(sender.tag)
        UIView.animate(withDuration: 0.5) {
            self.arrow.center = CGPoint(x: sender.center.x, y: self.arrow.center.y)
        }
        
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let model = ClassModel()
        model.name = classNameTf.text!
        model.room = roomNumberTf.text!
        model.teacher = teacherNameTf.text!
        model.bgColor = self.selectedTag
        
        if let editModel = self.classModel {
            // 如果前一个页面传入ClassModel，则为Update操作
            CDOption.updateClazz(model: editModel, newModel: model, completion: { (success) in
                AlertView.showAlert(message: "更新课程成功", inView: self) {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            CDOption.insertClazz(model: model)
            
            AlertView.showAlert(message: "添加课程成功", inView: self) {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
