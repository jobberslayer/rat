class Group < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :perms, dependent: :destroy

  validates :name, presence: true

  def can_create?(object, obj_id=0)
    Perm.can_create?(self.id, object, obj_id)
  end

  def can_read?(object, obj_id=0)
    Perm.can_read?(self.id, object, obj_id)
  end

  def can_update?(object, obj_id=0)
    Perm.can_update?(self.id, object, obj_id)
  end

  def can_destroy?(object, obj_id=0)
    Perm.can_destroy?(self.id, object, obj_id)
  end

  def can_create(object, obj_id=0)
    Perm.can_create(self.id, object, obj_id)
  end

  def can_read(object, obj_id=0)
    Perm.can_read(self.id, object, obj_id)
  end

  def can_update(object, obj_id=0)
    Perm.can_update(self.id, object, obj_id)
  end

  def can_destroy(object, obj_id=0) Perm.can_create(self.id, object, obj_id)
    Perm.can_destroy(self.id, object, obj_id)
  end

  def cannot_create(object, obj_id=0)
    Perm.cannot_create(self.id, object, obj_id)
  end

  def cannot_read(object, obj_id=0)
    Perm.cannot_read(self.id, object, obj_id)
  end

  def cannot_update(object, obj_id=0)
    Perm.cannot_update(self.id, object, obj_id)
  end

  def cannot_destroy(object, obj_id=0)
    Perm.cannot_destroy(self.id, object, obj_id)
  end
end
