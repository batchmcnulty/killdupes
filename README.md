# killdupes
Uniquifier which ignores trailing whitespace and cr/lf mismaches.

One of the most frustrating problems with dealing with large quantities of text data, such as wordlists and Nmap reports, is how hard it is to get rid of duplicate lines. The "uniq" command doesn't really work at all, and while "sort" is pretty good, there's always a trailing whitespace, usually just a " " but sometimes a rogue tab or a Windows-style CR/LF or something daft like that which stops you from actually eliminating every duplicate line. 

# killdupes 
just kills duplicate lines. Dead. It chops off the CR and CR/LFs at the end and destroys trailing whitespace. Then it searches for duplicate lines and destroys them. THen prints a text file full of guaranteed unique lines of text. Simple!
