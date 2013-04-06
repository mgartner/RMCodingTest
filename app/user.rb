class User
  PROPERTIES = [:id, :name, :email]
  attr_accessor *PROPERTIES

  KEY = 'user'

  # Retrieves the current user from NSUserDefaults.
  def self.current
    if user_as_data = NSUserDefaults.standardUserDefaults[KEY]
      user = NSKeyedUnarchiver.unarchiveObjectWithData(user_as_data)
      return user
    else
      return nil
    end
  end

  # Initializes a User from NSUserDefaults.
  def initWithCoder(decoder)
    self.init
    PROPERTIES.each do |prop|
      value = decoder.decodeObjectForKey(prop.to_s)
      self.send("#{prop}=", value) if value
    end
    self
  end

  # Encodes a User into a format that can be saved into NSUserDefaults.
  def encodeWithCoder(encoder)
    PROPERTIES.each do |prop|
      encoder.encodeObject(self.send(prop.to_s), forKey: prop.to_s)
    end
  end

  # Saves the user into NSUserDefaults for persistent storage.
  def save
    user_as_data = NSKeyedArchiver.archivedDataWithRootObject(self)
    NSUserDefaults.standardUserDefaults[KEY] = user_as_data
    NSUserDefaults.standardUserDefaults.synchronize
  end
end