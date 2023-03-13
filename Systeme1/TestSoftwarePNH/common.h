#ifndef COMMON_H
#define COMMON_H

#define TCP_PORT 4242

// messages from sequencer
#define MESSAGE_START_TEST      "START_TEST"
#define MESSAGE_STOP_TEST       "STOP_TEST"
#define GET_PRIMATE_LIST        "GET_PRIMATE_LIST"
//#define SEND_PRIMATE_LIST       "SEND_PRIMATE_LIST"



// messages from test software
#define MESSAGE_CONNECTED       "CONNECTED"


#define SQL_GET_PRIMATE_LIST    "SELECT name,comment FROM Primate"


#endif // COMMON_H
