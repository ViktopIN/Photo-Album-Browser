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
        view.addSubview(albumsCollectionView)
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
      let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
      view.addSubview(collectionView)
      collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      collectionView.backgroundColor = .systemBackground
    
      collectionView.register(MyAlbumCell.self, forCellWithReuseIdentifier: MyAlbumCell.reuseIdentifer)
      collectionView.register(PeopleAndPlacesCell.self, forCellWithReuseIdentifier: PeopleAndPlacesCell.reuseIdentifer)
      collectionView.register(MediafilesTypeCell.self, forCellWithReuseIdentifier: MediafilesTypeCell.reuseIdentifer)
      collectionView.register(
        HeadView.self,
      forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind,
      withReuseIdentifier: HeadView.reuseIdentifier)
    albumsCollectionView = collectionView
  }
    
    func generateLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500

        let sectionLayoutKind = Section.allCases[sectionIndex]
        switch (sectionLayoutKind) {
        case .myAlbums: return self.generateMyAlbumsLayout(isWide: isWideView)
        case .peopleAndPlaces: return self.peopleAndPlacesCell()
        case .mediafilesType: return self.generateMyAlbumsLayout(isWide: isWideView)
        }
      }
      return layout
    }
    
    
    func generateMyAlbumsLayout(isWide: Bool) -> NSCollectionLayoutSection {
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
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalWidth(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)

      let groupSize = NSCollectionLayoutSize(
        widthDimension: .absolute(140),
        heightDimension: .absolute(186))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
      group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

      let headerSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(44))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: headerSize,
        elementKind: MainViewController.sectionHeaderElementKind,
        alignment: .top)

      let section = NSCollectionLayoutSection(group: group)
      section.boundarySupplementaryItems = [sectionHeader]
      section.orthogonalScrollingBehavior = .groupPaging

      return section
    }

    func mediaFilesTypeCell(isWide: Bool) -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

      let groupHeight = NSCollectionLayoutDimension.fractionalWidth(isWide ? 0.25 : 0.5)
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: groupHeight)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: isWide ? 4 : 3)

      let headerSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(44))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: headerSize,
        elementKind: MainViewController.sectionHeaderElementKind,
        alignment: .top)

      let section = NSCollectionLayoutSection(group: group)
      section.boundarySupplementaryItems = [sectionHeader]

      return section
    }
}
