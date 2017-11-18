//
//  AlertView.swift
//  ClassSchedule
//
//  Created by wyx on 2017/11/18.
//  Copyright © 2017年 wyx. All rights reserved.
//

import Foundation
import UIKit

class AlertView {
    static func showAlert(message: String, inView: UIViewController, completion: (()->Void)? = nil) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        inView.present(alert, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { timer in
                alert.dismiss(animated: true, completion: nil)
                if let completionAlert = completion {
                    completionAlert()
                }
            })
        }
    }
}
