#include <Wt/WServer>
#include <Wt/WResource>
#include <Wt/Http/Response>
#include <iostream>
#include <string>
#include <regex>
#include "json/value.h"
#include "json/reader.h"

using namespace std;

class MyResource : public Wt::WResource{
    public:
        MyResource(){};
        virtual ~MyResource(){};
    protected:
        virtual void handleRequest(const Wt::Http::Request&, Wt::Http::Response&) override ;
};


//Input handler
void MyResource::handleRequest(const Wt::Http::Request& parsed, Wt::Http::Response& response){

    //read data recieved and convert to string
    int length = parsed.contentLength();
    char* buffer=new char[length+1];
    parsed.in().read(buffer, length);
    buffer[length]=0;
    string input =buffer;
    delete []buffer;

    //read json variables and test for consistency
    std::stringstream sstr( input );
    Json::Value root;
    try {
        sstr >> root;
        auto macaddress = root["mac"].asString();
        regex isMac("[0-9A-F]\\{2\\}\\(:[0-9A-F]\\{2\\}\\)\\{5\\}", regex::grep);
        if(!regex_match(macaddress, isMac)){
            response.out() << "no valid mac" << endl;
            return;
        }
        auto  bootstate = root["boot"].asInt();
        if(bootstate!=1 && bootstate!=0){
            response.out() << "no valid bootstate" << endl;
            return;
        }
        cout << endl << "macaddress= " << macaddress  << "\t bootstate= " << bootstate << endl;
 
        //Response to node if data are fine  
        response.out() << "data recieved" << endl; 
	std:string command= "/home/root/rest_server/change_boot.sh " + macaddress + " " + std::to_string(bootstate); 
        int  sysout = std::system(command.c_str());
        response.out() << "Boot changed: " << sysout  << endl;

    }catch ( ... ) {
        response.out() << "Expected was a json string: '{\"mac\": 00:00:00:00:00:00, \"boot\": 0^1;}'" << endl;
        return;    
    }
}



int main(int argc, char **argv){
    using namespace Wt;

    //start rest server and call handler

    Wt::WServer server(argv[0], "");
    server.setServerConfiguration(argc, argv);
    MyResource r;
    server.addResource(&r, "/node_return"); 
    if (server.start()) {
        cout << endl << "server started" << endl;
        WServer::waitForShutdown();
        server.stop();
    }
    else{
        cout << endl << "Fatal error starting resource server." << endl;
        return 1;
    }

    return 0;
}

