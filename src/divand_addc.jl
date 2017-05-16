# Add a constraint to the cost function.
#
# s = divand_addc(s,constrain)
#
# Include in the structure s the specified constrain.
#
# Input:
#   s: structure created by divand_background
#   constrain: The parameter constrain has the following fields: R (a covariance
#     matrix), H (extraction operator) and yo (specified value for the
#     constrain).
#
# Output:
#   s: structure to be used by divand_factorize


function divand_addc(s,constrain)
    if isempty(s.H)
        s.H = constrain.H;
        s.R = constrain.R;
        s.yo = constrain.yo;
    else
        s.H = cat(1,s.H,constrain.H);
        s.R = blkdiag(s.R,constrain.R);
        s.yo = cat(1,s.yo,constrain.yo);
    end
    return s
end

# Copyright (C) 2014,2017 Alexander Barth <a.barth@ulg.ac.be>
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <http://www.gnu.org/licenses/>.
