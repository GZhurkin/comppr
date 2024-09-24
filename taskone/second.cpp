#include <iostream>


void twoArr(int A[], int sizeA, int B[], int sizeB) {
    bool found;
    std::cout << "Indexes A, not foynd in B B:\n";
    for (int i = 0; i < sizeA; i++) {
        found = false;
        for (int j = 0; j < sizeB; j++) {
            if (A[i] == B[j]) {
                found = true;
                break;
            }
        }
        if (!found) {
            std::cout << "El A[" << i << "] = " << A[i] << " not in B\n";
        }
    }
}

int smI(int* arr, int n)
{
	int sm = 0;
	for (int i = 0; i < n; ++i)
	{
		if (!(arr[i]&1)&&(!(i&1)))
			sm+=arr[i];
	}
	return sm;
}