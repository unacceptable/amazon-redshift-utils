#!/usr/bin/env bash

set -e

echo "Running column-encoding utility"

# Required
DB=${DB:-}
DB_USER=${DB_USER:-}
DB_PWD=${DB_PWD:-}
DB_HOST=${DB_HOST:-}
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:-}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:-}

# Optional with Defaults
AWS_REGION=${AWS_REGION:-us-east-1}
DB_PORT=${DB_PORT:-5439}
ANALYZE_SCHEMA=${ANALYZE_SCHEMA:-public}
TARGET_SCHEMA=${TARGET_SCHEMA:-${ANALYZE_SCHEMA}}
THREADS=${THREADS:-2}
DEBUG=${DEBUG:-false}
DO_EXECUTE=${DO_EXECUTE:-false}
SLOT_COUNT=${SLOT_COUNT:-1}
IGNORE_ERRORS=${IGNORE_ERRORS:-false}
FORCE=${FORCE:-false}
DROP_OLD_DATA=${DROP_OLD_DATA:-false}
SSL_OPTION=${SSL_OPTION:-false}

ANALYZE_TABLE=${ANALYZE_TABLE:-}
ANALYZE_COL_WIDTH=${ANALYZE_COL_WIDTH:-}
OUTPUT_FILE=${OUTPUT_FILE:-}
COMP_ROWS=${COMP_ROWS:-}
QUERY_GROUP=${QUERY_GROUP:-}
NEW_DIST_KEY=${NEW_DIST_KEY:-}
NEW_SORT_KEYS=${NEW_SORT_KEYS:-}
STATEMENT_TIMEOUT=${STATEMENT_TIMEOUT:-}

if [ "${DB}" == "" ]; then echo "Environment Var 'DB' must be defined"
elif [ "${DB_USER}" == "" ]; then echo "Environment Var 'DB_USER' must be defined"
elif [ "${DB_PWD}" == "" ]; then echo "Environment Var 'DB_PWD' must be defined"
elif [ "${DB_HOST}" == "" ]; then echo "Environment Var 'DB_HOST' must be defined"
else
    if [ "${ANALYZE_TABLE}" != "" ]; then ANALYZE_TABLE_CMD="--analyze-table ${ANALYZE_TABLE}"; fi
    if [ "${ANALYZE_COL_WIDTH}" != "" ]; then ANALYZE_COL_WIDTH_CMD="--analyze-cols ${ANALYZE_COL_WIDTH}"; fi
    if [ "${OUTPUT_FILE}" != "" ]; then OUTPUT_FILE_CMD="--output-file ${OUTPUT_FILE}"; fi
    if [ "${COMP_ROWS}" != "" ]; then COMP_ROWS_CMD="--comprows ${COMP_ROWS}"; fi
    if [ "${QUERY_GROUP}" != "" ]; then QUERY_GROUP_CMD="--query_group ${QUERY_GROUP}"; fi
    if [ "${NEW_DIST_KEY}" != "" ]; then NEW_DIST_KEY_CMD="--new-dist-key ${NEW_DIST_KEY}"; fi
    if [ "${NEW_SORT_KEYS}" != "" ]; then NEW_SORT_KEYS_CMD="--new-sort-keys ${NEW_SORT_KEYS}"; fi
    if [ "${STATEMENT_TIMEOUT}" != "" ]; then STATEMENT_TIMEOUT_CMD="--statement-timeout ${STATEMENT_TIMEOUT}"; fi

    python ColumnEncodingUtility/analyze-schema-compression.py \
        --db "${DB}" \
        --db-user "${DB_USER}" \
        --db-pwd "${DB_PWD}" \
        --db-host "${DB_HOST}" \
        --db-port "${DB_PORT}" \
        --analyze-schema "${ANALYZE_SCHEMA}" \
        --target-schema "${TARGET_SCHEMA}" \
        --threads "${THREADS}" \
        --debug "${DEBUG}" \
        --do-execute "${DO_EXECUTE}" \
        --slot-count "${SLOT_COUNT}" \
        --ignore-errors "${IGNORE_ERRORS}" \
        --force "${FORCE}" \
        --drop-old-data "${DROP_OLD_DATA}" \
        --ssl-option "${SSL_OPTION}" \
        "${ANALYZE_TABLE_CMD}" "${ANALYZE_COL_WIDTH_CMD}" "${OUTPUT_FILE_CMD}" "${COMP_ROWS_CMD}" "${QUERY_GROUP_CMD}" \
        "${NEW_DIST_KEY_CMD}" "${NEW_SORT_KEYS_CMD}" "${STATEMENT_TIMEOUT_CMD}"

    echo "Done"
fi
