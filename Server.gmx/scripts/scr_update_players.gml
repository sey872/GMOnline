var socket = argument[0];
//update players that client joined
var size = 1024;
var type = buffer_fixed;
var alignment = 1;
bufferReply = buffer_create(size, type, alignment);

buffer_seek(bufferReply, buffer_seek_start, 0);
buffer_write(bufferReply, buffer_u8, 98);   //98
buffer_write(bufferReply, buffer_u32, ds_list_size( socketList));   //98 currentplayers
var size = ds_list_size(socketList);

for(var i = 0; i < size; i++)
{
    var testSocket = ds_list_find_value(socketList, i); 
    network_send_packet(testSocket, bufferReply, buffer_tell(bufferReply));
}
