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
  "((%description;)?,
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

<!ENTITY % countrycode.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % number.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % name.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % email.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % linkedin.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % website.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % specialty.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % techcategory.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >
<!ENTITY % techcategorylist.attributes "%id-atts; %localization-atts; outputclass CDATA #IMPLIED" >

<!ELEMENT name %name.content; >
<!ELEMENT countrycode %countrycode.content; >
<!ELEMENT number %number.content; >
<!ELEMENT email %email.content; >
<!ELEMENT linkedin %linkedin.content; >
<!ELEMENT website %website.content; >
<!ELEMENT specialty %specialty.content; >
<!ELEMENT techcategory %techcategory.content; >
<!ELEMENT techcategorylist %techcategorylist.content; >

<!ATTLIST countrycode %countrycode.attributes; >
<!ATTLIST number %number.attributes; >
<!ATTLIST name %name.attributes; >
<!ATTLIST email %email.attributes; >
<!ATTLIST linkedin %linkedin.attributes; >
<!ATTLIST website %website.attributes; >
<!ATTLIST specialty %specialty.attributes; >
<!ATTLIST techcategory %techcategory.attributes; >
<!ATTLIST techcategorylist %techcategorylist.attributes; >


<!-- =======================================
      SPECIALIZATION ATTRIBUTE DECLARATIONS
     ======================================= -->
  
<!ATTLIST  resume            %global-atts;  class CDATA "- topic/topic  resume/resume ">
<!ATTLIST  resumebody        %global-atts;  class CDATA "- topic/body   resume/resumebody ">
<!ATTLIST  name              %global-atts;  class CDATA "- topic/title  resume/name ">
<!ATTLIST  header            %global-atts;  class CDATA "- topic/abstract  resume/header ">
<!ATTLIST  description       %global-atts;  class CDATA "- topic/shortdesc  resume/description ">
<!ATTLIST  contact           %global-atts;  class CDATA "- topic/ul  resume/contact ">
<!ATTLIST  phone             %global-atts;  class CDATA "- topic/li  resume/phone ">
<!ATTLIST  countrycode       %global-atts;  class CDATA "- topic/ph  resume/countrycode ">
<!ATTLIST  number            %global-atts;  class CDATA "- topic/ph  resume/number ">
<!ATTLIST  email             %global-atts;  class CDATA "- topic/li  resume/email ">
<!ATTLIST  linkedin          %global-atts;  class CDATA "- topic/li  resume/linkedin ">
<!ATTLIST  website           %global-atts;  class CDATA "- topic/li  resume/website ">
<!ATTLIST  summary           %global-atts;  class CDATA "- topic/section  resume/summary " spectitle CDATA "st_summary">
<!ATTLIST  specialties       %global-atts;  class CDATA "- topic/ul  resume/specialties " spectitle CDATA "st_specialties">
<!ATTLIST  specialty         %global-atts;  class CDATA "- topic/li  resume/specialty ">
<!ATTLIST  technologies      %global-atts;  class CDATA "- topic/dl  resume/technologies " spectitle CDATA "st_technologies">
<!ATTLIST  technology        %global-atts;  class CDATA "- topic/dlentry  resume/technology ">
<!ATTLIST  techcategory      %global-atts;  class CDATA "- topic/dt  resume/techcategory ">
<!ATTLIST  techcategorylist  %global-atts;  class CDATA "- topic/dd  resume/techcategorylist ">

 