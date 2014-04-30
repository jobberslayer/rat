class Perm < ActiveRecord::Base
  attr_accessible :mode, :obj_id, :object, :user_id

  CREATE = 'create'
  READ = 'read'
  UPDATE = 'update'
  DESTROY = 'destroy'

  def self.can_create?(user_id, object, id=0)
    Group.where("user_id = ? and object = ? and obj_id = ? and (mode = ? or mode = 0)", user_id, object.to_s, id, CREATE).exists?
  end

  def self.can_read?(user_id, object, id=0)
    Group.where("user_id = ? and object = ? and obj_id = ? and (mode = ? or mode = 0)", user_id, object.to_s, id, READ).exists?
  end

  def self.can_update?(user_id, object, id=0)
    Group.where("user_id = ? and object = ? and obj_id = ? and (mode = ? or mode = 0)", user_id, object.to_s, id, UPDATE).exists?
  end

  def self.can_destroy?(user_id, object, id=0)
    Group.where("user_id = ? and object = ? and obj_id = ? and (mode = ? or mode = 0)", user_id, object.to_s, id, DESTROY).exists?
  end

  def self.can_create(user_id, object, obj_id=0)
    Group.new(user_id: user_id, object: object.to_s, obj_id: obj_id, mode: CREATE).save
  end

  def self.can_read(user_id, object, obj_id=0)
    Group.new(user_id: user_id, object: object.to_s, obj_id: obj_id, mode: READ).save
  end

  def self.can_update(user_id, object, obj_id=0)
    Group.new(user_id: user_id, object: object.to_s, obj_id: obj_id, mode: UPDATE).save
  end

  def self.can_destroy(user_id, object, obj_id=0)
    Group.new(user_id: user_id, object: object.to_s, obj_id: obj_id, mode: DESTROY).save
  end

  def self.cannot_create(user_id, object, id=0)
    Group.where("user_id = ? and object = ? and obj_id = ? and (mode = ? or mode = 0)", user_id, object.to_s, id, CREATE).destroy_all
  end

  def self.cannot_read(user_id, object, id=0)
    Group.where("user_id = ? and object = ? and obj_id = ? and (mode = ? or mode = 0)", user_id, object.to_s, id, READ).destroy_all
  end

  def self.cannot_update(user_id, object, id=0)
    Group.where("user_id = ? and object = ? and obj_id = ? and (mode = ? or mode = 0)", user_id, object.to_s, id, UPDATE).destroy_all
  end

  def self.cannot_destroy(user_id, object, id=0)
    Group.where("user_id = ? and object = ? and obj_id = ? and (mode = ? or mode = 0)", user_id, object.to_s, id, DESTROY).destroy_all
  end
end
