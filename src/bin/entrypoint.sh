#!/usr/bin/env bash
set -e

export PATH="$(find "$PWD" -maxdepth 1 -mindepth 1 -not -path "*bin*" -type d -printf "%p:")${PATH}"

# shellcheck disable=SC2120
usage(){
    EXIT=${1:-0}
    cat <<EOF
    Usage:
        $0 <project>

    Projects:
        analyze-vacuum
        column-encoding
        upload-copy
        user-last-login
EOF

    exit "$EXIT"
}

# shellcheck disable=SC2194

main(){
    # shellcheck disable=SC2034
    PROJECT=${1:-"Not provided"}

    case PROJECT in
        analyze-vacuum)
            bin/run-analyze-vacuum-utility.sh
            ;;
        column-encoding)
            bin/run-column-encoding-utility.sh
            ;;
        unload-copy)
            bin/run-unload-copy-utility.sh
            ;;
        user-last-login)
            bin/run-user-last-login.sh
            ;;
        *)
            echo "ERROR - Unhandled arg for project to run."
            usage
            ;;
    esac
}

main "$@"
