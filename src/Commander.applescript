property script_tools_path : "lib/script_tools.scpt"

-- Some common shell operators

property pipe : " | "
property io_out : " > "
property io_in : " < "

on run
	try
		set _HERE_ to POSIX path of ((path to me as text) & "::") as string
		set ScriptTools to load script ((_HERE_ & script_tools_path) as string)
		set output_file to ((_HERE_ & "output/output.json") as string)
		set input_file to ((_HERE_ & "input/command.sh") as string)
		
		tell ScriptTools
			
			if not file_exists(input_file) then
				error "Things fall apart, the centre cannot hold." number -128
				return
			end if
			
			set shell_cmd to read_file(input_file)
			set shell_script to (shell_cmd & pipe & my awk_to_json() & io_out & output_file & my cat(output_file)) as string
			set the_result to do shell script shell_script
			
			log the_result
			
			if file_exists(output_file) then
				return "Success!"
			else
				return "Doah!"
			end if
		end tell
		
	on error eMsg number eNum
		do shell script "echo " & format_error(eNum, eMsg) & io_out & output_file
	end try
end run

-- ----- FUNCTIONS ------ --

on format_error(eNum, eMsg)
	-- The error number is wrapped in quotes in case it is empty.
	-- `null` is not wrapped in quotes because we are setting that as a string literal.
	-- Example: {"result": null, "errnum": "-128", "errmsg": "The error message."}
	return "{" & qtd("result") & ": null, " & qtd("errnum") & ": " & qtd(eNum) & ", " & qtd("errmsg") & ": " & qtd(eMsg) & "}"
end format_error

-- qtd == "Quoted"
on qtd(str)
	return "\\\"" & str & "\\\""
end qtd

on cat(cat_file)
	return "; cat " & cat_file
end cat

on awk_to_json()
	return "awk '{printf  \"{\\\"result\\\": \\\"%s\\\"}\", $1}'"
end awk_to_json