//
//  HomeworkTableViewController.swift
//  mySchoolLife
//
//  Created by Артём Коротков on 11.10.2022.
//

import UIKit
import CoreData

class HomeworkTableViewController: UITableViewController {

    @IBOutlet weak var subjectTF: UITextField!
    @IBOutlet weak var hwTF: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var homework: Homework?
    var arrayHomework: [String] = []
    var arraySubjects: [String] = []
    var array = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let homework = homework {
            subjectTF.text = homework.subject
            hwTF.text = homework.homework
        }
    }

    
    func save() -> Bool {
        if homework == nil {
           
            let entityDesc = NSEntityDescription.entity(forEntityName: "Homework", in: context)
            let subjectObject = Homework(entity: entityDesc!, insertInto: context)
            
            self.array["subject"] = subjectTF.text
            self.array["homework"] = hwTF.text
            self.arrayHomework.append(self.array["homework"]!)
            self.arraySubjects.append(self.array["subject"]!)

            subjectObject.setValue(subjectTF.text, forKey: "subject")
            subjectObject.setValue(hwTF.text, forKey: "homework")
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        
        if let homework = homework {
            
            homework.subject = subjectTF.text
            homework.homework = hwTF.text
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        return true
    }
    
    
    
    
    @IBAction func saveTapped(_ sender: Any) {
        if save() == true {
            navigationController?.popViewController(animated: true)
        }
    }
}
