//
//  HomeworkViewController.swift
//  mySchoolLife
//
//  Created by Артём Коротков on 04.10.2022.
//

import UIKit
import CoreData

class HomeworkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - outlets
    
    @IBOutlet weak var tableview: UITableView!
    
    
    //MARK: - var/let
    
    var fetchController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Homework")
        let sortDesc = NSSortDescriptor(key: "subject", ascending: true)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        fetchRequest.sortDescriptors = [sortDesc]
        let resultCotroller = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return resultCotroller
    }()
    
    //MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchController.delegate = self
        do {
            try fetchController.performFetch()
        } catch {
            print(error)
        }
        
    }
    
    //MARK: - interface
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchController.sections {
            print(sections[section].numberOfObjects)
            return sections[section].numberOfObjects
            
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeworkTableViewCell
        let homework = fetchController.object(at: indexPath) as! Homework
        
        cell.hwLabel.text = homework.homework
        cell.subjectLabel?.text = homework.subject
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homework = fetchController.object(at: indexPath) as! Homework
        performSegue(withIdentifier: "redact", sender: homework)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "redact" {
            let controller = segue.destination as! HomeworkTableViewController
            controller.homework = sender as? Homework
        }
    }
}


//MARK: - extensions

extension HomeworkViewController:  NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
        case .move:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                let homework = fetchController.object(at: indexPath) as! Homework
                let cell = tableview.cellForRow(at: indexPath) as! HomeworkTableViewCell
                cell.subjectLabel.text = homework.subject
                cell.hwLabel.text = homework.homework
            }
        @unknown default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.endUpdates()
    }
    
    
    
}



extension HomeworkViewController {
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let homework = fetchController.object(at: indexPath) as! Homework
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(homework)
            do {
                try context.save()
                
            } catch {
                print(error)
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    
    
}
