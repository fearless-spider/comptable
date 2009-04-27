#include <iostream>
#include <string>
#include "tableOfSymbols.h"

using namespace std;

void tableOfSymbols::init() {
  tableOfSymbols::addSymbol("_");
}

void tableOfSymbols::addSymbol(string newElement) {
  try {
    if(tableOfSymbols::findSymbol(newElement) == 0) {
      entry temp(newElement);
      inputElement.push_back(temp);
    } else {
      throw 0;
    }
  } catch( int x ) {
    cout << "Element in the table \n\n";
  }
};

int tableOfSymbols::findSymbol(string search) {
  for (int i = inputElement.size() - 1; i > 0; i--) {
    if(inputElement[i].name == search) {
      return i;
    }
  }
  return 0;
};

void tableOfSymbols::setType(int count, int newEntry) {
  for(unsigned int temp = inputElement.size() - 1; temp > inputElement.size() - count - 1; temp--) {
    inputElement[temp].type = newEntry;
  }
};

void tableOfSymbols::setReference(int newEntry) {
  if(newEntry == Reference) {
    inputElement[inputElement.size() - 1].reference = Reference;
  } else if(newEntry == nReference) {
    inputElement[inputElement.size() - 1].reference = nReference;
  }
};

void tableOfSymbols::setScope(int count, int newEntry) {
  for(unsigned int temp = inputElement.size() - 1; temp > inputElement.size() - count - 1; temp--) {
    if(newEntry) {
      inputElement[inputElement.size() - 1 ].scope = newEntry;
    }
  }
};

void tableOfSymbols::setBeginningTable(int count, int newEntry) {
  for(unsigned int temp = inputElement.size() - 1; temp > inputElement.size() - count - 1; temp--) {
    inputElement[temp].beginningTable = newEntry;
  }
};

void tableOfSymbols::setEndTable(int count, int newEntry) {
  for(unsigned int temp = inputElement.size() - 1; temp > inputElement.size() - count - 1; temp--) {
    inputElement[temp].endTable = newEntry;
  }
};

void tableOfSymbols::setTypeTable(int count, int newEntry) {
  for(unsigned int temp = inputElement.size() - 1; temp > inputElement.size() - count - 1; temp--) {
    inputElement[temp].returnType = newEntry;
  }
};

void tableOfSymbols::setParameters(string functionName, int numberOfParameters) {
  int temp = tableOfSymbols::findSymbol(functionName);
  if(temp) {
    inputElement[temp].numberOfParameters = numberOfParameters;
  }
};

void tableOfSymbols::setReturnType(string functionName, int type) {
	int temp = tableOfSymbols::findSymbol(functionName);
	if(temp) {
		inputElement[temp].returnType = type;
	}
}
void tableOfSymbols::printSymbol() {
  unsigned int i;
  cout << "\n Generated the table : \n";
  for (i = 1; i <= inputElement.size() - 1; i++) {
    cout << "\n variable name : \t" << inputElement[i].name;
    switch(inputElement[i].type) {
      case tInt : {
          cout << "\t type INT ";
        }
        break;
      case tReal : {
          cout << "\t type REAL ";
        }
        break;
      case tTable : {
          cout << "\t typ ARRAY ";
        }
        break;
      case tFunction : {
          cout << "\t type FUNCTION";
        }
        break;
      default :
        break;
    }

    switch(inputElement[i].reference) {
      case Reference : {
          cout << "\t reference : YES ";
        }
        break;
      case nReference : {
          cout << "\t reference : NO ";
        }
        break;
      default :
        break;
    }
    
    switch(inputElement[i].type) {
      case tTable : {
          cout << "[" << inputElement[i].beginningTable << ".." << inputElement[i].endTable << "] type ";
          if(inputElement[i].returnType == tInt) {
            cout << "INT";
          } else if(inputElement[i].returnType == tReal) {
            cout << "REAL";
          }
        }
        break;
      case tFunction : {
          cout << "number of parameters " << inputElement[i].numberOfParameters;
          if(inputElement[i].returnType == tInt) {
            cout << "INT";
          } else if(inputElement[i].returnType == tReal) {
            cout << "REAL";
          }
        }
        break;
      default :
        break;
    }
  }
  cout << endl;
};

