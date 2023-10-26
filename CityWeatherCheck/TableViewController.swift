//
//  TableViewController.swift
//  CityWeatherCheck
//
//  Created by Aset Bakirov on 24.10.2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class TableViewController: UITableViewController {

    var arrayNews = [NewsData]()
    var arrayTopNews = [TopNews]()
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        tableView.addSubview(refreshControl!)
        
        loadTopNews()
        //loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func handleRefresh() {
        if !isLoading {
            isLoading = true
            arrayNews.removeAll()
            tableView.reloadData()
            loadTopNews()
        }
    }
    
    func loadTopNews() {
        AF.request("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty", method: .get).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.value!)
                print(json)
                if let resultArray = json.array {
                    for item in resultArray {
                        let topNewsItem = TopNews(json: item)
                        self.arrayTopNews.append(topNewsItem)
                    }
                    self.loadData()
                } else {
                    self.showNoTopNewsAvailableAlert()
                }
            } else {
                self.showTopNewsLoadFailureAlert()
            }
            
        }
    }

    func loadData() {
        
        for i in arrayTopNews[0...9] {
            SVProgressHUD.show()
            var newsID = i.newsID
            
            AF.request("https://hacker-news.firebaseio.com/v0/item/\(newsID).json?print=pretty", method: .get).responseJSON { response in
                
                SVProgressHUD.dismiss()
                
                self.isLoading = false
                self.refreshControl?.endRefreshing()
                
                if response.response?.statusCode == 200 {
                    let json = try? JSON(data: response.data!)
                    print(json!)
                    let newsItem = NewsData(json: json ?? "")
                    self.arrayNews.append(newsItem)
                    self.tableView.reloadData()
                    }
                }
        }
        }
    
    func showNoTopNewsAvailableAlert() {
        
        let alert = UIAlertController(title: "No Top Stories", message: "There are no top stories available.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showTopNewsLoadFailureAlert() {
        
        let alert = UIAlertController(title: "Top News Load Failed", message: "Failed to load top news. Please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayNews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        // Configure the cell...
        cell.setData(news: arrayNews[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 149
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsVC = storyboard?.instantiateViewController(identifier: "NewsViewController") as! ViewController
        newsVC.newsView = arrayNews[indexPath.row]
        newsVC.newsView.url = arrayNews[indexPath.row].url
        navigationController?.show(newsVC, sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
