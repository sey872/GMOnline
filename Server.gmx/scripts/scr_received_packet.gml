// scr_received_packet(buffer)
var buffer = argument[0];
var socket = argument[1];
var message_id = buffer_read(buffer, buffer_u8);

switch(message_id)    //mouse click event
{
    case 1:
        var mx = buffer_read(buffer, buffer_u32);
        var my = buffer_read(buffer, buffer_u32);
        instance_create(mx, my, obj_click);
        // Send dot to all other clients
        var size = 1024;
        var type = buffer_fixed;
        var alignment = 1;
        bufferReply = buffer_create(size, type, alignment);
        buffer_seek(bufferReply, buffer_seek_start, 0);
        buffer_write(bufferReply, buffer_u8, 1);         // 1
        buffer_write(bufferReply, buffer_u32, mx);  // 1, xpos
        buffer_write(bufferReply, buffer_u32, my);  // 1, xpos, ypos
        var size = ds_list_size(socketList);
        
        for(var i = 0; i < size; i++)
        {
            var testSocket = ds_list_find_value(socketList, i); 
            if(testSocket != socket)
            {
                network_send_packet(testSocket, bufferReply, buffer_tell(bufferReply));
            }
        }
    break;
}
