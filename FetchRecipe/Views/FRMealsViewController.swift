import UIKit
import SwiftUI

class FRMealsViewController: UIViewController
{
    let kMealTableViewCellIdentifier = "kMealTableViewCellIdentifier"

    @IBOutlet weak var mealsTableView: UITableView!
    private var mealsViewModel: FRMealsViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mealsViewModel = FRMealsViewModel()
        
        mealsTableView.dataSource = self
        mealsTableView.delegate = self
        mealsTableView.register(UINib(nibName: "FRMealTableViewCell", bundle: nil), forCellReuseIdentifier: kMealTableViewCellIdentifier)
        
        Task
        {
            await mealsViewModel.fetchDesserts()
            DispatchQueue.main.async {
                self.mealsTableView.reloadData()
            }
           
        }
    }

}

extension FRMealsViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mealsViewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMealTableViewCellIdentifier, for: indexPath) as! FRMealTableViewCell
        
        cell.meal = mealsViewModel.meals[indexPath.row]
        cell.mealsViewModel = self.mealsViewModel
        cell.configureCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        Task
        {
            do
            {
                guard let mealDetails = try await mealsViewModel.getMealDetails(indexPath: indexPath) else { return }
                let mealImage = try await self.mealsViewModel.getImage(imageUrl: mealDetails.strMealThumb, mealId: mealDetails.idMeal)
                let detailView = FRMealDetailsView(mealDetails: mealDetails, mealImage: mealImage)
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

