module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-info"
    end
  end
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render("grade", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def grade
    @subject.grades.collect { |c| ["#{c.name} -#{c.marks} -#{c.abr}", c.id]}
  end

  def full_grade(grade)
    "#{grade.name} -#{grade.marks} -#{grade.abr}"
  end

  def sheets
    if @sheets.present?
      @sheets.collect { |c| [c.title, c.id]}
    else
      @sheets = []
    end
  end

  def subjects
    @subjects.collect { |s| [s.name, s.id]}
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end
  
end
