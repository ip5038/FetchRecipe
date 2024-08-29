import Foundation

struct FRMealDetails: Codable
{
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String

    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
}

struct FRMealDetailsResponse: Codable
{
    let meals: [FRMealDetails]
}


extension FRMealDetails {
    static func getIngredientKeyPath(_ index: Int) -> KeyPath<FRMealDetails, String?>
    {
        switch index
        {
        case 1:
            return \FRMealDetails.strIngredient1
        case 2:
            return \FRMealDetails.strIngredient2
        case 3:
            return \FRMealDetails.strIngredient3
        case 4:
            return \FRMealDetails.strIngredient4
        case 5:
            return \FRMealDetails.strIngredient5
        case 6:
            return \FRMealDetails.strIngredient6
        case 7:
            return \FRMealDetails.strIngredient7
        case 8:
            return \FRMealDetails.strIngredient8
        case 9:
            return \FRMealDetails.strIngredient9
        case 10:
            return \FRMealDetails.strIngredient10
        case 11:
            return \FRMealDetails.strIngredient11
        case 12:
            return \FRMealDetails.strIngredient12
        case 13:
            return \FRMealDetails.strIngredient13
        case 14:
            return \FRMealDetails.strIngredient14
        case 15:
            return \FRMealDetails.strIngredient15
        case 16:
            return \FRMealDetails.strIngredient16
        case 17:
            return \FRMealDetails.strIngredient17
        case 18:
            return \FRMealDetails.strIngredient18
        case 19:
            return \FRMealDetails.strIngredient19
        case 20:
            return \FRMealDetails.strIngredient20
        default:
            return \FRMealDetails.strIngredient1
        }
    }
    
    static func getMeasureKeyPath(_ index: Int) -> KeyPath<FRMealDetails, String?>
    {
        switch index
        {
        case 1:
            return \FRMealDetails.strMeasure1
        case 2:
            return \FRMealDetails.strMeasure2
        case 3:
            return \FRMealDetails.strMeasure3
        case 4:
            return \FRMealDetails.strMeasure4
        case 5:
            return \FRMealDetails.strMeasure5
        case 6:
            return \FRMealDetails.strMeasure6
        case 7:
            return \FRMealDetails.strMeasure7
        case 8:
            return \FRMealDetails.strMeasure8
        case 9:
            return \FRMealDetails.strMeasure9
        case 10:
            return \FRMealDetails.strMeasure10
        case 11:
            return \FRMealDetails.strMeasure11
        case 12:
            return \FRMealDetails.strMeasure12
        case 13:
            return \FRMealDetails.strMeasure13
        case 14:
            return \FRMealDetails.strMeasure14
        case 15:
            return \FRMealDetails.strMeasure15
        case 16:
            return \FRMealDetails.strMeasure16
        case 17:
            return \FRMealDetails.strMeasure17
        case 18:
            return \FRMealDetails.strMeasure18
        case 19:
            return \FRMealDetails.strMeasure19
        case 20:
            return \FRMealDetails.strMeasure20
        default:
            return \FRMealDetails.strMeasure1
        }
    }
}
