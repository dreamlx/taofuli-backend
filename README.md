### 福利列表
```
curl -X GET http://localhost:3000/api/events/
```
```
response:
        {
          "events"=>
          [
            {
              "title"=>"MyString", 
              "url"=>"MyString", 
              "image_url"=>"/uploads/event/image/8/rails.png",
              "amount"=>1, 
              "effective_date"=>"2016-07-14", 
              "expire_date"=>"2016-07-14", 
              "engaged"=>1,
              "available_quota"=>1,
              "content"=>"detail",
              "official_benefit"=>"official",
              "additional_benefit"=>"additional"
            },
            ....
          ]
        }
```
### 获取某个福利详情
```
curl -X GET http://localhost:3000/api/events/{event.id}
```
### 获取用户信息
```
curl -X GET --header "Authorization: Token token=#{openid}" http://localhost:3000/api/users/get_info
```
```
response:
        {
          "name"=>"foobar",
          "cell"=>"1111111111",
          "email"=>"foobar@example.com",
          "gender"=>"男"
          "state"=>"权益未激活"
        }
```
### 更新用户信息
```
curl -X PATCH --header "Authorization: Token token=#{openid}" -d "name=foobar&..." http://localhost:3000/api/users/update_profile
```
```
params: {
          "name"=>"foobar",
          "cell"=>"1111111111",
          "email"=>"foobar@example.com",
          "gender"=>"男"
        }
```
### 商务合作
```
curl -X POST -d "name=foobar&..." http://localhost:3000/api/customers/
```
```
params:   {
            "name"=>"foobar",
            "cell"=>"11111111111",
            "qq"=>"1111111111",
            "desc"=>"many words"
          }
response:
        201 ok;422 ng
```
### 创建福利记录
```
curl -X POST --header "Authorization: Token token=#{openid}" -d "event_id=1" http://localhost:3000/api/orders/
```
```
response:
        201 ok;422 ng
```
### 福利记录列表
```
curl -X GET --header "Authorization: Token token=#{openid}" http://localhost:3000/api/orders/
```
```
response:
        {
          "orders"=>
          [
          {
            "id"=>34, 
            "date"=>"2016年7月15日", 
            "event_title"=>"MyString", 
            "amount"=>1, 
            "state"=>"未派发"
          },
          ...
          ]
        }
```
### 获取signature
```
curl -X GET -d "url=http://www.baidu.com" http://localhost:3000/api/wx_get_jsapi_ticket
```
