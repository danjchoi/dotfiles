"""Collection of common invoke tasks."""

import invoke


@invoke.task(aliases=["fmt"], help={"path": "Path to files that need formatting."})
def format(context, path="."):
    """Run black and isort."""
    cmds = ["black", "isort"]
    results = []
    for this_cmd in cmds:
        print(f"Running {this_cmd}:")
        results.append(context.run(f"{this_cmd} {path}", warn=True, hide="both"))
        _print_result(results[-1])
    # - Exit
    _print_exit(results)


@invoke.task(help={"path": "Path to files that need linting."})
def lint(context, path="."):
    """Run static lint checkers of flake8, pylint, and pydocstyle."""
    cmds = ["pydocstyle", "flake8", "pylint"]
    results = []
    for this_cmd in cmds:
        print(f"Running {this_cmd}:")
        results.append(context.run(f"{this_cmd} {path}", warn=True, hide="both"))
        _print_result(results[-1])
    # - Exit
    _print_exit(results)


@invoke.task(
    help={
        "cmd": "the command to loop",
        "num": "number of times to loop the command (DEFAULT 10)",
    }
)
def loop(context, cmd, num=10):
    """Loop the given command."""
    pass


# - Helpers
def _print_result(result):
    """Print the result."""
    tab = " " * 2
    print(f"{tab} Result: {result.exited}")
    stdout_lines = result.stdout.strip("\n").splitlines()
    for line in stdout_lines:
        print(f"{tab*2} {line}")
    stderr_lines = result.stderr.strip("\n").splitlines()
    for line in stderr_lines:
        print(f"{tab*2} {line}")


def _print_exit(results):
    """Print the exit message."""
    messages = []
    code = 0
    for this_result in results:
        code += this_result.exited
        if this_result.failed:
            messages.append(f'`"{this_result.command}" failed`')
    if code != 0:
        end_msg = f"ERROR: {' AND '.join(messages)}"
        raise invoke.exceptions.Exit(message=end_msg, code=code)
