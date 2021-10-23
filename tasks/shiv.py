import shlex
from invoke import task


@task(iterable=["requirements"])
def build(ctx, name, requirements=[]):
    if not requirements:
        requirements = [name]
    modules_to_install = shlex.join(requirements)

    ctx.run(
        f"shiv --python '/usr/bin/env python3' {modules_to_install} -c {name} -o ~/bin/{name}"
    )
