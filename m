Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF0DCB23
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439908AbfJRQav (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:30:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57725 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439882AbfJRQau (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV96-0002ph-5X; Fri, 18 Oct 2019 18:30:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 56DFC1C04A9;
        Fri, 18 Oct 2019 18:30:30 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:30 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/purgatory: Start using annotations
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-16-jslaby@suse.cz>
References: <20191011115108.12392-16-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623011.29376.15374755752054973720.tip-bot2@tip-bot2>
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

Commit-ID:     b16fed65a7938248c8b37d5d0a8020defa6fd926
Gitweb:        https://git.kernel.org/tip/b16fed65a7938248c8b37d5d0a8020defa6fd926
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:55 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 10:48:43 +02:00

x86/asm/purgatory: Start using annotations

Purgatory used no annotations at all. So include linux/linkage.h and
annotate everything:

* code by SYM_CODE_*
* data by SYM_DATA_*

 [ bp: Fixup comment in gdt: ]

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Enrico Weigelt <info@metux.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-arch@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191011115108.12392-16-jslaby@suse.cz
---
 arch/x86/purgatory/entry64.S      | 24 ++++++++++++++----------
 arch/x86/purgatory/setup-x86_64.S | 14 ++++++++------
 arch/x86/purgatory/stack.S        |  7 ++++---
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index 275a646..0b4390c 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -8,13 +8,13 @@
  * This code has been taken from kexec-tools.
  */
 
+#include <linux/linkage.h>
+
 	.text
 	.balign 16
 	.code64
-	.globl entry64, entry64_regs
-
 
-entry64:
+SYM_CODE_START(entry64)
 	/* Setup a gdt that should be preserved */
 	lgdt gdt(%rip)
 
@@ -54,10 +54,11 @@ new_cs_exit:
 
 	/* Jump to the new code... */
 	jmpq	*rip(%rip)
+SYM_CODE_END(entry64)
 
 	.section ".rodata"
 	.balign 4
-entry64_regs:
+SYM_DATA_START(entry64_regs)
 rax:	.quad 0x0
 rcx:	.quad 0x0
 rdx:	.quad 0x0
@@ -75,13 +76,14 @@ r13:	.quad 0x0
 r14:	.quad 0x0
 r15:	.quad 0x0
 rip:	.quad 0x0
-	.size entry64_regs, . - entry64_regs
+SYM_DATA_END(entry64_regs)
 
 	/* GDT */
 	.section ".rodata"
 	.balign 16
-gdt:
-	/* 0x00 unusable segment
+SYM_DATA_START_LOCAL(gdt)
+	/*
+	 * 0x00 unusable segment
 	 * 0x08 unused
 	 * so use them as gdt ptr
 	 */
@@ -94,6 +96,8 @@ gdt:
 
 	/* 0x18 4GB flat data segment */
 	.word 0xFFFF, 0x0000, 0x9200, 0x00CF
-gdt_end:
-stack:	.quad   0, 0
-stack_init:
+SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
+
+SYM_DATA_START_LOCAL(stack)
+	.quad   0, 0
+SYM_DATA_END_LABEL(stack, SYM_L_LOCAL, stack_init)
diff --git a/arch/x86/purgatory/setup-x86_64.S b/arch/x86/purgatory/setup-x86_64.S
index 321146b..89d9e9e 100644
--- a/arch/x86/purgatory/setup-x86_64.S
+++ b/arch/x86/purgatory/setup-x86_64.S
@@ -7,14 +7,14 @@
  *
  * This code has been taken from kexec-tools.
  */
+#include <linux/linkage.h>
 #include <asm/purgatory.h>
 
 	.text
-	.globl purgatory_start
 	.balign 16
-purgatory_start:
 	.code64
 
+SYM_CODE_START(purgatory_start)
 	/* Load a gdt so I know what the segment registers are */
 	lgdt	gdt(%rip)
 
@@ -32,10 +32,12 @@ purgatory_start:
 	/* Call the C code */
 	call purgatory
 	jmp	entry64
+SYM_CODE_END(purgatory_start)
 
 	.section ".rodata"
 	.balign 16
-gdt:	/* 0x00 unusable segment
+SYM_DATA_START_LOCAL(gdt)
+	/* 0x00 unusable segment
 	 * 0x08 unused
 	 * so use them as the gdt ptr
 	 */
@@ -48,10 +50,10 @@ gdt:	/* 0x00 unusable segment
 
 	/* 0x18 4GB flat data segment */
 	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-gdt_end:
+SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 	.bss
 	.balign 4096
-lstack:
+SYM_DATA_START_LOCAL(lstack)
 	.skip 4096
-lstack_end:
+SYM_DATA_END_LABEL(lstack, SYM_L_LOCAL, lstack_end)
diff --git a/arch/x86/purgatory/stack.S b/arch/x86/purgatory/stack.S
index 8b14274..1ef507c 100644
--- a/arch/x86/purgatory/stack.S
+++ b/arch/x86/purgatory/stack.S
@@ -5,13 +5,14 @@
  * Copyright (C) 2014 Red Hat Inc.
  */
 
+#include <linux/linkage.h>
+
 	/* A stack for the loaded kernel.
 	 * Separate and in the data section so it can be prepopulated.
 	 */
 	.data
 	.balign 4096
-	.globl stack, stack_end
 
-stack:
+SYM_DATA_START(stack)
 	.skip 4096
-stack_end:
+SYM_DATA_END_LABEL(stack, SYM_L_GLOBAL, stack_end)
