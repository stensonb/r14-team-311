class AchievementsProcessor
  def self.achievements
    @achievements ||= begin
      Padrino.logger.info "Loading achievements..."
      YAML.load_file(Padrino.root("config/achievements.yml"))['achievements']
    end
  end

  def initialize(users)
    @users = users
  end

  def run
    @users.each do |user|
      process_user(user)
    end
  end

  def process_user(user)
    AchievementsProcessor.achievements.each do |achievement|
      check_and_award_achievement(user, achievement)
    end
  end

  def check_and_award_achievement(user, achievement)
    if already_awarded?(user, achievement)
      return
    end

    if !match_conditions?(user, achievement)
      return
    end

    award_achievement(user, achievement)
  end

  def award_achievement(user, achievement)
    user.add_to_set(achievements: achievement['id'])
  end

  def already_awarded?(user, achievement)
    if user.achievements.include?(achievement['id'])
      # user already has this achievement.
      return true
    end

    return false
  end

  def match_conditions?(user, achievement)
    stats = UserStats.where(login: user.login).last
    achievement['conditions'].each do |key, value|
      if stats[key] < value
        return false
      end
    end

    return true
  end
end

