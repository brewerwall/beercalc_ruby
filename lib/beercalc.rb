class Beercalc

  ## ABV()
  #  param og: number - original gravity
  #  param fg: number - final gravity
  def self.abv(og, fg)
    unless og < fg || !og.is_a?(Numeric) || !fg.is_a?(Numeric)
      abv = (og - fg) * 131
    else
      abv = nil
    end
  end

  ## ABW()
  #  param og: number - original gravity
  #  param fg: number - final gravity
  #  SOURCE = http://hbd.org/ensmingr/
  def self.abw(og, fg)
    unless og < fg || !og.is_a?(Numeric) || !fg.is_a?(Numeric)
      abv = (0.79 * self.abv(og, fg)) / fg
    else
      abv = nil
    end
  end

  ## MCU()
  #  param weight: number - lbs of grain
  #  param lovibond: number - typically a number between 
  #  param volume: number - gallons
  def self.mcu(weight, lovibond, volume)
    unless volume == 0 || !weight.is_a?(Numeric) || !lovibond.is_a?(Numeric) || !volume.is_a?(Numeric)
      mcu = (weight * lovibond) / volume
    else
      mcu = nil
    end
  end

  ## SRM()
  #  param weight: number - lbs of grain
  #  param lovibond: number - typically a number between 1-25
  #  param volume: number - gallons
  def self.srm(weight, lovibond, volume)
    unless !weight.is_a?(Numeric) || !lovibond.is_a?(Numeric) || !volume.is_a?(Numeric)
      srm = 1.4922 * (mcu(weight, lovibond, volume) ** 0.6859)
    else
      srm = nil
    end
  end

  ## AAU()
  #  param alpha: percent - alpha unit of the hop
  #  param weight: number - oz of hops
  def self.aau(alpha, weight)
    unless !alpha.is_a?(Numeric) || !weight.is_a?(Numeric)
      aau = alpha * weight
    else
      aau = nil
    end
  end

  ## IBU()
  #  param alpha: percent - alpha unit of the hop
  #  param weight: number - oz of hops
  #  param utilization: number - output of self.utilization
  #  param volume: number - gallons
  def self.ibu(alpha, weight, time, gravity, volume)
    unless volume == 0 || !alpha.is_a?(Numeric) || !weight.is_a?(Numeric) || !time.is_a?(Numeric) || !gravity.is_a?(Numeric) || !volume.is_a?(Numeric)
      ibu = self.aau(alpha, weight) * self.utilization(time, gravity) * 75 / volume
    else
      ibu = nil
    end
  end

  ## UTILIZATION()
  #  param time: number - minute hops are in the boil
  #  param gravity: number - gravity of the boil upon inserting Ex. 1.050
  def self.utilization(time, gravity)
    unless !time.is_a?(Numeric) || !gravity.is_a?(Numeric)
      utilization = (1.65 * 0.000125**(gravity - 1)) * (1 - Math::E**(-0.04 * time)) / 4.15
    else
      utilization = nil
    end
  end

  ## PLATO
  #  param sGravity: number - specific gravity
  def self.plato(sGravity)  
    unless !sGravity.is_a?(Numeric) 
      plato = (-463.37) + (668.72 * sGravity) - (205.35 * sGravity**2)
    else
      plato = nil
    end
  end

  ## REAL EXTRACT
  #  param og: number - original gravity
  #  param fg: number - final gracivity
  #  SOURCE = http://hbd.org/ensmingr/
  def self.realExtract(og, fg)
    unless !og.is_a?(Numeric) || !fg.is_a?(Numeric) || og < fg
      realExtract = (0.1808 * self.plato(og)) + (0.8192 * self.plato(fg))
    else
      realExtract = nil
    end
  end

  ## CALORIES (in 12 ounce increments)
  #  param og: number - original gravity
  #  param fg: number - final gravity
  #  SOURCE = http://hbd.org/ensmingr/
  def self.calories(og, fg)
    unless og < fg || !og.is_a?(Numeric) || !fg.is_a?(Numeric)
      calories = ((6.9 * self.abw(og,fg)) + 4.0 * (self.realExtract(og,fg) - 0.1)) * fg * 3.55
    else
      calories = nil
    end
  end

  ## ATTENUATION
  #  param og: number - original gravity
  #  param fg: number - final gracivity
  #  Assuming this is in gravity (Ex. 1.054)
  def self.attenuation(og, fg)
    unless og < fg || !og.is_a?(Numeric) || !fg.is_a?(Numeric)
      attenuation = (og - fg)/(og - 1)
    else
      attenuation = nil
    end
  end

  ## GRAVITY UNITS
  #  param g: number - gravity
  def self.gu(g)
    unless !g.is_a?(Numeric)
      gu = ((g - 1) * 1000).round
    else
      gu = nil
    end 
  end

  ## TOTAL GRAVITY
  # param g: number - gravity
  # param vol: number - volume in gallons
  def self.totalGravity(g,v)
    unless !g.is_a?(Numeric) || !v.is_a?(Numeric)
      tg = self.gu(g) * v
    else
      tg = nil
    end
  end

  ## FINAL GRAVITY
  #  param g: number - initial gravity
  #  param vol_beg: number - volume in gallons at the begining of the boil
  #  param vol_end: number - volume in gallons at the end of the boil
  def self.finalGravity(g, vol_beg, vol_end)
    unless !g.is_a?(Numeric) || !vol_beg.is_a?(Numeric) || !vol_end.is_a?(Numeric)
      gu = self.totalGravity(g,vol_beg) / vol_end
    else
      gu = nil
    end
  end

  ## EXTRACT ADDITION
  # param target_gu: number - Target Total Gravity in Gravity Units
  # param total_gu: number - Total Gravity from Mash in Gravity Units
  # param extract: string/number - should be 'LME' or 'DME' or custom value
  def self.extractAddition(target_gu, total_gu, extractType)
    # Preset values for LME and DME, or account for a custom value
    if extractType == 'LME'
      extract = 38
    elsif extractType == 'DME'
      extract = 45
    elsif extractType.is_a?(Numeric)
      extract = extractType
    end

    unless !target_gu.is_a?(Numeric) || !total_gu.is_a?(Numeric) || !extract.is_a?(Numeric)
      addition = (target_gu - total_gu).to_f / extract
    else
      addition = nil
    end
    return addition  
  end

  ## GRAVITY TEMPERATURE CORRECTION
  # param temp: number - Temperature in Fahrenheit
  # param g: number - Gravity from the hydrometer reading
  def self.gravityCorrection(temp, g)
    unless !temp.is_a?(Numeric) || !g.is_a?(Numeric)
      correction = ((1.313454 - 0.132674*temp + 2.057793*10**-3*temp**2 - 2.627634*10**-6*temp**3) * 0.001) + g
    else
      correction = nil
    end
  end
end
