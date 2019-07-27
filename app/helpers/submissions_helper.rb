module SubmissionsHelper
	def test_cases(language_extension, language, submission_id, test_cases, use_lrun=true, max_cpu_time="2", max_memory="512m")
		# some setup stuff
		file_name = "#{submission_id}.#{language_extension}"
		make_file(file_name, submission_id)
		compile_command = ""
		run_command = ""
		compiled = true
		test_cases_passed = 0
		out_arr = []

		run_command, compile_command = get_commands(language, file_name, submission_id)

		if not compile_command.empty?
			compiled = system(compile_command)
		end
		if compiled
			if use_lrun
				# lots of flags to ensure no malicious
				# code runs on the server.
				run_command = "lrun --pass-exitcode --basic-devices false --max-rtprio 0 --max-nfile 256 --max-nprocess 2048 --nice 0 --remount-dev false --umount-outside false --no-new-privs true --interval 0.02 --reset-env false --isolate-process true --network false --max-cpu-time #{max_cpu_time} --max-memory #{max_memory} #{run_command}"
			end
			test_cases.each do |test_case, output|
				out = `echo #{test_case} | #{run_command} 2> err_#{submission_id}.txt`
				if not File.zero?("err_#{submission_id}.txt")
					out_arr << "Runtime Error"
				elsif out.strip() == output.strip()
					test_cases_passed += 1
					out_arr << "Success"
				else
					out_arr << "Wrong Answer"
				end
				system("rm err_#{submission_id}.txt")
			end
		else
			return "Compile Error"
		end

		# leave the campsite how you found it; scout's code
		System("rm #{submission_id}*")

		return test_cases_passed, out_arr
	end

	def get_commands(language, file_name, submission_id)
		compile_command = ""
		run_command = ""

		# fairly obvious how to add a new language
		# for compiled commands use 1> /dev/null 2>&1
		# to redirect stderr and stdout to the trash as we
		# do not want it popping up in the rails console,
		# the system function will return non-0 if it fails
		# and there is measures to deal with that.
		# otherwise add the relevant flags to make it run
		# properly at good speed without taking up a tonne
		# of time to compile. 
		case language.downcase
		when "python3"
			run_command = "python3 #{file_name}"
		when "python2", "python"
			run_command = "python #{file_name}"
		when "c"
			compile_command = "gcc #{file_name} -o #{submission_id}.out 1> /dev/null 2>&1"
			run_command = "./#{submission_id}.out"
		when "java6"
			compile_command = "javac --release 6 #{file_name} 1> /dev/null 2>&1"
			run_command = "java #{submission_id}"
		when "java7"
			compile_command = "javac --release 7 #{file_name} 1> /dev/null 2>&1"
			run_command = "java #{submission_id}"
		when "java8"
			compile_command = "javac --release 8 #{file_name} 1> /dev/null 2>&1"
			run_command = "java #{submission_id}"
		when "java9"
			compile_command = "javac --release 9 #{file_name} 1> /dev/null 2>&1"
			run_command = "java #{submission_id}"
		when "java10"
			compile_command = "javac --release 10 #{file_name} 1> /dev/null 2>&1"
			run_command = "java #{submission_id}"
		when "java11"
			compile_command = "javac --release 11 #{file_name} 1> /dev/null 2>&1"
			run_command = "java #{submission_id}"
		when "cpp11", "c++11", "cc11"
			compile_command = "g++ #{file_name} -O2 -std=c++11 -o #{submission_id}.out 1> /dev/null 2>&1"
			run_command = "./#{submission_id}.out"
		when "cpp14", "c++14", "cc14"
			compile_command = "g++ #{file_name} -O2 -std=c++14 -o #{submission_id}.out 1> /dev/null 2>&1"
			run_command = "./#{submission_id}.out"
		when "cpp17", "c++17", "cc17"
			compile_command = "g++ #{file_name} -O2 -std=c++17 -o #{submission_id}.out 1> /dev/null 2>&1"
			run_command = "./#{submission_id}.out"
		when "ruby"
			run_command = "ruby #{file_name}"
		when "go", "golang"
			compile_command = "go build #{file_name}"
			run_command = "./#{submission_id}"
		when "v", "vlang"
			compile_command = "v -prod -o #{submission_id}.out #{file_name}"
			run_command = "./#{submission_id}.out"
		else
			return "Unsupported Language", ""
		end

		return run_command, compile_command
	end

	def make_file(file_name, submission_id)
		subm = Submission.find(submission_id)
		text = subm.code
		system("echo '#{text}' > #{file_name}")
	end
end
