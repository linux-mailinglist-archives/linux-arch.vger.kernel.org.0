Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B7BD3EED
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfJKLvX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:51:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728045AbfJKLvX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABAF8B48A;
        Fri, 11 Oct 2019 11:51:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v9 16/28] x86/asm: Do not annotate functions by GLOBAL
Date:   Fri, 11 Oct 2019 13:50:56 +0200
Message-Id: <20191011115108.12392-17-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
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
they both require a closing by SYM_*_END, it is done here too.

startup_64, which does not use GLOBAL, but uses .globl explicitly, is
converted too.

"No alignments" are preserved.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: <x86@kernel.org>
---

Notes:
    [v9] in_pm32 is handled in a separate patch

 arch/x86/boot/copy.S      | 16 ++++++++--------
 arch/x86/boot/pmjump.S    |  4 ++--
 arch/x86/kernel/head_64.S |  5 +++--
 3 files changed, 13 insertions(+), 12 deletions(-)

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
index 81658fe35380..cbec8bd0841f 100644
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
@@ -42,7 +42,7 @@ GLOBAL(protected_mode_jump)
 	.byte	0x66, 0xea		# ljmpl opcode
 2:	.long	.Lin_pm32		# offset
 	.word	__BOOT_CS		# segment
-ENDPROC(protected_mode_jump)
+SYM_FUNC_END(protected_mode_jump)
 
 	.code32
 	.section ".text32","ax"
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 8b0926ac4ac6..10f306e31244 100644
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
2.23.0

