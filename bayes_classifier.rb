#used for mean, standard deviation, etc.
require 'descriptive_statistics'

# Bayes Classifier
#
# Marlesson Santana - 27/03/17
#
class BayesCassified

  def initialize
    @training_data  = {}
  end

  # training_data = {
  #   "class1" => [
  #     [feature1, feature2, feature3, ..., featureN],
  #     [feature1, feature2, feature3, ..., featureN]
  #   ],

  #   "class2" => [
  #     [feature1, feature2, feature3, ..., featureN],
  #     [feature1, feature2, feature3, ..., featureN]
  #   ],
  # }
  def traine(training_data = {})
    @training_data  = training_data
  end

  # This method classify the features, and return de class
  def classify(features)
    # Order by probability
    res = classes.sort_by do |class_name|
      class_probability(features, class_name)
    end

    return res[-1]
  end  

  def count_features
    @training_data.first.first.size
  end

  def count_classes
    @training_data.keys.size
  end

  def classes
    @training_data.keys
  end

  private 

  # Get all espeficic feature (index) of class (class_name)
  def get_feature_of_class(index, class_name)
    get_features      = []
    features_of_class = @training_data[class_name]

    features_of_class.length.times do |i|
      get_features << features_of_class[i][index]
    end

    return get_features
  end

  # Return the probability feature (index) of class (class_name)
  def feature_probability(index, value, class_name)
    features_of_class = get_feature_of_class(index, class_name)

    #statistical properties of the feature set
    fc_std  = features_of_class.standard_deviation
    fc_mean = features_of_class.mean
    fc_var  = features_of_class.variance    

    # Calc prbobability of Normal Distribui

    exp   = -((value - fc_mean)**2)/(2*fc_var)
    densy = (1.0/(Math.sqrt(2*Math::PI*fc_var))) * (Math::E**exp)

    return densy
  end

  def mult_prob_feature(features, class_name)
    prod = 1.0

    features.length.times do |i|
      prod *= feature_probability(i, features[i], class_name)
    end

    return prod    
  end

  def class_probability(features, class_name)

    # Probabilidade of class 
    prob_class = 1.0/count_classes
    
    mult_prob_feature = mult_prob_feature(features, class_name)

    return prob_class * mult_prob_feature
  end
end


# bc = BayesCassified.new
# bc.traine({
#     "class1" => [
#       [feature1, feature2, feature3, ..., featureN],
#       [feature1, feature2, feature3, ..., featureN]
#     ],

#     "class2" => [
#       [feature1, feature2, feature3, ..., featureN],
#       [feature1, feature2, feature3, ..., featureN]
#     ],
#   })