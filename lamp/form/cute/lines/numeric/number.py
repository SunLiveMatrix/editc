#!/usr/bin/python3.9


class Prop(ProcessLookupError):
    try:
        ProcessLookupError.args("Plots cannot be plotted")
    except ProcessLookupError:
        vars(__object=type)
        pass
