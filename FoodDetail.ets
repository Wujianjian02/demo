import router from '@ohos.router'
@Component
struct FoodImageDisplay{
  build(){
    //创建Stack布局
    Stack({alignContent:Alignment.BottomStart}){
      Image($rawfile('Tomato.jpg'))
        .objectFit(ImageFit.Contain)
        .height(390)
      Text('Tomato')
        .fontSize(30)
        .fontWeight(500)
        .margin({
          left:20,
          bottom:10,
        })
    }
  }
}
@Component
struct ContentTable{
  //自定义函数 简化开发可以使用@Builder来构建自定义方法，抽象出相同的UI结构声明。
  @Builder IngredientItem(title:string,name:string,value:string){
    Flex(){
      Text(title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .layoutWeight(1)
      Flex(){
        Text(name)
          .fontSize(17)
          .flexGrow(1)
        Text(value)
          .fontSize(17)
      }
      .layoutWeight(2)
    }
  }
  build(){
    Flex({
      // @ts-ignore
      direction:FlexDirection.Column,justifyContent:FlexAlign.SpaceBetween,alignItems:ItemAlign.Start}){
      this.IngredientItem('Calories','Calories','17kcal')
      this.IngredientItem('Nutrition','Protein','17kcal')
      this.IngredientItem('','Fat','17kcal')
      this.IngredientItem('','Carbohydrates','17kcal')
      this.IngredientItem('','vitaminC','17kcal')
    }
    .height(280)
    .padding({top:5,right:30,left:30})
  }
}
@Entry  //函数的主入口
@Component
struct FoodDetail{
  build() {
    Column() {
      Stack( { alignContent: Alignment.TopStart }) {
        FoodImageDisplay()
        PageTitle()
      }
      ContentTable()
    }
    .alignItems(HorizontalAlign.Center)
  }
}
@Component
struct PageTitle {
  build() {
    Flex({ alignItems: ItemAlign.Start }) {
      Image($r('app.media.Back'))
        .width(21.8)
        .height(19.6)
      Text('Food Detail')
        .fontSize(21.8)
        .margin({left: 17.4})
    }
    .height(61)
    .padding({ top: 13, bottom: 15, left: 28.3 })
    .onClick(() => {
      router.back()
    })
  }
}

