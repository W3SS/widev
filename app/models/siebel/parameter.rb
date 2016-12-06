require 'csv'


class Siebel::Parameter < ActiveRecord::Base

  def self.import(file,ptype,enterprise,server,component)
    logger.info ("Start importing")

    csv_text = File.read(file.tempfile,{:col_sep=>"|"})
    csv = CSV.parse(csv_text, :col_sep => "|")
    csv.each do |row|

      old_p = Siebel::Parameter.where(:enterprise => enterprise, :ptype =>ptype, :server=>server ,:component => component, :pa_alias =>row[0].strip).first
      if old_p != nil
        old_p.pa_value = row[1].strip
        if old_p.version == nil
          old_p.version = 1
        else
          old_p.version  = old_p.version + 1
        end

        old_p.save!
      else
        Siebel::Parameter.create!(:enterprise => enterprise, :ptype =>ptype, :server=>server ,:component => component, :pa_alias =>row[0].strip ,:pa_value =>row[1].strip)
      end

    end


  end


  def self.importspool(spool,ptype,enterprise,server,component)
    logger.info ("Start importing  by server spool")
    csv = CSV.parse(spool, :col_sep => "|")
    csv.each do |row|

      old_p = Siebel::Parameter.where(:enterprise => enterprise, :ptype =>ptype, :server=>server ,:component => component, :pa_alias =>row[0].strip).first
      if old_p != nil
        old_p.pa_value = row[1].strip
        if old_p.version == nil
          old_p.version = 1
        else
          old_p.version  = old_p.version + 1
        end

        old_p.save!
      else
        Siebel::Parameter.create!(:enterprise => enterprise, :ptype =>ptype, :server=>server ,:component => component, :pa_alias =>row[0].strip ,:pa_value =>row[1].strip)
      end

    end


  end


end
