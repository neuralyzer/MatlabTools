sleep_time = 1;  % in seconds
z_slize_100 = NumberedFileAndFoldersIterator('C:\Data\foo',...
                                             sleep_time, 1, 1, 'forever', '%06d');
while z_slize_100.items()
    display(z_slize_100.current_item)
    z_slize = NumberedFileAndFoldersIterator(z_slize_100.current_item, sleep_time,...
                                       100*z_slize_100.counter+10, 1,...
                                       100*z_slize_100.counter+99, '%06d');
    while z_slize.items()
        display(z_slize.current_item)
        single_image = RegularExpressionIterator(z_slize.current_item, sleep_time,...
                                                          280, '*.tif');
        while single_image.items()
            display(single_image.current_item)
        end
    end
end