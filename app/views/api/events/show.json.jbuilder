json.event do
  json.partial! partial: 'api/events/event', locals: {event: @event}
end