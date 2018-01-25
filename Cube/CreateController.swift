//
//  CreateController.swift
//  Cube
//
//  Created by John Nik on 3/31/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

class CreateController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var portraitTitleTopConstraint: NSLayoutConstraint?
    var portraitIntertitleTopConstraint: NSLayoutConstraint?
    var portraitPostTopConstraint: NSLayoutConstraint?
    
    var landscapeTitleTopConstraint: NSLayoutConstraint?
    var landscapeIntertitleTopConstraint: NSLayoutConstraint?
    var landscapePostTopConstraint: NSLayoutConstraint?

    
    
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setImageWith(imageName: "check_orange_61")
        button.setBorderAndRound(radius: (Button_Width_Height * 0.8) / 2)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        
        return button
    }()
    
    func handleDone() {
        
        let title = titleTextField.text
        let intertitle = intertitleTextField.text
        let maintext = postTextView.text
        
        if title == "" || intertitle == "" || maintext == "Write your post here..." {
            
//            print("enter a title")
            
            let alert = UIAlertController(title: "Warning", message: "Fill all Fields", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
            
            
        } else {
            
            CoredataManager.saveData(title: title!, intertitle: intertitle!, maintext: maintext!)
            
            let doneController = DoneController()
            navigationController?.pushViewController(doneController, animated: true)
            
        }
        
        
    }
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImageWith(imageName: "goback_61")
        button.setBorderAndRound(radius: (Button_Width_Height * 0.8) / 2)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goingBackViewController), for: .touchUpInside)
        
        return button
    }()
    
    func goingBackViewController() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setImageWith(imageName: "book_51")
        button.setBorderAndRound(radius: (Button_Width_Height * 0.7) / 2)

        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleInfo), for: .touchUpInside)
        
        return button
    }()
    
    func handleInfo() {
        
    }
    
    let titleTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Title"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.layer.cornerRadius = 6
        tf.layer.masksToBounds = true
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor(r: 255, g: 87, b: 34, a: 1).cgColor
        tf.sizeToFit()
        return tf
        
    }()
    
    let intertitleTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Intertitle"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.layer.cornerRadius = 6
        tf.layer.masksToBounds = true
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor(r: 255, g: 87, b: 34, a: 1).cgColor
        tf.sizeToFit()
        return tf
        
    }()
    
    let postTextView: UITextView = {
        
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        tv.textAlignment = .center
        tv.layer.cornerRadius = 6
        tv.layer.masksToBounds = true
        tv.layer.borderWidth = 2
        tv.layer.borderColor = UIColor(r: 255, g: 87, b: 34, a: 1).cgColor
        tv.sizeToFit()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        self.hideKeyboardWhenTappedAround()
        
        postTextView.delegate = self
        titleTextField.delegate = self
        intertitleTextField.delegate = self
        
        postTextView.resignFirstResponder()
        titleTextField.resignFirstResponder()
        intertitleTextField.resignFirstResponder()
        
        view.addSubview(backButton)
        view.addSubview(doneButton)
        view.addSubview(infoButton)
        view.addSubview(titleTextField)
        view.addSubview(intertitleTextField)
        view.addSubview(postTextView)
        
        setupBackButton()
        setupDoneButton()
        setupInfoButton()
        setupTitleTextField()
        setupIntertitleTextField()
        setupPostTextView()
        
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            
            applyLandScapeConstraint()
            
        } else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            
            applyLandScapeConstraint()
            
        } else if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            
            applyPotraitConstraint()
            
        } else if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
            
            applyPotraitConstraint()
            
        }
        
        
        
        
        
        
        postTextView.text = "Write your post here..."
        postTextView.textColor = UIColor.lightGray
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        titleTextField.text = ""
        intertitleTextField.text = ""
        postTextView.text = "Write your post here..."
        
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            
            applyLandScapeConstraint()
            
        } else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            
            applyLandScapeConstraint()
            
        } else if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            
            applyPotraitConstraint()
            
        } else if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
            
            applyPotraitConstraint()
            
        }

        
    }
    
    fileprivate var keyboardHeight: CGFloat?
    
    func keyboardWillShow(notification: NSNotification) {
        
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            keyboardHeight = keyboardSize.height
            if self.view.frame.size.height / 2 < keyboardHeight! {
                
                if self.view.frame.origin.y == 0{
                    //                self.view.frame.origin.y -= keyboardSize.height
                    self.view.frame.origin.y -= 70
                }
                
            }
            
        }

    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            keyboardHeight = keyboardSize.height
            
            if self.view.frame.size.height / 2 < keyboardHeight! {
                
                if self.view.frame.origin.y != 0{
                    //                self.view.frame.origin.y += keyboardSize.height
                    self.view.frame.origin.y += 70
                }
            }
            
            
        }
    }
    

    fileprivate var regularConstraints = [NSLayoutConstraint]()
    fileprivate var compactConstraints = [NSLayoutConstraint]()
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        if traitCollection.horizontalSizeClass == .regular {
            
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
            
            doneButton.setBorderAndRound(radius: (Button_Width_Height * 1.6) / 2)
            backButton.setBorderAndRound(radius: (Button_Width_Height * 1.6) / 2)
            infoButton.setBorderAndRound(radius: (Button_Width_Height * 1.4) / 2)
            doneButton.layer.borderWidth = 2
            backButton.layer.borderWidth = 2
            infoButton.layer.borderWidth = 2
            
            titleTextField.font = UIFont.systemFont(ofSize: 40)
            intertitleTextField.font = UIFont.systemFont(ofSize: 36)
            postTextView.font = UIFont.systemFont(ofSize: 36, weight: UIFontWeightLight)
            
            titleTextField.layer.cornerRadius = 10
            intertitleTextField.layer.cornerRadius = 10
            postTextView.layer.cornerRadius = 10
            
            titleTextField.layer.borderWidth = 4
            intertitleTextField.layer.borderWidth = 4
            postTextView.layer.borderWidth = 4
            
        } else {
            
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
            
        }
        
    }
    

    
    func setupBackButton() {
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        compactConstraints.append(backButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 0.8))
        compactConstraints.append(backButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 0.8))
        
        regularConstraints.append(backButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 1.6))
        regularConstraints.append(backButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 1.6))
        
        
    }
    
    func setupDoneButton() {
        
        doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        compactConstraints.append(doneButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 0.8))
        compactConstraints.append(doneButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 0.8))
        
        regularConstraints.append(doneButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 1.6))
        regularConstraints.append(doneButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 1.6))
        
    }
    
    func setupInfoButton() {
        
        infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        infoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        compactConstraints.append(infoButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 0.7))
        compactConstraints.append(infoButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 0.7))
        
        regularConstraints.append(infoButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 1.4))
        regularConstraints.append(infoButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 1.4))
    }
    
    func setupTitleTextField() {
        
        portraitTitleTopConstraint = titleTextField.topAnchor.constraint(equalTo: infoButton.bottomAnchor, constant: 20)
        
        landscapeTitleTopConstraint = titleTextField.topAnchor.constraint(equalTo: infoButton.bottomAnchor, constant: 10)
        
        titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        compactConstraints.append(titleTextField.widthAnchor.constraint(equalToConstant: 220))
        compactConstraints.append(titleTextField.heightAnchor.constraint(equalToConstant: 40))
        
        regularConstraints.append(titleTextField.widthAnchor.constraint(equalToConstant: 440))
        regularConstraints.append(titleTextField.heightAnchor.constraint(equalToConstant: 80))
        

        
    }
    
    func setupIntertitleTextField() {
        
        portraitIntertitleTopConstraint = intertitleTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 35)
        
        landscapeIntertitleTopConstraint = intertitleTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10)
        
        intertitleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        compactConstraints.append(intertitleTextField.widthAnchor.constraint(equalToConstant: 220))
        compactConstraints.append(intertitleTextField.heightAnchor.constraint(equalToConstant: 40))
        
        regularConstraints.append(intertitleTextField.widthAnchor.constraint(equalToConstant: 440))
        regularConstraints.append(intertitleTextField.heightAnchor.constraint(equalToConstant: 80))
        
        
    }
    
    
    func setupPostTextView() {
        
        postTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        postTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        postTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        
        portraitPostTopConstraint =  postTextView.topAnchor.constraint(equalTo: intertitleTextField.bottomAnchor, constant: 35)
        
        landscapePostTopConstraint = postTextView.topAnchor.constraint(equalTo: intertitleTextField.bottomAnchor, constant: 10)
    }
    
    
    func applyPotraitConstraint() {
        
        
        
        view.addConstraint(portraitTitleTopConstraint!)
        view.addConstraint(portraitIntertitleTopConstraint!)
        view.addConstraint(portraitPostTopConstraint!)
        
        
        view.removeConstraint(landscapeTitleTopConstraint!)
        view.removeConstraint(landscapeIntertitleTopConstraint!)
        view.removeConstraint(landscapePostTopConstraint!)
        
    }
    
    func applyLandScapeConstraint() {
        
        
        view.addConstraint(landscapeTitleTopConstraint!)
        view.addConstraint(landscapeIntertitleTopConstraint!)
        view.addConstraint(landscapePostTopConstraint!)
        
        
        view.removeConstraint(portraitTitleTopConstraint!)
        view.removeConstraint(portraitIntertitleTopConstraint!)
        view.removeConstraint(portraitPostTopConstraint!)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinator) in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                self.applyPotraitConstraint()
                break
            default:
                self.applyLandScapeConstraint()
                break
                
            }
            
        }, completion: nil)
        
        super.viewWillTransition(to: size, with: coordinator)
        
    }

    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        if self.view.frame.size.height / 2 < keyboardHeight! {
            
            
            if self.view.frame.origin.y == -70{
                self.view.frame.origin.y -= 115
            }
            

            
        }
        
        
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your Post here..."
            textView.textColor = UIColor.lightGray
        }
        
        if self.view.frame.size.height / 2 < keyboardHeight! {
            
            if self.view.frame.origin.y != -70{
                self.view.frame.origin.y += 115
            }

        }
        
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
        
    }

}










