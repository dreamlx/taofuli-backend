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
              "state"=>"有效"
            },
            ....
          ]
        }
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
curl -X PATCH --header "Authorization: Token token=#{openid}" http://localhost:3000/api/users/update_profile
```
```
params: {
          "name"=>"foobar",
          "cell"=>"1111111111",
          "email"=>"foobar@example.com",
          "gender"=>"男"
        }
```