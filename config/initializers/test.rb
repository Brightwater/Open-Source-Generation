require 'erb'
require 'yaml'

yaml_file = File.join(File.dirname(__FILE__), '..', '..', 'component-specs', 'grid.yaml')
input = YAML.load_file(yaml_file)

colArr = input["grid"]["columns"]
queryElements = ""          # queryElements string from columns

puts input["tableName"]

# loop through each column
input["grid"]["columns"].each_with_index { |col, index|
    queryElements.concat(input["grid"]["columns"][index][0] + "\n")  # append to queryElements string
}

puts queryElements