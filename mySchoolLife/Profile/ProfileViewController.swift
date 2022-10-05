//
//  ProfileViewController.swift
//  mySchoolLife
//
//  Created by Артём Коротков on 04.10.2022.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    
    
    
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var numberOfClassLabel: UILabel!
    @IBOutlet weak var myGradePointAverage: UILabel!
    
    
    //MARK: - Ovveride
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Child")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [Child]  {
                nameLabel.text = result.value(forKey: "name") as? String ?? ""
                secondNameLabel.text = result.value(forKey: "secondName") as? String ?? ""
                numberOfClassLabel.text = "Я учусь в \(result.numberOfClass!) классе"
                print(results)
            }
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        
    }
    
    
    //MARK: - MainCode
    
    
    
    //MARK: - IBActions
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newPlaceVc = segue.source as? ProfileTableViewController else { return }
        
        if segue.identifier == "saveAction" {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entityDesc = NSEntityDescription.entity(forEntityName: "Child", in: context)
            
            nameLabel.text = newPlaceVc.nameTF.text
            secondNameLabel.text = newPlaceVc.secondNameTF.text
            numberOfClassLabel.text = newPlaceVc.numberOfClassTF.text
            
            let childObject = Child(entity: entityDesc!, insertInto: context)
            childObject.setValue(nameLabel.text, forKey: "name")
            childObject.setValue(secondNameLabel.text, forKey: "secondName")
            childObject.setValue(numberOfClassLabel.text, forKey: "numberOfClass")
            do {
            try context.save()
            } catch {
                print(error)
            }
        } else {
            return
        }
        
    }
    
    
    @IBAction func gearShapeAction(_ sender: Any) {
        
    }
    
    
}




