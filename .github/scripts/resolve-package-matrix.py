import argparse
import json
import subprocess
from pathlib import Path


SHARED_INPUTS = {
    ".github/workflows/main.yml",
    "aur-push",
}


def resolve_before(before: str) -> str:
    if set(before) != {"0"}:
        return before

    return subprocess.check_output(
        ["git", "hash-object", "-t", "tree", "/dev/null"],
        text=True,
    ).strip()


def main() -> None:
    parser = argparse.ArgumentParser(description="Resolve packages changed by a push")
    parser.add_argument("--before", required=True, help="commit before the push")
    parser.add_argument("--after", required=True, help="commit after the push")
    args = parser.parse_args()

    changed_paths = subprocess.check_output(
        ["git", "diff", "--name-only", resolve_before(args.before), args.after],
        text=True,
    ).splitlines()
    packages = {path.parent.name for path in Path(".").glob("*/PKGBUILD")}

    if any(
        path in SHARED_INPUTS or path.startswith(".github/scripts/")
        for path in changed_paths
    ):
        selected = packages
    else:
        selected = {
            path.split("/", 1)[0]
            for path in changed_paths
            if "/" in path and path.split("/", 1)[0] in packages
        }

    print(json.dumps(sorted(selected)))


if __name__ == "__main__":
    main()
