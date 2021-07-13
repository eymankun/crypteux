//
//  ViewController.swift
//  Crypteux
//
//  Created by Aiman on 2021/06/29.
//

import UIKit

class CoinViewContorller: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    var networkManager = NetworkManager()
    var coinArray = [CoinData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        networkManager.fetchData()
    }
    
}

//MARK: - NetworkManagerDelegate, for parsing data from CoinAPI.io
extension CoinViewContorller: NetworkManagerDelegate {
    func didUpdateCoin(networkManager: NetworkManager, coin: [CoinData]) {
//        for row in coin {
//            print(row.asset_id, row.price_usd)
//        }
//        print(coin)
        coinArray = coin
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate, after the cell has been tapped, this func will triggered.
extension CoinViewContorller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped \(coinArray[indexPath.row].asset_id)")
        let detail = self.storyboard?.instantiateViewController(identifier: "detail") as! DetailViewController
        self.navigationController?.pushViewController(detail, animated: true)
        detail.coinType = coinArray[indexPath.row].asset_id
        detail.coinCurrentPrice = String(format: "$%.4f", coinArray[indexPath.row].price_usd)
        
    }
}

//MARK: - UITableViewDataSource - to display data in the cell
extension CoinViewContorller: UITableViewDataSource {
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

