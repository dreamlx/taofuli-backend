json.id event.id
json.title event.title
json.url event.url
json.image_url event.image_url
json.amount event.amount
json.effective_date event.effective_date
json.expire_date event.expire_date
json.engaged event.engaged
json.available_quota event.available_quota
json.content event.content
json.content_array event.content ? event.content.split("\r\n").reject{ |e| e.empty? } : []
json.official_benefit event.official_benefit
json.official_benefit_array event.official_benefit ? event.official_benefit.split("\r\n").reject{ |e| e.empty? } : []
json.additional_benefit event.additional_benefit
json.additional_benefit_array event.additional_benefit ? event.additional_benefit.split("\r\n").reject{ |e| e.empty? } : []
