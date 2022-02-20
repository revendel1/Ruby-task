# frozen_string_literal: true

=begin
 В результате анализа предметной области было установлено, что
 реализуемый метод использует уже существующий сервис FlussonicLastVersion.get,
 а также поля лицензии License. Ни то, ни другое в условиях реальной задачи 
 не вводятся пользователем, а берутся методом из системы. Однако, в целях 
 отладки и тестирования программы, данные значения вводятся с клавиатуры. 
 В случае использования реального сервиса FlussonicLastVersion.get, его 
 возвращаемый результат должен передаваться в метод get_versions() в качестве 
 единственного параметра. В данный момент в этот метод передается переменная 
 last_version, вводимая пользователем с клавиатуры и заменяющая собой работу 
 данного сервиса. Было установлено, что новые версии Flussonic выходят каждый месяц, сервис
 FlussonicLastVersion.get возвращает только версию самой последней, поэтому для
 получения 5 последних релизов, необходимо по порядку посчитать их номера,
 отталкиваясь только от номера самого последнего
=end

class License
  def initialize(paid_till, max_version, min_version)
    @paid_till = paid_till.to_s
    @max_version = max_version.to_s
    @min_version = min_version.to_s
  end

  def get_versions(last_version)
    arr = []  #массив для сохранения в него 5 последних релизов Flussonic
    month = (last_version[3] + last_version[4]).to_i #по номеру полученной версии определяются
    year = (last_version[0] + last_version[1]).to_i  #месяц и год этого релиза
    if month > 4        #если номер месяца больше 4, то все последние 5 релизов были сделаны в одном году
      (1..5).each do |i|
        month2 = month - 5 + i  #определяем месяца последних 5 версий, зная месяц последней, их общее количество, равное пяти и что версии выходят каждый месяц
        version = if month2 > 9 #определяем номер последних релизов, преобразовывая все номера к формату гг.мм
                    "#{year}.#{month2}"
                  else
                    "#{year}.0#{month2}"
                  end
        arr << version      #записываем в массив тот номер, который получился    
      end
    else
      year2 = year - 1      #в случае, если не все 5 последних релизов были сделаны в одном году, считаем какой был предыдущий год
      ((8 + month)..12).each do |i|
        version = "#{year2}.#{i}" #записываем в массив номера релизов в формате гг.мм, сделанных в прошлом году
        arr << version
      end
      (1..month).each do |i|
        version = "#{year}.0#{i}" #записываем в массив те релизы, которые были сделаны в текущем году
        arr << version
      end
    end
    available_versions = []
    (0..4).each do |i|
      paid_till_correct = "#{@paid_till[-2]}#{@paid_till[-1]}.#{@paid_till[3]}#{@paid_till[4]}" #преобразовываем поле paid_till из формата дд.мм.гггг к формату гг.мм для удобства сравнения
      unless (@max_version != '' && arr[i] > @max_version) || (@paid_till != '' && arr[i] > paid_till_correct) || (@max_version != '' && arr[i] < @min_version)
        available_versions << arr[i] #проверяем номера версий из массива arr, согласно критериям, указанным в условии и в случае успеха записываем текущую проверяемую версию в массив доступных версий available_versions
      end
    end
    available_versions << @max_version if available_versions.size.zero? #в случае, если массив оказался пустым, записываем в него максимальную версию, как указано в условии
    available_versions
  end
end
