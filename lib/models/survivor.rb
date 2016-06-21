class Survivor < Sequel::Model
  one_to_many :items, dependent: :destroy
  one_to_many :infections
  many_to_many :trades
  unrestrict_primary_key
  include BCrypt

  plugin :timestamps, update_on_create: true

  subset :infected, ->       { includes(:infections).where("infections.count >= 3") }
  subset :healthy, ->        { includes(:infections).where("infections.count < 3") }
  subset :most_recent, ->    (limit) { order(:created_at.desc).limit!(limit) }
  subset :created_since, ->  (time) { where("created_at > ?", time) if time.present? }

  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      self.errors.password.add 'Invalid name/password combination'
      false
    end
  end

  def pending_trade
    self.trades.first.where(accepted!=true || (accepted==true && reviewed!=true))
  end

  def zombie?
    self.infections.count >= 3
  end

  def report(infected)
    infected.infections.create(reported_by: self.id)
  end

  def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(password)
    self.encrypted_password = BCrypt::Password.create(password)
  end

  def generate_token!
    self.token = SecureRandom.urlsafe_base64(64)
    self.save
  end

  def items=(items)
      @items = items unless new? || @trade
  end


  def self.status
    Survivor.all.select_map(:infections).each { |survivor|
      if survivor.zombie?
        @survivors[:infected] =+ 1
      else
        @survivors[:healthy] =+ 1
      end
      @survivors[:total] =+ 1
    }
    @survivors[:infected_percentage] = (@survivors[:infected] / @survivors[:total])*100
    @survivors[:healthy_percentage] = (@survivors[:healthy] / @survivors[:total])*100
    @survivors
  end
end
