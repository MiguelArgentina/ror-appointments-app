module UsersHelper
  def options_for_select_user_type upgrade_scope = :client
    upgrade_scope = :client
    case upgrade_scope
    when :all
      User.user_types.map { |key, _value| [key.humanize, key] }
    when :provider
        User.user_types.map { |key, _value| [key.humanize, key] }.select{|user| user.first == upgrade_scope.to_s.humanize}
    when :admin
        User.user_types.map { |key, _value| [key.humanize, key] }.select{|user| user.first == upgrade_scope.to_s.humanize}
    else
      User.user_types.map { |key, _value| [key.humanize, key] }.select{|user| user.first == upgrade_scope.to_s.humanize}
    end
  end
end
