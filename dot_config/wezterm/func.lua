local function is_program_in_path(program)
	local path = os.getenv("PATH")
	if not path then
		return false
	end
	local sep = package.config:sub(1, 1) -- パス区切り文字
	local is_windows = sep == "\\"
	local ext_list = is_windows and { ".exe", ".bat", ".cmd", "" } or { "" }
	local path_sep = is_windows and ";" or ":"
	for dir in string.gmatch(path, "([^" .. path_sep .. "]+)") do
		for _, ext in ipairs(ext_list) do
			local fullpath = dir .. sep .. program .. ext
			local f = io.open(fullpath, "rb")
			if f then
				f:close()
				return true
			end
		end
	end
	return false
end

return {
	is_program_in_path = is_program_in_path,
}
