FC = gfortran-7
FLAGS = -Wall -Wno-unused-variable -g -fcheck=all -cpp
FILE_NAME = 'main.F90'

default:
	$(FC) $(FLAGS) day1/$(FILE_NAME) -o day1_f90
	$(FC) $(FLAGS) day2/$(FILE_NAME) -o day2_f90

clean:
	rm *.out
	rm *_f90
	rm *.mod
