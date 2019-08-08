Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1283886040
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389947AbfHHKk6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:40:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:47422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732146AbfHHKjA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9305DAF3F;
        Thu,  8 Aug 2019 10:38:58 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v8 03/28] x86/asm: annotate relocate_kernel
Date:   Thu,  8 Aug 2019 12:38:29 +0200
Message-Id: <20190808103854.6192-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are functions in relocate_kernel which are not annotated. This
makes automatic annotations rather hard. So annotate all the functions
now.

Note that these are not C-like functions, so we do not use FUNC, but
CODE markers. Also they are not aligned, so we use the NOALIGN versions:
- SYM_CODE_START_NOALIGN
- SYM_CODE_START_LOCAL_NOALIGN
- SYM_CODE_END

In return, we get:
  0000   108 NOTYPE  GLOBAL DEFAULT    1 relocate_kernel
  006c   165 NOTYPE  LOCAL  DEFAULT    1 identity_mapped
  0146   127 NOTYPE  LOCAL  DEFAULT    1 swap_pages
  0111    53 NOTYPE  LOCAL  DEFAULT    1 virtual_mapped

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/relocate_kernel_32.S | 13 ++++++++-----
 arch/x86/kernel/relocate_kernel_64.S | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_32.S b/arch/x86/kernel/relocate_kernel_32.S
index ee26df08002e..94b33885f8d2 100644
--- a/arch/x86/kernel/relocate_kernel_32.S
+++ b/arch/x86/kernel/relocate_kernel_32.S
@@ -35,8 +35,7 @@
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x1c)
 
 	.text
-	.globl relocate_kernel
-relocate_kernel:
+SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Save the CPU context, used for jumping back */
 
 	pushl	%ebx
@@ -93,8 +92,9 @@ relocate_kernel:
 	addl    $(identity_mapped - relocate_kernel), %eax
 	pushl   %eax
 	ret
+SYM_CODE_END(relocate_kernel)
 
-identity_mapped:
+SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* set return address to 0 if not preserving context */
 	pushl	$0
 	/* store the start address on the stack */
@@ -191,8 +191,9 @@ identity_mapped:
 	addl	$(virtual_mapped - relocate_kernel), %eax
 	pushl	%eax
 	ret
+SYM_CODE_END(identity_mapped)
 
-virtual_mapped:
+SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	movl	CR4(%edi), %eax
 	movl	%eax, %cr4
 	movl	CR3(%edi), %eax
@@ -208,9 +209,10 @@ virtual_mapped:
 	popl	%esi
 	popl	%ebx
 	ret
+SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
-swap_pages:
+SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movl	8(%esp), %edx
 	movl	4(%esp), %ecx
 	pushl	%ebp
@@ -270,6 +272,7 @@ swap_pages:
 	popl	%ebx
 	popl	%ebp
 	ret
+SYM_CODE_END(swap_pages)
 
 	.globl kexec_control_code_size
 .set kexec_control_code_size, . - relocate_kernel
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c51ccff5cd01..ef3ba99068d3 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -38,8 +38,7 @@
 	.text
 	.align PAGE_SIZE
 	.code64
-	.globl relocate_kernel
-relocate_kernel:
+SYM_CODE_START_NOALIGN(relocate_kernel)
 	/*
 	 * %rdi indirection_page
 	 * %rsi page_list
@@ -103,8 +102,9 @@ relocate_kernel:
 	addq	$(identity_mapped - relocate_kernel), %r8
 	pushq	%r8
 	ret
+SYM_CODE_END(relocate_kernel)
 
-identity_mapped:
+SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* set return address to 0 if not preserving context */
 	pushq	$0
 	/* store the start address on the stack */
@@ -209,8 +209,9 @@ identity_mapped:
 	movq	$virtual_mapped, %rax
 	pushq	%rax
 	ret
+SYM_CODE_END(identity_mapped)
 
-virtual_mapped:
+SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	movq	RSP(%r8), %rsp
 	movq	CR4(%r8), %rax
 	movq	%rax, %cr4
@@ -228,9 +229,10 @@ virtual_mapped:
 	popq	%rbp
 	popq	%rbx
 	ret
+SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
-swap_pages:
+SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rdi, %rcx 	/* Put the page_list in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
@@ -283,6 +285,7 @@ swap_pages:
 	jmp	0b
 3:
 	ret
+SYM_CODE_END(swap_pages)
 
 	.globl kexec_control_code_size
 .set kexec_control_code_size, . - relocate_kernel
-- 
2.22.0

