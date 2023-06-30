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
  @TODO:
  Will most likely remove this and have three separate builds.
  - Return the page-sequences in `cfg/fo/xsl/structure.xsl` 
    back to the original top level rather than the current specialized heading-one level.
  - Remove post-processing `pdftk` file splitting from
    `run.sh`, and remove its installation from the GitHub workflow.

## Features

Each entry under a Company section is assigned one or more job roles.
When you build a resume with the custom `resume` transform type,
provide the job role as a category,
and that category will be listed first under the Skills Summary section
and under each Company section.

## What's next

See [TODO](TODO) file.

### Design idea: experience data

To support two resume types, (1) a traditional historical listing
by company and position versus (2) a listing by specialty or role,
I could author the entries individually as an array.
The array could be in tabular form, such as from a spreadsheet
or database, or as a group of records, such as from YAML or JSON.

|company|location|jobtitle|from|to|role|entry|
|---|---|---|---|---|---|---|
|Spacely Sprockets|Jet City|Senior Sprocket Designer|3303-02|Present|Component Design|Designed the 3303 sprocket of the year.|
|Spacely Sprockets|Jet City|Senior Sprocket Designer|3303-02|Present|Project Management|Engaged a team of 50 in metal collection, surpassing Cogswell by 30%.|
|Cogswell Cogs|Jet City|Cog Tolerance Engineer|3290-12|3303-01|Manufacturing Engineering|Improved Cog engagement quality by a USO measurable standard of 0.3%|
|Cogswell Cogs|Jet City|Cog Tolerance Engineer|3290-12|3303-01|Manufacturing Engineering|Established improved standards of cog testing.|

```yaml
roles:
  - id: design
    name: Component Design
  - id: engineering
    name: Manufacturing Engineering
  - id: pm
    name: Project Management
experience:
  presentation: by-role
  positions:
    - from: 3303-02
      to: Present
      company: Spacely Sprockets
      location: Jet City
      jobtitle: Senior Sprocket Designer
      entries:
        - role: design
          entry: Designed the 3303 sprocket of the year.
        - role: pm
          entry: Engaged a team of 50 in metal collection, surpassing Cogswell by 30%.
    - from: 3290-12
      to: 3303-01
      company: Cogswell Cogs
      location: Jet City
      jobtitle: Cog Tolerance Engineer
      entries:
        - role: engineer
          entry: Improved Cog engagement quality by a USO measurable standard of 0.3%
        - role: engineer
          entry: Established improved standards of cog testing.
```

I could then write a Java class to take care of the conversion
to DITA and extend one of the `org.dita.base` plugin's
preprocessing Ant steps in our plugin.

The problem with that, however, is if there's content in the items that
I want to conref or apply metadata, such as company or product names,
or keywords such as skills.
Therefore, in practice, it's probably best to store the data as a list
of records in specialized DITA within the document.
Or, rather than repeat the position info for each entry,
structure it as if it were organized by-position to begin with.
Then, I'd only need to re-swizzle things with XSLT if `@outputclass`
specifies 'by-role'.

```xml
<roles>
  <role id="design">Component Design</role>
  <role id="pm">Project Management</role>
  <role id="engineering">Manufacturing Engineering</role>
</roles>
<experience outputclass="by-position">
  <positions>
    <position>
      <company>Spacely Sprockets</company>
      <location>Jet City</location>
      <dates><from>3303-02</from><to>Present</to></dates>
      <jobtitle>Senior Sprocket Designer</jobtitle>
      <role>design</role>
      <accomplishments>
        <accomplishment role="design">Designed the 3303 <keyword conref="sprocket"/> of the year.</accomplishment>
        <accomplishment role="pm">Engaged a team of 50 in metal collection, surpassing <keyword conref="cogsw"/> by 30%.</accomplishment>
      </accomplishments>
    </position>
    <position>
      <company>Cogswell Cogs</company>
      <location>Jet City</location>
      <dates><from>3290-12</from><to>3303-01</to></dates>
      <jobtitle>Manufacturing Engineer</jobtitle>
      <role>design</role>
      <accomplishments>
        <accomplishment role="engineer">Improved <keyword conref="cog"/> engagement quality by a USO measurable standard of 0.3%</accomplishment>
        <accomplishment role="engineer">Established improved standards of <keyword conref="cog"/> testing.</accomplishment>
      </accomplishments>
    </position>
  </positions>
</experience>
```

I might implement the DITA version and provide the option
to pull in an Excel spreadsheet for the `<experience>` data.

```xml
<experience fromfile="experience.xlsx" outputclass="by-position"/>
```


### Design idea: summary data

Similarly, the technologies listed in the summary could be reused
or shared in other contexts, such as the skills listing in LinkedIn.
So, rather than storing the technologies as comma-delimited sentences
grouped by category, let's change that to a structured list of skills,
perhaps keywords instead of list items so that they can be conreffed
for use elsewhere
(such as the experience data or indexes to analyze for Recruiter ATS optimization).
Each skill would contain specialized _resume-domain_ attributes called
`@skilltype` (technology, softskill, and the like) and `@jobrole`.
The jobroles would be in a list as well to contain text, keyed off the `@jobrole`
attributes and associated with the role in the `@audience` property.

```xml
<skill role="design" skilltype="technology" id="sprockm">Sprockomaster</skill>
```

With that data, the current `<technologies>` element would be changed
to the more general `<skills>`, using the `@outputclass` attribute to specify
whether to list the skills _by-role_ as it's listed currently or
_individually_ as a long alphabetized list.

```xml
<skills outputclass="by-role">
  <li><skill role="design" skilltype="technology" id="sprockm">Sprockomaster</skill></li>
  <li><skill role="engineer" skilltype="technology" id="bcog">Build-a-Cog 2.0</skill></li>
  <li><skill role="pm" skilltype="softskill" id="shflmgmt">Shop-floor management</skill></li>
</skills>
```

Referenced elsewhere:

```xml
<accomplishment role="engineer">Achieved Master Certification with <skill conref="bcog"/>.</accomplishment>
```
