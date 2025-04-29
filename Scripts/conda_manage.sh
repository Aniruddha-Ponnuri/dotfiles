#!/usr/bin/env bash
set -euo pipefail

#-------------------------------------------------------
# Single script to BACKUP (-b) or RESTORE (-r) Conda envs
#-------------------------------------------------------
usage() {
  cat <<EOF
Usage: $0 [-b <backup_dir>] | [-r <file_or_dir>]
  -b  Backup all Conda envs into YAML files in <backup_dir>
  -r  Restore Conda envs from a specific YAML or all YAMLs in <file_or_dir>
EOF
  exit 1
}

# Parse flags
if [[ $# -lt 2 ]]; then
  usage
fi

mode=""
target=""
while getopts "b:r:" opt; do
  case $opt in
    b) mode="backup"; target="$OPTARG" ;;
    r) mode="restore"; target="$OPTARG" ;;
    *) usage ;;
  esac
done

# Ensure target path exists (backup dir) or is accessible (restore)
if [[ "$mode" == "backup" ]]; then
  mkdir -p "$target"
elif [[ "$mode" == "restore" ]]; then
  [[ ! -e "$target" ]] && { echo "Error: '$target' not found"; exit 1; }
else
  usage
fi

# Backup mode: export each env to YAML
if [[ "$mode" == "backup" ]]; then
  echo "Backing up all Conda environments to '$target'..."
  for env in $(conda env list | awk '{print $1}'); do
    # Skip header/commented or empty entries
    [[ -z "$env" || "${env:0:1}" == "#" ]] && continue
    ts=$(date +"%Y%m%d_%H%M%S")
    out="$target/${env}_${ts}.yml"
    echo "  -> Exporting '$env' to '$out'"
    conda env export -n "$env" --no-builds --from-history > "$out"
  done
  echo "Backup complete."
  exit 0
fi

# Restore mode: import from file or all YAMLs in dir
if [[ "$mode" == "restore" ]]; then
  echo "Restoring Conda environments from '$target'..."
  files=()
  if [[ -d "$target" ]]; then
    files=("$target"/*.yml)
  else
    files=("$target")
  fi
  for f in "${files[@]}"; do
    [[ ! -f "$f" ]] && continue
    echo "  -> Creating from '$f'"
    conda env create -f "$f" || \
      echo "     [Warning] Failed to restore from '$f'"
  done
  echo "Restore complete."
  exit 0
fi
