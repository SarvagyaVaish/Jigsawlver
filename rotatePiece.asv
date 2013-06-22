function [rotated_piece] = rotatePiece(piece_to_rotate, angle)


num_rotations = unmatched_edges(best_unmatched_edge_index,1) - mod((edge_to_be_checked(1,2) + 2),4);
if(num_rotations > 0)
    pieces{unmatched_edges(best_unmatched_edge_index,1)}.Image = imrotate(pieces{unmatched_edges(best_unmatched_edge_index,1)}.Image,90*num_rotations);
    Corners = pieces{unmatched_edges(best_unmatched_edge_index,1)}.Corners;
    image_size = size(pieces{unmatched_edges(best_unmatched_edge_index,1)});
    
    switch(num_rotations)
        case 1
            Corners.tl = [(image_size(1,1) - Corners.tl(1,2))    Corners.tl(1,1)]
        case 2
            
        case 3
    end
    
    pieces{unmatched_edges(best_unmatched_edge_index,1)}.Corners = Corners;
end

end