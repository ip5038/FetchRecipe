import Foundation

struct FRMeal: Codable
{
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct FRMealsResponse: Codable
{
    let meals: [FRMeal]
}
