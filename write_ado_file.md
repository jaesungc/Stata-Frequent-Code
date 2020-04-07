https://stats.idre.ucla.edu/stata/seminars/stata-programming/

https://data.princeton.edu/stata/programming

https://www.stata.com/manuals13/u18.pdf

http://www.ncer.edu.au/events/documents/QUT15S1.slides.pdf

<br>

### Sample Code: 


#### Programs With No Arguments

```stata
capture program drop myfun
program define myfun
    version 13
    forv i=1/10 {
      display `i'
      }
end

myfun
```
