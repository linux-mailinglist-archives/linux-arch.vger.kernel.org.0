Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA04AD3EE5
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfJKLwJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:52:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:33440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728090AbfJKLvZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 222B3B493;
        Fri, 11 Oct 2019 11:51:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v9 20/28] x86/asm: Make some functions local
Date:   Fri, 11 Oct 2019 13:51:00 +0200
Message-Id: <20191011115108.12392-21-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is a couple of assembly functions, which are invoked only locally
in the file they are defined. In C, they are marked "static". In
assembly, annotate them using SYM_{FUNC,CODE}_START_LOCAL (and switch
their ENDPROC to SYM_{FUNC,CODE}_END too). Whether FUNC or CODE is used,
depends on whether ENDPROC or END was used for a particular function
before.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/boot/compressed/efi_thunk_64.S |  8 ++++----
 arch/x86/entry/entry_64.S               | 21 +++++++++++----------
 arch/x86/lib/copy_page_64.S             |  4 ++--
 arch/x86/lib/memcpy_64.S                | 12 ++++++------
 arch/x86/lib/memset_64.S                |  8 ++++----
 arch/x86/platform/efi/efi_thunk_64.S    | 12 ++++++------
 arch/x86/platform/pvh/head.S            |  4 ++--
 7 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index d66000d23921..31312070db22 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -99,12 +99,12 @@ ENTRY(efi64_thunk)
 	ret
 ENDPROC(efi64_thunk)
 
-ENTRY(efi_exit32)
+SYM_FUNC_START_LOCAL(efi_exit32)
 	movq	func_rt_ptr(%rip), %rax
 	push	%rax
 	mov	%rdi, %rax
 	ret
-ENDPROC(efi_exit32)
+SYM_FUNC_END(efi_exit32)
 
 	.code32
 /*
@@ -112,7 +112,7 @@ ENDPROC(efi_exit32)
  *
  * The stack should represent the 32-bit calling convention.
  */
-ENTRY(efi_enter32)
+SYM_FUNC_START_LOCAL(efi_enter32)
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
 	movl	%eax, %es
@@ -172,7 +172,7 @@ ENTRY(efi_enter32)
 	btsl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 	lret
-ENDPROC(efi_enter32)
+SYM_FUNC_END(efi_enter32)
 
 	.data
 	.balign	8
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 57d246048ac6..1568da63bf16 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1101,7 +1101,8 @@ idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
  * existing activation in its critical region -- if so, we pop the current
  * activation and restart the handler using the previous one.
  */
-ENTRY(xen_do_hypervisor_callback)		/* do_hypervisor_callback(struct *pt_regs) */
+/* do_hypervisor_callback(struct *pt_regs) */
+SYM_CODE_START_LOCAL(xen_do_hypervisor_callback)
 
 /*
  * Since we don't modify %rdi, evtchn_do_upall(struct *pt_regs) will
@@ -1119,7 +1120,7 @@ ENTRY(xen_do_hypervisor_callback)		/* do_hypervisor_callback(struct *pt_regs) */
 	call	xen_maybe_preempt_hcall
 #endif
 	jmp	error_exit
-END(xen_do_hypervisor_callback)
+SYM_CODE_END(xen_do_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
@@ -1214,7 +1215,7 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
  * Use slow, but surefire "are we in kernel?" check.
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
-ENTRY(paranoid_entry)
+SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
@@ -1248,7 +1249,7 @@ ENTRY(paranoid_entry)
 	FENCE_SWAPGS_KERNEL_ENTRY
 
 	ret
-END(paranoid_entry)
+SYM_CODE_END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
@@ -1262,7 +1263,7 @@ END(paranoid_entry)
  *
  * On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
  */
-ENTRY(paranoid_exit)
+SYM_CODE_START_LOCAL(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF_DEBUG
@@ -1279,12 +1280,12 @@ ENTRY(paranoid_exit)
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:
 	jmp restore_regs_and_return_to_kernel
-END(paranoid_exit)
+SYM_CODE_END(paranoid_exit)
 
 /*
  * Save all registers in pt_regs, and switch GS if needed.
  */
-ENTRY(error_entry)
+SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
@@ -1364,16 +1365,16 @@ ENTRY(error_entry)
 	call	fixup_bad_iret
 	mov	%rax, %rsp
 	jmp	.Lerror_entry_from_usermode_after_swapgs
-END(error_entry)
+SYM_CODE_END(error_entry)
 
-ENTRY(error_exit)
+SYM_CODE_START_LOCAL(error_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 	testb	$3, CS(%rsp)
 	jz	retint_kernel
 	jmp	.Lretint_user
-END(error_exit)
+SYM_CODE_END(error_exit)
 
 /*
  * Runs on exception stack.  Xen PV does not go through this path at all,
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index fd2d09afa097..f505870bd93b 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -21,7 +21,7 @@ ENTRY(copy_page)
 ENDPROC(copy_page)
 EXPORT_SYMBOL(copy_page)
 
-ENTRY(copy_page_regs)
+SYM_FUNC_START_LOCAL(copy_page_regs)
 	subq	$2*8,	%rsp
 	movq	%rbx,	(%rsp)
 	movq	%r12,	1*8(%rsp)
@@ -86,4 +86,4 @@ ENTRY(copy_page_regs)
 	movq	1*8(%rsp), %r12
 	addq	$2*8, %rsp
 	ret
-ENDPROC(copy_page_regs)
+SYM_FUNC_END(copy_page_regs)
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 57a64266ba69..3265b21e86c0 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -29,7 +29,7 @@
  * rax original destination
  */
 SYM_FUNC_START_ALIAS(__memcpy)
-ENTRY(memcpy)
+SYM_FUNC_START_LOCAL(memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
@@ -41,7 +41,7 @@ ENTRY(memcpy)
 	movl %edx, %ecx
 	rep movsb
 	ret
-ENDPROC(memcpy)
+SYM_FUNC_END(memcpy)
 SYM_FUNC_END_ALIAS(__memcpy)
 EXPORT_SYMBOL(memcpy)
 EXPORT_SYMBOL(__memcpy)
@@ -50,14 +50,14 @@ EXPORT_SYMBOL(__memcpy)
  * memcpy_erms() - enhanced fast string memcpy. This is faster and
  * simpler than memcpy. Use memcpy_erms when possible.
  */
-ENTRY(memcpy_erms)
+SYM_FUNC_START_LOCAL(memcpy_erms)
 	movq %rdi, %rax
 	movq %rdx, %rcx
 	rep movsb
 	ret
-ENDPROC(memcpy_erms)
+SYM_FUNC_END(memcpy_erms)
 
-ENTRY(memcpy_orig)
+SYM_FUNC_START_LOCAL(memcpy_orig)
 	movq %rdi, %rax
 
 	cmpq $0x20, %rdx
@@ -182,7 +182,7 @@ ENTRY(memcpy_orig)
 
 .Lend:
 	retq
-ENDPROC(memcpy_orig)
+SYM_FUNC_END(memcpy_orig)
 
 #ifndef CONFIG_UML
 
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 927ac44d34aa..564abf9ecedb 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -59,16 +59,16 @@ EXPORT_SYMBOL(__memset)
  *
  * rax   original destination
  */
-ENTRY(memset_erms)
+SYM_FUNC_START_LOCAL(memset_erms)
 	movq %rdi,%r9
 	movb %sil,%al
 	movq %rdx,%rcx
 	rep stosb
 	movq %r9,%rax
 	ret
-ENDPROC(memset_erms)
+SYM_FUNC_END(memset_erms)
 
-ENTRY(memset_orig)
+SYM_FUNC_START_LOCAL(memset_orig)
 	movq %rdi,%r10
 
 	/* expand byte value  */
@@ -139,4 +139,4 @@ ENTRY(memset_orig)
 	subq %r8,%rdx
 	jmp .Lafter_bad_alignment
 .Lfinal:
-ENDPROC(memset_orig)
+SYM_FUNC_END(memset_orig)
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 46c58b08739c..d677a7eb2d0a 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -67,7 +67,7 @@ ENDPROC(efi64_thunk)
  *
  * This function must be invoked with a 1:1 mapped stack.
  */
-ENTRY(__efi64_thunk)
+SYM_FUNC_START_LOCAL(__efi64_thunk)
 	movl	%ds, %eax
 	push	%rax
 	movl	%es, %eax
@@ -114,14 +114,14 @@ ENTRY(__efi64_thunk)
 	or	%rcx, %rax
 1:
 	ret
-ENDPROC(__efi64_thunk)
+SYM_FUNC_END(__efi64_thunk)
 
-ENTRY(efi_exit32)
+SYM_FUNC_START_LOCAL(efi_exit32)
 	movq	func_rt_ptr(%rip), %rax
 	push	%rax
 	mov	%rdi, %rax
 	ret
-ENDPROC(efi_exit32)
+SYM_FUNC_END(efi_exit32)
 
 	.code32
 /*
@@ -129,7 +129,7 @@ ENDPROC(efi_exit32)
  *
  * The stack should represent the 32-bit calling convention.
  */
-ENTRY(efi_enter32)
+SYM_FUNC_START_LOCAL(efi_enter32)
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
 	movl	%eax, %es
@@ -145,7 +145,7 @@ ENTRY(efi_enter32)
 	pushl	%eax
 
 	lret
-ENDPROC(efi_enter32)
+SYM_FUNC_END(efi_enter32)
 
 	.data
 	.balign	8
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 4e63480bb223..43b4d864817e 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -50,7 +50,7 @@
 #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
 #define PVH_CANARY_SEL		(PVH_GDT_ENTRY_CANARY * 8)
 
-ENTRY(pvh_start_xen)
+SYM_CODE_START_LOCAL(pvh_start_xen)
 	cld
 
 	lgdt (_pa(gdt))
@@ -146,7 +146,7 @@ ENTRY(pvh_start_xen)
 
 	ljmp $PVH_CS_SEL, $_pa(startup_32)
 #endif
-END(pvh_start_xen)
+SYM_CODE_END(pvh_start_xen)
 
 	.section ".init.data","aw"
 	.balign 8
-- 
2.23.0

