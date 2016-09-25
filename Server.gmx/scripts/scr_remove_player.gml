var buffer = argument[0];
var socket = argument[1];
//update players that client left
var size = 1024;
var type = buffer_fixed;
var alignment = 1;
bufferReply = buffer_create(size, type, alignment);

buffer_seek(bufferReply, buffer_seek_start, 0);
buffer_write(bufferReply, buffer_u8, 97);   //97
var size = ds_list_size(socketList);

for(var i = 0; i < size; i++)
{
    var testSocket = ds_list_find_value(socketList, i); 
    if(testSocket != socket)
    {
        network_send_packet(testSocket, bufferReply, buffer_tell(bufferReply));
    }
}
