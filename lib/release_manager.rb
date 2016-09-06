class ReleaseManager

  def self.getObjectForRelease(rel)
    result=""
     oracle = OCI8.new('SIEBEL', 'SIEBEL', 'CRMDB_NEW')



    cursor = oracle.exec("select k.oggetto as NAME, ao.tipo_oggetto as TYPE, y.descrizione as DESCRIPTION,z.nome as RELEASE
                          from siebel.FUNZIONALITA y,siebel.RICHIESTA_RILASCIO x,siebel.ITEM k,siebel.RELEASE z, siebel.anagrafica_tipo_ogg ao
                          where ao.ID_ANAGRAFICA_TIPO_OGG = K.ID_ANAGRAFICA_TIPO_OGG
                          and x.ID_RICHIESTA_RILASCIO=y.ID_RICHIESTA_RILASCIO
                          and x.ID_RELEASE=z.ID_RELEASE(+)
                          and k.ID_FUNZIONALITA=y.ID_FUNZIONALITA
                          and z.nome ='"+rel+"'")
    q_result = []

    while r = cursor.fetch_hash()
      q_result.push(r)
      puts r['NAME']
    end

    q_result
  end


  def self.getWorkItemForRelease(rel)
    result=""
    oracle = OCI8.new('SIEBEL', 'SIEBEL', 'CRMDB_NEW')



    cursor = oracle.exec("select k.oggetto as NAME, ao.tipo_oggetto as TYPE, y.descrizione as DESCRIPTION,z.nome as RELEASE
                          from siebel.FUNZIONALITA y,siebel.RICHIESTA_RILASCIO x,siebel.ITEM k,siebel.RELEASE z, siebel.anagrafica_tipo_ogg ao
                          where ao.ID_ANAGRAFICA_TIPO_OGG = K.ID_ANAGRAFICA_TIPO_OGG
                          and x.ID_RICHIESTA_RILASCIO=y.ID_RICHIESTA_RILASCIO
                          and x.ID_RELEASE=z.ID_RELEASE(+)
                          and k.ID_FUNZIONALITA=y.ID_FUNZIONALITA
                          and z.nome ='"+rel+"'")
    q_result = []

    while r = cursor.fetch_hash()
      if is_number?( r['DESCRIPTION'] )
        q_result.push(r)
        puts r['DESCRIPTION'] +" -  "+ r['NAME']
      end

    end

    q_result
  end

  def is_number? string
    true if Float(string) rescue false
  end

end