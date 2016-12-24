//
//  MovieViewController.swift
//  MovieCollector
//
//  Created by Toshimitsu Kugimoto on 2016/12/24.
//  Copyright © 2016 Toshimitsu Kugimoto. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var movie: Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if movie != nil {
            movieImageView.image = UIImage(data: movie!.image as! Data)
            titleTextField.text = movie!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }

    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        movieImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        let appdelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        if movie != nil {
            
            movie!.title = titleTextField.text
            
            movie!.image = UIImagePNGRepresentation(movieImageView.image!) as NSData?
            
        } else {
            
            let context = appdelegate.persistentContainer.viewContext
            
            let movie = Movie(context: context)
            movie.title = titleTextField.text
            
            movie.image = UIImagePNGRepresentation(movieImageView.image!) as NSData?
        }
        
        appdelegate.saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let appdelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = appdelegate.persistentContainer.viewContext
        
        context.delete(movie!)
        
        appdelegate.saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    
}
