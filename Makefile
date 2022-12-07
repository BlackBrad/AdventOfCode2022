FC = gfortran-7
FFLAGS = -Wall -Wno-unused-variable -g -fcheck=all -cpp
FILE_NAME = 'main.F90'

all:
	$(FC) $(FFLAGS) day1/$(FILE_NAME) $(REAL_SET) -o day1_f90
	$(FC) $(FFLAGS) day2/$(FILE_NAME) $(REAL_SET) -o day2_f90

clean:
	rm *_f90
	rm *.mod
