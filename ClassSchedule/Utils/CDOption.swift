//
//  CDOption.swift
//  TimeLineNew
//
//  Created by wyx on 2017/10/15.
//  Copyright © 2017年 wyx. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CDOption {
    //MARK: CoreData options
    static func insertData(model: ClassModel) {
        //获取管理的数据上下文 对象
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //创建Clazz对象
        let clazz = NSEntityDescription.insertNewObject(forEntityName: "Clazz",
                                                      into: context) as! Clazz
        //对象赋值
        clazz.name = model.name
        clazz.teacher = model.teacher
        clazz.room = model.room
        clazz.bgColor = model.bgColor
        
        //保存
        do {
            try context.save()
            print("保存成功！")
        } catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    /*
    static func fetch(between fromDate:Date, toDate:Date) -> [ClassModel]{
        //获取管理的数据上下文 对象
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //声明数据的请求
        let fetchRequest = NSFetchRequest<Clazz>(entityName:"Clazz")
        //        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        //        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //设置查询条件
        let predicate = NSPredicate(format: "(dateStamp > '\(fromTimeStamp)') and (dateStamp<'\(toTimeStamp)') ", "")
        fetchRequest.predicate = predicate
        
        var dataArray = [ClassModel]()
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            //遍历查询的结果
            for info in fetchedObjects{
                let model = ClassModel()
                model.name = info.name!
                model.endPoint = CGPoint(x: CGFloat(info.endPointX), y: CGFloat(info.endPointY))
                model.date = Date(timeIntervalSince1970: TimeInterval(info.dateStamp))
                model.createTime = info.createTime
                
                dataArray.append(model)
            }
            print("查询成功")
        }
        catch {
            fatalError("不能查询：\(error)")
        }
        return dataArray
    }
    
//    static func deleteData(model: ClassModel) {
    static func deleteData(modelId: Int, completion:((Bool) -> Swift.Void)? = nil) {
        //获取管理的数据上下文 对象
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //声明数据的请求
        let fetchRequest = NSFetchRequest<Clazz>(entityName:"Clazz")
        //        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        //        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //设置查询条件
        let predicate = NSPredicate(format: "createTime= '\(modelId)' ", "")
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
//            let model = ClassModel()
            //遍历查询的结果
            for info in fetchedObjects{
                if info.createTime == modelId {
                    context.delete(info)
                }
            }
            
            //重新保存-更新到数据库
            try! context.save()
            print("删除成功")
            if let handler = completion {
                handler(true)
            }
        }
        catch {
            fatalError("不能删除：\(error)")
        }
        
    }
 */
}
