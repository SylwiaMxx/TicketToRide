//
//  ColorCollectionViewCell.swift
//  TicketToRide
//
//  Created by Sylwia Markes on 01/05/2021.
//

import UIKit

final class ColorCollectionViewCell: UICollectionViewCell {
    
    private struct Constants {
        static let borderWidth: CGFloat = 3
    }
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderWidth = isSelected ? Constants.borderWidth : 0
            contentView.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func configure(with playerColor: PlayerColor) {
        contentView.backgroundColor = playerColor.color
        contentView.layer.cornerRadius = contentView.frame.width / 2
    }
}

