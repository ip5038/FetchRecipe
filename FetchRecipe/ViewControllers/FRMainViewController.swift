import UIKit
import SwiftUI

class FRMainViewController: UIViewController
{
    @IBOutlet weak var mealsTableView: UITableView!
    private var desserts: [FRMeal] = []
    private var dessertImages: [String: UIImage] = [:]
    let kMealTableViewCellIdentifier = "kMealTableViewCellIdentifier"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mealsTableView.dataSource = self
        mealsTableView.delegate = self
        
        mealsTableView.register(UINib(nibName: "FRMealTableViewCell", bundle: nil), forCellReuseIdentifier: kMealTableViewCellIdentifier)
        
        Task
        {
            await fetchDesserts()
        }
    }
    
    func fetchDesserts() async
    {
        do
        {
            let dessertsRes = try await FRRecipeService.shared.fetchDesserts()
            self.desserts = dessertsRes
            self.mealsTableView.reloadData()
        }
        catch
        {
            print("Error fetching desserts: \(error)")
        }
    }
    
    func getImage(mealId: String) -> UIImage?
    {
        return dessertImages[mealId]
    }
    
    func saveImage(mealId: String, image: UIImage)
    {
        dessertImages[mealId] = image
    }
}

extension FRMainViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return desserts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMealTableViewCellIdentifier, for: indexPath) as! FRMealTableViewCell
        
        cell.meal = desserts[indexPath.row]
        cell.mainViewController = self
        cell.configureCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedMeal = desserts[indexPath.row]
        Task
        {
            do
            {
                guard let mealDetails = try await FRRecipeService.shared.fetchMealDetails(with: selectedMeal.idMeal) else { return }
                let detailView = FRMealDetailsView(meal: mealDetails)
                let hostingController = UIHostingController(rootView: detailView)
                hostingController.modalPresentationStyle = .fullScreen
                self.present(hostingController, animated: true)
                
            }
            catch let error
            {
                print("Error: \(error)")
            }
        }
    }
    
}

