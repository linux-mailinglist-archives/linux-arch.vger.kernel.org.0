Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9333DDCB06
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbfJRQan (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:30:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57580 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbfJRQam (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV98-0002m7-MN; Fri, 18 Oct 2019 18:30:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 35ED01C048C;
        Fri, 18 Oct 2019 18:30:29 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:28 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/realmode: Use SYM_DATA_* instead of GLOBAL
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-arch@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-19-jslaby@suse.cz>
References: <20191011115108.12392-19-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141622891.29376.4044422203344506913.tip-bot2@tip-bot2>
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

Commit-ID:     78f44330d80e2632856b840cf82aa554f34415a1
Gitweb:        https://git.kernel.org/tip/78f44330d80e2632856b840cf82aa554f34415a1
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:58 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 11:28:47 +02:00

x86/asm/realmode: Use SYM_DATA_* instead of GLOBAL

GLOBAL had several meanings and is going away. Convert all the data
marked using GLOBAL to use SYM_DATA_START or SYM_DATA instead.

Note that SYM_DATA_END_LABEL is used to generate tr_gdt_end too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-arch@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191011115108.12392-19-jslaby@suse.cz
---
 arch/x86/realmode/rm/header.S            |  8 +++-----
 arch/x86/realmode/rm/reboot.S            |  8 ++++----
 arch/x86/realmode/rm/stack.S             | 14 ++++++--------
 arch/x86/realmode/rm/trampoline_32.S     | 10 +++++-----
 arch/x86/realmode/rm/trampoline_64.S     | 19 +++++++++----------
 arch/x86/realmode/rm/trampoline_common.S |  2 +-
 arch/x86/realmode/rm/wakeup_asm.S        |  8 ++++----
 arch/x86/realmode/rmpiggy.S              | 10 ++++------
 8 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 6363761..af04512 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -14,7 +14,7 @@
 	.section ".header", "a"
 
 	.balign	16
-GLOBAL(real_mode_header)
+SYM_DATA_START(real_mode_header)
 	.long	pa_text_start
 	.long	pa_ro_end
 	/* SMP trampoline */
@@ -33,11 +33,9 @@ GLOBAL(real_mode_header)
 #ifdef CONFIG_X86_64
 	.long	__KERNEL32_CS
 #endif
-END(real_mode_header)
+SYM_DATA_END(real_mode_header)
 
 	/* End signature, used to verify integrity */
 	.section ".signature","a"
 	.balign 4
-GLOBAL(end_signature)
-	.long	REALMODE_END_SIGNATURE
-END(end_signature)
+SYM_DATA(end_signature, .long REALMODE_END_SIGNATURE)
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index f91425a..424826a 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -127,13 +127,13 @@ bios:
 	.section ".rodata", "a"
 
 	.balign	16
-GLOBAL(machine_real_restart_idt)
+SYM_DATA_START(machine_real_restart_idt)
 	.word	0xffff		/* Length - real mode default value */
 	.long	0		/* Base - real mode default value */
-END(machine_real_restart_idt)
+SYM_DATA_END(machine_real_restart_idt)
 
 	.balign	16
-GLOBAL(machine_real_restart_gdt)
+SYM_DATA_START(machine_real_restart_gdt)
 	/* Self-pointer */
 	.word	0xffff		/* Length - real mode default value */
 	.long	pa_machine_real_restart_gdt
@@ -153,4 +153,4 @@ GLOBAL(machine_real_restart_gdt)
 	 * semantics we don't have to reload the segments once CR0.PE = 0.
 	 */
 	.quad	GDT_ENTRY(0x0093, 0x100, 0xffff)
-END(machine_real_restart_gdt)
+SYM_DATA_END(machine_real_restart_gdt)
diff --git a/arch/x86/realmode/rm/stack.S b/arch/x86/realmode/rm/stack.S
index 8d4cb64..0fca640 100644
--- a/arch/x86/realmode/rm/stack.S
+++ b/arch/x86/realmode/rm/stack.S
@@ -6,15 +6,13 @@
 #include <linux/linkage.h>
 
 	.data
-GLOBAL(HEAP)
-	.long	rm_heap
-GLOBAL(heap_end)
-	.long	rm_stack
+SYM_DATA(HEAP,		.long rm_heap)
+SYM_DATA(heap_end,	.long rm_stack)
 
 	.bss
 	.balign	16
-GLOBAL(rm_heap)
-	.space	2048
-GLOBAL(rm_stack)
+SYM_DATA(rm_heap,	.space 2048)
+
+SYM_DATA_START(rm_stack)
 	.space	2048
-GLOBAL(rm_stack_end)
+SYM_DATA_END_LABEL(rm_stack, SYM_L_GLOBAL, rm_stack_end)
diff --git a/arch/x86/realmode/rm/trampoline_32.S b/arch/x86/realmode/rm/trampoline_32.S
index 1868b15..ff00594 100644
--- a/arch/x86/realmode/rm/trampoline_32.S
+++ b/arch/x86/realmode/rm/trampoline_32.S
@@ -62,10 +62,10 @@ ENTRY(startup_32)			# note: also used from wakeup_asm.S
 
 	.bss
 	.balign 8
-GLOBAL(trampoline_header)
-	tr_start:		.space	4
-	tr_gdt_pad:		.space	2
-	tr_gdt:			.space	6
-END(trampoline_header)
+SYM_DATA_START(trampoline_header)
+	SYM_DATA_LOCAL(tr_start,	.space 4)
+	SYM_DATA_LOCAL(tr_gdt_pad,	.space 2)
+	SYM_DATA_LOCAL(tr_gdt,		.space 6)
+SYM_DATA_END(trampoline_header)
 	
 #include "trampoline_common.S"
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index aee2b45..c1aeab1 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -149,26 +149,25 @@ ENTRY(startup_64)
 	# Duplicate the global descriptor table
 	# so the kernel can live anywhere
 	.balign	16
-	.globl tr_gdt
-tr_gdt:
+SYM_DATA_START(tr_gdt)
 	.short	tr_gdt_end - tr_gdt - 1	# gdt limit
 	.long	pa_tr_gdt
 	.short	0
 	.quad	0x00cf9b000000ffff	# __KERNEL32_CS
 	.quad	0x00af9b000000ffff	# __KERNEL_CS
 	.quad	0x00cf93000000ffff	# __KERNEL_DS
-tr_gdt_end:
+SYM_DATA_END_LABEL(tr_gdt, SYM_L_LOCAL, tr_gdt_end)
 
 	.bss
 	.balign	PAGE_SIZE
-GLOBAL(trampoline_pgd)		.space	PAGE_SIZE
+SYM_DATA(trampoline_pgd, .space PAGE_SIZE)
 
 	.balign	8
-GLOBAL(trampoline_header)
-	tr_start:		.space	8
-	GLOBAL(tr_efer)		.space	8
-	GLOBAL(tr_cr4)		.space	4
-	GLOBAL(tr_flags)	.space	4
-END(trampoline_header)
+SYM_DATA_START(trampoline_header)
+	SYM_DATA_LOCAL(tr_start,	.space 8)
+	SYM_DATA(tr_efer,		.space 8)
+	SYM_DATA(tr_cr4,		.space 4)
+	SYM_DATA(tr_flags,		.space 4)
+SYM_DATA_END(trampoline_header)
 
 #include "trampoline_common.S"
diff --git a/arch/x86/realmode/rm/trampoline_common.S b/arch/x86/realmode/rm/trampoline_common.S
index 8d8208d..5033e64 100644
--- a/arch/x86/realmode/rm/trampoline_common.S
+++ b/arch/x86/realmode/rm/trampoline_common.S
@@ -1,4 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 	.section ".rodata","a"
 	.balign	16
-tr_idt: .fill 1, 6, 0
+SYM_DATA_LOCAL(tr_idt, .fill 1, 6, 0)
diff --git a/arch/x86/realmode/rm/wakeup_asm.S b/arch/x86/realmode/rm/wakeup_asm.S
index 08438ee..01092d6 100644
--- a/arch/x86/realmode/rm/wakeup_asm.S
+++ b/arch/x86/realmode/rm/wakeup_asm.S
@@ -17,7 +17,7 @@
 	.section ".data", "aw"
 
 	.balign	16
-GLOBAL(wakeup_header)
+SYM_DATA_START(wakeup_header)
 	video_mode:	.short	0	/* Video mode number */
 	pmode_entry:	.long	0
 	pmode_cs:	.short	__KERNEL_CS
@@ -31,7 +31,7 @@ GLOBAL(wakeup_header)
 	realmode_flags:	.long	0
 	real_magic:	.long	0
 	signature:	.long	WAKEUP_HEADER_SIGNATURE
-END(wakeup_header)
+SYM_DATA_END(wakeup_header)
 
 	.text
 	.code16
@@ -152,7 +152,7 @@ bogus_real_magic:
 	 */
 
 	.balign	16
-GLOBAL(wakeup_gdt)
+SYM_DATA_START(wakeup_gdt)
 	.word	3*8-1		/* Self-descriptor */
 	.long	pa_wakeup_gdt
 	.word	0
@@ -164,7 +164,7 @@ GLOBAL(wakeup_gdt)
 	.word	0xffff		/* 16-bit data segment @ real_mode_base */
 	.long	0x93000000 + pa_real_mode_base
 	.word	0x008f		/* big real mode */
-END(wakeup_gdt)
+SYM_DATA_END(wakeup_gdt)
 
 	.section ".rodata","a"
 	.balign	8
diff --git a/arch/x86/realmode/rmpiggy.S b/arch/x86/realmode/rmpiggy.S
index c078dba..c8fef76 100644
--- a/arch/x86/realmode/rmpiggy.S
+++ b/arch/x86/realmode/rmpiggy.S
@@ -10,12 +10,10 @@
 
 	.balign PAGE_SIZE
 
-GLOBAL(real_mode_blob)
+SYM_DATA_START(real_mode_blob)
 	.incbin	"arch/x86/realmode/rm/realmode.bin"
-END(real_mode_blob)
+SYM_DATA_END_LABEL(real_mode_blob, SYM_L_GLOBAL, real_mode_blob_end)
 
-GLOBAL(real_mode_blob_end);
-
-GLOBAL(real_mode_relocs)
+SYM_DATA_START(real_mode_relocs)
 	.incbin	"arch/x86/realmode/rm/realmode.relocs"
-END(real_mode_relocs)
+SYM_DATA_END(real_mode_relocs)
