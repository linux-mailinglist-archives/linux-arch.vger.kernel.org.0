Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC664DCB80
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409256AbfJRQdI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:33:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57747 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439916AbfJRQax (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:53 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV9B-0002xp-8M; Fri, 18 Oct 2019 18:30:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D0D101C04D0;
        Fri, 18 Oct 2019 18:30:32 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:32 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/boot: Annotate local functions
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Wei Huang <wei@redhat.com>, "x86-ml" <x86@kernel.org>,
        Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-8-jslaby@suse.cz>
References: <20191011115108.12392-8-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623264.29376.1288394809866461027.tip-bot2@tip-bot2>
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

Commit-ID:     deff8a24e1021fb39dddf5f6bc5832e0e3a632ea
Gitweb:        https://git.kernel.org/tip/deff8a24e1021fb39dddf5f6bc5832e0e3a632ea
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:47 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 10:29:34 +02:00

x86/boot: Annotate local functions

.Lrelocated, .Lpaging_enabled, .Lno_longmode, and .Lin_pm32 are
self-standing local functions, annotate them as such and preserve "no
alignment".

The annotations do not generate anything yet.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-arch@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Huang <wei@redhat.com>
Cc: x86-ml <x86@kernel.org>
Cc: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Link: https://lkml.kernel.org/r/20191011115108.12392-8-jslaby@suse.cz
---
 arch/x86/boot/compressed/head_32.S |  3 ++-
 arch/x86/boot/compressed/head_64.S |  9 ++++++---
 arch/x86/boot/pmjump.S             |  4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 5e30eaa..f9e2a80 100644
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
index d98cd48..7afe6e0 100644
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
index ea88d52..81658fe 100644
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
