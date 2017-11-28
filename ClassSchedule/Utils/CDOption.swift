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
    static func insertClazz(model: ClassModel) {
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
    
    
    static func fetchClazz() -> [ClassModel]{
        //获取管理的数据上下文 对象
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //声明数据的请求
        let fetchRequest = NSFetchRequest<Clazz>(entityName:"Clazz")
        //        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        //        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //设置查询条件
//        let predicate = NSPredicate(format: "(dateStamp > '\(fromTimeStamp)') and (dateStamp<'\(toTimeStamp)') ", "")
//        fetchRequest.predicate = predicate
        
        var dataArray = [ClassModel]()
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            //遍历查询的结果
            for info in fetchedObjects{
                let model = ClassModel()
                model.name = info.name!
                model.room = info.room!
                model.teacher = info.teacher!
                model.bgColor = info.bgColor
                
                dataArray.append(model)
            }
            print("查询成功")
        }
        catch {
            fatalError("不能查询：\(error)")
        }
        return dataArray
    }
    
    static func deleteClazz(model: ClassModel, completion:((Bool) -> Swift.Void)? = nil) {
        //获取管理的数据上下文 对象
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //声明数据的请求
        let fetchRequest = NSFetchRequest<Clazz>(entityName:"Clazz")
        //        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        //        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //设置查询条件
        let predicate = NSPredicate(format: "name= '\(model.name)' AND room='\(model.room)' AND teacher='\(model.teacher)' ", "")
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
//            let model = ClassModel()
            //遍历查询的结果
            for info in fetchedObjects{
                if info.name == model.name && info.room == model.room && info.teacher == model.teacher {
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
    
    static func updateClazz(model: ClassModel, newModel:ClassModel, completion:((Bool) -> Swift.Void)? = nil) {
        //获取管理的数据上下文 对象
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //声明数据的请求
        let fetchRequest = NSFetchRequest<Clazz>(entityName:"Clazz")
        //        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        //        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //设置查询条件
        let predicate = NSPredicate(format: "name= '\(model.name)' AND room='\(model.room)' AND teacher='\(model.teacher)' ", "")
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            //            let model = ClassModel()
            //遍历查询的结果
            for info in fetchedObjects{
                if info.name == model.name && info.room == model.room && info.teacher == model.teacher {
                    info.name = newModel.name
                    info.room = newModel.room
                    info.teacher = newModel.teacher
                    info.bgColor = newModel.bgColor
                }
            }
            
            //重新保存-更新到数据库
            try! context.save()
            print("更新成功")
            if let handler = completion {
                handler(true)
            }
        }
        catch {
            fatalError("不能更新：\(error)")
        }
        
    }
}
