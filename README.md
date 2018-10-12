# Lunar Terminator Visualization Tool Source Repository

## October 2018 Update 

Welcome to a fork of the LTVT code base.  LTVT lost their home when wikispaces shut down.  We're getting the content from ltvt.wikispaces.com back up [here](https://github.com/fermigas/ltvt/wiki), and this is a repository of the program's code and binaries.   Our intent is to take LTVT forward, but we don't have a plan yet.  There's some talk of Javascript, Typescript, React and Electron, but we've got a lot to learn about the existing program.  

This isn't the official site, but the original author Jim Mosher was kind enough to provide permission and a huge archive of files (through John Moore on [Cloudy Nights](https://www.cloudynights.com/topic/623894-long-term-status-of-lunar-terminator-visualization-tool/#entry8879915)). 

If you want to get the program or code the [LTVT Program Downloads](https://github.com/fermigas/ltvt/wiki/LTVT%20Download) page has you covered.  

Many resources that can enrich your use of the the program [Downloads](https://github.com/fermigas/ltvt/wiki/Downloads) can be found here.  

If you want to learn how to use LTVT, you can hardly do better than [LTVT-function-details](https://github.com/fermigas/ltvt/wiki/LTVT-function-details).

You can find the source code for older versions by choosing its branch above or by following links from the  [Source Code Archive](https://github.com/fermigas/ltvt/wiki/Download%20Archive#source-code) which contains zipped files of older source code versions.  

This site is a work in progress.  We can't promise help, but we'll try to supply as much as we can to help you help yourself.  Fork to your heart's content.  Pull requests from anyone other than those involved originally with the project won't be accepted until we've got a better idea of how we're going to move forward.     

Here's the text of the original [Readme.txt](https://github.com/fermigas/ltvt/blob/master/ReadMe.txt) file:  

----------------
LTVT Source Code
----------------

A. PURPOSE

The accompanying folders contain the complete source code for the Lunar Terminator Visualization Tool.

This information is being placed online for the benefit of those who may wish to understand more deeply how LTVT works, or to make improvements to the program logic.

In principle the program anyone with a suitable compiler can regenerate the program from these files, but due to the idiosyncrasies of computer systems I can make no guarantee as to how practical this is.  Therefore, the intention is primarily to provide materials suitable for study at the source-code level.

B. CONTENTS

LTVT is written in Borland International's Delphi 6 programming language, and all the files contained herein can be opened with a simple text editor.  They are primarily of two types:

1. *.pas extension:  "units" of hand-written Delphi source code consisting of instructions the computer needs to process to react to user inputs on the screen. Units can call other units.

2. *.dfm extension:  "forms" -- files automatically generated by the Delphi editing environment which specify the layout of controls on the screen when a "unit" has a visible manifestation.

The main program is in a unit called "LTVT_Unit.pas" which has an associated Delphi project file "LTVT.dpr" and a set of compiler directives: LTVT.dof.

The many units (and forms) have been divided into three separate folders because it approximates the way the way the units are divided on my hard drive (the folder "Astro" is actually inside "My Units").  This division is quite arbitrary and essentially meaningless to the compiler -- it only needs to know where to look for the units.

C. POSSIBLE PROBLEMS ON RE-COMPILATION

The main problem that is likely to be encountered is that the LTVT forms visible on the screen make extensive use of a "custom component" (which is actually a component "template") for numeric input.  It is called "LabeledNumericEdit" and can be found in the "My Units" folder.  This component has to be installed in the "Design Palette" before Delphi can successfully compile LTVT.  My understanding of the correct way to do this is extremely vague, but I initially used the "package" called "JimsPackage.dpk" (which as included here also attempts to install some other custom components irrelevant to LTVT).  Once installed, the "LabeledNumericEdit.pas" source code, can, like any other unit, be modified and the changes will be reflected in all forms using it.

D. CONCLUSION

Programming style is quite idiosyncratic, and attempting to make sense of other peoples' code can be extremely difficult and often frustrating.  The present files are presented exactly as written, and may not be understandable to anyone but me; but I sincerely hope they will be of some use.  I would also, of course, appreciate being informed of any serious errors they contain.

Good luck to all those who try to make use of this information!  


Jim Mosher 
March 6, 2008
