Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00358D3ECD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfJKLve (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:51:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:33348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728152AbfJKLve (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF6E3B490;
        Fri, 11 Oct 2019 11:51:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v9 27/28] x86_32/asm: Change all ENTRY+ENDPROC to SYM_FUNC_*
Date:   Fri, 11 Oct 2019 13:51:07 +0200
Message-Id: <20191011115108.12392-28-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These are all functions which are invoked from elsewhere, so they are
annotated as global using the new SYM_FUNC_START. And their ENDPROC's by
SYM_FUNC_END.

Now, ENTRY/ENDPROC can be forced to be undefined on X86, so do so.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Bill Metzenthen <billm@melbpc.org.au>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-crypto@vger.kernel.org
Cc: linux-efi@vger.kernel.org
---
 arch/x86/boot/compressed/efi_stub_32.S     |  4 +--
 arch/x86/boot/compressed/head_32.S         | 12 ++++----
 arch/x86/crypto/serpent-sse2-i586-asm_32.S |  8 +++---
 arch/x86/crypto/twofish-i586-asm_32.S      |  8 +++---
 arch/x86/entry/entry_32.S                  | 24 ++++++++--------
 arch/x86/kernel/head_32.S                  | 16 +++++------
 arch/x86/lib/atomic64_386_32.S             |  4 +--
 arch/x86/lib/atomic64_cx8_32.S             | 32 +++++++++++-----------
 arch/x86/lib/checksum_32.S                 |  8 +++---
 arch/x86/math-emu/div_Xsig.S               |  4 +--
 arch/x86/math-emu/div_small.S              |  4 +--
 arch/x86/math-emu/mul_Xsig.S               | 12 ++++----
 arch/x86/math-emu/polynom_Xsig.S           |  4 +--
 arch/x86/math-emu/reg_norm.S               |  8 +++---
 arch/x86/math-emu/reg_round.S              |  4 +--
 arch/x86/math-emu/reg_u_add.S              |  4 +--
 arch/x86/math-emu/reg_u_div.S              |  4 +--
 arch/x86/math-emu/reg_u_mul.S              |  4 +--
 arch/x86/math-emu/reg_u_sub.S              |  4 +--
 arch/x86/math-emu/round_Xsig.S             |  8 +++---
 arch/x86/math-emu/shr_Xsig.S               |  4 +--
 arch/x86/math-emu/wm_shrx.S                |  8 +++---
 arch/x86/math-emu/wm_sqrt.S                |  4 +--
 arch/x86/platform/efi/efi_stub_32.S        |  4 +--
 arch/x86/power/hibernate_asm_32.S          |  8 +++---
 include/linux/linkage.h                    |  8 ++----
 26 files changed, 104 insertions(+), 108 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_stub_32.S b/arch/x86/boot/compressed/efi_stub_32.S
index 257e341fd2c8..ed6c351d34ed 100644
--- a/arch/x86/boot/compressed/efi_stub_32.S
+++ b/arch/x86/boot/compressed/efi_stub_32.S
@@ -24,7 +24,7 @@
  */
 
 .text
-ENTRY(efi_call_phys)
+SYM_FUNC_START(efi_call_phys)
 	/*
 	 * 0. The function can only be called in Linux kernel. So CS has been
 	 * set to 0x0010, DS and SS have been set to 0x0018. In EFI, I found
@@ -77,7 +77,7 @@ ENTRY(efi_call_phys)
 	movl	saved_return_addr(%edx), %ecx
 	pushl	%ecx
 	ret
-ENDPROC(efi_call_phys)
+SYM_FUNC_END(efi_call_phys)
 .previous
 
 .data
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index f9e2a80bd699..f2dfd6d083ef 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -61,7 +61,7 @@
 	.hidden _egot
 
 	__HEAD
-ENTRY(startup_32)
+SYM_FUNC_START(startup_32)
 	cld
 	/*
 	 * Test KEEP_SEGMENTS flag to see if the bootloader is asking
@@ -142,14 +142,14 @@ ENTRY(startup_32)
  */
 	leal	.Lrelocated(%ebx), %eax
 	jmp	*%eax
-ENDPROC(startup_32)
+SYM_FUNC_END(startup_32)
 
 #ifdef CONFIG_EFI_STUB
 /*
  * We don't need the return address, so set up the stack so efi_main() can find
  * its arguments.
  */
-ENTRY(efi_pe_entry)
+SYM_FUNC_START(efi_pe_entry)
 	add	$0x4, %esp
 
 	call	1f
@@ -174,9 +174,9 @@ ENTRY(efi_pe_entry)
 	pushl	%eax
 	pushl	%ecx
 	jmp	2f		/* Skip efi_config initialization */
-ENDPROC(efi_pe_entry)
+SYM_FUNC_END(efi_pe_entry)
 
-ENTRY(efi32_stub_entry)
+SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp
 	popl	%ecx
 	popl	%edx
@@ -205,7 +205,7 @@ fail:
 	movl	BP_code32_start(%esi), %eax
 	leal	startup_32(%eax), %eax
 	jmp	*%eax
-ENDPROC(efi32_stub_entry)
+SYM_FUNC_END(efi32_stub_entry)
 #endif
 
 	.text
diff --git a/arch/x86/crypto/serpent-sse2-i586-asm_32.S b/arch/x86/crypto/serpent-sse2-i586-asm_32.S
index e5c4a4690ca9..6379b99cb722 100644
--- a/arch/x86/crypto/serpent-sse2-i586-asm_32.S
+++ b/arch/x86/crypto/serpent-sse2-i586-asm_32.S
@@ -497,7 +497,7 @@
 	pxor t0,		x3; \
 	movdqu x3,		(3*4*4)(out);
 
-ENTRY(__serpent_enc_blk_4way)
+SYM_FUNC_START(__serpent_enc_blk_4way)
 	/* input:
 	 *	arg_ctx(%esp): ctx, CTX
 	 *	arg_dst(%esp): dst
@@ -559,9 +559,9 @@ ENTRY(__serpent_enc_blk_4way)
 	xor_blocks(%eax, RA, RB, RC, RD, RT0, RT1, RE);
 
 	ret;
-ENDPROC(__serpent_enc_blk_4way)
+SYM_FUNC_END(__serpent_enc_blk_4way)
 
-ENTRY(serpent_dec_blk_4way)
+SYM_FUNC_START(serpent_dec_blk_4way)
 	/* input:
 	 *	arg_ctx(%esp): ctx, CTX
 	 *	arg_dst(%esp): dst
@@ -613,4 +613,4 @@ ENTRY(serpent_dec_blk_4way)
 	write_blocks(%eax, RC, RD, RB, RE, RT0, RT1, RA);
 
 	ret;
-ENDPROC(serpent_dec_blk_4way)
+SYM_FUNC_END(serpent_dec_blk_4way)
diff --git a/arch/x86/crypto/twofish-i586-asm_32.S b/arch/x86/crypto/twofish-i586-asm_32.S
index 290cc4e9a6fe..a6f09e4f2e46 100644
--- a/arch/x86/crypto/twofish-i586-asm_32.S
+++ b/arch/x86/crypto/twofish-i586-asm_32.S
@@ -207,7 +207,7 @@
 	xor	%esi,		d ## D;\
 	ror	$1,		d ## D;
 
-ENTRY(twofish_enc_blk)
+SYM_FUNC_START(twofish_enc_blk)
 	push	%ebp			/* save registers according to calling convention*/
 	push    %ebx
 	push    %esi
@@ -261,9 +261,9 @@ ENTRY(twofish_enc_blk)
 	pop	%ebp
 	mov	$1,	%eax
 	ret
-ENDPROC(twofish_enc_blk)
+SYM_FUNC_END(twofish_enc_blk)
 
-ENTRY(twofish_dec_blk)
+SYM_FUNC_START(twofish_dec_blk)
 	push	%ebp			/* save registers according to calling convention*/
 	push    %ebx
 	push    %esi
@@ -318,4 +318,4 @@ ENTRY(twofish_dec_blk)
 	pop	%ebp
 	mov	$1,	%eax
 	ret
-ENDPROC(twofish_dec_blk)
+SYM_FUNC_END(twofish_dec_blk)
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 0ecc12fcfc05..a987b62fc591 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -757,7 +757,7 @@ SYM_CODE_END(__switch_to_asm)
  * asmlinkage function so its argument has to be pushed on the stack.  This
  * wrapper creates a proper "end of stack" frame header before the call.
  */
-ENTRY(schedule_tail_wrapper)
+SYM_FUNC_START(schedule_tail_wrapper)
 	FRAME_BEGIN
 
 	pushl	%eax
@@ -766,7 +766,7 @@ ENTRY(schedule_tail_wrapper)
 
 	FRAME_END
 	ret
-ENDPROC(schedule_tail_wrapper)
+SYM_FUNC_END(schedule_tail_wrapper)
 /*
  * A newly forked process directly context switches into this address.
  *
@@ -885,7 +885,7 @@ SYM_CODE_END(xen_sysenter_target)
  * ebp  user stack
  * 0(%ebp) arg6
  */
-ENTRY(entry_SYSENTER_32)
+SYM_FUNC_START(entry_SYSENTER_32)
 	/*
 	 * On entry-stack with all userspace-regs live - save and
 	 * restore eflags and %eax to use it as scratch-reg for the cr3
@@ -1013,7 +1013,7 @@ ENTRY(entry_SYSENTER_32)
 	popfl
 	jmp	.Lsysenter_flags_fixed
 SYM_ENTRY(__end_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
-ENDPROC(entry_SYSENTER_32)
+SYM_FUNC_END(entry_SYSENTER_32)
 
 /*
  * 32-bit legacy system call entry.
@@ -1043,7 +1043,7 @@ ENDPROC(entry_SYSENTER_32)
  * edi  arg5
  * ebp  arg6
  */
-ENTRY(entry_INT80_32)
+SYM_FUNC_START(entry_INT80_32)
 	ASM_CLAC
 	pushl	%eax			/* pt_regs->orig_ax */
 
@@ -1120,7 +1120,7 @@ SYM_CODE_START(iret_exc)
 SYM_CODE_END(iret_exc)
 .previous
 	_ASM_EXTABLE(.Lirq_return, iret_exc)
-ENDPROC(entry_INT80_32)
+SYM_FUNC_END(entry_INT80_32)
 
 .macro FIXUP_ESPFIX_STACK
 /*
@@ -1213,7 +1213,7 @@ SYM_CODE_START_LOCAL(common_interrupt)
 SYM_CODE_END(common_interrupt)
 
 #define BUILD_INTERRUPT3(name, nr, fn)			\
-ENTRY(name)						\
+SYM_FUNC_START(name)					\
 	ASM_CLAC;					\
 	pushl	$~(nr);					\
 	SAVE_ALL switch_stacks=1;			\
@@ -1222,7 +1222,7 @@ ENTRY(name)						\
 	movl	%esp, %eax;				\
 	call	fn;					\
 	jmp	ret_from_intr;				\
-ENDPROC(name)
+SYM_FUNC_END(name)
 
 #define BUILD_INTERRUPT(name, nr)		\
 	BUILD_INTERRUPT3(name, nr, smp_##name);	\
@@ -1341,7 +1341,7 @@ SYM_CODE_START(spurious_interrupt_bug)
 SYM_CODE_END(spurious_interrupt_bug)
 
 #ifdef CONFIG_XEN_PV
-ENTRY(xen_hypervisor_callback)
+SYM_FUNC_START(xen_hypervisor_callback)
 	pushl	$-1				/* orig_ax = -1 => not a system call */
 	SAVE_ALL
 	ENCODE_FRAME_POINTER
@@ -1369,7 +1369,7 @@ SYM_INNER_LABEL_ALIGN(xen_do_upcall, SYM_L_GLOBAL)
 	call	xen_maybe_preempt_hcall
 #endif
 	jmp	ret_from_intr
-ENDPROC(xen_hypervisor_callback)
+SYM_FUNC_END(xen_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
@@ -1383,7 +1383,7 @@ ENDPROC(xen_hypervisor_callback)
  * to pop the stack frame we end up in an infinite loop of failsafe callbacks.
  * We distinguish between categories by maintaining a status value in EAX.
  */
-ENTRY(xen_failsafe_callback)
+SYM_FUNC_START(xen_failsafe_callback)
 	pushl	%eax
 	movl	$1, %eax
 1:	mov	4(%esp), %ds
@@ -1420,7 +1420,7 @@ ENTRY(xen_failsafe_callback)
 	_ASM_EXTABLE(2b, 7b)
 	_ASM_EXTABLE(3b, 8b)
 	_ASM_EXTABLE(4b, 9b)
-ENDPROC(xen_failsafe_callback)
+SYM_FUNC_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
 #ifdef CONFIG_XEN_PVHVM
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 7029bbaccc41..ea24aa5465fd 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -180,12 +180,12 @@ SYM_CODE_END(startup_32)
  * up already except stack. We just set up stack here. Then call
  * start_secondary().
  */
-ENTRY(start_cpu0)
+SYM_FUNC_START(start_cpu0)
 	movl initial_stack, %ecx
 	movl %ecx, %esp
 	call *(initial_code)
 1:	jmp 1b
-ENDPROC(start_cpu0)
+SYM_FUNC_END(start_cpu0)
 #endif
 
 /*
@@ -196,7 +196,7 @@ ENDPROC(start_cpu0)
  * If cpu hotplug is not supported then this code can go in init section
  * which will be freed later
  */
-ENTRY(startup_32_smp)
+SYM_FUNC_START(startup_32_smp)
 	cld
 	movl $(__BOOT_DS),%eax
 	movl %eax,%ds
@@ -363,7 +363,7 @@ ENTRY(startup_32_smp)
 
 	call *(initial_code)
 1:	jmp 1b
-ENDPROC(startup_32_smp)
+SYM_FUNC_END(startup_32_smp)
 
 #include "verify_cpu.S"
 
@@ -393,7 +393,7 @@ setup_once:
 	andl $0,setup_once_ref	/* Once is enough, thanks */
 	ret
 
-ENTRY(early_idt_handler_array)
+SYM_FUNC_START(early_idt_handler_array)
 	# 36(%esp) %eflags
 	# 32(%esp) %cs
 	# 28(%esp) %eip
@@ -408,7 +408,7 @@ ENTRY(early_idt_handler_array)
 	i = i + 1
 	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
-ENDPROC(early_idt_handler_array)
+SYM_FUNC_END(early_idt_handler_array)
 	
 SYM_CODE_START_LOCAL(early_idt_handler_common)
 	/*
@@ -464,7 +464,7 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
 SYM_CODE_END(early_idt_handler_common)
 
 /* This is the default interrupt "handler" :-) */
-ENTRY(early_ignore_irq)
+SYM_FUNC_START(early_ignore_irq)
 	cld
 #ifdef CONFIG_PRINTK
 	pushl %eax
@@ -499,7 +499,7 @@ ENTRY(early_ignore_irq)
 hlt_loop:
 	hlt
 	jmp hlt_loop
-ENDPROC(early_ignore_irq)
+SYM_FUNC_END(early_ignore_irq)
 
 __INITDATA
 	.align 4
diff --git a/arch/x86/lib/atomic64_386_32.S b/arch/x86/lib/atomic64_386_32.S
index e0788bade5ab..3b6544111ac9 100644
--- a/arch/x86/lib/atomic64_386_32.S
+++ b/arch/x86/lib/atomic64_386_32.S
@@ -20,10 +20,10 @@
 
 #define BEGIN(op) \
 .macro endp; \
-ENDPROC(atomic64_##op##_386); \
+SYM_FUNC_END(atomic64_##op##_386); \
 .purgem endp; \
 .endm; \
-ENTRY(atomic64_##op##_386); \
+SYM_FUNC_START(atomic64_##op##_386); \
 	LOCK v;
 
 #define ENDP endp
diff --git a/arch/x86/lib/atomic64_cx8_32.S b/arch/x86/lib/atomic64_cx8_32.S
index 843d978ee341..1c5c81c16b06 100644
--- a/arch/x86/lib/atomic64_cx8_32.S
+++ b/arch/x86/lib/atomic64_cx8_32.S
@@ -16,12 +16,12 @@
 	cmpxchg8b (\reg)
 .endm
 
-ENTRY(atomic64_read_cx8)
+SYM_FUNC_START(atomic64_read_cx8)
 	read64 %ecx
 	ret
-ENDPROC(atomic64_read_cx8)
+SYM_FUNC_END(atomic64_read_cx8)
 
-ENTRY(atomic64_set_cx8)
+SYM_FUNC_START(atomic64_set_cx8)
 1:
 /* we don't need LOCK_PREFIX since aligned 64-bit writes
  * are atomic on 586 and newer */
@@ -29,19 +29,19 @@ ENTRY(atomic64_set_cx8)
 	jne 1b
 
 	ret
-ENDPROC(atomic64_set_cx8)
+SYM_FUNC_END(atomic64_set_cx8)
 
-ENTRY(atomic64_xchg_cx8)
+SYM_FUNC_START(atomic64_xchg_cx8)
 1:
 	LOCK_PREFIX
 	cmpxchg8b (%esi)
 	jne 1b
 
 	ret
-ENDPROC(atomic64_xchg_cx8)
+SYM_FUNC_END(atomic64_xchg_cx8)
 
 .macro addsub_return func ins insc
-ENTRY(atomic64_\func\()_return_cx8)
+SYM_FUNC_START(atomic64_\func\()_return_cx8)
 	pushl %ebp
 	pushl %ebx
 	pushl %esi
@@ -69,14 +69,14 @@ ENTRY(atomic64_\func\()_return_cx8)
 	popl %ebx
 	popl %ebp
 	ret
-ENDPROC(atomic64_\func\()_return_cx8)
+SYM_FUNC_END(atomic64_\func\()_return_cx8)
 .endm
 
 addsub_return add add adc
 addsub_return sub sub sbb
 
 .macro incdec_return func ins insc
-ENTRY(atomic64_\func\()_return_cx8)
+SYM_FUNC_START(atomic64_\func\()_return_cx8)
 	pushl %ebx
 
 	read64 %esi
@@ -94,13 +94,13 @@ ENTRY(atomic64_\func\()_return_cx8)
 	movl %ecx, %edx
 	popl %ebx
 	ret
-ENDPROC(atomic64_\func\()_return_cx8)
+SYM_FUNC_END(atomic64_\func\()_return_cx8)
 .endm
 
 incdec_return inc add adc
 incdec_return dec sub sbb
 
-ENTRY(atomic64_dec_if_positive_cx8)
+SYM_FUNC_START(atomic64_dec_if_positive_cx8)
 	pushl %ebx
 
 	read64 %esi
@@ -119,9 +119,9 @@ ENTRY(atomic64_dec_if_positive_cx8)
 	movl %ecx, %edx
 	popl %ebx
 	ret
-ENDPROC(atomic64_dec_if_positive_cx8)
+SYM_FUNC_END(atomic64_dec_if_positive_cx8)
 
-ENTRY(atomic64_add_unless_cx8)
+SYM_FUNC_START(atomic64_add_unless_cx8)
 	pushl %ebp
 	pushl %ebx
 /* these just push these two parameters on the stack */
@@ -155,9 +155,9 @@ ENTRY(atomic64_add_unless_cx8)
 	jne 2b
 	xorl %eax, %eax
 	jmp 3b
-ENDPROC(atomic64_add_unless_cx8)
+SYM_FUNC_END(atomic64_add_unless_cx8)
 
-ENTRY(atomic64_inc_not_zero_cx8)
+SYM_FUNC_START(atomic64_inc_not_zero_cx8)
 	pushl %ebx
 
 	read64 %esi
@@ -177,4 +177,4 @@ ENTRY(atomic64_inc_not_zero_cx8)
 3:
 	popl %ebx
 	ret
-ENDPROC(atomic64_inc_not_zero_cx8)
+SYM_FUNC_END(atomic64_inc_not_zero_cx8)
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 74256bd193da..4742e8fa7ee7 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -46,7 +46,7 @@ unsigned int csum_partial(const unsigned char * buff, int len, unsigned int sum)
 	   * Fortunately, it is easy to convert 2-byte alignment to 4-byte
 	   * alignment for the unrolled loop.
 	   */		
-ENTRY(csum_partial)
+SYM_FUNC_START(csum_partial)
 	pushl %esi
 	pushl %ebx
 	movl 20(%esp),%eax	# Function arg: unsigned int sum
@@ -128,13 +128,13 @@ ENTRY(csum_partial)
 	popl %ebx
 	popl %esi
 	ret
-ENDPROC(csum_partial)
+SYM_FUNC_END(csum_partial)
 
 #else
 
 /* Version for PentiumII/PPro */
 
-ENTRY(csum_partial)
+SYM_FUNC_START(csum_partial)
 	pushl %esi
 	pushl %ebx
 	movl 20(%esp),%eax	# Function arg: unsigned int sum
@@ -246,7 +246,7 @@ ENTRY(csum_partial)
 	popl %ebx
 	popl %esi
 	ret
-ENDPROC(csum_partial)
+SYM_FUNC_END(csum_partial)
 				
 #endif
 EXPORT_SYMBOL(csum_partial)
diff --git a/arch/x86/math-emu/div_Xsig.S b/arch/x86/math-emu/div_Xsig.S
index ee08449d20fd..951da2ad54bb 100644
--- a/arch/x86/math-emu/div_Xsig.S
+++ b/arch/x86/math-emu/div_Xsig.S
@@ -75,7 +75,7 @@ FPU_result_1:
 
 
 .text
-ENTRY(div_Xsig)
+SYM_FUNC_START(div_Xsig)
 	pushl	%ebp
 	movl	%esp,%ebp
 #ifndef NON_REENTRANT_FPU
@@ -364,4 +364,4 @@ L_bugged_2:
 	pop	%ebx
 	jmp	L_exit
 #endif /* PARANOID */ 
-ENDPROC(div_Xsig)
+SYM_FUNC_END(div_Xsig)
diff --git a/arch/x86/math-emu/div_small.S b/arch/x86/math-emu/div_small.S
index 8f5025c80ee0..d047d1816abe 100644
--- a/arch/x86/math-emu/div_small.S
+++ b/arch/x86/math-emu/div_small.S
@@ -19,7 +19,7 @@
 #include "fpu_emu.h"
 
 .text
-ENTRY(FPU_div_small)
+SYM_FUNC_START(FPU_div_small)
 	pushl	%ebp
 	movl	%esp,%ebp
 
@@ -45,4 +45,4 @@ ENTRY(FPU_div_small)
 
 	leave
 	ret
-ENDPROC(FPU_div_small)
+SYM_FUNC_END(FPU_div_small)
diff --git a/arch/x86/math-emu/mul_Xsig.S b/arch/x86/math-emu/mul_Xsig.S
index 3e489122a2b0..4afc7b1fa6e9 100644
--- a/arch/x86/math-emu/mul_Xsig.S
+++ b/arch/x86/math-emu/mul_Xsig.S
@@ -25,7 +25,7 @@
 #include "fpu_emu.h"
 
 .text
-ENTRY(mul32_Xsig)
+SYM_FUNC_START(mul32_Xsig)
 	pushl %ebp
 	movl %esp,%ebp
 	subl $16,%esp
@@ -63,10 +63,10 @@ ENTRY(mul32_Xsig)
 	popl %esi
 	leave
 	ret
-ENDPROC(mul32_Xsig)
+SYM_FUNC_END(mul32_Xsig)
 
 
-ENTRY(mul64_Xsig)
+SYM_FUNC_START(mul64_Xsig)
 	pushl %ebp
 	movl %esp,%ebp
 	subl $16,%esp
@@ -116,11 +116,11 @@ ENTRY(mul64_Xsig)
 	popl %esi
 	leave
 	ret
-ENDPROC(mul64_Xsig)
+SYM_FUNC_END(mul64_Xsig)
 
 
 
-ENTRY(mul_Xsig_Xsig)
+SYM_FUNC_START(mul_Xsig_Xsig)
 	pushl %ebp
 	movl %esp,%ebp
 	subl $16,%esp
@@ -176,4 +176,4 @@ ENTRY(mul_Xsig_Xsig)
 	popl %esi
 	leave
 	ret
-ENDPROC(mul_Xsig_Xsig)
+SYM_FUNC_END(mul_Xsig_Xsig)
diff --git a/arch/x86/math-emu/polynom_Xsig.S b/arch/x86/math-emu/polynom_Xsig.S
index 604f0b2d17e8..702315eecb86 100644
--- a/arch/x86/math-emu/polynom_Xsig.S
+++ b/arch/x86/math-emu/polynom_Xsig.S
@@ -37,7 +37,7 @@
 #define OVERFLOWED      -16(%ebp)	/* addition overflow flag */
 
 .text
-ENTRY(polynomial_Xsig)
+SYM_FUNC_START(polynomial_Xsig)
 	pushl	%ebp
 	movl	%esp,%ebp
 	subl	$32,%esp
@@ -134,4 +134,4 @@ L_accum_done:
 	popl	%esi
 	leave
 	ret
-ENDPROC(polynomial_Xsig)
+SYM_FUNC_END(polynomial_Xsig)
diff --git a/arch/x86/math-emu/reg_norm.S b/arch/x86/math-emu/reg_norm.S
index 7f6b4392a15d..cad1d60b1e84 100644
--- a/arch/x86/math-emu/reg_norm.S
+++ b/arch/x86/math-emu/reg_norm.S
@@ -22,7 +22,7 @@
 
 
 .text
-ENTRY(FPU_normalize)
+SYM_FUNC_START(FPU_normalize)
 	pushl	%ebp
 	movl	%esp,%ebp
 	pushl	%ebx
@@ -95,12 +95,12 @@ L_overflow:
 	call	arith_overflow
 	pop	%ebx
 	jmp	L_exit
-ENDPROC(FPU_normalize)
+SYM_FUNC_END(FPU_normalize)
 
 
 
 /* Normalise without reporting underflow or overflow */
-ENTRY(FPU_normalize_nuo)
+SYM_FUNC_START(FPU_normalize_nuo)
 	pushl	%ebp
 	movl	%esp,%ebp
 	pushl	%ebx
@@ -147,4 +147,4 @@ L_exit_nuo_zero:
 	popl	%ebx
 	leave
 	ret
-ENDPROC(FPU_normalize_nuo)
+SYM_FUNC_END(FPU_normalize_nuo)
diff --git a/arch/x86/math-emu/reg_round.S b/arch/x86/math-emu/reg_round.S
index 04563421ee7d..11a1f798451b 100644
--- a/arch/x86/math-emu/reg_round.S
+++ b/arch/x86/math-emu/reg_round.S
@@ -109,7 +109,7 @@ FPU_denormal:
 .globl fpu_Arith_exit
 
 /* Entry point when called from C */
-ENTRY(FPU_round)
+SYM_FUNC_START(FPU_round)
 	pushl	%ebp
 	movl	%esp,%ebp
 	pushl	%esi
@@ -708,4 +708,4 @@ L_exception_exit:
 	jmp	fpu_reg_round_special_exit
 #endif /* PARANOID */ 
 
-ENDPROC(FPU_round)
+SYM_FUNC_END(FPU_round)
diff --git a/arch/x86/math-emu/reg_u_add.S b/arch/x86/math-emu/reg_u_add.S
index 50fe9f8c893c..9c9e2c810afe 100644
--- a/arch/x86/math-emu/reg_u_add.S
+++ b/arch/x86/math-emu/reg_u_add.S
@@ -32,7 +32,7 @@
 #include "control_w.h"
 
 .text
-ENTRY(FPU_u_add)
+SYM_FUNC_START(FPU_u_add)
 	pushl	%ebp
 	movl	%esp,%ebp
 	pushl	%esi
@@ -166,4 +166,4 @@ L_exit:
 	leave
 	ret
 #endif /* PARANOID */
-ENDPROC(FPU_u_add)
+SYM_FUNC_END(FPU_u_add)
diff --git a/arch/x86/math-emu/reg_u_div.S b/arch/x86/math-emu/reg_u_div.S
index 94d545e118e4..e2fb5c2644c5 100644
--- a/arch/x86/math-emu/reg_u_div.S
+++ b/arch/x86/math-emu/reg_u_div.S
@@ -75,7 +75,7 @@ FPU_ovfl_flag:
 #define DEST	PARAM3
 
 .text
-ENTRY(FPU_u_div)
+SYM_FUNC_START(FPU_u_div)
 	pushl	%ebp
 	movl	%esp,%ebp
 #ifndef NON_REENTRANT_FPU
@@ -471,4 +471,4 @@ L_exit:
 	ret
 #endif /* PARANOID */ 
 
-ENDPROC(FPU_u_div)
+SYM_FUNC_END(FPU_u_div)
diff --git a/arch/x86/math-emu/reg_u_mul.S b/arch/x86/math-emu/reg_u_mul.S
index 21cde47fb3e5..0c779c87ac5b 100644
--- a/arch/x86/math-emu/reg_u_mul.S
+++ b/arch/x86/math-emu/reg_u_mul.S
@@ -45,7 +45,7 @@ FPU_accum_1:
 
 
 .text
-ENTRY(FPU_u_mul)
+SYM_FUNC_START(FPU_u_mul)
 	pushl	%ebp
 	movl	%esp,%ebp
 #ifndef NON_REENTRANT_FPU
@@ -147,4 +147,4 @@ L_exit:
 	ret
 #endif /* PARANOID */ 
 
-ENDPROC(FPU_u_mul)
+SYM_FUNC_END(FPU_u_mul)
diff --git a/arch/x86/math-emu/reg_u_sub.S b/arch/x86/math-emu/reg_u_sub.S
index f05dea7dec38..e9bb7c248649 100644
--- a/arch/x86/math-emu/reg_u_sub.S
+++ b/arch/x86/math-emu/reg_u_sub.S
@@ -33,7 +33,7 @@
 #include "control_w.h"
 
 .text
-ENTRY(FPU_u_sub)
+SYM_FUNC_START(FPU_u_sub)
 	pushl	%ebp
 	movl	%esp,%ebp
 	pushl	%esi
@@ -271,4 +271,4 @@ L_exit:
 	popl	%esi
 	leave
 	ret
-ENDPROC(FPU_u_sub)
+SYM_FUNC_END(FPU_u_sub)
diff --git a/arch/x86/math-emu/round_Xsig.S b/arch/x86/math-emu/round_Xsig.S
index 226a51e991f1..d9d7de8dbd7b 100644
--- a/arch/x86/math-emu/round_Xsig.S
+++ b/arch/x86/math-emu/round_Xsig.S
@@ -23,7 +23,7 @@
 
 
 .text
-ENTRY(round_Xsig)
+SYM_FUNC_START(round_Xsig)
 	pushl	%ebp
 	movl	%esp,%ebp
 	pushl	%ebx		/* Reserve some space */
@@ -79,11 +79,11 @@ L_exit:
 	popl	%ebx
 	leave
 	ret
-ENDPROC(round_Xsig)
+SYM_FUNC_END(round_Xsig)
 
 
 
-ENTRY(norm_Xsig)
+SYM_FUNC_START(norm_Xsig)
 	pushl	%ebp
 	movl	%esp,%ebp
 	pushl	%ebx		/* Reserve some space */
@@ -139,4 +139,4 @@ L_n_exit:
 	popl	%ebx
 	leave
 	ret
-ENDPROC(norm_Xsig)
+SYM_FUNC_END(norm_Xsig)
diff --git a/arch/x86/math-emu/shr_Xsig.S b/arch/x86/math-emu/shr_Xsig.S
index 96f4779aa9c1..726af985f758 100644
--- a/arch/x86/math-emu/shr_Xsig.S
+++ b/arch/x86/math-emu/shr_Xsig.S
@@ -22,7 +22,7 @@
 #include "fpu_emu.h"
 
 .text
-ENTRY(shr_Xsig)
+SYM_FUNC_START(shr_Xsig)
 	push	%ebp
 	movl	%esp,%ebp
 	pushl	%esi
@@ -86,4 +86,4 @@ L_more_than_95:
 	popl	%esi
 	leave
 	ret
-ENDPROC(shr_Xsig)
+SYM_FUNC_END(shr_Xsig)
diff --git a/arch/x86/math-emu/wm_shrx.S b/arch/x86/math-emu/wm_shrx.S
index d588874eb6fb..4fc89174caf0 100644
--- a/arch/x86/math-emu/wm_shrx.S
+++ b/arch/x86/math-emu/wm_shrx.S
@@ -33,7 +33,7 @@
  |   Results returned in the 64 bit arg and eax.                             |
  +---------------------------------------------------------------------------*/
 
-ENTRY(FPU_shrx)
+SYM_FUNC_START(FPU_shrx)
 	push	%ebp
 	movl	%esp,%ebp
 	pushl	%esi
@@ -93,7 +93,7 @@ L_more_than_95:
 	popl	%esi
 	leave
 	ret
-ENDPROC(FPU_shrx)
+SYM_FUNC_END(FPU_shrx)
 
 
 /*---------------------------------------------------------------------------+
@@ -112,7 +112,7 @@ ENDPROC(FPU_shrx)
  |   part which has been shifted out of the arg.                             |
  |   Results returned in the 64 bit arg and eax.                             |
  +---------------------------------------------------------------------------*/
-ENTRY(FPU_shrxs)
+SYM_FUNC_START(FPU_shrxs)
 	push	%ebp
 	movl	%esp,%ebp
 	pushl	%esi
@@ -204,4 +204,4 @@ Ls_more_than_95:
 	popl	%esi
 	leave
 	ret
-ENDPROC(FPU_shrxs)
+SYM_FUNC_END(FPU_shrxs)
diff --git a/arch/x86/math-emu/wm_sqrt.S b/arch/x86/math-emu/wm_sqrt.S
index f031c0e19356..3b2b58164ec1 100644
--- a/arch/x86/math-emu/wm_sqrt.S
+++ b/arch/x86/math-emu/wm_sqrt.S
@@ -75,7 +75,7 @@ FPU_fsqrt_arg_0:
 
 
 .text
-ENTRY(wm_sqrt)
+SYM_FUNC_START(wm_sqrt)
 	pushl	%ebp
 	movl	%esp,%ebp
 #ifndef NON_REENTRANT_FPU
@@ -469,4 +469,4 @@ sqrt_more_prec_large:
 /* Our estimate is too large */
 	movl	$0x7fffff00,%eax
 	jmp	sqrt_round_result
-ENDPROC(wm_sqrt)
+SYM_FUNC_END(wm_sqrt)
diff --git a/arch/x86/platform/efi/efi_stub_32.S b/arch/x86/platform/efi/efi_stub_32.S
index ab2e91e76894..eed8b5b441f8 100644
--- a/arch/x86/platform/efi/efi_stub_32.S
+++ b/arch/x86/platform/efi/efi_stub_32.S
@@ -22,7 +22,7 @@
  */
 
 .text
-ENTRY(efi_call_phys)
+SYM_FUNC_START(efi_call_phys)
 	/*
 	 * 0. The function can only be called in Linux kernel. So CS has been
 	 * set to 0x0010, DS and SS have been set to 0x0018. In EFI, I found
@@ -114,7 +114,7 @@ ENTRY(efi_call_phys)
 	movl	(%edx), %ecx
 	pushl	%ecx
 	ret
-ENDPROC(efi_call_phys)
+SYM_FUNC_END(efi_call_phys)
 .previous
 
 .data
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index a19ed3d23185..8786653ad3c0 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -16,7 +16,7 @@
 
 .text
 
-ENTRY(swsusp_arch_suspend)
+SYM_FUNC_START(swsusp_arch_suspend)
 	movl %esp, saved_context_esp
 	movl %ebx, saved_context_ebx
 	movl %ebp, saved_context_ebp
@@ -33,7 +33,7 @@ ENTRY(swsusp_arch_suspend)
 	call swsusp_save
 	FRAME_END
 	ret
-ENDPROC(swsusp_arch_suspend)
+SYM_FUNC_END(swsusp_arch_suspend)
 
 SYM_CODE_START(restore_image)
 	/* prepare to jump to the image kernel */
@@ -82,7 +82,7 @@ SYM_CODE_END(core_restore_code)
 
 	/* code below belongs to the image kernel */
 	.align PAGE_SIZE
-ENTRY(restore_registers)
+SYM_FUNC_START(restore_registers)
 	/* go back to the original page tables */
 	movl	%ebp, %cr3
 	movl	mmu_cr4_features, %ecx
@@ -109,4 +109,4 @@ ENTRY(restore_registers)
 	movl	%eax, in_suspend
 
 	ret
-ENDPROC(restore_registers)
+SYM_FUNC_END(restore_registers)
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 5ffcf72c8f87..331a2306312c 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -112,15 +112,13 @@
 	.globl name ASM_NL \
 	name:
 #endif
-#endif
 
-#ifndef CONFIG_X86_64
 #ifndef ENTRY
 /* deprecated, use SYM_FUNC_START */
 #define ENTRY(name) \
 	SYM_FUNC_START(name)
 #endif
-#endif /* CONFIG_X86_64 */
+#endif /* CONFIG_X86 */
 #endif /* LINKER_SCRIPT */
 
 #ifndef WEAK
@@ -135,9 +133,7 @@
 #define END(name) \
 	.size name, .-name
 #endif
-#endif /* CONFIG_X86 */
 
-#ifndef CONFIG_X86_64
 /* If symbol 'name' is treated as a subroutine (gets called, and returns)
  * then please use ENDPROC to mark 'name' as STT_FUNC for the benefit of
  * static analysis tools such as stack depth analyzer.
@@ -147,7 +143,7 @@
 #define ENDPROC(name) \
 	SYM_FUNC_END(name)
 #endif
-#endif /* CONFIG_X86_64 */
+#endif /* CONFIG_X86 */
 
 /* === generic annotations === */
 
-- 
2.23.0

