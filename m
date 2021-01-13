Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B3E2F5481
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 22:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbhAMVNq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 16:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbhAMVJS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2021 16:09:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE10C061794
        for <linux-arch@vger.kernel.org>; Wed, 13 Jan 2021 13:09:54 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kznOq-005vHf-5i; Wed, 13 Jan 2021 22:09:52 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] um: rework userspace stubs to not hard-code stub location
Date:   Wed, 13 Jan 2021 22:09:43 +0100
Message-Id: <20210113220944.5a2ed3c1e619.I08d3297d2a88fda957e5139b9803a20bc600b0eb@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113220944.7732f6bfd3bb.Ib87c91b49d57d27314cf444696273da6d8463e9c@changeid>
References: <20210113220944.7732f6bfd3bb.Ib87c91b49d57d27314cf444696273da6d8463e9c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The userspace stacks mostly have a stack (and in the case of the
syscall stub we can just set their stack pointer) that points to
the location of the stub data page already.

Rework the stubs to use the stack pointer to derive the start of
the data page, rather than requiring it to be hard-coded.

In the clone stub, also integrate the int3 into the stack remap,
since we really must not use the stack while we remap it.

This prepares for putting the stub at a variable location that's
not part of the normal address space of the userspace processes
running inside the UML machine.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/as-layout.h      | 16 +++--------
 arch/um/include/shared/common-offsets.h |  6 +++++
 arch/um/kernel/skas/clone.c             |  3 +--
 arch/um/os-Linux/skas/mem.c             |  2 ++
 arch/x86/um/shared/sysdep/stub_32.h     | 33 +++++++++++++++--------
 arch/x86/um/shared/sysdep/stub_64.h     | 36 ++++++++++++++++---------
 arch/x86/um/stub_32.S                   | 17 +++++++-----
 arch/x86/um/stub_64.S                   |  5 ++--
 arch/x86/um/stub_segv.c                 |  5 ++--
 9 files changed, 75 insertions(+), 48 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 5f286ef2721b..56408bf3480d 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -20,18 +20,10 @@
  * 'UL' and other type specifiers unilaterally.  We
  * use the following macros to deal with this.
  */
-
-#ifdef __ASSEMBLY__
-#define _UML_AC(X, Y)	(Y)
-#else
-#define __UML_AC(X, Y)	(X(Y))
-#define _UML_AC(X, Y)	__UML_AC(X, Y)
-#endif
-
-#define STUB_START _UML_AC(, 0x100000)
-#define STUB_CODE _UML_AC((unsigned long), STUB_START)
-#define STUB_DATA _UML_AC((unsigned long), STUB_CODE + UM_KERN_PAGE_SIZE)
-#define STUB_END _UML_AC((unsigned long), STUB_DATA + UM_KERN_PAGE_SIZE)
+#define STUB_START 0x100000UL
+#define STUB_CODE STUB_START
+#define STUB_DATA (STUB_CODE + UM_KERN_PAGE_SIZE)
+#define STUB_END (STUB_DATA + UM_KERN_PAGE_SIZE)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 16a51a8c800f..edc90ab73734 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* for use by sys-$SUBARCH/kernel-offsets.c */
+#include <stub-data.h>
 
 DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
 
@@ -43,3 +44,8 @@ DEFINE(UML_CONFIG_64BIT, CONFIG_64BIT);
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
 DEFINE(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT, CONFIG_UML_TIME_TRAVEL_SUPPORT);
 #endif
+
+/* for stub */
+DEFINE(UML_STUB_FIELD_OFFSET, offsetof(struct stub_data, offset));
+DEFINE(UML_STUB_FIELD_CHILD_ERR, offsetof(struct stub_data, child_err));
+DEFINE(UML_STUB_FIELD_FD, offsetof(struct stub_data, fd));
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index 7c592c788cbf..592cdb138441 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -41,8 +41,7 @@ stub_clone_handler(void)
 		goto done;
 	}
 
-	remap_stack(data->fd, data->offset);
-	goto done;
+	remap_stack_and_trap();
 
  done:
 	trap_myself();
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index c546d16f8dfe..3b4975ee67e2 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -40,6 +40,8 @@ static int __init init_syscall_regs(void)
 	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
 		((unsigned long) batch_syscall_stub -
 		 (unsigned long) __syscall_stub_start);
+	syscall_regs[REGS_SP_INDEX] = STUB_DATA;
+
 	return 0;
 }
 
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 8ea69211e53c..c3891c1ada26 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -7,8 +7,8 @@
 #define __SYSDEP_STUB_H
 
 #include <asm/ptrace.h>
+#include <generated/asm-offsets.h>
 
-#define STUB_SYSCALL_RET EAX
 #define STUB_MMAP_NR __NR_mmap2
 #define MMAP_OFFSET(o) ((o) >> UM_KERN_PAGE_SHIFT)
 
@@ -77,17 +77,28 @@ static inline void trap_myself(void)
 	__asm("int3");
 }
 
-static inline void remap_stack(int fd, unsigned long offset)
+static void inline remap_stack_and_trap(void)
 {
-	__asm__ volatile ("movl %%eax,%%ebp ; movl %0,%%eax ; int $0x80 ;"
-			  "movl %7, %%ebx ; movl %%eax, (%%ebx)"
-			  : : "g" (STUB_MMAP_NR), "b" (STUB_DATA),
-			    "c" (UM_KERN_PAGE_SIZE),
-			    "d" (PROT_READ | PROT_WRITE),
-			    "S" (MAP_FIXED | MAP_SHARED), "D" (fd),
-			    "a" (offset),
-			    "i" (&((struct stub_data *) STUB_DATA)->child_err)
-			  : "memory");
+	__asm__ volatile (
+		"movl %%esp,%%ebx ;"
+		"andl %0,%%ebx ;"
+		"movl %1,%%eax ;"
+		"movl %%ebx,%%edi ; addl %2,%%edi ; movl (%%edi),%%edi ;"
+		"movl %%ebx,%%ebp ; addl %3,%%ebp ; movl (%%ebp),%%ebp ;"
+		"int $0x80 ;"
+		"addl %4,%%ebx ; movl %%eax, (%%ebx) ;"
+		"int $3"
+		: :
+		"g" (~(UM_KERN_PAGE_SIZE - 1)),
+		"g" (STUB_MMAP_NR),
+		"g" (UML_STUB_FIELD_FD),
+		"g" (UML_STUB_FIELD_OFFSET),
+		"g" (UML_STUB_FIELD_CHILD_ERR),
+		"c" (UM_KERN_PAGE_SIZE),
+		"d" (PROT_READ | PROT_WRITE),
+		"S" (MAP_FIXED | MAP_SHARED)
+		:
+		"memory");
 }
 
 #endif
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index b7b8b8e4359d..6e2626b77a2e 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -7,8 +7,8 @@
 #define __SYSDEP_STUB_H
 
 #include <sysdep/ptrace_user.h>
+#include <generated/asm-offsets.h>
 
-#define STUB_SYSCALL_RET PT_INDEX(RAX)
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
 
@@ -82,18 +82,30 @@ static inline void trap_myself(void)
 	__asm("int3");
 }
 
-static inline void remap_stack(long fd, unsigned long offset)
+static inline void remap_stack_and_trap(void)
 {
-	__asm__ volatile ("movq %4,%%r10 ; movq %5,%%r8 ; "
-			  "movq %6, %%r9; " __syscall "; movq %7, %%rbx ; "
-			  "movq %%rax, (%%rbx)":
-			  : "a" (STUB_MMAP_NR), "D" (STUB_DATA),
-			    "S" (UM_KERN_PAGE_SIZE),
-			    "d" (PROT_READ | PROT_WRITE),
-                            "g" (MAP_FIXED | MAP_SHARED), "g" (fd),
-			    "g" (offset),
-			    "i" (&((struct stub_data *) STUB_DATA)->child_err)
-			  : __syscall_clobber, "r10", "r8", "r9" );
+	__asm__ volatile (
+		"movq %0,%%rax ;"
+		"movq %%rsp,%%rdi ;"
+		"andq %1,%%rdi ;"
+		"movq %2,%%r10 ;"
+		"movq %%rdi,%%r8 ; addq %3,%%r8 ; movq (%%r8),%%r8 ;"
+		"movq %%rdi,%%r9 ; addq %4,%%r9 ; movq (%%r9),%%r9 ;"
+		__syscall ";"
+		"movq %%rsp,%%rdi ; andq %1,%%rdi ;"
+		"addq %5,%%rdi ; movq %%rax, (%%rdi) ;"
+		"int3"
+		: :
+		"g" (STUB_MMAP_NR),
+		"g" (~(UM_KERN_PAGE_SIZE - 1)),
+		"g" (MAP_FIXED | MAP_SHARED),
+		"g" (UML_STUB_FIELD_FD),
+		"g" (UML_STUB_FIELD_OFFSET),
+		"g" (UML_STUB_FIELD_CHILD_ERR),
+		"S" (UM_KERN_PAGE_SIZE),
+		"d" (PROT_READ | PROT_WRITE)
+		:
+		__syscall_clobber, "r10", "r8", "r9");
 }
 
 #endif
diff --git a/arch/x86/um/stub_32.S b/arch/x86/um/stub_32.S
index a193e88536a9..8291899e6aaf 100644
--- a/arch/x86/um/stub_32.S
+++ b/arch/x86/um/stub_32.S
@@ -5,21 +5,22 @@
 
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	/* load pointer to first operation */
-	mov	$(STUB_DATA+8), %esp
-
+	/* %esp comes in as "top of page" */
+	mov %esp, %ecx
+	/* %esp has pointer to first operation */
+	add $8, %esp
 again:
 	/* load length of additional data */
 	mov	0x0(%esp), %eax
 
 	/* if(length == 0) : end of list */
 	/* write possible 0 to header */
-	mov	%eax, STUB_DATA+4
+	mov	%eax, 0x4(%ecx)
 	cmpl	$0, %eax
 	jz	done
 
 	/* save current pointer */
-	mov	%esp, STUB_DATA+4
+	mov	%esp, 0x4(%ecx)
 
 	/* skip additional data */
 	add	%eax, %esp
@@ -38,6 +39,10 @@ again:
 	/* execute syscall */
 	int	$0x80
 
+	/* restore top of page pointer in %ecx */
+	mov	%esp, %ecx
+	andl	$(~UM_KERN_PAGE_SIZE) + 1, %ecx
+
 	/* check return value */
 	pop	%ebx
 	cmp	%ebx, %eax
@@ -45,7 +50,7 @@ again:
 
 done:
 	/* save return value */
-	mov	%eax, STUB_DATA
+	mov	%eax, (%ecx)
 
 	/* stop */
 	int3
diff --git a/arch/x86/um/stub_64.S b/arch/x86/um/stub_64.S
index 8a95c5b2eaf9..f3404640197a 100644
--- a/arch/x86/um/stub_64.S
+++ b/arch/x86/um/stub_64.S
@@ -4,9 +4,8 @@
 .section .__syscall_stub, "ax"
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	mov	$(STUB_DATA), %rbx
-	/* load pointer to first operation */
-	mov	%rbx, %rsp
+	/* %rsp has the pointer to first operation */
+	mov	%rsp, %rbx
 	add	$0x10, %rsp
 again:
 	/* load length of additional data */
diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
index 27361cbb7ca9..21836eaf1725 100644
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -11,10 +11,11 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
 {
+	int stack;
 	ucontext_t *uc = p;
+	struct faultinfo *f = (void *)(((unsigned long)&stack) & ~(UM_KERN_PAGE_SIZE - 1));
 
-	GET_FAULTINFO_FROM_MC(*((struct faultinfo *) STUB_DATA),
-			      &uc->uc_mcontext);
+	GET_FAULTINFO_FROM_MC(*f, &uc->uc_mcontext);
 	trap_myself();
 }
 
-- 
2.26.2

