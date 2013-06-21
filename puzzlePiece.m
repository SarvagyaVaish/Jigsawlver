classdef puzzlePiece < handle

   properties
      Image
      Corners
	  PositionInSolution
      UpPosition
      DownPosition
      LeftPosition
      RightPosition
   end
    
   methods
      function piece = puzzlePiece(Image)
         if nargin > 0
            piece.Image = Image;
         end
      end
      
%       function insertBefore(newNode, nodeAfter)
%       % insertBefore  Inserts newNode before nodeAfter.
%          disconnect(newNode);
%          newNode.Next = nodeAfter;
%          newNode.Prev = nodeAfter.Prev;
%          if ~isempty(nodeAfter.Prev)
%              nodeAfter.Prev.Next = newNode;
%          end
%          nodeAfter.Prev = newNode;
%       end
      
   end % methods
end % classdef