class Sheet < ApplicationRecord
  belongs_to :teacher
  has_many :details, :dependent => :destroy
  belongs_to :subject

  accepts_nested_attributes_for :details, allow_destroy: true

  validates :title, :subject_id, :teacher_id, :date, presence: true


  def self.get_details(id)
    find_by_sql("select children.name, sheets.title, grades.abr as grade_name, grades.color, details.comment from subjects INNER JOIN students ON subjects.id = students.subject_id and subjects.id = #{id} INNER JOIN children ON children.id = students.child_id INNER JOIN details ON details.child_id = children.id INNER JOIN sheets ON sheets.id = details.sheet_id FULL JOIN grades ON grades.id = details.grade_id where sheets.subject_id = #{id} order by sheets.created_at DESC, children.name,grade_name, details.comment")
  end

  def sanitize_comment
    comment? ? ActionView::Base.full_sanitizer.sanitize(comment) : ''
  end
end
