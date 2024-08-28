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
        let cachedImage = self.mealsViewModel.getImage(mealId: meal.idMeal)
        if (cachedImage == nil)
        {
            Task
            {
                do
                {
                    let imgUrl = URL(string: meal.strMealThumb)!
                    let data = try await FRRecipeService.shared.downloadImage(imgUrl)
                    if let img = UIImage(data: data)
                    {
                        self.mealImageView.image = img
                        self.mealsViewModel.saveImage(mealId: meal.idMeal, image: img)
                    }
                }
                catch
                {
                    print("Error downloading recipe image: \(error.localizedDescription)")
                }
            }
        }
        else
        {
            self.mealImageView.image = cachedImage
        }
        
        titleLabel.text = meal.strMeal
    }
    
    override func prepareForReuse() {
        self.mealImageView.image = nil
    }
    
}
