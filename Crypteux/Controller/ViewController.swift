//
//  ViewController.swift
//  Crypteux
//
//  Created by Aiman on 2021/06/29.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var coinArray = [CoinData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        fetchData()
    }
    
    func fetchData() {
        let coinURL = "\(K.coinURL)\(K.coinID)&apikey=\(API.Key)"
        
        if let url = URL(string: coinURL) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            coinArray = try decoder.decode([CoinData].self, from: data)
//            for row in coinArray {
//                print(row.asset_id, row.price_usd)
//            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error)
        }
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

