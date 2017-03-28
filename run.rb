require "./bayes_classifier.rb"

# Load Data
dada        = File.open("data/iris.data.txt")
data_class  = {}

dada.each_line do |line|
  sl, sw, pl, pw, c = line.split(",")

  data_class[c] ||= []
  data_class[c] << [sl.to_f, sw.to_f, pl.to_f, pw.to_f]
end

# Divide training data and prediction
# 70% Training
# 30% Prediction

data_training   = {}
data_prediction = {}

data_class.each do |type, data|
  d = (data.size * 0.70).to_i
  data_training[type]   = data[0...d]
  data_prediction[type] = data[d...50]
end

# Means and variance of features in types. Use this values in the problem 1, build de probability density
puts "Means and variance of features in types. Use this values in the problem 1, build de probability density\n"
data_training.each do |type, data|
  puts "\n>> #{type}\n"
  # Features index
  #[ 0,  1,  2,  3, 4]
  #[sl, sw, pl, pw, c]

  # sepal length in cm (SL)
  sl_data = data.collect{|d| d[0]}
  puts "SL(#{sl_data.mean}, #{sl_data.standard_deviation})"

  #sepal width in cm (SW)
  sw_data = data.collect{|d| d[1]}
  puts "SW(#{sw_data.mean}, #{sw_data.standard_deviation})"

  # petal length in cm (PL)
  pl_data = data.collect{|d| d[2]}
  puts "PL(#{pl_data.mean}, #{pl_data.standard_deviation})"

  # petal width in cm (PW)
  pw_data = data.collect{|d| d[3]}
  puts "PW(#{pw_data.mean}, #{pw_data.standard_deviation})"
end


# Training BayesClassified
puts "\n\ntraining...\n"
bc = BayesCassified.new
bc.traine(data_training)

# Teste Prediction of BayesClassified
puts "\n\nteste predictions:\n"
right_class = {}
error_class = {}

data_prediction.each do |type, data|
  right_class[type] = []
  error_class[type] = []

  data.each do |features|

    if bc.classify(features) == type # Right
      right_class[type] << features
    else # Error
      error_class[type] << features
    end
  end
end

data_prediction.each do |type, data|
  hit = right_class[type].size.to_f/data.size
  puts ">> #{type} >>> #{hit}"
end