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
end
