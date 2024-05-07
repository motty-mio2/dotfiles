local function is_program_in_path(program)
	local path = os.getenv("PATH")
	return string.match(path, "[/\\]" .. program .. "$")
end

return {
	is_program_in_path = is_program_in_path,
}
