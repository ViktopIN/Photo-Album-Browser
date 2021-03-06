//
//  Directories.swift
//  Photo Album Browser
//
//  Created by t h a . m a m e rozz on 08.07.22.
//

import UIKit

struct MyAlbum {
    static func get() -> [Album] {
        return [
            Album(image: UIImage(named: "food01")!, name: "Томаты", countItems: "6"),
            Album(image: UIImage(named: "food02")!, name: "Киви", countItems: "8962"),
            Album(image: UIImage(named: "food03")!, name: "Watermelon", countItems: "666"),
            Album(image: UIImage(named: "food04")!, name: "Цветочки", countItems: "1"),
            Album(image: UIImage(named: "food05")!, name: "Ханни", countItems: "3"),
            Album(image: UIImage(named: "food06")!, name: "Шампань", countItems: "75"),
            Album(image: UIImage(named: "food07")!, name: "Кофе", countItems: "12"),
            Album(image: UIImage(named: "food08")!, name: "Кофе в склянке", countItems: "6")
        ]
    }
}

struct PeopleAndPlaces {
    static func get() -> [Album] {
        return [
            Album(image: UIImage(named: "ана")!, name: "Ана", countItems: "1"),
            Album(image: UIImage(named: "бритни")!, name: "Бритни!", countItems: "76487"),
            Album(image: UIImage(named: "кармен")!, name: "Электра", countItems: "1")
        ]
    }
}

struct MediafilesType {
    static func get() -> [Album] {
        return [
            Album(image: UIImage(systemName: "video")!, name: "Видео", countItems: "6"),
            Album(image: UIImage(systemName: "person.crop.square")!, name: "Селфи", countItems: "5"),
            Album(image: UIImage(systemName: "livephoto")!, name: "Фото Live Photos", countItems: "4"),
            Album(image: UIImage(systemName: "cube")!, name: "Портреты", countItems: "3"),
            Album(image: UIImage(systemName: "camera.viewfinder")!, name: "Снимки экрана", countItems: "2"),
            Album(image: UIImage(systemName: "square.stack.3d.forward.dottedline")!, name: "Анимированные", countItems: "1")
        ]
    }
}

