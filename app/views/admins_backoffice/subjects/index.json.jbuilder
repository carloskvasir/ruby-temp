json.subjects do
  json.array! @subjects do |subject|
    json.extract! subject, :id, :description
  end
end

json.count @subjects.count
