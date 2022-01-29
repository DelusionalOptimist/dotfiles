#!/bin/env bash

main() {
	CONFIG=$HOME/.config/doctl/snapdrop.config
	if [[ -f "$CONFIG" ]]; then
		echo "Using config $CONFIG..."
	else
		echo "Prompting for default values..."
		set_defaults
	fi

	# DEFAULT VALUES ARE SOURCED FROM $CONFIG
	source $CONFIG

	local DROPLET_ID=$DEFAULT_DROPLET_ID
	local DROPLET_NAME=$DEFAULT_DROPLET_NAME
	local SSH_KEY=$DEFAULT_SSH_KEY
	local SNAPSHOT=$DEFAULT_SNAPSHOT_NAME
	local DROPLET_SIZE=$DEFAULT_DROPLET_SIZE

	parse_cli_args "$@"

	if [[ $CREATE == "true" && $DELETE == "false" ]]
	then
		create_droplet $DROPLET_ID $SNAPSHOT $SSH_KEY $DROPLET_NAME $DROPLET_SIZE
		exit 1
	elif [[ $CREATE == "false" && $DELETE == "true" ]]
	then
		deallocate_droplet $DROPLET_ID $SNAPSHOT
	fi

}

set_defaults() {
	echo "Enter default droplet name"
	read DEFAULT_DROPLET_NAME
	DEFAULT_DROPLET_ID=$(doctl compute droplet get $DEFAULT_DROPLET_NAME -o json | jq '.[] | ."id"')
	echo "Enter default ssh key"
	read DEFAULT_SSH_KEY
	echo "Enter default snapshot name"
	read DEFAULT_SNAPSHOT_NAME

	echo "DEFAULT_DROPLET_NAME=$DEFAULT_DROPLET_NAME" >> $CONFIG
	echo "DEFAULT_DROPLET_ID=$DEFAULT_DROPLET_ID" >> $CONFIG
	echo "DEFAULT_SSH_KEY=$DEFAULT_SSH_KEY" >> $CONFIG
	echo "DEFAULT_SNAPSHOT_NAME=$DEFAULT_SNAPSHOT_NAME" >> $CONFIG
}

# restores a droplet from a given snapshot
create_droplet() {
	echo "Getting snapshot id..."
	SNAPSHOT_ID=$(doctl compute snapshot list -o json | jq '.[] | select(.resource_id=='\"$1\"') | select(.name=='\"$2\"') | ."id"' | tr -d '"')
	echo "Creating droplet..."
	doctl compute droplet create --image $SNAPSHOT_ID --size $5 --ssh-keys $3 --region blr1 --wait $4

	DROPLET_ID_NEW=$(doctl compute droplet get $4 -o json | jq '.[] | ."id"')
	sed -i 's/DEFAULT_DROPLET_ID=.*/DEFAULT_DROPLET_ID='$DROPLET_ID_NEW'/g' $CONFIG

	echo "Deleting snapshot..."
	doctl compute snapshot delete --force $SNAPSHOT_ID
}

# powers off, creates a snapshot and deletes a droplet
deallocate_droplet() {
	echo "Powering off..."
	doctl compute droplet-action power-off $1 --wait
	echo "Taking a snapshot..."
	doctl compute droplet-action snapshot $1 --snapshot-name $2 --wait
	echo "Saved snapshot with ID: $(doctl compute droplet snapshots $1 -o json | jq '.[] | select(.name=="'$2'") | ."id"')"
	echo "Deleting droplet..."
	doctl compute droplet delete --force $1
}

parse_cli_args() {
	while :
	do
		case "${1:-}" in
			restore)
				CREATE=true
				DELETE=false
				shift
				;;
			deallocate)
				DELETE=true
				CREATE=false
				shift
				;;
			--droplet)
				if [[ -n "${2:-}" ]]; then
					DROPLET_NAME=$2
					DROPLET_ID=$(doctl compute droplet get $DROPLET_NAME -o json | jq '.[] | ."id"')
					shift
				else
					echo "ERROR: '--droplet' cannot be empty." >&2
					exit 1
				fi
				;;
			--snapshot)
				if [[ -n "${2:-}" ]]; then
					SNAPSHOT=$2
					shift
				else
					echo "ERROR: '--droplet-name' cannot be empty." >&2
					exit 1
				fi
				;;
			help|--help|-h)
				printf "\nsnapdrop: A CLI for deallocating and restoring Digital Ocean Droplets (VMs)\n"
				printf "COMMANDS:\n"
				printf "deallocate:\t\tdeallocates given droplet\n"
				printf "restore:\t\trestores droplet with the given snapshot\n"
				printf "\nFLAGS:\n--droplet:\t\tname of the droplet to be referenced\n--snapshot:\t\tname of the snapshot to be referenced\n"
				exit 0
				;;
			set-defaults)
				rm -rf $CONFIG
				set_defaults
				exit 0
				;;
			*)
				break
				;;
		esac
		shift
	done
}

main "$@"
