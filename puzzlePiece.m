classdef puzzlePiece < handle
	
	properties
		Image
		ImageRGB
		ImageBW
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
		
		function show_image(p)
			imshow(p.Image)
			hold on
			for i = 1:size(p.Corners, 1)
				plot(p.Corners(i, 1), p.Corners(i, 2), 'or', 'MarkerSize', 10);
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