Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D9DCB24
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439672AbfJRQaw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:30:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57732 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439900AbfJRQav (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:51 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV9H-00032Z-Jl; Fri, 18 Oct 2019 18:30:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 175DF1C04D5;
        Fri, 18 Oct 2019 18:30:34 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:33 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Annotate relocate_kernel_{32,64}.c
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-4-jslaby@suse.cz>
References: <20191011115108.12392-4-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623386.29376.15307122503000886721.tip-bot2@tip-bot2>
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

Commit-ID:     6ec2a968247e51535e08dbbbfc8f53c95a48cde0
Gitweb:        https://git.kernel.org/tip/6ec2a968247e51535e08dbbbfc8f53c95a48cde0
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:43 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 09:53:19 +02:00

x86/asm: Annotate relocate_kernel_{32,64}.c

There are functions in relocate_kernel_{32,64}.c which are not
annotated. This makes automatic annotations on them rather hard. So
annotate all the functions now.

Note that these are not C-like functions, so FUNC is not used. Instead
CODE markers are used. Also the functions are not aligned, so the
NOALIGN versions are used:

- SYM_CODE_START_NOALIGN
- SYM_CODE_START_LOCAL_NOALIGN
- SYM_CODE_END

The result is:
  0000   108 NOTYPE  GLOBAL DEFAULT    1 relocate_kernel
  006c   165 NOTYPE  LOCAL  DEFAULT    1 identity_mapped
  0146   127 NOTYPE  LOCAL  DEFAULT    1 swap_pages
  0111    53 NOTYPE  LOCAL  DEFAULT    1 virtual_mapped

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
Link: https://lkml.kernel.org/r/20191011115108.12392-4-jslaby@suse.cz
---
 arch/x86/kernel/relocate_kernel_32.S | 13 ++++++++-----
 arch/x86/kernel/relocate_kernel_64.S | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_32.S b/arch/x86/kernel/relocate_kernel_32.S
index ee26df0..94b3388 100644
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
index c51ccff..ef3ba99 100644
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
