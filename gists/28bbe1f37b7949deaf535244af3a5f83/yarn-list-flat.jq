# Usage: yarn list --json | jq -r 'include "yarn-list-flat"; yarnListFlat'
def yarnListFlat:
  select(.type = "tree")
  |.data.trees[]
  |(
    .name,
    (.children[]? | (
      .name,
      (.children[]? | (
        .name,
        (.children[]? | (
          .name,
          (.children[]? | (
            .name,
            (.children[]? | (
              .name,
              (.children[]?)
            ))
          ))
        ))
      ))
    ))
  );
