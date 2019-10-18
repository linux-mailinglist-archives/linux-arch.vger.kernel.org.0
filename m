Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC6DCB7D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502825AbfJRQdC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:33:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57768 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439948AbfJRQa5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV98-0002ja-0v; Fri, 18 Oct 2019 18:30:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 735761C03AB;
        Fri, 18 Oct 2019 18:30:28 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:28 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Make some functions local
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Darren Hart <dvhart@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>, linux-arch@vger.kernel.org,
        "linux-efi" <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, xen-devel@lists.xenproject.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-21-jslaby@suse.cz>
References: <20191011115108.12392-21-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141622822.29376.17208623014273753631.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     ef1e03152cb027d5925646d4d1772ced7595292f
Gitweb:        https://git.kernel.org/tip/ef1e03152cb027d5925646d4d1772ced7595292f
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:51:00 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 11:34:39 +02:00

x86/asm: Make some functions local

There are a couple of assembly functions which are invoked only locally
in the file they are defined. In C, they are marked "static". In
assembly, annotate them using SYM_{FUNC,CODE}_START_LOCAL (and switch
their ENDPROC to SYM_{FUNC,CODE}_END too). Whether FUNC or CODE is used,
depends on whether ENDPROC or END was used for a particular function
before.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-efi <linux-efi@vger.kernel.org>
Cc: linux-efi@vger.kernel.org
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20191011115108.12392-21-jslaby@suse.cz
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
index d66000d..3131207 100644
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
index 57d2460..1568da6 100644
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
index fd2d09a..f505870 100644
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
index 57a6426..3265b21 100644
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
index 927ac44..564abf9 100644
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
index 46c58b0..d677a7e 100644
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
index 4e63480..43b4d86 100644
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
