//
//  RegisterViewController.swift
//  ProblemsCity
//
//  Created by Lucas Dev on 28/08/21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewRegister: UIImageView!
    
    var register: Register?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let registerFormViewController = segue.destination as? RegisterFormViewController {
            registerFormViewController.register = register
        }
    }
    
    func prepareScreen() {
        if let register = register {
            if let image = register.image {
                imageViewRegister.image = UIImage(data: image)
            }
            labelTitle.text = register.title
            textViewSummary.text = register.summary
            labelLocation.text = register.location
        }
    }

}
