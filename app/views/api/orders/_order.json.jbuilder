json.id order.id
json.date I18n.l(order.date, format: :long)
json.event_title order.event.title if order.event
json.amount order.amount
json.state order.state