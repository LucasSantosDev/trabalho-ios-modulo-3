//
//  UIViewController+Context.swift
//  ProblemsCity
//
//  Created by Lucas Dev on 28/08/21.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
}
