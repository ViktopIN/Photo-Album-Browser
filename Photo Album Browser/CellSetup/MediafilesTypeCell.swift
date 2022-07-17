//
//  MediafilesTypeCell.swift
//  Photo Album Browser
//
//  Created by t h a . m a m e rozz on 08.07.22.
//

import UIKit

class MediafilesTypeCell: UICollectionViewCell {
    static let reuseIdentifer = "MediafilesTypeCell"

    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode =  .scaleAspectFit
        image.tintColor = .systemBlue
        return image
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.textColor = .systemBlue
        nameLabel.numberOfLines = 1
        return nameLabel
    }()

    private let numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = UIFont.systemFont(ofSize: 16)
        numberLabel.textColor = .systemGray
        numberLabel.numberOfLines = 1
        return numberLabel
    }()

    private let indicatorImageView: UIImageView = {
        let indicatorImageView = UIImageView()
        indicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        indicatorImageView.image = UIImage(systemName: "chevron.right")
        indicatorImageView.contentMode = .scaleAspectFit
        indicatorImageView.tintColor = .systemGray
        indicatorImageView.clipsToBounds = true
        return indicatorImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.clipsToBounds = true
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(indicatorImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            indicatorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            indicatorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

extension MediafilesTypeCell {
func configure(with model: Album) {
    image.image = model.image
        nameLabel.text = model.name
        numberLabel.text = model.countItems
}
}
