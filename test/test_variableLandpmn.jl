# A simple example of divand in 2 dimensions
# with observations from an analytical function.

using divand
using Base.Test

# observations
x = [2  3  4];
y = [2  3  4];
f=ones(3)

# final grid
xi,yi = ndgrid(linspace(0,6,15),linspace(0,5,15));


# all points are valid points
mask = trues(xi);

# this problem has a simple cartesian metric
# pm is the inverse of the resolution along the 1st dimension
# pn is the inverse of the resolution along the 2nd dimension

pm = ones(xi) / (xi[2,1]-xi[1,1]);
pn = ones(xi) / (yi[1,2]-yi[1,1]);

# correlation length
len = 1;

# obs. error variance normalized by the background error variance
epsilon2 = 1.;

# fi is the interpolated field
fireg,s = divandrun(mask,(pm,pn),(xi,yi),(x,y),f,len,epsilon2);

sampler1=divand_sampler((pm,pn),len)

@test sampler1==[1,1]
@test 0.59 < maximum(fireg) < 0.7

fis,s = divandrun(mask,(pm,pn),(xi,yi),(x,y),f,(len*0.5,len*1.5),epsilon2);

sampler1=divand_sampler((pm,pn),(len*0.5,len*1.5))

@test sampler1==[1,1]
@test 0.59 < maximum(fis) < 0.7

pm=ones(xi)./((1+xi/5).*(xi[2,1]-xi[1,1]));
pn=ones(yi)./((1+yi/5).*(yi[1,2]-yi[1,1]));

lx=0.5+xi/5
ly=0.5+yi/5

finu,s = divandrun(mask,(pm,pn),(xi,yi),(x,y),f,(ly,lx),epsilon2);


sampler1=divand_sampler((pm,pn),(lx,ly))

@test sampler1==[1,1]
@test 0.63 < maximum(finu) < 0.7




# Copyright (C) 2014, 2017 Alexander Barth <a.barth@ulg.ac.be>
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
