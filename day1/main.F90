#define DAY

#ifdef REAL
#define INPUT_FILE "input.txt"
#else
#define INPUT_FILE "example.txt"
#endif

#define FILE_LINE_LENGTH 255

module file_helpers
    contains
        subroutine read_file(file_data, file_data_length)
            character (len=FILE_LINE_LENGTH), pointer :: file_data (:) ! Output
            integer :: file_data_length                                ! Output
            integer :: iFile, ios, line_number

            character (len=FILE_LINE_LENGTH) :: file_name

            iFile = 1
            line_number = 0

            file_name = DAY//INPUT_FILE

            open (iFile, file=file_name, action="read")

            ! Count the number of lines in the file so that we can assign an array size
            call get_file_length(iFile, file_data_length)

            ! Allocate the array
            allocate (file_data(file_data_length))

            ! Put the cursor back to the start of the file
            rewind(iFile)

            ! Populate the array with data
            call read_file_into_array(iFile, file_data, file_data_length)

            close (iFile)

        end subroutine read_file

        subroutine get_file_length(iFile, file_data_length)
            integer :: file_data_length, ios
            character (len=255) :: file_line_data

            file_data_length = 0

            ! Count the number of lines in the file so that we can assign an array size
            do
                read (iFile, "(a)", IOSTAT=ios) file_line_data

                if (ios < 0) then
                    exit
                endif

                file_data_length = file_data_length + 1
            end do

        end subroutine get_file_length

        subroutine read_file_into_array(iFile, array, file_data_length)
            integer :: iFile, array_index, file_data_length, ios
            character (len=FILE_LINE_LENGTH), pointer :: array (:)

            array_index = 1

            iFile = 1

            do i = 1, file_data_length
                read (iFile, "(a)", IOSTAT=ios) array(i)
            end do
        end subroutine read_file_into_array
end module file_helpers

program main
use file_helpers
implicit none
    character (len=FILE_LINE_LENGTH), pointer :: file_data (:)
    integer :: file_data_length, current_calorie_count, largest_count, this_line, i
    integer, dimension(3) :: top_elves
    integer :: top_elves_size, j, current_index

    current_calorie_count = 0
    largest_count = 0
    file_data_length = 0
    top_elves_size = 3

    ! Read the file into the array
    call read_file(file_data, file_data_length)

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ! Your code goes below here
    do i = 1, file_data_length
        if (file_data(i) == "") then
            current_index = 1
            do j = 1, top_elves_size
                ! Get the index with the smallest value
                if (top_elves(j) < top_elves(current_index)) then
                    current_index = j
                end if
            end do

            if (current_calorie_count > top_elves(current_index)) then
                top_elves(current_index) = current_calorie_count
            end if

            current_calorie_count = 0
        else
            ! Convert the character from the array to an integer for addition
            read (file_data(i), *) this_line
            current_calorie_count = current_calorie_count + this_line
            !write (*, *) "Current count: ", current_calorie_count
        end if
    end do

    do i = 1, top_elves_size
        largest_count = largest_count + top_elves(i)
    end do

    print *, largest_count

    ! Remember to free your memory
    deallocate (file_data)

end program main
