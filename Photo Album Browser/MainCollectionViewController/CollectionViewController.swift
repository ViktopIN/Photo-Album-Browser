//
//  CollectionViewController.swift
//  Photo Album Browser
//
//  Created by t h a . m a m e rozz on 03.07.22.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hierarchySetup()
        layoutSetup()
        viewSetup()
    }
//    MARK: - Settings
    private func hierarchySetup() {
        
    }
    
    private func layoutSetup() {
        
    }
    
    private func viewSetup() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = Strings.titleOfMainCollectionViewController
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(plusButtonAction))
    }
//    MARK: - Methods
    @objc func plusButtonAction() {
        print("Plus button tapped!")
    }
}
