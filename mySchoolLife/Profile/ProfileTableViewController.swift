//
//  ProfileTableViewController.swift
//  mySchoolLife
//
//  Created by Артём Коротков on 04.10.2022.
//

import UIKit


class ProfileTableViewController: UITableViewController {

    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imageRedact: UIImageView!
    @IBOutlet weak var secondNameTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var numberOfClassTF: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
  
    //MARK: - Ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStateButton()
    }
    
    
    
    //MARK: - MainCode
    
    private func updateStateButton() {
        let nameText = nameTF.text ?? ""
        let secondNameText = secondNameTF.text ?? ""
        let numbOfClassText = numberOfClassTF.text ?? ""
        
        saveButton.isEnabled = !nameText.isEmpty && !secondNameText.isEmpty && !numbOfClassText.isEmpty
    }


    //MARK: - IBActions
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateStateButton()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
}
