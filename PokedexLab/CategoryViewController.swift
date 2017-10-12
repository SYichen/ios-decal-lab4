//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if let pokeArr = pokemonArray {
            count = pokeArr.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let pokemon = pokemonArray![indexPath.row]
        let name = pokemon.name
        cell.nameLabel.text = name
        print(cell.nameLabel.text!)
        let number = pokemon.number!
        cell.numLabel.text = String(describing: number)
        let attack = pokemon.attack!
        let defense = pokemon.defense!
        let health = pokemon.health!
        let stats = String(describing: attack) + "\\" + String(describing: defense) + "\\" + String(describing: health)
        cell.statsLabel.text = stats

        if let image = cachedImages[indexPath.row] {
            DispatchQueue.main.async {
                cell.pokeImage.image = image
            }
        } else {
            let url = URL(string: pokemon.imageUrl)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            DispatchQueue.main.async {
                                cell.pokeImage.image = UIImage(data: imageData)
                            }
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
            }
            downloadPicTask.resume()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "toInfoView", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "toInfoView" {
                if let dest = segue.destination as? PokemonInfoViewController {
                    if let index = sender as? IndexPath {
                        dest.pokemon = pokemonArray![index.row]
                        if let image = cachedImages[index.row] {
                            dest.image = image
                        }
                    }
                }
            }
        }
    }
}
