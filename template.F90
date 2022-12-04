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

            iFile = 1
            line_number = 0

            open (iFile, file=INPUT_FILE, action="read")

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
                write(*, *) "file_line_data was ", file_line_data
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
    integer :: file_data_length

    ! Read the file into the array
    call read_file(file_data, file_data_length)

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ! Your code goes below here

    ! Remember to free your memory
    deallocate (file_data)

end program main
