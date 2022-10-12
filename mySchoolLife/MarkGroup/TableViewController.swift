//
//  TableViewController.swift
//  mySchoolLife
//
//  Created by Артём Коротков on 07.10.2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    //MARK: - var/let
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var subject: Subjects?
    var arrayMarks: [String] = []
    var arraySubjects: [String] = []
    var array = [String:String]()
    
    //MARK: - Outlets
    
    @IBOutlet weak var markTF: UITextField!
    @IBOutlet weak var subjectTF: UITextField!
    
    
    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let subject = subject {
            subjectTF.text = subject.subjects
            markTF.text = subject.marks
        }
    }
    
    //MARK: - MainCode
    
    func save() -> Bool {
        if subject == nil {
            
            let entityDesc = NSEntityDescription.entity(forEntityName: "Subjects", in: context)
            let subjectObject = Subjects(entity: entityDesc!, insertInto: context)
            
            self.array["subjects"] = subjectTF.text
            self.array["marks"] = markTF.text
            self.arrayMarks.append(self.array["marks"]!)
            self.arraySubjects.append(self.array["subjects"]!)
            
            subjectObject.setValue(subjectTF.text, forKey: "subjects")
            subjectObject.setValue(markTF.text, forKey: "marks")
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        
        if let subject = subject {
            
            subject.subjects = subjectTF.text
            subject.marks = markTF.text
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        return true
    }
    
    //MARK: - Actions
    
    @IBAction func save(_ sender: Any) {
        if save()  == true {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

