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
        viewModel.delegate = self
    }
    private func handleAddPlayerButtonState(name: String?) {
        addPlayerButton.isEnabled = (name != nil && name?.isEmpty == false) && viewModel.selectedPlayerColor != nil
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        guard let sender = sender as? UITextField else { return }
        handleAddPlayerButtonState(name: sender.text)
        viewModel.setPlayer(name: sender.text)
    }
    
    @IBAction func addPlayerButtonAction(_ sender: Any) {
        viewModel.createPlayer()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.setPlayerColor(at: indexPath)
        handleAddPlayerButtonState(name: playerNameTextField.text)
    }
}

extension ViewController: PlayersViewModelDelegate {
    func newPlayerWasCreated() {
        playerNameTextField.text = nil
        playersTableView.reloadData()
        colorsCollectionView.reloadData()
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

//przeniesc do innego pliku

