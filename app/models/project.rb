class Project < ApplicationRecord
  mount_uploader :image, ProjectImageUploader

  validates :permalink, presence: true, uniqueness: {case_sensitive: true}
  validates :owner_user_id, presence: true
  validates :title, presence: true

  has_many :project_members
  has_many :project_tags
  has_many :project_wants
  has_many :project_links
  has_many :join_requests
  has_many :user_invitations



  def tags
    ProjectTag.where(project_id: self.id)
  end

  def wants
    ProjectWant.where(project_id: self.id)
  end

  def links
    ProjectLink.where(project_id: self.id)
  end

  def owner_user
    User.find_by(id: self.owner_user_id)
  end

  def accesses
    144
  end

  def likes
    1728
  end

  def comments
    567
  end

  def invitable?(user)
    wanted_positions = ProjectWant.where(project_id: self.id).pluck(:position_id)
    positions = UserPosition.where(user_id: user.id).where(position_id: wanted_positions)

    positions.length > 0
  end

  def invitable_positions(user)
    wanted_positions = ProjectWant.where(project_id: self.id).pluck(:position_id)

    UserPosition.joins(:position).where(user_id: user.id).where(position_id: wanted_positions).order(sort_number: :asc).select(:position_id, :name)
  end

  def invite_user_react_info(user)
    wanted_positions = ProjectWant.where(project_id: self.id).pluck(:position_id)

    {
        project:{
            id: self.id,
            permalink: self.permalink,
            image: self.image.url,
            title: self.title,
            description: self.description
        },
        user:{
            id: user.id,
            permalink: user.permalink,
            name: user.name
        },
        positions: UserPosition.joins(:position).where(user_id: user.id).where(position_id: wanted_positions).order(sort_number: :asc).select(:position_id, :name)
    }.as_json
  end
end
