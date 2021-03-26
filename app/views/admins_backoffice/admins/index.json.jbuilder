json.result do
  json.array! @admins do |admin|
    json.extract! admin, :id, :email, :created_at, :updated_at
  end
end

if params['$inlinecount']
  json.count @admins_total
end
