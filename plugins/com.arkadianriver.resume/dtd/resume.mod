<?xml version="1.0" encoding="UTF-8"?>


<!-- =======================
      Some common entities
     ======================= -->

<!ENTITY % DITAArchNSPrefix
  "ditaarch" >

<!ENTITY % arch-atts 
  "xmlns:%DITAArchNSPrefix; CDATA #FIXED 'http://dita.oasis-open.org/architecture/2005/'
   %DITAArchNSPrefix;:DITAArchVersion CDATA '1.3'" >


<!-- ===============
      Resume 
     =============== -->

<!ENTITY % resume         "resume"      >
<!ENTITY % name           "name"        >
<!ENTITY % header         "header"      >
<!ENTITY % resumebody     "resumebody"  >

<!ENTITY % resume.content
  "((%name;),
    (%header;)?,
    (%resumebody;))"
>
<!ENTITY % resume.attributes
  "id ID #REQUIRED
   %conref-atts;
   %select-atts;
   %localization-atts;
   outputclass  CDATA #IMPLIED" >

<!ELEMENT  resume %resume.content; >
<!ATTLIST  resume
  %resume.attributes;
  %arch-atts;
  domains CDATA "&included-domains;" >


<!-- ===============
      Header
     =============== -->

<!ENTITY % description  "description" >
<!ENTITY % contact      "contact" >

<!ENTITY % header.content
  "((%description;)+,
    (%contact;)?)" >

<!ENTITY % header.attributes
  "spectitle CDATA #IMPLIED
   %univ-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  header %header.content;>
<!ATTLIST  header %header.attributes;>

<!ENTITY % description.content "( #PCDATA | %basic.ph; )*" >
<!ELEMENT description %description.content; >


<!-- ===============
      Contact
     =============== -->

<!ENTITY % phone    "phone" >
<!ENTITY % email    "email" >
<!ENTITY % linkedin "linkedin" >
<!ENTITY % website  "website" >

<!ENTITY % contact.content
  "((%phone;)?,
    (%email;)?,
    (%linkedin;)?,
    (%website;)?)" >

<!ENTITY % contact.attributes
  "spectitle CDATA #IMPLIED
   %univ-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  contact %contact.content;>
<!ATTLIST  contact %contact.attributes;>


<!-- ===============
      Resumebody
     =============== -->

<!ENTITY % summary     "summary"    >
<!ENTITY % experience  "experience" >
<!ENTITY % education   "education"  >
<!ENTITY % awards      "awards"     >

<!ENTITY % resumebody.content
  "((%summary;),
    (%experience;)?,
    (%education;)?,
    (%awards;)?)" >

<!ENTITY % resumebody.attributes
  "%id-atts;
   %localization-atts;
   base CDATA #IMPLIED
   %base-attribute-extensions;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  resumebody %resumebody.content;>
<!ATTLIST  resumebody %resumebody.attributes;>


<!-- ===============
      Summary
     =============== -->

<!ENTITY % specialties "specialties" >
<!ENTITY % technologies "technologies" >

<!ENTITY % summary.content
  "((%basic.block;)*,
    (%specialties;)?,
    (%technologies;)?)" >

<!ENTITY % summary.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  summary %summary.content;>
<!ATTLIST  summary %summary.attributes;>


<!-- ===============
      Specialties
     =============== -->

<!ENTITY % specialty "specialty" >

<!ENTITY % specialties.content
  "((%specialty;)*)" >

<!ENTITY % specialties.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  specialties %specialties.content;>
<!ATTLIST  specialties %specialties.attributes;>


<!-- ===============
      Technologies
     =============== -->

<!ENTITY % technology "technology"    >

<!ENTITY % technologies.content
  "((%technology;)*)" >

<!ENTITY % technologies.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  technologies %technologies.content;>
<!ATTLIST  technologies %technologies.attributes;>


<!-- ===============
      Technology
     =============== -->

<!ENTITY % techcategory "techcategory" >
<!ENTITY % techcategorylist "techcategorylist" >

<!ENTITY % technology.content
  "((%techcategory;),
    (%techcategorylist;))" >

<!ENTITY % technology.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  technology %technology.content; >
<!ATTLIST  technology %technology.attributes; >


<!-- ===============
      Phone
     =============== -->

<!ENTITY % countrycode "countrycode" >
<!ENTITY % number "number" >

<!ENTITY % phone.content
  "((%countrycode;),
    (%number;))" >

<!ENTITY % phone.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  phone %phone.content; >
<!ATTLIST  phone %phone.attributes; >

<!-- ===============
      Experience
     =============== -->

<!ENTITY % positions  "positions"    >

<!ENTITY % experience.content
  "((%positions;)*)" >

<!ENTITY % experience.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  experience %experience.content;>
<!ATTLIST  experience %experience.attributes;>


<!-- ===============
      positions
     =============== -->

<!ENTITY % position  "position"    >

<!ENTITY % positions.content
  "((%position;)*)" >

<!ENTITY % positions.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  positions %positions.content;>
<!ATTLIST  positions %positions.attributes;>


<!-- ===============
      position
     =============== -->

<!ENTITY % position  "position"    >
<!ENTITY % organization  "organization"    >
<!ENTITY % location  "location"    >
<!ENTITY % datefrom  "datefrom"    >
<!ENTITY % dateto    "dateto"    >
<!ENTITY % jobtitle  "jobtitle"    >
<!ENTITY % accomplishments  "accomplishments"    >

<!ENTITY % position.content
  "((%organization;),
    (%location;),
    (%datefrom;),
    (%dateto;),
    (%jobtitle;),
    (%accomplishments;)?)" >

<!ENTITY % position.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  position %position.content;>
<!ATTLIST  position %position.attributes;>


<!-- ================
      accomplishments
     ================ -->

<!ENTITY % accomplishment "accomplishment" >

<!ENTITY % accomplishments.content
  "((%accomplishment;)*)" >

<!ENTITY % accomplishments.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  accomplishments %accomplishments.content;>
<!ATTLIST  accomplishments %accomplishments.attributes;>


<!-- ===============
      Education
     =============== -->

<!ENTITY % program "program" >

<!ENTITY % education.content
  "((%program;)*)" >

<!ENTITY % education.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  education %education.content;>
<!ATTLIST  education %education.attributes;>

<!-- ===============
      program
     =============== -->

<!ENTITY % school  "school"    >
<!ENTITY % degree  "degree"    >
<!ENTITY % field  "field"    >
<!ENTITY % minor  "minor"    >

<!ENTITY % program.content
  "((%school;),
    (%degree;),
    (%field;)?,
    (%minor;)?,
    (%datefrom;),
    (%dateto;))" >

<!ENTITY % program.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  program %program.content;>
<!ATTLIST  program %program.attributes;>


<!-- ===============
      Awards
     =============== -->

<!ENTITY % award "award" >

<!ENTITY % awards.content
  "((%award;)*)" >

<!ENTITY % awards.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  awards %awards.content;>
<!ATTLIST  awards %awards.attributes;>

<!-- ===============
      award
     =============== -->

<!ENTITY % issuedby  "issuedby"    >
<!ENTITY % dateissued  "dateissued"    >
<!ENTITY % achievement  "achievement"    >

<!ENTITY % award.content
  "((%title;),
    (%issuedby;),
    (%dateissued;),
    (%achievement;)?)" >

<!ENTITY % award.attributes
  "%id-atts;
   %localization-atts;
   outputclass CDATA #IMPLIED" >

<!ELEMENT  award %award.content;>
<!ATTLIST  award %award.attributes;>


<!-- ===============
      Phrase data
     =============== -->

<!ENTITY % countrycode.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % number.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % name.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % email.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % linkedin.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % website.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % specialty.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % techcategory.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % techcategorylist.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % organization.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % location.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % jobtitle.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % datefrom.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % dateto.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % accomplishment.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % school.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % degree.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % field.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % minor.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % issuedby.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % dateissued.content "( #PCDATA | %basic.ph; )*" >
<!ENTITY % achievement.content "( #PCDATA | %basic.ph; )*" >

<!ENTITY % countrycode.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % number.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % name.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % email.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % linkedin.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % website.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % specialty.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % techcategory.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % techcategorylist.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % organization.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % location.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % jobtitle.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % datefrom.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % dateto.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % accomplishment.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED %jobrole-d-attribute;" >
<!ENTITY % school.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % degree.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % field.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % minor.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % issuedby.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % dateissued.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % achievement.attributes  "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >

<!ELEMENT name %name.content; >
<!ELEMENT countrycode %countrycode.content; >
<!ELEMENT number %number.content; >
<!ELEMENT email %email.content; >
<!ELEMENT linkedin %linkedin.content; >
<!ELEMENT website %website.content; >
<!ELEMENT specialty %specialty.content; >
<!ELEMENT techcategory %techcategory.content; >
<!ELEMENT techcategorylist %techcategorylist.content; >
<!ELEMENT organization %organization.content; >
<!ELEMENT location %location.content; >
<!ELEMENT jobtitle %jobtitle.content; >
<!ELEMENT datefrom %datefrom.content; >
<!ELEMENT dateto %dateto.content; >
<!ELEMENT accomplishment %accomplishment.content; >
<!ELEMENT school %school.content; >
<!ELEMENT degree %degree.content; >
<!ELEMENT field %field.content; >
<!ELEMENT minor %minor.content; >
<!ELEMENT issuedby %issuedby.content; >
<!ELEMENT dateissued %dateissued.content; >
<!ELEMENT achievement %achievement.content; >

<!ATTLIST countrycode %countrycode.attributes; >
<!ATTLIST number %number.attributes; >
<!ATTLIST name %name.attributes; >
<!ATTLIST email %email.attributes; >
<!ATTLIST linkedin %linkedin.attributes; >
<!ATTLIST website %website.attributes; >
<!ATTLIST specialty %specialty.attributes; >
<!ATTLIST techcategory %techcategory.attributes; >
<!ATTLIST techcategorylist %techcategorylist.attributes; >
<!ATTLIST organization %organization.attributes; >
<!ATTLIST location %location.attributes; >
<!ATTLIST jobtitle %jobtitle.attributes; >
<!ATTLIST datefrom %datefrom.attributes; >
<!ATTLIST dateto %dateto.attributes; >
<!ATTLIST accomplishment %accomplishment.attributes; >
<!ATTLIST school %school.attributes; >
<!ATTLIST degree %degree.attributes; >
<!ATTLIST field %field.attributes; >
<!ATTLIST minor %minor.attributes; >
<!ATTLIST issuedby %issuedby.attributes; >
<!ATTLIST dateissued %dateissued.attributes; >
<!ATTLIST achievement %achievement.attributes; >


<!-- =======================================
      SPECIALIZATION ATTRIBUTE DECLARATIONS
     ======================================= -->
  
<!ATTLIST  resume            %global-atts;  class CDATA "- topic/topic  resume/resume ">
<!ATTLIST  resumebody        %global-atts;  class CDATA "- topic/body   resume/resumebody ">
<!ATTLIST  name              %global-atts;  class CDATA "- topic/title  resume/name ">
<!ATTLIST  header            %global-atts;  class CDATA "- topic/abstract  resume/header ">
<!ATTLIST  description       %global-atts;  class CDATA "- topic/shortdesc  resume/description " %jobrole-d-attribute;>
<!ATTLIST  contact           %global-atts;  class CDATA "- topic/ul  resume/contact ">
<!ATTLIST  phone             %global-atts;  class CDATA "- topic/li  resume/phone ">
<!ATTLIST  countrycode       %global-atts;  class CDATA "- topic/ph  resume/countrycode ">
<!ATTLIST  number            %global-atts;  class CDATA "- topic/ph  resume/number ">
<!ATTLIST  email             %global-atts;  class CDATA "- topic/li  resume/email ">
<!ATTLIST  linkedin          %global-atts;  class CDATA "- topic/li  resume/linkedin ">
<!ATTLIST  website           %global-atts;  class CDATA "- topic/li  resume/website ">
<!ATTLIST  summary           %global-atts;  class CDATA "- topic/section  resume/summary " spectitle CDATA "st_summary">
<!ATTLIST  specialties       %global-atts;  class CDATA "- topic/ul  resume/specialties " spectitle CDATA "st_specialties">
<!ATTLIST  specialty         %global-atts;  class CDATA "- topic/li  resume/specialty " %jobrole-d-attribute;>
<!ATTLIST  technologies      %global-atts;  class CDATA "- topic/dl  resume/technologies " spectitle CDATA "st_technologies">
<!ATTLIST  technology        %global-atts;  class CDATA "- topic/dlentry  resume/technology " %jobrole-d-attribute;>
<!ATTLIST  techcategory      %global-atts;  class CDATA "- topic/dt  resume/techcategory ">
<!ATTLIST  techcategorylist  %global-atts;  class CDATA "- topic/dd  resume/techcategorylist ">
<!ATTLIST  experience        %global-atts;  class CDATA "- topic/section  resume/experience " spectitle CDATA "st_experience">
<!ATTLIST  positions         %global-atts;  class CDATA "- topic/ul  resume/positions ">
<!ATTLIST  position          %global-atts;  class CDATA "- topic/li  resume/position ">
<!ATTLIST  accomplishments   %global-atts;  class CDATA "- topic/ul  resume/accomplishments ">
<!ATTLIST  accomplishment    %global-atts;  class CDATA "- topic/li  resume/accomplishment ">
<!ATTLIST  organization      %global-atts;  class CDATA "- topic/ph  resume/organization " >
<!ATTLIST  location          %global-atts;  class CDATA "- topic/ph  resume/location " >
<!ATTLIST  jobtitle          %global-atts;  class CDATA "- topic/ph  resume/jobtitle " >
<!ATTLIST  datefrom          %global-atts;  class CDATA "- topic/ph  resume/datefrom " >
<!ATTLIST  dateto            %global-atts;  class CDATA "- topic/ph  resume/dateto " >
<!ATTLIST  education         %global-atts;  class CDATA "- topic/section  resume/education " spectitle CDATA "st_education">
<!ATTLIST  program           %global-atts;  class CDATA "- topic/p  resume/program " >
<!ATTLIST  school            %global-atts;  class CDATA "- topic/ph  resume/school " >
<!ATTLIST  degree            %global-atts;  class CDATA "- topic/ph  resume/degree " >
<!ATTLIST  field             %global-atts;  class CDATA "- topic/ph  resume/field " >
<!ATTLIST  minor             %global-atts;  class CDATA "- topic/ph  resume/minor " >
<!ATTLIST  awards            %global-atts;  class CDATA "- topic/section  resume/awards " spectitle CDATA "st_awards">
<!ATTLIST  award             %global-atts;  class CDATA "- topic/p  resume/award " >
<!ATTLIST  issuedby          %global-atts;  class CDATA "- topic/ph  resume/issuedby " >
<!ATTLIST  dateissued        %global-atts;  class CDATA "- topic/ph  resume/dateissued " >
<!ATTLIST  achievement       %global-atts;  class CDATA "- topic/ph  resume/achievement " >
