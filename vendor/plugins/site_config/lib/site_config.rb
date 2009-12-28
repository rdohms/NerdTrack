SITE_CONFIG = YAML::load(File.open("#{RAILS_ROOT}/config/site_config.yml")).with_indifferent_access

def config_option(p, env = nil) 
	env ||= RAILS_ENV
	raise "No configuration for environment \"#{env}\"" if SITE_CONFIG[env].nil?	
	inherit_env = SITE_CONFIG[env]["inherit"]
	SITE_CONFIG[env][p] || (inherit_env && config_option(p, inherit_env))
end