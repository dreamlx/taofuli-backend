json.orders do
  json.partial! 'api/orders/order', collection: @orders, as: :order
end