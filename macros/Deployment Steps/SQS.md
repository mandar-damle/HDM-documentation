# HDM SQS Configuration

HDM is integrated with an SQS (Simple Queue Service from AWS) message bus. HDM **_sqs-python_** is a python-based library that provides an interface to manage and operate  HDM. 

**Client Application** : Clients will be written by a third party and will use the sqs-python library to send HDM command messages and receive responses.

**SQS Messaging Service** :  This service receives command requests from the client and passes them to HDM. The responses are then received from HDM and passed back to the client.

**HDM** : HDM acts as the server for the commands and sends responses. There is also a periodic heartbeat between HDM and the client, for the client to be aware of the server's system state.

![drawing](images/image12.png?classes=content-img)

For third-party integration to work, after deployment the HDM appliance must be configured with the message bus. HDM will then listen and execute operations posted on this bus and send back the status of these operations to the caller. 

Pre-requisites

1. HDM Appliance must be installed before the configuration of HDM SQS.
2. No other step in the HDM deployment should have been performed at this point.
3. User should be ready with the SQS message bus token to be used for the configuration


Steps

1. Access the PrimaryIO appliance via a browser.
2. Log into the appliance using administrator credentials.
3. Visit the vCenter page and select the user profile icon

![alt_text](images/image6.png?classes=content-img "image_tooltip")

4. Select **Configure Message Bus**.
5. Provide the third party's SQS message bus token in the pop-up, then select **Configure.** 

![alt_text](images/image8.png?classes=content-img "image_tooltip")

6. The configured message bus details can be seen. To change the message bus configuration, select **Reconfigure**.

![alt_text](images/image9.jpg?classes=content-img "image_tooltip")

**Note: The PrimaryIO Appliance should have access to the Internet for warm or cold migration through SQS.**
