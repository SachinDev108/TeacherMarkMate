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

  def teacher_redirect_url
    @teacher.persisted? ? teacher_path(@teacher) : create_teacher_teachers_path
  end

  def printer_options
    (@subscription_type.id == 1) ? options_for_select(%w{ 1 }) : options_for_select(%w{ 1 2 3 4 5 })
  end

  def get_image
    if @subscription_type.id == 1
      "individual.png"
    elsif @subscription_type.id == 2
      "5users.png"
    elsif @subscription_type.id == 3
      "10users.png"
    else
      "20users.png"
    end
  end

  def find_grades_persents(sheet)
    @arraydata = []
    @tooltripData = []
    @data = sheet.details
    @countdata = 0
    @countdata = @data.count
    @data.each do |id|
      @data2 = Grade.find_by_id("#{id.grade_id}")
      @arraydata << @data2.name rescue nil
      if @arraydata != nil
        @hashdata = @arraydata.group_by(&:itself).map { |k,v| [k, "#{v.count*100/@countdata}%"] }.to_h 
      end
    end
    if @hashdata != nil
      @hashdata.each do |k, v|
        @tooltripData  << "#{k} = #{v}"
      end
      if  @tooltripData != nil
        return @tooltripData 
      else
        return nil   
      end
    end 
  end
end
