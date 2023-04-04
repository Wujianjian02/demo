import {FoodData,Category} from '../pojo/FoodData'
import {initializeOnStartUp} from '../pojo/FoodDataModule'
import router from '@ohos.router'
@Component
struct FoodListItem{
  private foodItem:FoodData;
  build() {
    Navigator({ target: 'foodpage/FoodDetail' }) {
      Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
        Image(this.foodItem.image)
          .objectFit(ImageFit.Contain)
          .height(40)
          .width(40)
        Text(this.foodItem.name)
          .fontSize(18)
          .flexGrow(1)
        Text(this.foodItem.calories + 'kcal')
          .fontSize(18)
      }
      .height(50)
      .margin({ right: 20, left: 20, top: 20 })
    }
  }
}

@Component
struct FoodList{
  private foodItems:FoodData[]
  build(){
    Column(){
      Flex(){
        Text('Food List')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding({left:20,top:15})
      }
      .backgroundColor('#FFf1f3f5')
      .height('7%')
      List(){
        ForEach(this.foodItems,item=>{
          ListItem(){
            FoodListItem({foodItem:item })
          }
        })
      }
      .height('93%')
    }
  }
}

//创建GridItem的子组件  获取食物信息
@Component
struct FoodGridItem{
  private foodItem:FoodData
  build(){
    Column(){
      Row(){
        Image(this.foodItem.image)
          .objectFit(ImageFit.Contain)
          .height(152)
          .width('100%')
      }
      Flex({justifyContent:FlexAlign.Start,
        alignItems:ItemAlign.Center}){
        Text(this.foodItem.name)
          .fontSize(17)
          .flexGrow(1)

        Text(this.foodItem.calories+'kcal')
          .fontSize(16)
          .margin({right:15})
      }
      .height(32)
      .width('100%')
      .backgroundColor('#FFe5e5e5')
    }
    .height(184)
    .width('100%')
    .onClick(() => {
      router.push({ url: 'foodpage/FoodDetail' })
    })
  }
}

//创建网格布局
@Component
struct FoodGrid{
  private foodItems:FoodData[]
  build(){
    Scroll(){
      Grid(){
        ForEach(this.foodItems,(item:FoodData)=>{
          GridItem(){
            FoodGridItem({ foodItem:item })
          }
        })
      }
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .columnsTemplate('1fr 1fr')
      .rowsGap(8)
      .columnsGap(8)
      .height(1144)
    }
    .scrollBar(BarState.Off)
    .padding({left:16,right:16})
  }
}

@Component
struct FoodCategory{
  private foodItems:FoodData[]
  build(){
    Stack(){
      Tabs(){
        TabContent(){
          FoodGrid({ foodItems: this.foodItems })
        }.tabBar('All')
        TabContent(){
          FoodGrid({ foodItems: this.foodItems.filter(item=>(item.category===Category.Fruit)) })
        }.tabBar('Fruit')
        TabContent(){
          FoodGrid({ foodItems: this.foodItems.filter(item=>(item.category===Category.Vegetable)) })
        }.tabBar('Vegetable')
        TabContent(){
          FoodGrid({ foodItems: this.foodItems.filter(item=>(item.category===Category.Nut)) })
        }.tabBar('Nut')
        TabContent(){
          FoodGrid({ foodItems: this.foodItems.filter(item=>(item.category===Category.Seafood)) })
        }.tabBar('Seafood')
        TabContent(){
          FoodGrid({ foodItems: this.foodItems.filter(item=>(item.category===Category.Dessert)) })
        }.tabBar('Dessert')
      }
      .barWidth(200)
      .barMode(BarMode.Scrollable)
    }
  }
}

@Entry
@Component
struct FoodCategoryList{
  private foodItems:FoodData[] = initializeOnStartUp();
  @State private showList:boolean = false
  build(){
    Stack({alignContent:Alignment.TopEnd}){
      if (this.showList) {
        FoodList({foodItems:this.foodItems})  //进行list布局
      } else {
        FoodCategory({foodItems:this.foodItems})  //进行Grid布局
      }

      Image($rawfile('switch.png'))
        .height(30)
        .width(30)
        .margin({top:10,left:10,right:20})
        .onClick(()=>{
          this.showList = !this.showList
        })
    }
  }
}

