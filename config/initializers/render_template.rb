require 'erb'
require 'yaml'

yaml_file = File.join(File.dirname(__FILE__), '..', '..', 'component-specs', 'grid.yaml')
@input = YAML.load_file(yaml_file)

colArr = @input["grid"]["columns"]
@queryElements = ""          # queryElements string from columns
@columns = []

# loop through each column
colArr.each_with_index { |col, index|
    @queryElements.concat(@input["grid"]["columns"][index][0] + "\n")  # append to queryElements string
    @columns.append(@input["grid"]["columns"][index][0])
}

#@primaryKey = input["grid"]["columns"][0].split(',').first
grid_file = File.join(File.dirname(__FILE__), '..', '..', 'component-specs', 'grid-template.vue.erb')
form_file = File.join(File.dirname(__FILE__), '..', '..', 'component-specs', 'form-template.vue.erb')

# Grid part
grid_str = File.read(grid_file)

renderer = ERB.new(grid_str)
result = renderer.result()

curr_Dir = Dir.pwd
grid_generated_file = curr_Dir + '/app/javascript/components/grid-widget-render.vue'

# create grid file in /app/javascript/components
File.open(grid_generated_file, 'w') do |f|
    f.write(result)
    puts("File created in /app/javascript/components")
end

# form part
form_str = File.read(form_file)

renderer = ERB.new(form_str, nil, '-')
result = renderer.result()

curr_Dir = Dir.pwd
form_generated_file = curr_Dir + '/app/javascript/components/form-widget-render.vue'

# create form file in /app/javascript/components
File.open(form_generated_file, 'w') do |f|
    f.write(result)
    puts("File created in /app/javascript/components")
end



