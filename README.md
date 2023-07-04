[![Build status](https://github.com/arkadianriver/dita-resume/workflows/build/badge.svg)](https://github.com/arkadianriver/dita-resume/actions)

# dita-resume

## Purpose

Build separate résumés, each with contents prioritized by a specified job role.

## Technology

Made possible with the custom DITA-OT plugin
in the `plugins/com.arkadianriver.resume` folder.
The plugin:

- specializes new résumé elements from the base topic type.
- implements a custom XSL-FO `pdf2` transform type called _resume_.

## Features

Each entry under a Position section is assigned one or more job roles.
Assign job roles to each skill, technology category, and accomplishment.
When you build a résumé with the custom `resume` transform type,
provide the job role you want prioritized,
and entries with that role will be listed first under the Summary Skills and
Technologies sections and also under each Position section.
Also, the description with that role will be included
while descriptions for other roles are excluded, same as props values.


## What's next

See [TODO](TODO) file.

### Design idea: experience by role

Potentially support two résumé types, (1) a traditional historical listing
by company and position versus (2) a listing by specialty or role.
The default is a historical listing.
The jobrole attribute could be used to group Accomplishments by role instead.

I've not heard good things about the second role-based grouping,
so this is probably a pass for now.

### Design idea: accept experience data in tabular form

Potentially accept experience data from a spreadsheet, database, or JSON list.
Only reason to do this would be to demonstrate it can be done.
I don't foresee anyone wanting to maintain resume data in two places.

|organization|location|jobtitle|datefrom|dateto|jobrole|entry|
|---|---|---|---|---|---|---|
|Spacely Sprockets|Jet City|Senior Sprocket Designer|3303-02|Present|Component Design|Designed the 3303 sprocket of the year.|
|Spacely Sprockets|Jet City|Senior Sprocket Designer|3303-02|Present|Project Management|Engaged a team of 50 in metal collection, surpassing Cogswell by 30%.|
|Cogswell Cogs|Jet City|Cog Tolerance Engineer|3290-12|3303-01|Manufacturing Engineering|Improved Cog engagement quality by a USO measurable standard of 0.3%|
|Cogswell Cogs|Jet City|Cog Tolerance Engineer|3290-12|3303-01|Manufacturing Engineering|Established improved standards of cog testing.|

Also, keeping the data separate doesn't provide the capability of
reuse with conrefs.

### Design idea: summary data

Potentially store the technologies as a structured list of skills,
perhaps with keywords instead of list items so that they can be conreffed
for use elsewhere
(such as the experience data or indexes to analyze for Recruiter ATS optimization).
Each skill would contain specialized _resume-domain_ attributes called
`@skilltype` (technology, softskill, and the like) and `@jobrole`.
The jobroles would need to be given human-readable titles in this case so that the
skills could be categorized by them.

```xml
<skill role="design" skilltype="technology" id="sprockm">Sprockomaster</skill>
```

With that data, the current `<technologies>` element would be changed
to the more general `<skills>`, using the `@outputclass` attribute to specify
whether to list the skills _by-role_ as it's listed currently or
_individually_ as a long alphabetized list.

```xml
<jobroles>
  <jobrole id="design">Component Design</jobrole>
  <jobrole id="pm">Project Management</jobrole>
  <jobrole id="engineering">Manufacturing Engineering</jobrole>
</jobroles>
<skills outputclass="by-role">
  <li><skill jobrole="design" skilltype="technology" id="lofi">Lo-fi testing</skill></li>
  <li><skill jobrole="design" skilltype="technology" id="sprockm">Sprockomaster</skill></li>
  <li><skill jobrole="engineer" skilltype="technology" id="bcog">Build-a-Cog 2.0</skill></li>
  <li><skill jobrole="engineer" skilltype="technology" id="cfab">Cog fabrication</skill></li>
  <li><skill jobrole="engineer" skilltype="technology" id="ptest">Production testing</skill></li>
  <li><skill jobrole="pm" skilltype="softskill" id="shflmgmt">Shop-floor management</skill></li>
  <li><skill jobrole="pm" skilltype="softskill" id="agile">Agile methodologies</skill></li>
</skills>
```

Output:

```
Component Design:
  Sprockomaster, Lo-fi testing

Project Management:
  Shop-floor management, Agile methodologies

Manufacturing Engineering:
  Build-a-Cog 2.0, Cog fabrication, Production testing
```

Referenced elsewhere:

```xml
<accomplishment jobrole="engineer">Achieved Master Certification with <skill conref="#resume/bcog"/>.</accomplishment>
```
