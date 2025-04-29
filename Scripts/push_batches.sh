#!/bin/bash

# Get the commit hashes in reverse order
commit_hashes=$(git log --oneline --reverse | awk '{print $1}')

# Set the batch size (number of commits to push at a time)
batch_size=5

# Initialize a counter
counter=0

# Loop through each commit hash
for commit in $commit_hashes; do
  # Push the commit as part of the batch
  git push origin +$commit:refs/heads/main

  # Increment the counter
  counter=$((counter + 1))

  # Check if the batch size is reached
  if ((counter % batch_size == 0)); then
    echo "Pushed a batch of $batch_size commits."
  fi
done

# Perform a final mirror push to sync all references
git push origin --mirror
echo "All commits pushed successfully!"

