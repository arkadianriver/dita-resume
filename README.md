[![Build status](https://github.com/arkadianriver/dita-resume/workflows/build/badge.svg)](https://github.com/arkadianriver/dita-resume/actions)

> STILL UNDER CONSTRUCTION

# dita-resume

## Purpose

Build separate resumes, each highlighting a different job role.

## Technology

Made possible with a custom DITA-OT plugin:

- Specializes new resume elements from the base topic type.
- Implements a custom XSL-FO `pdf2` transform type called _resume_.
- **Bonus:** Makes use of the _ditavalref_ map element to build
  the separate resumes in one run.
	(A working POC, but perhaps not ideal, since they need to be split
	into separate documents again in post-processing.)

## Features

Each entry under a Company section is assigned one or more job roles.
When you build a resume with the custom `resume` transform type,
provide the job role as a category,
and that category will be listed first under the Skills Summary section
and under each Company section.

## What's next

See [TODO](TODO) file.

