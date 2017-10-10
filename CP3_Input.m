
function [x] = CP3_Input(type)
%   *-------------------------------------------------------------------*
%   |  Function to create vertex array 'x' for different geometric      |
%   |  shapes, specified by the input variable 'type'.                  |
%   |  Note that the vertices of each enclosed area must be numbered    |
%   |  sequentially with positive areas numbered counterclockwise and   |
%   |  negative areas numbered clockwise (for cutouts).                 |
%   *-------------------------------------------------------------------*

%... Check to make sure the cross section type requested is in the list
     maxNumTypes = 3;
     if (type < 1) || (type > maxNumTypes)
         fprintf('\n%s%3i,%s',' Error. Type',type,' not found.')
         fprintf('%s\n',' Defaulting to type 1.')
         type = 1;
     end
     
%... Execute the creation of 'x' based upon variable 'type'     
     switch type
         
       case 1  % Rectangle
         width = 2; height = 5;
         x = [ 0,     0;
               width, 0;
               width, height;
               0,     height;
               0,     0];    

       case 2   % Hollow Rectanglular tube
         width = 2; height = 5; tf = 0.5; tw = 0.5;
         x = [ 0,          0;
               width,      0;
               width,      height;
               0,          height;
               0,          0;
               tw,         tf;
               tw,         height-tf;
               width-tw,   height-tf;
               width-tw,   tf;
               tw,         tf;
               0,          0;]; 

       case 3  % Equal Angle L-shape
         t = 25; b = 200;
         x = [0, 0;
              b, 0;
              b, t;
              t, t;
              t, b;
              0, b;
              0, 0];
                    
     end % switch
    
%... End of function CP3_Input
