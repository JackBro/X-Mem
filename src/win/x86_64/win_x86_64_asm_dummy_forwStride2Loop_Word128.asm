; The MIT License (MIT)
;
; Copyright (c) 2014 Microsoft
; 
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.


.code
win_x86_64_asm_dummy_forwStride2Loop_Word128 proc

; Arguments:
; rcx is address of the first 128-bit word in the array
; rdx is address of the last 128-bit word in the array

; rax holds current 128-bit word address
; rbx holds number of words accessed
; rcx holds the target total number of words to access
; xmm0 holds result from reading the memory 128-bit wide

	mov rax,rcx		; initialize current word address to start of the array
	mov rbx,0 		; initialize number of words accessed to 0
	mov rcx,256		; initialize target total number of words to access
	cmp rbx,rcx		; have we completed the target total number of words to access?
	jae done		; if the number of words accessed >= the target number, then we are done

myloop:
	add rbx,128		; Just did 128 accesses

	cmp rbx,rcx		; have we completed 256 accesses in total yet (total of 4096 B)?
	jb myloop 		; make another unrolled pass on the memory
	
done:
	xor eax,eax		; return 0
	ret

win_x86_64_asm_dummy_forwStride2Loop_Word128 endp
end
