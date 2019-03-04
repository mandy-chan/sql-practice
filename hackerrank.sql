/* Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.

where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
Note: There will be at least two entries in the table for each type of occupation. */

SELECT CONCAT(o.Name, '(', SUBSTRING(o.Occupation,1, 1), ')')
FROM occupations o
ORDER BY o.Name;

# CONCAT(string1, string2, string3...)
# SUBSTRING(____, initial position, extracting_length)

SELECT 'There are a total of', COUNT(o.Occupation), CONCAT(LOWER(o.Occupation),'s.')
FROM occupations o
GROUP BY o.Occupation
ORDER BY COUNT(o.Occupation), o.Occupation;



