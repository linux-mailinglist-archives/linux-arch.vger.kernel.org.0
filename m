Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E2D3EFC
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfJKLvS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:51:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727226AbfJKLvR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 668EFB490;
        Fri, 11 Oct 2019 11:51:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v9 07/28] x86/boot: Annotate local functions
Date:   Fri, 11 Oct 2019 13:50:47 +0200
Message-Id: <20191011115108.12392-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

.Lrelocated, .Lpaging_enabled, .Lno_longmode, and .Lin_pm32 are
self-standing local functions, annotate them as such and preserve "no
alignment".

The annotations do not generate anything yet.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---

Notes:
    [v9] preserve alignments

 arch/x86/boot/compressed/head_32.S | 3 ++-
 arch/x86/boot/compressed/head_64.S | 9 ++++++---
 arch/x86/boot/pmjump.S             | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 5e30eaaf8576..f9e2a80bd699 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -209,7 +209,7 @@ ENDPROC(efi32_stub_entry)
 #endif
 
 	.text
-.Lrelocated:
+SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -260,6 +260,7 @@ ENDPROC(efi32_stub_entry)
  */
 	xorl	%ebx, %ebx
 	jmp	*%eax
+SYM_FUNC_END(.Lrelocated)
 
 #ifdef CONFIG_EFI_STUB
 	.data
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d98cd483377e..7afe6e067066 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -511,7 +511,7 @@ ENDPROC(efi64_stub_entry)
 #endif
 
 	.text
-.Lrelocated:
+SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -540,6 +540,7 @@ ENDPROC(efi64_stub_entry)
  * Jump to the decompressed kernel.
  */
 	jmp	*%rax
+SYM_FUNC_END(.Lrelocated)
 
 /*
  * Adjust the global offset table
@@ -635,9 +636,10 @@ ENTRY(trampoline_32bit_src)
 	lret
 
 	.code64
-.Lpaging_enabled:
+SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
 	/* Return from the trampoline */
 	jmp	*%rdi
+SYM_FUNC_END(.Lpaging_enabled)
 
 	/*
          * The trampoline code has a size limit.
@@ -647,11 +649,12 @@ ENTRY(trampoline_32bit_src)
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
 	.code32
-.Lno_longmode:
+SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
 	hlt
 	jmp     1b
+SYM_FUNC_END(.Lno_longmode)
 
 #include "../../kernel/verify_cpu.S"
 
diff --git a/arch/x86/boot/pmjump.S b/arch/x86/boot/pmjump.S
index ea88d52eeac7..81658fe35380 100644
--- a/arch/x86/boot/pmjump.S
+++ b/arch/x86/boot/pmjump.S
@@ -46,7 +46,7 @@ ENDPROC(protected_mode_jump)
 
 	.code32
 	.section ".text32","ax"
-.Lin_pm32:
+SYM_FUNC_START_LOCAL_NOALIGN(.Lin_pm32)
 	# Set up data segments for flat 32-bit mode
 	movl	%ecx, %ds
 	movl	%ecx, %es
@@ -72,4 +72,4 @@ ENDPROC(protected_mode_jump)
 	lldt	%cx
 
 	jmpl	*%eax			# Jump to the 32-bit entrypoint
-ENDPROC(.Lin_pm32)
+SYM_FUNC_END(.Lin_pm32)
-- 
2.23.0

