module SubmissionsHelper
	def test_cases(language, submission_id, test_cases, use_lrun=true, max_cpu_time="2", max_memory="512m")
		# test cases come split into cases with
		# three dashes, '---' and the input and
		# output within each test case is split
		# into input and output by three stars, 
		# '***'
		test_case_lst = []
	    test_cases.split("---").each do |tc|
	      test_case_lst << tc.split("***")
		end

		# some setup stuff
		language_extension = get_extension(language)
		if language_extension == "java"
			file_name = "j#{submission_id}.#{language_extension}"
		else
			file_name = "#{submission_id}.#{language_extension}"
		end
	    run_command, compile_command = get_language_bits(language, file_name, submission_id)
		make_file(file_name, submission_id)
		compiled = true
		test_cases_passed = 0
		out_arr = []

		if not compile_command.empty?
			compiled = system(compile_command)
		end
		if compiled
			if use_lrun
				# lots of flags to ensure no malicious
				# code runs on the server.
				run_command = "lrun --basic-devices false --max-rtprio 0 --max-nfile 256 --max-nprocess 2048 --nice 0 --remount-dev false --umount-outside false --no-new-privs true --interval 0.02 --reset-env false --isolate-process true --network false --max-cpu-time #{max_cpu_time} --max-memory #{max_memory} #{run_command}"
			end
			test_case_lst.each do |test_case, output|
				out = `echo '#{test_case}' | #{run_command} 2> err_#{submission_id}.txt 3> info_#{submission_id}.txt`

				# processing lrun run info
				info = File.read("info_#{submission_id}.txt").split("\n")
				if info[4] != "EXITCODE 0"
					out_arr << "Runtime Error"
				elsif info[6] != "EXCEED   none"
					if info[6].split(" ")[1] == "CPU_TIME"
						out_arr << "Time Limit Exceeded"
					elsif info[6].split(" ")[1] == "MEMORY"
						out_arr << "Memory Limit Exceeded"
					end
				else
					# this removes weird hidden characters
					output = output.strip().split(' ').map(&:strip).join(' ')
					out = out.strip().split(' ').map(&:strip).join(' ')
					puts "				RESULT HERE", out, output, run_command
					system("cat err_#{submission_id}.txt")

					if out.strip() == output.strip()
						test_cases_passed += 1
						out_arr << "Success"
					else
						out_arr << "Wrong Answer"
					end
				end
				system("rm info_#{submission_id}.txt err_#{submission_id}.txt")
			end
		else
			out_arr << "Compile Error"
		end

		# leave the campsite how you found it; scout's code
		system("rm *#{submission_id}*")

		return test_cases_passed, out_arr
	end

	def get_language_bits(language, file_name, submission_id)
		hsh = languages_hash(file_name, submission_id)

		run_command = hsh[language]["run_command"]
		compile_command = hsh[language]["compile_command"]

		return run_command, compile_command
	end

	def get_extension(language)
		hsh = languages_hash("none", -1)
		return hsh[language]["extension"]
	end

	def languages_hash(file_name, submission_id)
		# fairly obvious how to add a new language
		# for compiled commands use 1> /dev/null 2>&1
		# to redirect stderr and stdout to the trash as we
		# do not want it popping up in the rails console,
		# the system function will return non-0 if it fails
		# and there is measures to deal with that.
		# otherwise add the relevant flags to make it run
		# properly at good speed without taking up a tonne
		# of time to compile.
		# The format for adding a new language is as follows:
		#
		# "language_name" => {
		#     "extension" => "language-extension",
		#     "run_command" => "command to run file",
		#     "compile_command" => "command to compile file"
		# },
		#
		# Note: If you are adding an interpreted language
		# just leave compile_command with an empty string, ""
		# Also if a language is added here it will be added
		# to the dropdown automatically as the dropdown gets
		# its list of languages from get_language_list below. 
		{
			"python3" => {
				"extension" => "py",
				"run_command" => "python3 #{file_name}",
				"compile_command" => ""
			},
			"python2" => {
				"extension" => "py",
				"run_command" => "python #{file_name}",
				"compile_command" => ""
			},
			"java6" => {
				"extension" => "java",
				"run_command" => "java j#{submission_id}",
				"compile_command" =>"javac --release 6 -Xlint:-options #{file_name} 1> /dev/null 2>&1"
			},
			"java7" => {
				"extension" => "java",
				"run_command" => "java j#{submission_id}",
				"compile_command" =>"javac --release 7 -Xlint:-options #{file_name} 1> /dev/null 2>&1"
			},
			"java8" => {
				"extension" => "java",
				"run_command" => "java j#{submission_id}",
				"compile_command" =>"javac --release 8 -Xlint:-options #{file_name} 1> /dev/null 2>&1"
			},
			"java9" => {
				"extension" => "java",
				"run_command" => "java j#{submission_id}",
				"compile_command" =>"javac --release 9 -Xlint:-options #{file_name} 1> /dev/null 2>&1"
			},
			"java10" => {
				"extension" => "java",
				"run_command" => "java j#{submission_id}",
				"compile_command" =>"javac --release 10 -Xlint:-options #{file_name} 1> /dev/null 2>&1"
			},
			"java11" => {
				"extension" => "java",
				"run_command" => "java j#{submission_id}",
				"compile_command" =>"javac --release 11 -Xlint:-options #{file_name} 1> /dev/null 2>&1"
			},
			"c" => {
				"extension" => "c",
				"run_command" => "./#{submission_id}.out",
				"compile_command" => "gcc #{file_name} -o #{submission_id}.out 1> /dev/null 2>&1"
			},
			"cpp11" => {
				"extension" => "cpp",
				"run_command" => "./#{submission_id}.out",
				"compile_command" => "g++ #{file_name} -O2 -std=c++11 -o #{submission_id}.out 1> /dev/null 2>&1"
			},
			"cpp14" => {
				"extension" => "cpp",
				"run_command" => "./#{submission_id}.out",
				"compile_command" => "g++ #{file_name} -O2 -std=c++14 -o #{submission_id}.out 1> /dev/null 2>&1"
			},
			"cpp17" => {
				"extension" => "cpp",
				"run_command" => "./#{submission_id}.out",
				"compile_command" => "g++ #{file_name} -O2 -std=c++17 -o #{submission_id}.out 1> /dev/null 2>&1"
			},
			"ruby" => {
				"extension" => "rb",
				"run_command" => "ruby #{file_name}",
				"compile_command" => ""
			},
			"go" => {
				"extension" => "go",
				"run_command" => "./#{submission_id}.out",
				"compile_command" => "go build -o #{submission_id}.out #{file_name}"
			},
			"rust" => {
				"extension" => "rs",
				"run_command" => "./#{submission_id}.out",
				"compile_command" => "rustc -O --crate-type bin --edition=2018 #{file_name} -o #{submission_id}.out"
			},
			"v" => {
				"extension" => "v",
				"run_command" => "./#{submission_id}.out",
				"compile_command" => "v -prod -o #{submission_id}.out #{file_name}"
			}
		}
	end

	def get_language_list
		out = []
		hsh = languages_hash("none", -1)
		hsh.each do |n, o|
			out << n
		end
		return out
	end

	def make_file(file_name, submission_id)
		subm = Submission.find(submission_id)
		text = subm.code
		File.open("#{file_name}", "w") { |file| file.puts "#{text}"}
	end

	def javaify(code, id)
		code["public class main"] = "public class j#{id}"
		return code
	end
end