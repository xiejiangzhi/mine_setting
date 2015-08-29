require "mine_setting/version"

require 'yaml'
require 'erb'

# Files:
#   config/settings/base.yml
#   config/settings/secrets.yml
#   config/settings/other_config.yml
#
# File Content:
#   development:
#     foo: bar
#   test:
#     xxx: yyy
#
#
# Code:
#   class MySettings
#     extend MineSetting
#
#     load_dir Rails.root.join('config/settings'), 'development'
#   end
#
# MySettings.base # {foo: bar}
# MySettings.secrets
# MySettings.other_config
#

module MineSetting
  def self.included(cls)
    raise "Cannot include SimpleSettings, please use extend"
  end

  def load_dir(dir_path, env)
    Dir[File.join(dir_path, '*')].each do |filepath|
      filename = File.basename filepath
      next unless filename =~ /^\w+\.ya?ml$/
      puts "Load config '#{filename}'"

      setting_name = filename.gsub(/\.ya?ml/, '')
      eval(%Q{
        def self.#{setting_name}
          @#{setting_name} ||= load_setting('#{filepath}', '#{env}')
        end
      })
    end
  end


  protected

  def load_setting(filepath, env)
    str = File.read(filepath)
    YAML.load(ERB.new(str).result)[env]
  end
end
