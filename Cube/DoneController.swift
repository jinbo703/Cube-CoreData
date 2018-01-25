//
//  DoneController.swift
//  Cube
//
//  Created by John Nik on 3/31/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

class DoneController: UIViewController {
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImageWith(imageName: "goback_61")
        button.setBorderAndRound(radius: (Button_Width_Height * 0.8) / 2)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goingBackViewController), for: .touchUpInside)
        
        return button
    }()
    
    let cubeView: UIImageView = {
        let view = UIImageView()
        view.setImageWith(imageName: "rainbow_check_100")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()

    
    func goingBackViewController() {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        view.addSubview(backButton)
        view.addSubview(cubeView)
        
        setupBackButton()
        setupCubeView()
        
        
    }

    fileprivate var regularConstraints = [NSLayoutConstraint]()
    fileprivate var compactConstraints = [NSLayoutConstraint]()
    
    func setupCubeView() {
        
        cubeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cubeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        compactConstraints.append(cubeView.widthAnchor.constraint(equalToConstant: Cube_Width_Height * 0.6))
        compactConstraints.append(cubeView.heightAnchor.constraint(equalToConstant: Cube_Width_Height * 0.6))
        
        regularConstraints.append(cubeView.widthAnchor.constraint(equalToConstant: Cube_Width_Height * 1.5))
        regularConstraints.append(cubeView.heightAnchor.constraint(equalToConstant: Cube_Width_Height * 1.5))
        
        
    }

    func setupBackButton() {
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        compactConstraints.append(backButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 0.8))
        compactConstraints.append(backButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 0.8))
        
        regularConstraints.append(backButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 1.6))
        regularConstraints.append(backButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 1.6))
        
        
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        if traitCollection.horizontalSizeClass == .regular {
            
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
            
            
            backButton.setBorderAndRound(radius: (Button_Width_Height * 1.6) / 2)
            
            backButton.layer.borderWidth = 2
            
                        
        } else {
            
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
            
        }
        
    }
    
   
}
