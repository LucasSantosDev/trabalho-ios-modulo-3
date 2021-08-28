//
//  RegisterFormViewController.swift
//  ProblemsCity
//
//  Created by Lucas Dev on 28/08/21.
//

import UIKit

class RegisterFormViewController: UIViewController {

    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var buttonAddEdit: UIButton!
    @IBOutlet weak var imagemViewRegister: UIImageView!
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var register: Register?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.keyboardDismissMode = .interactive
        
        if let register = register {
            title = "Edição"
            textFieldTitle.text = register.title
            textFieldLocation.text = register.location
            textViewSummary.text = register.summary
            if let image = register.image {
                imagemViewRegister.image = UIImage(data: image)
            }
            buttonAddEdit.setTitle("Alterar", for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {return}
        
        scrollView.contentInset.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
    }
    
    @objc func keyboardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar imagem", message: "Faça upload da imagem da rua", preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            }

            alert.addAction(cameraAction)
        }

        let libraryAction = UIAlertAction(title: "Biblioteca de Fotos", style: .default) { _ in
            self.selectPicture(sourceType: .photoLibrary)
        }

        alert.addAction(libraryAction)

        let albumAction = UIAlertAction(title: "Álbum de Fotos", style: .default) { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }

        alert.addAction(albumAction)

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if register == nil {
            register = Register(context: context)
        }
        
        register?.title = textFieldTitle.text
        register?.summary = textViewSummary.text
        register?.location = textFieldLocation.text
        register?.image = imagemViewRegister.image?.jpegData(compressionQuality: 0.9)
        let dateFormatter = Date()
        register?.created_at = dateFormatter
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }

}

extension RegisterFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagemViewRegister.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
