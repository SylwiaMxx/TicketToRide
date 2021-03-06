//
//  PlayerTableViewCell.swift
//  TicketToRide
//
//  Created by Sylwia Markes on 30/04/2021.
//

import UIKit

final class PlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    func configure(with viewModel: Player) {
        playerNameLabel.text = viewModel.name
        colorView.backgroundColor = viewModel.playerColor.color
        colorView.layer.cornerRadius = colorView.frame.width / 2
    }
}
