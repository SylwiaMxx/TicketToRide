//
//  PlayersViewModel.swift
//  TicketToRide
//
//  Created by Sylwia Markes on 16/05/2021.
//

import UIKit

enum PlayerColor: CaseIterable {
    case green, blue, black, yellow, red
    
    var color: UIColor {
        switch self {
        case .green:
            return .green
        case .blue:
            return .blue
        case .black:
            return .black
        case .yellow:
            return .yellow
        case .red:
            return .red
        }
    }
}

protocol PlayersViewModelDelegate: AnyObject {
    func newPlayerWasCreated()
}

final class PlayersViewModel {
    var players: [Player] = []
    var colors = PlayerColor.allCases
    private(set) var selectedPlayerColor: PlayerColor?
    private var selectedPlayerName: String?
    weak var delegate: PlayersViewModelDelegate?
    
    func setPlayerColor(at indexPath: IndexPath) {
        selectedPlayerColor = colors[indexPath.row]
    }
    
    func setPlayer(name: String?) {
        selectedPlayerName = name
    }
    
    func createPlayer() {
        guard let name = selectedPlayerName, let color = selectedPlayerColor else { return }
        let player = Player(name: name, playerColor: color)
        players.append(player)
        selectedPlayerColor = nil
        selectedPlayerName = nil
        colors.removeAll(where: { $0 == color })
        delegate?.newPlayerWasCreated()
    }
}

struct Player {
    let name: String
    let playerColor: PlayerColor
}
