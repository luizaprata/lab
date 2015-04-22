#include <iostream>
#include <vector>
#include <string>
#include <fstream>


using namespace std;

class Animal {
	private: 
		int height;
		int weight;
		string name;

		static int numOfAnimals;

	public:
		int getHeight(){return height;}
		void setHeight(int cm){height = cm;}
		int getWeight(){return weight;}
		void setWeight(int kg){ weight = kg; }
		string getName() {return name;}
		void setName(string p_name) { name = p_name;}

		// void setAll(int, int, string);

		void getFamily(){
			cout << "family animal" << endl;
		}

		virtual void getClass() { cout << "class animal" << endl; } //virtual method => subclasses can overwritte this method

		Animal(int, int, string);
		Animal(); // you  can overwrite contructor, passing others parameters

		~Animal(); // Destructor

		static int getNumOfAnimals(){ return numOfAnimals; }

		void toString();



};

// :: refers to static variables
int Animal::numOfAnimals = 0;

// void Animal::setAll(int height, int weight, string name) { // both does the same // method or contructor
Animal::Animal(int height, int weight, string name) {
	this -> height = height;
	this -> weight = weight;
	this -> name = name;
	Animal::numOfAnimals++;
}

Animal::Animal() {
	Animal::numOfAnimals++;
}

Animal::~Animal() {
	cout << "Animal " << this -> name << " is destroyed!!!" << endl;
}

void Animal::toString() {
	cout << this -> name << " is " << this -> height << "cm tall and " << this -> weight << "kg in weight."<< endl;
}


class Cat : public Animal {

	private:
		string sound;

	public:
		string getSound(){return sound;}
		
		Cat(int, int, string, string);
		Cat() : Animal(){};
		void toString();
		void getClass(){ cout << "I am cat!" << endl;}
};

Cat::Cat(int height, int weight, string name, string p_sound) :
Animal ( height, weight, name) {
	this -> sound = p_sound;
}



void Cat::toString(){
	// cout << this -> getName() << endl;
	cout << this -> getName() << " is " << this -> getHeight() << "cm tall and " << this -> getWeight() << "kg in weight and sounds" << this -> sound<< endl;
}

////////////////////////

void whatClassAreYou(Animal *animal) {
	animal -> getClass();
}



int randInt(int min = 0, int max = 100) {
	return (rand()%100) + 1;
}

int getFactorial(int num) {

	int sum;

	if(num == 1) sum = 1;
	else sum = getFactorial(num-1)*num;
	return sum;

}

void makeMeYounger(int* age) {
	cout << "I used to be " << *age;
	*age = 10;
}

int main(){
	cout << "HELLO WORLD" << endl;

	const double PI = 3.14;

	char myGrade = 'A';

	bool isHappy = false;

	int age = 29;

	float favNum = 2.566;

	double otherfavNum = 1.343343;

	cout << "FAV NUM: " << favNum << endl;
	cout << "SIZE OF INT: " << sizeof(age) << endl;

	cout << "5/4 = " << 5/4 << endl;
	cout << "5/4 = " << (float)5/4 << endl;

	int greetings = 2;

	switch (greetings) {
		case 1:
			cout << "bom dia" << endl;
			break;

		case 2:
			cout << "bonjour" << endl;
			break;

		default:
			cout << "good morning" << endl;
	}

	int largest = (5<6) ? 6 : 5;
	cout << "largest: " << largest << endl;

	//arrays

	int myFavNums[5];
	int badNums[5] = {1,13,14, 24,34};
	char myName[2][6] = {{'L','u','i','z','a', ' '},
						{'P','r','a','t','a'}};


	cout << "myName : " << myName[1][0] << endl;
	cout << "badNums 1: " << badNums[0] << endl;
	cout << "sizeof:" << sizeof(myName[0]) << endl;

	for(int i = 0; i<2; i++) {

		for(int j = 0; j<6; j++) {
			cout << myName[i][j];
		}
		
		cout << endl;
	}


	//random //what rand() does is use an algorithm to generate a random number. The problem is that the algorithm is always the same, so the random number generated is always the same.//What you need is a way to "seed" that algorithm with a different number each time, so that rand() will generate a different number.
	
	srand(time(0));
	int randNum = randInt();
	cout << 'rand' << randNum << endl;

	// while(randNum != 100) {
	// 	cout << randNum << "-";
	// 	randNum = randInt();
	// }
	// cout << endl;


	// do while

	string strNumberGuessed = "";
	int numberGuessed = 0;

	// do {
	// 	cout << "Guess 1-10: ";
	// 	getline(cin, strNumberGuessed);
	// 	numberGuessed = stoi(strNumberGuessed); //convert string to int /// stod convert string to double
	// 	cout << numberGuessed << endl;
	// } while(numberGuessed != 4);

	cout << "You win!!" << endl;

	


	// concat

	char happy[6] = {'H','H','H','H','H','\0'};
	string birthday = "Birthday";

	cout << happy + birthday << endl;



	cout << "is birthday empty?" << birthday.empty() << endl; // 0 means false
	cout << "birthday size?" << birthday.size() << endl; 



	// compare strings

	string cat1 = "frida";
	string cat2 = "sam";
	cout << cat1.compare(cat2) << endl; // if equal return 0


	string name = "Lucas Andrade";
	string testName = name.assign(name, 0,4);
	cout << testName << endl;

	int lastNameIdx = name.find("Andrade", 0);
	cout << "Index last name: " << lastNameIdx << endl;

	name.insert(name.size(), " da Silva");

	name.erase(0,1);
	name.replace(0,3,"L");

	cout << "name: " << name << endl;


	//vector, like array but size can change

	vector <int> lotteryVector(10);

	int lotteryArray[6] = {4,13,27,34,39,41};

	lotteryVector.insert(lotteryVector.begin(), lotteryArray, lotteryArray+3);

	cout << "lottery :: " << lotteryVector.at(3) << endl;

	lotteryVector.push_back(64);

	cout << "Final Value :: " << lotteryVector.back() << endl;

	lotteryVector.pop_back();

	cout << "First Value :: " << lotteryVector.front() << endl;

	cout << "Size :: " << lotteryVector.size() << endl;

	cout << "Is Empty? :: " << lotteryVector.empty() << endl;
	

	cout << "getFactorial 3 :: " << getFactorial(3) << endl;



	// READING DATA

	string quote = "Petequinho quando nasce, esparrama pelo chao";

	ofstream writer("quote.txt");

	if (!writer){ // writer is a variable (?)
		cout << "Error opening file" << endl;
		return -1;
	} else {
		writer << quote << endl;
		writer.close();
	}

	ofstream writer2("quote.txt", ios::app); // append to the end of the file
	if (!writer2){ // writer is a variable (?)
		cout << "Error opening file" << endl;
		return -1;
	} else {
		writer2 << "\nkiiii" << endl;
		writer2.close();
	}

	char letter;

	ifstream reader("quote.txt");

	if (!reader) {
		cout << "Error opening file" << endl;
		return -1;
	} else {
		for (int i = 0; !reader.eof(); i++) {// read each char of the file until reach the end // eof = end of the file
			reader.get(letter);
			cout << letter;
		}

		cout << endl;

		reader.close();
	}
	// ios::app : Open a stream to append to whats there 
	// ios::binary : treat file as binary
	// ios::in : open file to read input
	// ios::trunk : default
	// ios::out : open file to write output



	// POINTER

	int myAge = 29;

	int* agePointer = &myAge;

	cout << "Address of pointer address : " << agePointer << endl;
	cout << "Data at memory address : " << *agePointer << "//" << myAge << endl;

	int* numArrayPointer = badNums;


	cout << "Address" << numArrayPointer << " value " << *numArrayPointer << endl;

	makeMeYounger(&myAge);
	cout << "I'm " << myAge << " years old now." << endl;

	int& ageRef = myAge;

	cout << "my age :: " << myAge << endl;

	// classes


	Animal fred;
	fred.setHeight(33);
	fred.setWeight(10);
	fred.setName("Fred");

	fred.toString();

	Animal tom(12, 2, "Tom");
	tom.toString();

	Cat frida(40, 3, "Frida", "Meow");
	frida.toString();
	frida.Animal::toString(); // :: = scope operator

	Animal *animal = new Animal;
	Cat *cat = new Cat;

	animal->getClass();
	cat->getClass();

	whatClassAreYou(animal);
	whatClassAreYou(cat);


	return 0;
}
