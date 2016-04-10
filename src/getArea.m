function area = getArea(pks_loca,local_mm)
    area = [];
    for i = 1:size(pks_loca,1)
        ind = pks_loca{i,5};

        Lmin = local_mm{ind,1};
        Lmax = local_mm{ind+1,1};
        Lmin1 = local_mm{ind+2,1};

        xmin = local_mm{ind,2};
        xmax = local_mm{ind+1,2};
        xmin1 = local_mm{ind+2,2};

        a = sqrt((Lmax-Lmin)^2+(xmax-xmin)^2);
        b = sqrt((Lmin1-Lmax)^2+(xmin1-xmax)^2);
        c = sqrt((Lmin1-Lmin)^2+(xmin1-xmin)^2);
        s = (a+b+c)/2;
        area(i,1) = sqrt(s*(s-a)*(s-b)*(s-c));
    end
end