//
//  MainViewControllerDataSourceConfigurate.swift
//  Photo Album Browser
//
//  Created by t h a . m a m e rozz on 12.07.22.
//

import UIKit

extension MainViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Album>(collectionView: albumsCollectionView)
        { collectionView, indexPath, itemIdentifier in
            let sectionType = Section.allCases[indexPath.section]

            switch sectionType {
            case .myAlbums:
                guard let cell = self.albumsCollectionView.dequeueReusableCell(withReuseIdentifier: MyAlbumCell.reuseIdentifer,
                                                                          for: indexPath) as? MyAlbumCell else { fatalError() }
                cell.configure(with: itemIdentifier)
                return cell

            case .peopleAndPlaces:
                guard let cell = self.albumsCollectionView.dequeueReusableCell(withReuseIdentifier: PeopleAndPlacesCell.reuseIdentifer,
                                                                    for: indexPath) as? PeopleAndPlacesCell else { fatalError() }
                cell.configure(with: itemIdentifier)
                return cell

            case .mediafilesType:
                guard let cell = self.albumsCollectionView.dequeueReusableCell(withReuseIdentifier: MediafilesTypeCell.reuseIdentifer,
                                                                          for: indexPath) as? MediafilesTypeCell else { fatalError() }
                cell.configure(with: itemIdentifier)
                return cell
            }
        }

            dataSource.supplementaryViewProvider = { (collectionView: UICollectionView,
                                                  kind: String,
                                                  indexPath: IndexPath) -> UICollectionReusableView? in

            let sectionType = Section.allCases[indexPath.section]

            switch sectionType {
            case .myAlbums:
                guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                              withReuseIdentifier: AlbumHeadLayout.reuseIdentifier,
                                                                                              for: indexPath) as? AlbumHeadLayout else { fatalError() }
                supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
                return supplementaryView

            case .peopleAndPlaces:
                guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                              withReuseIdentifier: AlbumHeadLayout.reuseIdentifier,
                                                                                              for: indexPath) as? AlbumHeadLayout else { fatalError() }
                supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
                return supplementaryView

            case .mediafilesType:
                guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                              withReuseIdentifier: AlbumHeadLayout.reuseIdentifier,
                                                                                              for: indexPath) as? AlbumHeadLayout else { fatalError() }
                supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
                return supplementaryView
        }
                
    }

        let snapshot = snapshotForCurrentState()
                self.dataSource.apply(snapshot, animatingDifferences: true)
    }

    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, Album> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Album>()
        snapshot.appendSections([Section.myAlbums, Section.peopleAndPlaces, Section.mediafilesType])

        let itemsMyAlbumSection = MyAlbum.get()
        snapshot.appendItems(itemsMyAlbumSection, toSection: .myAlbums)

        let itemsPeopleAndPlacesSection = PeopleAndPlaces.get()
        snapshot.appendItems(itemsPeopleAndPlacesSection, toSection: .peopleAndPlaces)

        let itemsMediaFileTypesSection = MediafilesType.get()
        snapshot.appendItems(itemsMediaFileTypesSection, toSection: .mediafilesType)

        return snapshot
        
        }
}
