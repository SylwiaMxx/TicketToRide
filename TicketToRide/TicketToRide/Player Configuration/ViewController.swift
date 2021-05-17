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
    
    private let playerViewController = PlayersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerViewController.delegate = self
    }
    private func handleAddPlayerButtonState(name: String?) {
        addPlayerButton.isEnabled = (name != nil && name?.isEmpty == false) && playerViewController.selectedPlayerColor != nil
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        guard let sender = sender as? UITextField else { return }
        handleAddPlayerButtonState(name: sender.text)
        playerViewController.setPlayer(name: sender.text)
    }
    
    @IBAction func addPlayerButtonAction(_ sender: Any) {
        playerViewController.createPlayer()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playerViewController.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath)
        if let playerCell = cell as? PlayerTableViewCell {
            playerCell.configure(with: playerViewController.players[indexPath.row])
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        playerViewController.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath)
        
        if let colorCell = cell as? ColorCollectionViewCell {
            colorCell.configure(with: playerViewController.colors[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playerViewController.setPlayerColor(at: indexPath)
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


