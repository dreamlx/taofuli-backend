json.events do
  json.partial! 'api/events/event', collection: @events, as: :event
end