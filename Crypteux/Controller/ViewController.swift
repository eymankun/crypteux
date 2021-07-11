//
//  ViewController.swift
//  Crypteux
//
//  Created by Aiman on 2021/06/29.
//

import UIKit

class ViewController: UIViewController, NetworkManagerDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    var networkManager = NetworkManager()
    
    var coinArray = [CoinData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        networkManager.fetchData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func didUpdateCoin(networkManager: NetworkManager, coin: [CoinData]) {
        for row in coin {
            print(row.asset_id)
        }
        coinArray = coin
    }
    
    
}

//MARK: - UITableViewDelegate, after the cell has been tapped, this func will triggered.
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

//MARK: - UITableViewDataSource - to display data in the cell
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = coinArray[indexPath.row].asset_id
        cell.detailTextLabel?.text = String(format: "$ %.4f",coinArray[indexPath.row].price_usd)
        return cell
    }
}

