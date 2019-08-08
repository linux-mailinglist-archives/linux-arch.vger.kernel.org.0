Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5BC86006
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403852AbfHHKjJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:39:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:47612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403842AbfHHKjI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CEBEB066;
        Thu,  8 Aug 2019 10:39:07 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v8 16/28] x86/asm: do not annotate functions by GLOBAL
Date:   Thu,  8 Aug 2019 12:38:42 +0200
Message-Id: <20190808103854.6192-17-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

GLOBAL is an x86's custom macro and is going to die very soon. It was
meant for global symbols, but here, it was used for functions. Instead,
use the new macros SYM_FUNC_START* and SYM_CODE_START* (depending on the
type of a function) which are dedicated for global functions. And since
they both require a closing by SYM_*_END, we do this here too.

startup_64, which does not use GLOBAL, but uses .globl explicitly, is
converted too.

in_pm32 should not be global at all as it is used only locally, so
switch to SYM_FUNC_START_LOCAL_NOALIGN.

"No alignments" are preserved.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: <x86@kernel.org>
---
 arch/x86/boot/copy.S      | 16 ++++++++--------
 arch/x86/boot/pmjump.S    |  8 ++++----
 arch/x86/kernel/head_64.S |  5 +++--
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/copy.S b/arch/x86/boot/copy.S
index 4c5f4f4ad035..6afd05e819d2 100644
--- a/arch/x86/boot/copy.S
+++ b/arch/x86/boot/copy.S
@@ -15,7 +15,7 @@
 	.code16
 	.text
 
-GLOBAL(memcpy)
+SYM_FUNC_START_NOALIGN(memcpy)
 	pushw	%si
 	pushw	%di
 	movw	%ax, %di
@@ -29,9 +29,9 @@ GLOBAL(memcpy)
 	popw	%di
 	popw	%si
 	retl
-ENDPROC(memcpy)
+SYM_FUNC_END(memcpy)
 
-GLOBAL(memset)
+SYM_FUNC_START_NOALIGN(memset)
 	pushw	%di
 	movw	%ax, %di
 	movzbl	%dl, %eax
@@ -44,22 +44,22 @@ GLOBAL(memset)
 	rep; stosb
 	popw	%di
 	retl
-ENDPROC(memset)
+SYM_FUNC_END(memset)
 
-GLOBAL(copy_from_fs)
+SYM_FUNC_START_NOALIGN(copy_from_fs)
 	pushw	%ds
 	pushw	%fs
 	popw	%ds
 	calll	memcpy
 	popw	%ds
 	retl
-ENDPROC(copy_from_fs)
+SYM_FUNC_END(copy_from_fs)
 
-GLOBAL(copy_to_fs)
+SYM_FUNC_START_NOALIGN(copy_to_fs)
 	pushw	%es
 	pushw	%fs
 	popw	%es
 	calll	memcpy
 	popw	%es
 	retl
-ENDPROC(copy_to_fs)
+SYM_FUNC_END(copy_to_fs)
diff --git a/arch/x86/boot/pmjump.S b/arch/x86/boot/pmjump.S
index c22f9a7d1aeb..52f37b66b5ba 100644
--- a/arch/x86/boot/pmjump.S
+++ b/arch/x86/boot/pmjump.S
@@ -21,7 +21,7 @@
 /*
  * void protected_mode_jump(u32 entrypoint, u32 bootparams);
  */
-GLOBAL(protected_mode_jump)
+SYM_FUNC_START_NOALIGN(protected_mode_jump)
 	movl	%edx, %esi		# Pointer to boot_params table
 
 	xorl	%ebx, %ebx
@@ -42,11 +42,11 @@ GLOBAL(protected_mode_jump)
 	.byte	0x66, 0xea		# ljmpl opcode
 2:	.long	in_pm32			# offset
 	.word	__BOOT_CS		# segment
-ENDPROC(protected_mode_jump)
+SYM_FUNC_END(protected_mode_jump)
 
 	.code32
 	.section ".text32","ax"
-GLOBAL(in_pm32)
+SYM_FUNC_START_LOCAL_NOALIGN(in_pm32)
 	# Set up data segments for flat 32-bit mode
 	movl	%ecx, %ds
 	movl	%ecx, %es
@@ -72,4 +72,4 @@ GLOBAL(in_pm32)
 	lldt	%cx
 
 	jmpl	*%eax			# Jump to the 32-bit entrypoint
-ENDPROC(in_pm32)
+SYM_FUNC_END(in_pm32)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 6661c76a2049..94d747307c6a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -49,8 +49,7 @@ L3_START_KERNEL = pud_index(__START_KERNEL_map)
 	.text
 	__HEAD
 	.code64
-	.globl startup_64
-startup_64:
+SYM_CODE_START_NOALIGN(startup_64)
 	UNWIND_HINT_EMPTY
 	/*
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
@@ -90,6 +89,8 @@ startup_64:
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
 	jmp 1f
+SYM_CODE_END(startup_64)
+
 ENTRY(secondary_startup_64)
 	UNWIND_HINT_EMPTY
 	/*
-- 
2.22.0

