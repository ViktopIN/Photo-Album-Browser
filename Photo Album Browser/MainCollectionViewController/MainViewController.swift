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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 10,
                                                     trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))

        let subGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                        subitem: item, count: 2)
        subGroup.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                         leading: 0,
                                                         bottom: 0,
                                                         trailing: 10)

        let containerGroupSize = NSCollectionLayoutSize(widthDimension:
                                                UIScreen.main.bounds.width > 400 ? .fractionalWidth(0.45) : .fractionalWidth(0.96),
                                                        heightDimension:
                                                UIScreen.main.bounds.width > 400 ? .fractionalWidth(0.55) : .fractionalWidth(1.2))
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize,
                                                                subitem: subGroup, count: 2)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(50))
        let headerSection = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: MainViewController.sectionHeaderElementKind,
                                                                        alignment: .topLeading)

        let section = NSCollectionLayoutSection(group: containerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 15,
                                                        bottom: 10,
                                                        trailing: 0)

        section.boundarySupplementaryItems = [headerSection]
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    func peopleAndPlacesCell() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 20,
                                                     trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension:
                                            UIScreen.main.bounds.width > 400 ? .fractionalWidth(0.45) : .fractionalWidth(0.95),
                                               heightDimension:
                                            UIScreen.main.bounds.width > 400 ? .fractionalWidth(0.3) : .fractionalWidth(0.6))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 2)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(52))

        let headerSection = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: MainViewController.sectionHeaderElementKind,
                                                                        alignment: .topLeading)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 15,
                                                        bottom: 10,
                                                        trailing: 0)
        section.boundarySupplementaryItems = [headerSection]
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    func mediaFilesTypeCell() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension:
                                                UIScreen.main.bounds.width > 400 ? .fractionalWidth(0.13) : .fractionalWidth(0.15))

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
