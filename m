Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936FDDCB39
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442995AbfJRQbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:31:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57843 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443017AbfJRQbR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:31:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV92-0002jQ-4w; Fri, 18 Oct 2019 18:30:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C22611C0450;
        Fri, 18 Oct 2019 18:30:27 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:27 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/64: Add ENDs to some functions and relabel
 with SYM_CODE_*
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arch@vger.kernel.org, linux-pm@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Pingfan Liu <kernelfans@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Huang <wei@redhat.com>, "x86-ml" <x86@kernel.org>,
        xen-devel@lists.xenproject.org,
        Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-23-jslaby@suse.cz>
References: <20191011115108.12392-23-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141622755.29376.5490878094731204617.tip-bot2@tip-bot2>
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

Commit-ID:     4aec216b93dd8e3597124f41369ec835ff18dbd0
Gitweb:        https://git.kernel.org/tip/4aec216b93dd8e3597124f41369ec835ff18dbd0
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:51:02 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 11:58:16 +02:00

x86/asm/64: Add ENDs to some functions and relabel with SYM_CODE_*

All these are functions which are invoked from elsewhere but they are
not typical C functions. So annotate them using the new SYM_CODE_START.
All these were not balanced with any END, so mark their ends by
SYM_CODE_END appropriately too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com> [xen bits]
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> [power mgmt]
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Huang <wei@redhat.com>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Cc: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Link: https://lkml.kernel.org/r/20191011115108.12392-23-jslaby@suse.cz
---
 arch/x86/boot/compressed/head_64.S   |  6 ++++--
 arch/x86/platform/olpc/xo1-wakeup.S  |  3 ++-
 arch/x86/power/hibernate_asm_64.S    |  6 ++++--
 arch/x86/realmode/rm/reboot.S        |  3 ++-
 arch/x86/realmode/rm/trampoline_64.S | 10 +++++++---
 arch/x86/realmode/rm/wakeup_asm.S    |  3 ++-
 arch/x86/xen/xen-asm_64.S            |  6 ++++--
 7 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index ca762ea..5580046 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -250,7 +250,7 @@ ENDPROC(efi32_stub_entry)
 
 	.code64
 	.org 0x200
-ENTRY(startup_64)
+SYM_CODE_START(startup_64)
 	/*
 	 * 64bit entry is 0x200 and it is ABI so immutable!
 	 * We come here either from startup_32 or directly from a
@@ -442,6 +442,7 @@ trampoline_return:
  */
 	leaq	.Lrelocated(%rbx), %rax
 	jmp	*%rax
+SYM_CODE_END(startup_64)
 
 #ifdef CONFIG_EFI_STUB
 
@@ -571,7 +572,7 @@ SYM_FUNC_END(.Lrelocated)
  * ECX contains the base address of the trampoline memory.
  * Non zero RDX means trampoline needs to enable 5-level paging.
  */
-ENTRY(trampoline_32bit_src)
+SYM_CODE_START(trampoline_32bit_src)
 	/* Set up data and stack segments */
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
@@ -634,6 +635,7 @@ ENTRY(trampoline_32bit_src)
 	movl	%eax, %cr0
 
 	lret
+SYM_CODE_END(trampoline_32bit_src)
 
 	.code64
 SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
diff --git a/arch/x86/platform/olpc/xo1-wakeup.S b/arch/x86/platform/olpc/xo1-wakeup.S
index 5fee3a2..75f4faf 100644
--- a/arch/x86/platform/olpc/xo1-wakeup.S
+++ b/arch/x86/platform/olpc/xo1-wakeup.S
@@ -90,7 +90,7 @@ restore_registers:
 
 	ret
 
-ENTRY(do_olpc_suspend_lowlevel)
+SYM_CODE_START(do_olpc_suspend_lowlevel)
 	call	save_processor_state
 	call	save_registers
 
@@ -110,6 +110,7 @@ ret_point:
 	call	restore_registers
 	call	restore_processor_state
 	ret
+SYM_CODE_END(do_olpc_suspend_lowlevel)
 
 .data
 saved_gdt:             .long   0,0
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index a4d5eb0..4057cd5 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -52,7 +52,7 @@ ENTRY(swsusp_arch_suspend)
 	ret
 ENDPROC(swsusp_arch_suspend)
 
-ENTRY(restore_image)
+SYM_CODE_START(restore_image)
 	/* prepare to jump to the image kernel */
 	movq	restore_jump_address(%rip), %r8
 	movq	restore_cr3(%rip), %r9
@@ -67,9 +67,10 @@ ENTRY(restore_image)
 	/* jump to relocated restore code */
 	movq	relocated_restore_code(%rip), %rcx
 	jmpq	*%rcx
+SYM_CODE_END(restore_image)
 
 	/* code below has been relocated to a safe page */
-ENTRY(core_restore_code)
+SYM_CODE_START(core_restore_code)
 	/* switch to temporary page tables */
 	movq	%rax, %cr3
 	/* flush TLB */
@@ -97,6 +98,7 @@ ENTRY(core_restore_code)
 .Ldone:
 	/* jump to the restore_registers address from the image header */
 	jmpq	*%r8
+SYM_CODE_END(core_restore_code)
 
 	 /* code below belongs to the image kernel */
 	.align PAGE_SIZE
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index 424826a..f10515b 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -19,7 +19,7 @@
  */
 	.section ".text32", "ax"
 	.code32
-ENTRY(machine_real_restart_asm)
+SYM_CODE_START(machine_real_restart_asm)
 
 #ifdef CONFIG_X86_64
 	/* Switch to trampoline GDT as it is guaranteed < 4 GiB */
@@ -63,6 +63,7 @@ SYM_INNER_LABEL(machine_real_restart_paging_off, SYM_L_GLOBAL)
 	movl	%ecx, %gs
 	movl	%ecx, %ss
 	ljmpw	$8, $1f
+SYM_CODE_END(machine_real_restart_asm)
 
 /*
  * This is 16-bit protected mode code to disable paging and the cache,
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index c1aeab1..251758e 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -38,7 +38,7 @@
 	.code16
 
 	.balign	PAGE_SIZE
-ENTRY(trampoline_start)
+SYM_CODE_START(trampoline_start)
 	cli			# We should be safe anyway
 	wbinvd
 
@@ -78,12 +78,14 @@ ENTRY(trampoline_start)
 no_longmode:
 	hlt
 	jmp no_longmode
+SYM_CODE_END(trampoline_start)
+
 #include "../kernel/verify_cpu.S"
 
 	.section ".text32","ax"
 	.code32
 	.balign 4
-ENTRY(startup_32)
+SYM_CODE_START(startup_32)
 	movl	%edx, %ss
 	addl	$pa_real_mode_base, %esp
 	movl	%edx, %ds
@@ -137,13 +139,15 @@ ENTRY(startup_32)
 	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
 	 */
 	ljmpl	$__KERNEL_CS, $pa_startup_64
+SYM_CODE_END(startup_32)
 
 	.section ".text64","ax"
 	.code64
 	.balign 4
-ENTRY(startup_64)
+SYM_CODE_START(startup_64)
 	# Now jump into the kernel using virtual addresses
 	jmpq	*tr_start(%rip)
+SYM_CODE_END(startup_64)
 
 	.section ".rodata","a"
 	# Duplicate the global descriptor table
diff --git a/arch/x86/realmode/rm/wakeup_asm.S b/arch/x86/realmode/rm/wakeup_asm.S
index 01092d6..02d0ba1 100644
--- a/arch/x86/realmode/rm/wakeup_asm.S
+++ b/arch/x86/realmode/rm/wakeup_asm.S
@@ -37,7 +37,7 @@ SYM_DATA_END(wakeup_header)
 	.code16
 
 	.balign	16
-ENTRY(wakeup_start)
+SYM_CODE_START(wakeup_start)
 	cli
 	cld
 
@@ -135,6 +135,7 @@ ENTRY(wakeup_start)
 #else
 	jmp	trampoline_start
 #endif
+SYM_CODE_END(wakeup_start)
 
 bogus_real_magic:
 1:
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 45c1249..c209c70 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -85,11 +85,12 @@ hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
  *	r11		}<-- pushed by hypercall page
  * rsp->rax		}
  */
-ENTRY(xen_iret)
+SYM_CODE_START(xen_iret)
 	pushq $0
 	jmp hypercall_iret
+SYM_CODE_END(xen_iret)
 
-ENTRY(xen_sysret64)
+SYM_CODE_START(xen_sysret64)
 	/*
 	 * We're already on the usermode stack at this point, but
 	 * still with the kernel gs, so we can easily switch back.
@@ -107,6 +108,7 @@ ENTRY(xen_sysret64)
 
 	pushq $VGCF_in_syscall
 	jmp hypercall_iret
+SYM_CODE_END(xen_sysret64)
 
 /*
  * Xen handles syscall callbacks much like ordinary exceptions, which
