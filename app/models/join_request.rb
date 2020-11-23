class JoinRequest < ApplicationRecord
  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :position_id, presence: true
  validates :result_code, presence: true, inclusion: {in: 1..3}

  belongs_to :project
  belongs_to :user
  belongs_to :position

  def user
    User.find_by(id: self.user_id)
  end

  def react_info
    project = Project.find_by(id: self.project_id)
    user = User.find_by(id: self.user_id)
    position = Position.find_by(id: self.position_id)

    {
        project:{
            permalink: project.permalink
        },
        user:{
            permalink: user.permalink,
            image: user.image.url,
            name: user.name
        },
        position:{
            name: position.name
        },
        id: self.id
    }.as_json
  end
end
