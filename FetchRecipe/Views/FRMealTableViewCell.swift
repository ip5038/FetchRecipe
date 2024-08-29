//
//  FRMealTableViewCell.swift
//  FetchRecipe
//
//  Created by Ishan Patel on 8/27/24.
//

import UIKit

class FRMealTableViewCell: UITableViewCell {

    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var meal: FRMeal!
    var mealsViewModel: FRMealsViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell()
    {
        Task
        {
            do
            {
                let cachedImage = try await self.mealsViewModel.getImage(imageUrl: meal.strMealThumb, mealId: meal.idMeal)
                self.mealImageView.image = cachedImage
            }
            catch
            {
                print("Error fetching image: \(error)")
            }
        }
        
        titleLabel.text = meal.strMeal
    }
    
    override func prepareForReuse() {
        self.mealImageView.image = nil
    }
    
}
