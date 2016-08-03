# HeyUpdate for Alfred
## Instructions and contact/help info here: 
## https://github.com/raamdev/heyupdate-for-alfred


## Enter your Personal API token between the quotes below
### (see the instructions link above for how to get your token)

api_token="PERSONAL_ACCESS_TOKEN_GOES_HERE"


###################################
### DO NOT EDIT BELOW THIS LINE ###
######### HERE BE DRAGONS #########
###################################


oIFS=$IFS
IFS="
"


## Static values
base_uri="https://api.heyupdate.com"
tmp_file="/tmp/done.json"
update="{query}"

### Let's replace single and double quotes with unicode values so we can include them easily in the update
update="${update//\'/\\u0027}"
update="${update//\"/\\u0022}"

## Add update.
### Create json temp file.
cat > $tmp_file << DONE
{"message": "${update}"}
DONE

### Submit update to API saving the return response.
res=$(curl -H "Content-type:application/json" -H "Authorization: Bearer ${api_token}" --data @${tmp_file} ${base_uri}/updates)

## If it was successful print out success message.
## If the request failed, print it.
if [[ $res == *"\"timestamp\":"* ]]
then
    echo \"{query}\" has been posted.
else
    echo $res
fi

## A bit of cleanup.
IFS=$oIFS
rm $tmp_file
