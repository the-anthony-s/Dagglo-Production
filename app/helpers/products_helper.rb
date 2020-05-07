module ProductsHelper

    def nested_dropdown(items)
        result = []
        items.map do |item, sub_items|
            result << [('- ' * item.depth) + item.name, item.id]
            result += nested_dropdown(sub_items) unless sub_items.blank?
        end
        result
    end

end
