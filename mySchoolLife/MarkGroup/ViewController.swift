//
//  ViewController.swift
//  mySchoolLife
//
//  Created by Артём Коротков on 07.10.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: - var/let
    
    var fetchController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Subjects")
        let sortDesc = NSSortDescriptor(key: "subjects", ascending: true)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        fetchRequest.sortDescriptors = [sortDesc]
        let resultCotroller = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return resultCotroller
    }()
    
    //MARK: - overeide
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchController.delegate = self
        do {
            try fetchController.performFetch()
        } catch {
            print(error)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let controller = segue.destination as! TableViewController
            controller.subject = sender as? Subjects
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let subj = fetchController.object(at: indexPath) as! Subjects
        
        cell.marksLabel.text = subj.marks
        cell.subectLabel?.text = subj.subjects
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subject = fetchController.object(at: indexPath) as! Subjects
        performSegue(withIdentifier: "add", sender: subject)
    }
    
}

//MARK: - extensions

extension ViewController:  NSFetchedResultsControllerDelegate {
    
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
                let subject = fetchController.object(at: indexPath) as! Subjects
                let cell = tableview.cellForRow(at: indexPath) as! TableViewCell
                cell.subectLabel.text = subject.subjects
                cell.marksLabel.text = subject.marks
            }
        @unknown default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.endUpdates()
    }
    
    
    
}



extension ViewController {
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let subject = fetchController.object(at: indexPath) as! Subjects
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(subject)
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



