admin = User.create :email => "admin@example.com", :password => "welcome1"
admin.add_role :admin
jcooper = User.create :email => "jcooper@example.com", :password => "welcome1"
jcooper.add_role :project_owner