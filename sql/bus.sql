      select r.routeid,
                   b.busid,  
                              b.cardid,  
                                         b.busselfid,     
                                                 b.oiltype,      
                                                        b.buydate,     
                                                                b.usedate,  
                                                                           b.buslength,   
                                                                                     b.isactive, 
                                                                                                 b.bustype,  
                                                                                                            b.orgidfrom,             b.seatcount,             b.busstatus        from mcbusinfogs b        join mcrbusroutegs br on b.busid = br.busid        join mcrouteinfogs r on r.routeid = br.routeid        join mcorginfogs o on o.orgid = r.orgid        where rownum <= 50     and o.parentorgid = :p_org_id and b.isactive = :p_is_active