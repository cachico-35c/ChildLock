# ChildLock
たった2つのクラスを実装するだけChildLockを簡単に実装するサンプル  
（*cocoapdsでSwiftyJsonを使える状態を想定しています）

<img src="https://user-images.githubusercontent.com/62793390/78417228-112d9680-766b-11ea-987e-798d3598a82a.png" width="300">

・ChildLockData.swift (データを管理するクラス) 
・ChildLockView.swift (Viewを作成するクラス) 

こちら2つのクラスをプロジェクトに取り込みdelegeteの設定をし、以下を呼び出したいところで記載するだけです。　 
 
<img src="https://user-images.githubusercontent.com/62793390/78417450-0f64d280-766d-11ea-9969-c64d778056f0.png" width="600"> 

func LockResult(result: Bool)がdelegateMethodになっているのでここで受け取った処理してください。 

準備さえすれば以下を呼ぶだけです。 

<img src="https://user-images.githubusercontent.com/62793390/78417456-14c21d00-766d-11ea-8419-db91725ae7f5.png" width="300"> 
 
取り急ぎ作っていたものをあげたのでもう少しまとめ直していいかとは思いますがお役にたてばと思います。 
現時点では端末に依存せずに使えるはずです。


cachico
