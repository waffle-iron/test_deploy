set :ec2_project_tag, 'test_deploy'
set :ec2_roles_tag, 'Roles'
set :ec2_stages_tag, 'Stages'
# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.
set :branch, 'master'
set :deploy_to, '/home/ubuntu/test_deploy'
ec2_role :web,
  user: 'ec2-user',
  ssh_options: {
    user: 'ec2-user', # overrides user setting above
    keys: %w(/home/anhn/nat-tmp.pem),
    forward_agent: true,
  }
  ec2_role :app,
  user: 'ec2-user',
  ssh_options: {
    user: 'ec2-user', # overrides user setting above
    keys: %w(/home/anhn/nat-tmp.pem),
    forward_agent: true,
  }
ec2_role :db,
  user: 'ec2-user',
  ssh_options: {
    user: 'ec2-user ', # overrides user setting above
    keys: %w(/home/anhn/nat-tmp.pem),
    forward_agent: true,
  }
# server '10.0.0.11', user: 'ubuntu', roles: %i(web app db), proxy: Net::SSH::Proxy::Command.new('ssh -i ~/.ssh/test/nat-tmp.pem ec2-user@52.22.119.86')
# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

set :stage, :production
set :bundle_flags, "--no-deployment"
# set :ssh_options, {
#   keys: %w(/home/ec2-user/nat-tmp.pem),
#   forward_agent: true
# }

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
