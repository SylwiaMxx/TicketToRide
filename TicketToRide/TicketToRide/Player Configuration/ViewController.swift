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
    
    private func showPointsScreen(for player: Player) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PointsViewController")
        if let controller = controller as? PointsViewController {
            controller.configure(player: player)
        }
        navigationController?.pushViewController(controller, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showPointsScreen(for: viewModel.players[indexPath.row])
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

final class PointsViewController: UIViewController {
    public func configure(player: Player) {
        
    }
}

