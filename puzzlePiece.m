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
			plot(p.Corners(1, 1), p.Corners(1, 2), 'or', 'MarkerSize', 10);
			plot(p.Corners(2, 1), p.Corners(2, 2), 'or', 'MarkerSize', 10);
			plot(p.Corners(3, 1), p.Corners(3, 2), 'or', 'MarkerSize', 10);
			plot(p.Corners(4, 1), p.Corners(4, 2), 'or', 'MarkerSize', 10);
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