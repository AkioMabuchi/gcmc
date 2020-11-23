class UserInvitation < ApplicationRecord
  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :position_id, presence: true
  validates :result_code, presence: true, inclusion: {in: 1..3}

  belongs_to :user
  belongs_to :project
  belongs_to :position

  def user
    User.find_by(id: self.user_id)
  end

  def project
    Project.find_by(id: self.project_id)
  end

  def position
    Position.find_by(id: self.position_id)
  end

  def react_info
    user = User.find_by(id: self.user_id)
    project = Project.find_by(id: self.project_id)
    owner_user = User.find_by(id: project.owner_user_id)
    position = Position.find_by(id: self.position_id)

    {
        id: self.id,
        project:{
            id: project.id,
            permalink: project.permalink,
            image: project.image.url,
            title: project.title,
            ownerUser:{
                permalink: owner_user.permalink,
                image: owner_user.image.url,
                name: owner_user.name
            },
            description: project.description
        },
        user:{
            id: user.id
        },
        position:{
            name: position.name
        }
    }.as_json
  end
end
