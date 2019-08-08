Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11E086028
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390042AbfHHKkB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:40:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:47594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403849AbfHHKjK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99AF7B087;
        Thu,  8 Aug 2019 10:39:08 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v8 18/28] x86/asm/realmode: use SYM_DATA_* instead of GLOBAL
Date:   Thu,  8 Aug 2019 12:38:44 +0200
Message-Id: <20190808103854.6192-19-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

GLOBAL had several meanings and is going away. In this patch, convert
all the data marked using GLOBAL to use SYM_DATA_START or SYM_DATA
instead.

Notes:
* SYM_DATA_END_LABEL is used to generate tr_gdt_end too.
* wakeup_idt is marked as LOCAL now as it is used only locally.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/realmode/rm/header.S            |  8 +++-----
 arch/x86/realmode/rm/reboot.S            |  8 ++++----
 arch/x86/realmode/rm/stack.S             | 14 ++++++--------
 arch/x86/realmode/rm/trampoline_32.S     | 10 +++++-----
 arch/x86/realmode/rm/trampoline_64.S     | 19 +++++++++----------
 arch/x86/realmode/rm/trampoline_common.S |  2 +-
 arch/x86/realmode/rm/wakeup_asm.S        | 12 ++++++------
 arch/x86/realmode/rmpiggy.S              | 10 ++++------
 8 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 6363761cc74c..af04512c02d9 100644
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
index f91425a01f8f..424826afb501 100644
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
index 8d4cb64799ea..0fca64061ad2 100644
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
index 1868b158480d..ff00594a2ed0 100644
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
index aee2b45d83b8..c1aeab1dae25 100644
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
index 8d8208dcca24..5033e640f957 100644
--- a/arch/x86/realmode/rm/trampoline_common.S
+++ b/arch/x86/realmode/rm/trampoline_common.S
@@ -1,4 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 	.section ".rodata","a"
 	.balign	16
-tr_idt: .fill 1, 6, 0
+SYM_DATA_LOCAL(tr_idt, .fill 1, 6, 0)
diff --git a/arch/x86/realmode/rm/wakeup_asm.S b/arch/x86/realmode/rm/wakeup_asm.S
index 05ac9c17c811..0af6b30d3c68 100644
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
@@ -164,15 +164,15 @@ GLOBAL(wakeup_gdt)
 	.word	0xffff		/* 16-bit data segment @ real_mode_base */
 	.long	0x93000000 + pa_real_mode_base
 	.word	0x008f		/* big real mode */
-END(wakeup_gdt)
+SYM_DATA_END(wakeup_gdt)
 
 	.section ".rodata","a"
 	.balign	8
 
 	/* This is the standard real-mode IDT */
 	.balign	16
-GLOBAL(wakeup_idt)
+SYM_DATA_START_LOCAL(wakeup_idt)
 	.word	0xffff		/* limit */
 	.long	0		/* address */
 	.word	0
-END(wakeup_idt)
+SYM_DATA_END(wakeup_idt)
diff --git a/arch/x86/realmode/rmpiggy.S b/arch/x86/realmode/rmpiggy.S
index c078dba40cef..c8fef76743f6 100644
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
-- 
2.22.0

