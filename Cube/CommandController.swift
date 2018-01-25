//
//  CommandController.swift
//  Cube
//
//  Created by John Nik on 3/31/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

class CommandController: UIViewController, UITextFieldDelegate {
    
    
    var portraitCubeTopConstraint: NSLayoutConstraint?
   
    var landscapeCubeTopConstraint: NSLayoutConstraint?
    

    let cubeView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: Cube_Width_Height, height: Cube_Width_Height))
        view.setImageWith(imageName: "rainbow_125")
//        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let containerView: UIView = {
        
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(r: 255, g: 87, b: 34, a: 1).cgColor
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let invalidCommandLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Invalid Command!"
        label.textAlignment = .center
        label.textColor = UIColor(r: 255, g: 87, b: 34, a: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
        
    }()
    
    let commandTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Enter a Command..."
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.sizeToFit()
        
        return tf
        
    }()
    
    let commandButton: UIButton = {
        let button = UIButton()
        button.setImageWith(imageName: "goforward_36")
       
        
        button.setBorderAndRound(radius: (Button_Width_Height * 0.42) / 2)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goingNextViewXontroller), for: .touchUpInside)
        
        
        return button
    }()
    
    func goingNextViewXontroller() {
        
        commandTextField.resignFirstResponder()
        
        let commandWord = commandTextField.text
        
        var commandWordArr = commandWord?.components(separatedBy: " ")
        
        let count = commandWordArr?.count
        
        var firstWord: String?
        var secondWord: String?
        var thirdWord: String?
        
        
        
        if count! > 0 {
            
            firstWord = commandWordArr![0]
            
            if count! == 1 {
               
                
                
            } else if count! == 2 {
                
                secondWord = commandWordArr![1]
                
            } else {
                
                secondWord = commandWordArr![1]
                commandWordArr?.removeFirst()
                commandWordArr?.removeFirst()
                thirdWord = commandWordArr?.joined(separator: " ")
                
            }
            
            
            if firstWord == "Create" && secondWord == "Post" {
                
                let createController = CreateController()
                navigationController?.pushViewController(createController, animated: true)
                
            } else if firstWord == "Search" && secondWord == "Post" {
                
                let searchController = SearchResultController()
                
                if thirdWord == nil {
                    
                    showAlert()
                    print("Write Search word")
                } else {
                    
                    searchController.searchWord = thirdWord
                    navigationController?.pushViewController(searchController, animated: true)
                    
                }
                
                
                
            } else {
                
                
                showAlert()
                
            }

            
            
            
        } else {
            
            showAlert()
            
        }
        
    }
    
    func showAlert() {
        
        view.addSubview(invalidCommandLabel)
        
        invalidCommandLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        invalidCommandLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20).isActive = true
        fadeViewInThenOut(view: invalidCommandLabel, delay: 3)
        
    }
    
    func fadeViewInThenOut(view : UIView, delay: TimeInterval) {
        
        let animationDuration = 0.25
        
        // Fade in the view
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            view.alpha = 1
        }) { (Bool) -> Void in
            
            // After the animation completes, fade out the view after a delay
            
            UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseInOut, animations: { () -> Void in
                view.alpha = 0
            },
                                       completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(cubeView)
        view.addSubview(containerView)
        
        setupCubeView()
        setupContainerView()
        
        applyPotraitConstraint()
        
        commandTextField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
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
    
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            
            if self.view.frame.size.height / 2 < keyboardSize.height {
                
                if self.view.frame.origin.y == 0{
                    //                self.view.frame.origin.y -= keyboardSize.height
                    self.view.frame.origin.y -= 75
                }
                
            }
            
        }
        
    }
    
    
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.size.height / 2 < keyboardSize.height {
                
                if self.view.frame.origin.y != 0{
                    //                self.view.frame.origin.y += keyboardSize.height
                    self.view.frame.origin.y += 75
                }
            }
            
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        commandTextField.text = ""
        
        
    }
    
    fileprivate var regularConstraints = [NSLayoutConstraint]()
    fileprivate var compactConstraints = [NSLayoutConstraint]()

    
    func setupCubeView() {
    
        cubeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        portraitCubeTopConstraint = cubeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70)
        
        landscapeCubeTopConstraint = cubeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        compactConstraints.append(cubeView.widthAnchor.constraint(equalToConstant: Cube_Width_Height * 0.6))
        compactConstraints.append(cubeView.heightAnchor.constraint(equalToConstant: Cube_Width_Height * 0.6))
        
        regularConstraints.append(cubeView.widthAnchor.constraint(equalToConstant: Cube_Width_Height * 1.5))
        regularConstraints.append(cubeView.heightAnchor.constraint(equalToConstant: Cube_Width_Height * 1.5))
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        if traitCollection.horizontalSizeClass == .regular {
            
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
            
            setupViewsInContainerView(width: Cube_Width_Height * 3.5)
            
            commandButton.setBorderAndRound(radius: Cube_Width_Height * 3.5 * 0.11 / 2)
            commandButton.layer.borderWidth = 3
            
            commandTextField.font = UIFont.boldSystemFont(ofSize: 35)
            containerView.layer.borderWidth = 3
            containerView.layer.cornerRadius = 15
            
            invalidCommandLabel.font = UIFont.boldSystemFont(ofSize: 30)
            
            
        } else {
            
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
            
            setupViewsInContainerView(width: Cube_Width_Height * 1.5)
            commandButton.setBorderAndRound(radius: (Button_Width_Height * 0.42) / 2)
            
        }
        
    }
    
    func applyPotraitConstraint() {
        
        
        
        view.addConstraint(portraitCubeTopConstraint!)
        
        
        
        view.removeConstraint(landscapeCubeTopConstraint!)
        
    }
    
    func applyLandScapeConstraint() {
        
        
        view.addConstraint(landscapeCubeTopConstraint!)
        
        
        
        view.removeConstraint(portraitCubeTopConstraint!)
        
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



    func setupContainerView() {
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.addSubview(commandTextField)
        containerView.addSubview(commandButton)
        
        
        compactConstraints.append(containerView.widthAnchor.constraint(equalToConstant: Cube_Width_Height * 1.5))
        compactConstraints.append(containerView.heightAnchor.constraint(equalToConstant: Cube_Width_Height * 0.2))
        
        regularConstraints.append(containerView.widthAnchor.constraint(equalToConstant: Cube_Width_Height * 3.5))
        regularConstraints.append(containerView.heightAnchor.constraint(equalToConstant: Cube_Width_Height * 0.6))
        
        
        
    }
    
    func setupViewsInContainerView(width: CGFloat) {
        
        commandTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        commandTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: width * 0.08).isActive = true
        
        commandTextField.widthAnchor.constraint(equalToConstant: width * 0.85).isActive = true
        commandTextField.heightAnchor.constraint(equalToConstant: width * 0.12).isActive = true
        
        commandButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        commandButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -width * 0.02).isActive = true
        commandButton.widthAnchor.constraint(equalToConstant: width * 0.11).isActive = true
        commandButton.heightAnchor.constraint(equalToConstant: width * 0.11).isActive = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
        
    }
    
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}










