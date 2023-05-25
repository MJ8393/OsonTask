# OsonTask
iOS Task

- Task:
Guruhlanmagan Category massivi bor, sizdan qilinadigan talab, shu massivni guruhlashdan iborat.
Bunda sizga Category obyektida id va parent_id beriladi.
parent_id = 0 bo’lsa asosiy category, farqli teng bo’lmasa sub_category bo’ladi.
childs ga shu category ning sub_category lari yig’ish.

struct Category {
    var id: Int?
    var parentId: Int?
    var childs: [Category]?
}
func makeTree(list: [Category]) -> [Category] { // algorithm
}
**************************************************************************************************

- Yuqoridagi taskni bajarishda UIKit(Snapkit) va MVVM architechture pattern ishlatildi. 

- Bizga tartiblanmagan Category massivi berilgan. Vazifa massivni Tree data structure yordamida tartiblashdan iborat.

Masalan: 
var categories: [Category] = [
    Category(id: 1, parentId: 0),
    Category(id: 2, parentId: 0),
    Category(id: 3, parentId: 0),
    
    Category(id: 10, parentId: 1),
    Category(id: 11, parentId: 1),
    Category(id: 12, parentId: 1),
    
    Category(id: 20, parentId: 2),
    Category(id: 21, parentId: 2),
    Category(id: 22, parentId: 2),
    
    Category(id: 30, parentId: 3),
    Category(id: 31, parentId: 3),
    Category(id: 32, parentId: 3),
]

- Bizning Category structimiz quyidagicha. addChild mutating funksiyamiz bizga shu categoryning childs o'zgaruvchisiga element qo'shish uchun yaratilgan.

    struct Category {
        var id: Int?
        var parentId: Int?
        var childs: [Category]?
        
        init(id: Int, parentId: Int) {
            self.id = id
            self.parentId = parentId
        }
        
        mutating func addChild(_ child: Category) {
            if childs != nil {
                childs?.append(child)
            } else {
                childs = [child]
            }
        }
    }

- Algorithm: 
- Birinchi qadamda massivimizdan dictionary(lug'at) yaratib olamiz. Bunda lug'atning key qiymati categoryning id si, value qiymati esa category ga teng bo'ladi. 
- Ikkinchi qadamda massiving elementi uchun parent aniqlanadi va element parenting childs massiviga qo'shiladi. Yakunda, category mapdagi parentning  qitmati yangilanadi. 
- So'ngi qadamda biz root categorylarni filter methodi yordamizda ajratib olamiz. 

    func makeTree(list: [Category]) {
        var categoryMap = [Int: Category]()
        
        // Build a dictionary of categories using their ids as keys
        for category in list {
            categoryMap[category.id ?? 0] = category
        }

        // Build Tree Hierarchy
        for category in list {
            if let parentId = category.parentId, var parent = categoryMap[parentId] {
                parent.addChild(category)
                categoryMap[parentId] = parent
            }
        }
        
        // Filter Root Categories
        orderedCategories = Array(categoryMap.values.filter { $0.parentId == 0 })
    }

- Yuqoridaagi input uchun tree quyidagi ko'rinishda bo'ladi:
                            0
            1               2                   3
       10  11 12        20 21 22            30 31 32

- Dasturimiz esha quyidagi natijani chiqaradi: 

 ![Simulator Screenshot - iPhone 14 Pro - 2023-05-25 at 04 58 19](https://github.com/MJ8393/OsonTask/assets/108180424/702c61d3-5c42-4efa-97e1-88b000ab7f70)
