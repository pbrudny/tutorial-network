#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Feature: Sample

    Background:
        Given I have deployed the business network definition ..
        And I have added the following participants of type org.example.mynetwork.Trader
            | tradeId         | firstName | lastName |
            | alice@email.com | Alice     | A        |
            | bob@email.com   | Bob       | B        |
        And I have added the following assets of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 1             | alice@email.com | 10       | good        | abcExc       |
            | 2             | bob@email.com   | 20       | bad         | defExc       |
        And I have issued the participant org.example.mynetwork.Trader#alice@email.com with the identity alice1
        And I have issued the participant org.example.mynetwork.Trader#bob@email.com with the identity bob1

    Scenario: Alice can read her own assets only
        When I use the identity alice1
        Then I should have the following assets of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 1             | alice@email.com | 10       | good        | abcExc       |

    Scenario: Bob can read only his assets
        When I use the identity bob1
        Then I should have the following assets of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 2             | bob@email.com   | 20       | bad         | defExc       |

    Scenario: Alice can add assets that she owns
        When I use the identity alice1
        And I add the following asset of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 3             | alice@email.com | 15       | good        | abcExc       |
        Then I should have the following assets of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 3             | alice@email.com | 15       | good        | abcExc       |

    Scenario: Alice cannot add assets that Bob owns
        When I use the identity alice1
        And I add the following asset of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 4             | bob@email.com   | 15       | good        | abcExc       |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Bob can add assets that he owns
        When I use the identity bob1
        And I add the following asset of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 4             | bob@email.com   | 15       | good        | abcExc       |
        Then I should have the following assets of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 4             | bob@email.com   | 15       | good        | abcExc       |

    Scenario: Bob cannot add assets that Alice owns
        When I use the identity bob1
        And I add the following asset of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 3             | alice@email.com | 15       | good        | abcExc       |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Alice can update her assets
        When I use the identity alice1
        And I update the following asset of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 1             | alice@email.com | 40       | very good   | turboExch    |
        Then I should have the following assets of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 1             | alice@email.com | 40       | very good   | turboExch    |
    Scenario: Alice cannot update Bob's assets
        When I use the identity alice1
        And I update the following asset of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 2             | bob@email.com   | 20       | terrible    | defExc       |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Bob can update his assets
        When I use the identity bob1
        And I update the following asset of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 2             | bob@email.com   | 25       | bad         | defExc       |
        Then I should have the following assets of type org.example.mynetwork.Commodity
            | tradingSymbol | owner           | quantity | description | mainExchange |
            | 2             | bob@email.com   | 25       | bad         | defExc       |
#
#    Scenario: Bob cannot update Alice's assets
#        When I use the identity bob1
#        And I update the following asset of type org.example.mynetwork.Commodity
#            | assetId | owner           | value |
#            | 1       | alice@email.com | 60    |
#        Then I should get an error matching /does not have .* access to resource/
#
#    Scenario: Alice can remove her assets
#        When I use the identity alice1
#        And I remove the following asset of type org.example.mynetwork.Commodity
#            | assetId |
#            | 1       |
#        Then I should not have the following assets of type org.example.mynetwork.Commodity
#            | assetId |
#            | 1       |
#
#    Scenario: Alice cannot remove Bob's assets
#        When I use the identity alice1
#        And I remove the following asset of type org.example.mynetwork.Commodity
#            | assetId |
#            | 2       |
#        Then I should get an error matching /does not have .* access to resource/
#
#    Scenario: Bob can remove his assets
#        When I use the identity bob1
#        And I remove the following asset of type org.example.mynetwork.Commodity
#            | assetId |
#            | 2       |
#        Then I should not have the following assets of type org.example.mynetwork.Commodity
#            | assetId |
#            | 2       |
#
#    Scenario: Bob cannot remove Alice's assets
#        When I use the identity bob1
#        And I remove the following asset of type org.example.mynetwork.Commodity
#            | assetId |
#            | 1       |
#        Then I should get an error matching /does not have .* access to resource/
#
#    Scenario: Alice can submit a transaction for her assets
#        When I use the identity alice1
#        And I submit the following transaction of type org.example.mynetwork.Trade
#            | asset | newValue |
#            | 1     | 50       |
#        Then I should have the following assets of type org.example.mynetwork.Commodity
#            | assetId | owner           | value |
#            | 1       | alice@email.com | 50    |
#
#    Scenario: Alice cannot submit a transaction for Bob's assets
#        When I use the identity alice1
#        And I submit the following transaction of type org.example.mynetwork.Trade
#            | commodity | newOwner |
#            | 2     | 50       |
#        Then I should get an error matching /does not have .* access to resource/
#
#    Scenario: Bob can submit a transaction for his assets
#        When I use the identity bob1
#        And I submit the following transaction of type org.example.mynetwork.Trade
#            | asset | newValue |
#            | 2     | 60       |
#        Then I should have the following assets of type org.example.mynetwork.Commodity
#            | assetId | owner         | value |
#            | 2       | bob@email.com | 60    |
#
#    Scenario: Bob cannot submit a transaction for Alice's assets
#        When I use the identity bob1
#        And I submit the following transaction of type org.example.mynetwork.Trade
#            | asset | newValue |
#            | 1     | 60       |
#        Then I should get an error matching /does not have .* access to resource/
