#include <iostream>
#include <vector>
#include <string>

using namespace std;

enum {
  NONE,
  tInt,
  tReal,
  tTable,
  tFunction,
  tProcedure,
  Reference,
  nReference
  };
  
struct entry {
  string name;
  int type;
  int reference;
  string addressInMemory;
  int scope;
  int numberOfParameters;
  int returnType;
  int beginningTable;
  int endTable;
  
  entry(string newName) {
    name = newName;
    type = 0;
    reference = 0;
    addressInMemory = "none";
    scope = 0;
    numberOfParameters = 0;
    returnType = 0;
  };
  
  ~entry(){
  };
};

class tableOfSymbols {
  vector <entry> inputElement;
  
  public :
    void init();
    int findSymbol(string);
    void addSymbol(string);
    void printSymbol();
    void setType(int, int);
    void setReference(int);
    void setScope(int, int);
    void setBeginningTable(int, int);
    void setEndTable(int, int);
    void setTypeTable(int, int);
    
    void setParameters(string, int);
    void setReturnType(string, int);
} tableOfSymbols;
