Feature: Valet parking
  Parking lot calculator calculates costs for Valet parking

  Scenario: Calculate Valet Parking cost for half hour
    When I park my car in the Valet Parking Lot for 30 minutes
    Then I will have to pay $12.00
