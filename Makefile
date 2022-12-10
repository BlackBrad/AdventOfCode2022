# Fortran compilaion options
FC = gfortran
FFLAGS = -Wall -Wno-unused-variable -g -fcheck=all -cpp
FILE_NAME = 'main.F90'

# COBOL complication options
COC = cobc
COCFLAGS = -free

all:
	$(FC) $(FFLAGS) hello_world_examples/hello.f90 -o hello_f90
	$(COC) $(COCFLAGS) -x hello_world_examples/hello.cob -o hello_cob

	$(FC) $(FFLAGS) day1/$(FILE_NAME) $(REAL_SET) -o day1_f90
	$(FC) $(FFLAGS) day2/$(FILE_NAME) $(REAL_SET) -o day2_f90
	$(FC) $(FFLAGS) day3/$(FILE_NAME) $(REAL_SET) -o day3_f90

clean:
	rm *_f90
	rm *.mod
	rm *_cob
