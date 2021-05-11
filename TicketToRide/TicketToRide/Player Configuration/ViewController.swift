//
//  ViewController.swift
//  TicketToRide
//
//  Created by Sylwia Markes on 25/04/2021.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var playersTableView: UITableView! {
        didSet {
            playersTableView.delegate = self
            playersTableView.dataSource = self
        }
    }
    
    @IBOutlet weak var colorsCollectionView: UICollectionView! {
        didSet {
            colorsCollectionView.delegate = self
            colorsCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var addPlayerButton: UIButton!
    
    private let viewModel = PlayersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addPlayerButtonAction(_ sender: Any) {
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath)
        if let playerCell = cell as? PlayerTableViewCell {
            playerCell.configure(with: viewModel.players[indexPath.row])
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath)
        
        if let colorCell = cell as? ColorCollectionViewCell {
            colorCell.configure(with: viewModel.colors[indexPath.row])
        }
        return cell
    }
}

//przeniesc do innego pliku

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

final class PlayersViewModel {
    var players: [Player] = [
        Player(name: "Donata", playerColor: .black),
        Player(name: "Dorota", playerColor: .blue),
        Player(name: "Monika", playerColor: .green)
    ]
    
    var colors = PlayerColor.allCases
}

struct Player {
    let name: String
    let playerColor: PlayerColor
}

//przeniesc do innego pliku

