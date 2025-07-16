#!/usr/bin/env bash

# Globals
result_path="/tmp/api_results.json"
exit_flag=false
selected_keys=()

echo_log() {
   echo $1 >> /tmp/logging.txt
}

is_stringified_json() {
    local json_data=$1
    local key=$2
    
    result=$(echo "$json_data" | jq -r "if (try ($key | fromjson) catch false) then true else false end")

    [[ "$result" == "true" ]]
}

get_type() {
    local json_data=$1
    local selected_key=$2

    echo "$json_data" | jq -r "$selected_key | type"
}

back_cmd() {
  unset "selected_keys[${#selected_keys[@]}-1]"
  return 0
}

json_query() {
    key=$1
    echo "jq -r '$key' $result_path"
}

select_keys() {
    local json_data=$1

    local prop_type
    local string_key="${selected_keys[*]}"
    local header=$(echo "$string_key" | tr -d ' | ' | sed 's/fromjson//g')
    local options_query="keys_unsorted[]"
    local preview_query=".{}"
    local primitive_types=("string" "number" "boolean")
    local other_options="back exit"
    local bindings="ctrl-d:preview-down,ctrl-u:preview-up"
    local blank_exit="[[ {} = 'exit' || {} = 'back' ]] && echo ''"

    if [[ "${#selected_keys[@]}" -gt 0 ]]; then
        prop_type=$(get_type "$json_data" "$string_key")

        case $prop_type in
            "array")
                options_query="$string_key | keys[]"
                preview_query="$string_key | .[{}]"
                ;;
            "object")
                options_query="$string_key | keys_unsorted[]"
                preview_query="$string_key | .{}"
                ;;
        esac
    fi

    # Keybinding to use fx
    open_binding=",ctrl-o:execute($(json_query "$preview_query") | fx)"
    bindings="${bindings}${open_binding}"

    preview_cmd="$blank_exit || $(json_query "if ($preview_query | type == \"string\" and (try fromjson catch false)) then $preview_query | fromjson else $preview_query end")"

    # Main interaction
    key=$(echo $json_data | jq -r "$options_query" | \
        (echo "exit back" | tr ' ' '\n'; cat) | \
        fzf --header "$header" --preview "$preview_cmd" --bind "$bindings")

    if [[ -z $key ]]; then
        echo 'No key selected, exiting...'
        exit 1

    elif [[ "$key" == 'back' ]]; then
        back_cmd
        
    elif [[ "$key" == 'exit' ]]; then
        exit 1

    elif [[ -n "$key" && "${#selected_keys[@]}" -gt 0 ]]; then
        prop_type=$(get_type "$json_data" "$string_key")

        case $prop_type in
            "array")
                selected_keys+=("| .[$key]")
                ;;
            "object")
                selected_keys+=("| .$key")
                ;;
        esac
    else
        selected_keys+=(".$key")
    fi
    local new_string_key="${selected_keys[*]}"

    # Check type of selected key
    prop_type=$(get_type "$json_data" "$new_string_key")
    if [[ " ${primitive_types[@]} " =~ " $prop_type " ]]; then
        # Return if stringified JSON
        if [[ $prop_type == 'string' ]]; then
            if is_stringified_json "$json_data" "$new_string_key"; then
                last_index=$((${#selected_keys[@]} - 1))
                selected_keys[$last_index]="| .$key | fromjson"
                echo $selected_keys
            else
                echo $(json_query "$new_string_key") | pbcopy
                back_cmd
            fi
        else
            echo $(json_query "$new_string_key") | pbcopy
            back_cmd
        fi
    fi

    echo $selected_keys 
}


echo -n "API endpoint: "
read input

if [[ -n $input ]]; then
    curl $input > /tmp/api_results.json
fi

json=$(cat /tmp/api_results.json)

while true; do
    echo_log "Started"
    select_keys "$json"
    echo_log "You selected: ${selected_keys[*]}"
done
echo_log "End"
