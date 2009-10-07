class RailsMineConfig
  @@results_per_page = 5
  def RailsMineConfig.initialise_from_yaml_file
    yaml = YAML::load(File.open("#{RAILS_ROOT}/config/railsmine.yml"))
    config = yaml[RAILS_ENV]
    @@results_per_page = config['results_per_page']
  end

  def RailsMineConfig.results_per_page
    @@results_per_page 
  end
end