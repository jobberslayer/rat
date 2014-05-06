class Perm < ActiveRecord::Base
  attr_accessible :mode, :obj_id, :object, :group_id

  has_one :group

  CREATE = 'create'
  READ = 'read'
  UPDATE = 'update'
  DESTROY = 'destroy'

  def self.can_create?(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and (obj_id = ? or obj_id = 0) and mode = ?", group_id, object.to_s, id, CREATE).exists?
  end

  def self.create_on?(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and obj_id = ? and mode = ?", group_id, object.to_s, id, CREATE).exists?
  end

  def self.can_read?(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and (obj_id = ? or obj_id = 0) and mode = ?", group_id, object.to_s, id, READ).exists?
  end

  def self.read_on?(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and obj_id = ? and mode = ?", group_id, object.to_s, id, READ).exists?
  end

  def self.can_update?(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and (obj_id = ? or obj_id = 0) and mode = ?", group_id, object.to_s, id, UPDATE).exists?
  end

  def self.update_on?(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and obj_id = ? and mode = ?", group_id, object.to_s, id, UPDATE).exists?
  end

  def self.can_destroy?(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and (obj_id = ? or obj_id = 0) and mode = ?", group_id, object.to_s, id, DESTROY).exists?
  end

  def self.destroy_on?(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and obj_id = ? and mode = ?", group_id, object.to_s, id, DESTROY).exists?
  end

  def self.can_create(group_id, object, obj_id=0)
    Perm.new(group_id: group_id, object: object.to_s, obj_id: obj_id, mode: CREATE).save
  end

  def self.can_read(group_id, object, obj_id=0)
    Perm.new(group_id: group_id, object: object.to_s, obj_id: obj_id, mode: READ).save
  end

  def self.can_update(group_id, object, obj_id=0)
    Perm.new(group_id: group_id, object: object.to_s, obj_id: obj_id, mode: UPDATE).save
  end

  def self.can_destroy(group_id, object, obj_id=0)
    Perm.new(group_id: group_id, object: object.to_s, obj_id: obj_id, mode: DESTROY).save
  end

  def self.cannot_create(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and obj_id = ? and mode = ?", group_id, object.to_s, id, CREATE).destroy_all
  end

  def self.cannot_read(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and obj_id = ? and mode = ?", group_id, object.to_s, id, READ).destroy_all
  end

  def self.cannot_update(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and obj_id = ? and mode = ?", group_id, object.to_s, id, UPDATE).destroy_all
  end

  def self.cannot_destroy(group_id, object, id=0)
    Perm.where("group_id = ? and object = ? and obj_id = ? and mode = ?", group_id, object.to_s, id, DESTROY).destroy_all
  end

  def self.revoke(group_id, mode, object, obj_id)
    Perm.where("group_id = ? and object = ? and obj_id = ? and mode = ?", group_id, object.to_s, obj_id, mode).destroy_all
  end

  def self.permit(group_id, mode, object, obj_id)
    if !Perm.where("group_id = ? and object = ? and obj_id = ? and mode = ?", group_id, object.to_s, obj_id, mode).exists?
      p = Perm.new(group_id: group_id, mode: mode, object: object, obj_id: obj_id)
      p.save
    end
  end
end
