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