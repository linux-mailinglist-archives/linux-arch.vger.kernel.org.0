Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8F08602D
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390044AbfHHKkL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:40:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:47594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403838AbfHHKjI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABC4EAF10;
        Thu,  8 Aug 2019 10:39:06 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v8 15/28] x86/asm/purgatory: start using annotations
Date:   Thu,  8 Aug 2019 12:38:41 +0200
Message-Id: <20190808103854.6192-16-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

purgatory used no annotations at all. So include linux/linkage.h and
annotate everything:
* code by SYM_CODE_*
* data by SYM_DATA_*

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/purgatory/entry64.S      | 21 ++++++++++++---------
 arch/x86/purgatory/setup-x86_64.S | 14 ++++++++------
 arch/x86/purgatory/stack.S        |  7 ++++---
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index 275a646d1048..9d73d3648aa6 100644
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
@@ -75,12 +76,12 @@ r13:	.quad 0x0
 r14:	.quad 0x0
 r15:	.quad 0x0
 rip:	.quad 0x0
-	.size entry64_regs, . - entry64_regs
+SYM_DATA_END(entry64_regs)
 
 	/* GDT */
 	.section ".rodata"
 	.balign 16
-gdt:
+SYM_DATA_START_LOCAL(gdt)
 	/* 0x00 unusable segment
 	 * 0x08 unused
 	 * so use them as gdt ptr
@@ -94,6 +95,8 @@ gdt:
 
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
index 321146be741d..89d9e9e53fcd 100644
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
index 8b1427422dfc..1ef507ca50a5 100644
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
-- 
2.22.0

