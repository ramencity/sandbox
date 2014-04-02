Feature: 

  As a Monsoon guy
  I want to do some math
  So I can test cucumber.
	
	Scenario Outline:  
	  Given <input a> and <input b>
	  When they are numbers
	  Then we add them
	  And the result matches my <expectation>
	  
	Examples:
    |input a|input b|expectation|
	| 1 | 1 | 2 |