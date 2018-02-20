----

#### dropdown smallscreen not working on ios browser
- dropdown wasn't working on ios, but worked on small screen in mac chrome browser.
- issue was with position: fixed for header element.  seems like the dropdown could not break out of the header object when header position was set to fixed.
- solution was to change header position to static and adjust padding for app content on devices < 600px

so browser behavior for css attributes is different on chrome ios vs. chrome osx

----