# tutorial-network

Based on: https://hyperledger.github.io/composer/latest/tutorials/developer-tutorial.html

### Start Fabric 
    cd fabric-dev-servers
    ./startFabric.sh

### Create Archive
Go back to `tutorial-network`

    composer archive create -t dir -n .
    
### Install 

    composer network install --card PeerAdmin@hlfv1 --archiveFile tutorial-network@0.0.1.bna
### Start

    composer network start --networkName tutorial-network --networkVersion 0.0.1 --networkAdmin admin --networkAdminEnrollSecret adminpw --card PeerAdmin@hlfv1 --file networkadmin.card
Make sure you use the right network version
### Check
    composer network ping --card admin@tutorial-network

### Generating (starting) Rest Server
    composer-rest-server
Network card to use: `admin@tutorial-network`


### Starting fronted app
    cd angular-app && npm start

### Open
    localhost:4200
