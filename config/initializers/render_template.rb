require 'erb'
require 'yaml'

curr_Dir = Dir.pwd

specs_dir = curr_Dir + "/component-specs/specs"

yaml_dir = curr_Dir + "/component-specs/yaml_input"

# loop through template files
Dir.each_child(specs_dir) do |spec|
    widget_name = spec.split('-').first

    # loop through yaml/input files
    Dir.each_child(yaml_dir) do |yaml_file|
        yaml_name = yaml_file.split('.').first

        # check if yaml file corresponds to template file
        if yaml_name == widget_name
            
            yaml_file_dir = yaml_dir + "/" + yaml_file
            
            # this part is temporary to make it easier to test since form and grid.yaml are always the same
            if yaml_name == "form"
                yaml_file_dir = yaml_dir + "/" + "grid.yaml"
            end

            @input = YAML.load_file(yaml_file_dir)

            colArr = @input["columns"]
            @queryElements = ""  # queryElements string from columns
            @columns = []

            # loop through each column
            colArr.each_with_index { |col, index|
                @queryElements.concat(@input["columns"][index][0] + "\n")  # append to queryElements string
                @columns.append(@input["columns"][index][0])
            }

            file = curr_Dir + "/component-specs/specs" + "/" + spec
            file_str = File.read(file)
            
            renderer = ERB.new(file_str, nil, '-')
            result = renderer.result()
            
            generated_file = curr_Dir + '/app/javascript/components/' +  yaml_name + '-widget-render.vue'

            # create new file in /app/javascript/components
            File.open(generated_file, 'w') do |f|
                f.write(result)
                puts("#{yaml_name} file created in /app/javascript/components")
            end
        end
    end
end
