let check_bounds buffer_length offset data_length =
	if offset > buffer_length then invalid_arg "offset";
	if data_length < 0 then invalid_arg "length";
	if offset + data_length > buffer_length then invalid_arg "length";
	if offset < 0 then invalid_arg "offset"

external unsafe_crc32_cstruct : Cstruct.buffer -> int -> int -> int32 =
	"crc32_cstruct"

let crc32_cstruct t =
	unsafe_crc32_cstruct t.Cstruct.buffer t.Cstruct.off t.Cstruct.len

external unsafe_crc32_string : string -> int -> int -> int32 =
	"crc32_string"

let check_bounds_string str offset length =
	check_bounds (String.length str) offset length

let crc32_string str offset length =
	check_bounds_string str offset length;
	unsafe_crc32_string str offset length
