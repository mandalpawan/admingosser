

class AddServices{
  int total = 0;

  int add(int quantity, int price){
    total += quantity*price;
    return total;
  }

}