prawn_document do |pdf|
  pdf.text "Listando assuntos",  :align => :center, :size => 24
  pdf.move_down 20
  pdf.table @subjects.collect{|p| [p.id,p.description]}
end
