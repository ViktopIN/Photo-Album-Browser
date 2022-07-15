//
//  MainViewController.swift
//  Photo Album Browser
//
//  Created by t h a . m a m e rozz on 08.07.22.
//

import UIKit

class MainViewController: UIViewController {
//    MARK: - Properties
    static let sectionHeaderElementKind = "section-header-element-kind"

    enum Section: String, CaseIterable {
        case myAlbums = "Мои альбомы"
        case peopleAndPlaces = "Люди и места"
        case mediafilesType = "Типы медиафайлов"
    }
    
    var albumsCollectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Album>! = nil
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureDataSource()
            
        hierarchySetup()
        layoutSetup()
        viewSetup()
    }
//    MARK: - Settings
    private func hierarchySetup() {
    }
        
    private func layoutSetup() {
        albumsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            albumsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            albumsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
        
    private func viewSetup() {
        view.backgroundColor = .systemBackground
            
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = Strings.titleOfMainCollectionViewController
            
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action:#selector(plusButtonAction))
        }
//    MARK: - Methods
    @objc func plusButtonAction() {
        print("Plus button tapped!")
    }
}
//MARK: - Extensions
extension MainViewController {
  func configureCollectionView() {
      let collectionView = UICollectionView(frame: view.frame,
                                            collectionViewLayout: generateLayout())
      view.addSubview(collectionView)
      collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      collectionView.backgroundColor = .systemBackground
      collectionView.dataSource = dataSource
      collectionView.register(MyAlbumCell.self, forCellWithReuseIdentifier: MyAlbumCell.reuseIdentifer)
      collectionView.register(PeopleAndPlacesCell.self, forCellWithReuseIdentifier: PeopleAndPlacesCell.reuseIdentifer)
      collectionView.register(MediafilesTypeCell.self, forCellWithReuseIdentifier: MediafilesTypeCell.reuseIdentifer)
      collectionView.register(
        HeadView.self,
      forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind,
      withReuseIdentifier: HeadView.reuseIdentifier)
      collectionView.register(AlbumHeadLayout.self,
                              forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind,
                              withReuseIdentifier: AlbumHeadLayout.reuseIdentifier)
    albumsCollectionView = collectionView
  }
    
    func generateLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
    

        let sectionLayoutKind = Section.allCases[sectionIndex]
        switch (sectionLayoutKind) {
        case .myAlbums: return self.generateMyAlbumsLayout()
        case .peopleAndPlaces: return self.peopleAndPlacesCell()
        case .mediafilesType: return self.mediaFilesTypeCell()
        }
      }
        layout.configuration = UICollectionViewCompositionalLayoutConfiguration()
        
        return layout
    }
    
    
    func generateMyAlbumsLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(CGFloat(UIScreen.main.bounds.width > 500 ? 0.23 : 0.46)),
          heightDimension: .fractionalWidth(CGFloat(UIScreen.main.bounds.width > 500 ? 0.27 : 1.1)))
        let group = UIScreen.main.bounds.width > 500 ? NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1) : NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: MainViewController.sectionHeaderElementKind, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 15,
                                                        bottom: 10,
                                                        trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        return section
    }

    func peopleAndPlacesCell() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(CGFloat(UIScreen.main.bounds.width > 500 ? 0.23 : 0.46)),
          heightDimension: .fractionalWidth(CGFloat(UIScreen.main.bounds.width > 500 ? 0.27 : 0.55)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: MainViewController.sectionHeaderElementKind, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 15,
                                                        bottom: 10,
                                                        trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        return section
    }

    func mediaFilesTypeCell() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(45))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let headerSection = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: MainViewController.sectionHeaderElementKind,
                                                                        alignment: .topLeading)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 30, trailing: 0)
        section.boundarySupplementaryItems = [headerSection]

        return section
    }
}
