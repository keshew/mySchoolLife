//
//  ProfileTableViewController.swift
//  mySchoolLife
//
//  Created by Артём Коротков on 04.10.2022.
//

import UIKit


class ProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if indexPath.row == 0 {
            
            let cameraIcon = UIImage(systemName: "camera")
            let photoIcon = UIImage(systemName: "photo")
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
 
    
    //MARK: - MainCode
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
 
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageRedact.image = info[.editedImage] as? UIImage
        imageRedact.contentMode = .scaleAspectFill
        imageRedact.clipsToBounds = true
        
        
        dismiss(animated: true)
    }
    
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
