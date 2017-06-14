//
//  AddActivityViewController.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/04.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseStorage

class AddActivityViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    // Rating...
    @IBOutlet weak var progress: UIProgressView!
    
    var delegate: AddActivityDelegate?
    var newActivity: ActivityDto?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveActivity(_ sender: Any) {
        
        newActivity?.name = nameTextField.text!
        newActivity?.description = descriptionTextView.text
        
        if let image = newActivity?.image {
            // Get a reference to the storage service using the default Firebase App
            let storage = Storage.storage()
            
            // Create a storage reference from our storage service
            let storageRef = storage.reference()
            
            if let imageName = newActivity?.name {
            let imagesRef = storageRef.child("images/\(imageName).jpg")
            
            // Local file you want to upload
            //let localFile = image. //URL(string: "path/to/image")!
            
            // Create the file metadata
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            // Upload file and metadata to the object 'images/mountains.jpg'
            //let uploadTask = storageRef.putFile(from: localFile, metadata: metadata)
            let jpg = UIImageJPEGRepresentation(image, CGFloat(1))
            let uploadTask = imagesRef.putData(jpg!)
            
            // Listen for state changes, errors, and completion of the upload.
            uploadTask.observe(.resume) { snapshot in
                // Upload resumed, also fires when the upload starts
            }
            
            uploadTask.observe(.pause) { snapshot in
                // Upload paused
            }
            
            uploadTask.observe(.progress) { snapshot in
                // Upload reported progress
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
                self.progress.progress = Float(percentComplete)
            }
            
            uploadTask.observe(.success) { snapshot in
                // Upload completed successfully
                self.newActivity?.imageUrl = snapshot.metadata?.downloadURL()?.absoluteString
                self.postActivity()
            }
            
            uploadTask.observe(.failure) { snapshot in
                if let error = snapshot.error as? NSError {
                    switch (StorageErrorCode(rawValue: error.code)!) {
                    case .objectNotFound:
                        // File doesn't exist
                        break
                    case .unauthorized:
                        // User doesn't have permission to access file
                        break
                    case .cancelled:
                        // User canceled the upload
                        break
                        
                        /* ... */
                        
                    case .unknown:
                        // Unknown error occurred, inspect the server response
                        break
                    default:
                        // A separate error occurred. This is a good place to retry the upload.
                        break
                    }
                }
            }
            }
        } else {
            postActivity()
        }
    }
    
    func postActivity() {
        Alamofire.request("https://ixlocation.firebaseio.com/activities.json", method: .post, parameters: newActivity?.toJSON(), encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let _):
                self.delegate?.didSaveActivity(activity: self.newActivity!)
                self.dismiss(animated: true, completion: nil)
            case .failure: break
                // Failure... handle error
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.didCancelActivity()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func selectImageFromGallery(_ sender: Any) {
    
        // Hide the keyboard
        nameTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set image to display the selected image.
        imageView.image = selectedImage
        newActivity?.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

}
