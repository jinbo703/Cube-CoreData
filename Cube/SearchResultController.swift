//
//  SearchResultController.swift
//  Cube
//
//  Created by John Nik on 3/31/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit



class SearchResultController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "Cell"
    
    var searchWord: String?
    var resultArray: [NoteItems]?
    
    
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
    
    let cubeView: UIImageView = {
        let view = UIImageView()
        view.setImageWith(imageName: "rainbow_125")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
        
    }()
    
    let noResultLabel: UILabel = {
        
        let label = UILabel()
        label.text = "No Results Found"
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableHeight = 200
        
        view.backgroundColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(backButton)
        view.addSubview(cubeView)
        view.addSubview(titleLabel)
        
        setupBackButton()
        setupCubeView()
        setuptitleLabel()
        isnotSearchResult()
        
    }
    
    func isnotSearchResult() {
        
        titleLabel.text = searchWord
        
        resultArray = CoredataManager.fetchData(title: searchWord!)
        if resultArray?.count == 0 {
            
            view.addSubview(noResultLabel)
            setupNoResultLabel()
            
        } else {
            
            view.addSubview(tableView)
            setupTableView()
            tableView.register(PostCell.self, forCellReuseIdentifier: cellId)
            tableView.reloadData()
        }
        
        
    }

    func setupNoResultLabel() {
        
        noResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noResultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        compactConstraints.append(noResultLabel.widthAnchor.constraint(equalToConstant: 250))
        compactConstraints.append(noResultLabel.heightAnchor.constraint(equalToConstant: 60))
        
        regularConstraints.append(noResultLabel.widthAnchor.constraint(equalToConstant: 350))
        regularConstraints.append(noResultLabel.heightAnchor.constraint(equalToConstant: 100))

        
    }
    

    func setuptitleLabel() {
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        compactConstraints.append(titleLabel.widthAnchor.constraint(equalToConstant: 110))
        compactConstraints.append(titleLabel.heightAnchor.constraint(equalToConstant: 40))
        
        regularConstraints.append(titleLabel.widthAnchor.constraint(equalToConstant: 165))
        regularConstraints.append(titleLabel.heightAnchor.constraint(equalToConstant: 60))
        
    }
    
    
    func setupTableView() {
        
        tableView.topAnchor.constraint(equalTo: cubeView.bottomAnchor, constant: 40).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        
    }
    
    fileprivate var regularConstraints = [NSLayoutConstraint]()
    fileprivate var compactConstraints = [NSLayoutConstraint]()
    
    func setupCubeView() {
        
        cubeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cubeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        compactConstraints.append(cubeView.widthAnchor.constraint(equalToConstant: Cube_Width_Height * 0.6))
        compactConstraints.append(cubeView.heightAnchor.constraint(equalToConstant: Cube_Width_Height * 0.6))
        
        regularConstraints.append(cubeView.widthAnchor.constraint(equalToConstant: Cube_Width_Height * 1))
        regularConstraints.append(cubeView.heightAnchor.constraint(equalToConstant: Cube_Width_Height * 1))
        
        
    }
    
    func setupBackButton() {
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        compactConstraints.append(backButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 0.8))
        compactConstraints.append(backButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 0.8))
        
        regularConstraints.append(backButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 1.6))
        regularConstraints.append(backButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 1.6))
        
        
    }
    
    fileprivate var tableHeight: CGFloat?
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        if traitCollection.horizontalSizeClass == .regular {
            
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
            
            
            backButton.setBorderAndRound(radius: (Button_Width_Height * 1.6) / 2)
            
            backButton.layer.borderWidth = 2
            
            titleLabel.font = UIFont.systemFont(ofSize: 35, weight: UIFontWeightBold)
            
            noResultLabel.font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightBold)
            
            tableHeight = 350
            
        } else {
            
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
            
            tableHeight = 200
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultArray!.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = PostCell(style: .subtitle, reuseIdentifier: cellId)
        let post = resultArray?[indexPath.row]
        
        cell.titleLabel.text = post?.title
        cell.interTitleLabel.text = post?.intertitle
        cell.postTextView.text = post?.maintext
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableHeight!
    }
}


class PostCell: UITableViewCell {
    
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)

        return label
    }()
    
    let interTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)

        return label
    }()
    
    let postTextView: UITextView = {
        
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textAlignment = .center
        tv.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium)
        tv.isEditable = false
        return tv
        
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setImageWith(imageName: "book_38")
        button.setBorderAndRound(radius: (Button_Width_Height * 0.4) / 2)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(containerView)
        
        setupContainerView()
    }
    
    func setupContainerView() {
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        compactConstraints.append(containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -55))
        
        regularConstraints.append(containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80))
        
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(interTitleLabel)
        containerView.addSubview(postTextView)
        containerView.addSubview(infoButton)
        
        titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        compactConstraints.append(titleLabel.widthAnchor.constraint(equalToConstant: 230))
        compactConstraints.append(titleLabel.heightAnchor.constraint(equalToConstant: 28))
        
        regularConstraints.append(titleLabel.widthAnchor.constraint(equalToConstant: 330))
        regularConstraints.append(titleLabel.heightAnchor.constraint(equalToConstant: 45))

        
        
        interTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        interTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        compactConstraints.append(interTitleLabel.widthAnchor.constraint(equalToConstant: 230))
        compactConstraints.append(interTitleLabel.heightAnchor.constraint(equalToConstant: 18))
        
        regularConstraints.append(interTitleLabel.widthAnchor.constraint(equalToConstant: 330))
        regularConstraints.append(interTitleLabel.heightAnchor.constraint(equalToConstant: 42))


        postTextView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        postTextView.topAnchor.constraint(equalTo: interTitleLabel.bottomAnchor, constant: 1).isActive = true
        postTextView.widthAnchor.constraint(equalToConstant: 230).isActive = true
        postTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
        
        
        compactConstraints.append(postTextView.widthAnchor.constraint(equalToConstant: 230))
        
        
        regularConstraints.append(postTextView.widthAnchor.constraint(equalToConstant: 530))
        
        
        infoButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        infoButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        compactConstraints.append(infoButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 0.4))
        compactConstraints.append(infoButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 0.4))
        
        regularConstraints.append(infoButton.widthAnchor.constraint(equalToConstant: Button_Width_Height * 0.8))
        regularConstraints.append(infoButton.heightAnchor.constraint(equalToConstant: Button_Width_Height * 0.8))
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var regularConstraints = [NSLayoutConstraint]()
    fileprivate var compactConstraints = [NSLayoutConstraint]()
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        if traitCollection.horizontalSizeClass == .regular {
            
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
            
            
            infoButton.setBorderAndRound(radius: (Button_Width_Height * 0.8) / 2)
            infoButton.layer.borderWidth = 2
            containerView.layer.borderWidth = 4
            
            titleLabel.font = UIFont.systemFont(ofSize: 45, weight: UIFontWeightBold)
            interTitleLabel.font = UIFont.systemFont(ofSize: 35, weight: UIFontWeightMedium)
            postTextView.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightMedium)
        }
            
       else {
            
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
            
        }
        
    }

    
}










