set :application, 'test_deploy'
set :repo_url, 'git@github.com:at-anhn/test_deploy.git'
set :deploy_user, 'ec2-user'
set :ec2_access_key_id, 'aaaaaaaaaaaaaaaaa'
set :ec2_secret_access_key, 'aaaaaaaaaaaaaaaaaaaaaaaaaaa'
set :ec2_region, %w{us-east-1}

set :ec2_contact_point, :private_ip
namespace :deploy do
  desc 'Invoke a rake command'
  task :invoke, [:command] => 'deploy:set_rails_env' do |task, args|
    on primary(:app) do
      within current_path do
        with :rails_env => fetch(:rails_env) do
          rake args[:command]
        end
      end
    end
  end

  task :compile_assets, [:command] => 'deploy:set_rails_env' do
    on primary(:app) do
      within current_path do
        with :rails_env => fetch(:rails_env) do
          execute :rake, 'assets:precompile'
        end
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end