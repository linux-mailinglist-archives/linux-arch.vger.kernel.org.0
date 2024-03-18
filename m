Return-Path: <linux-arch+bounces-3020-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1213E87E3F1
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 08:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4237A1C20CFE
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 07:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65714225DD;
	Mon, 18 Mar 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="4qfo7+Bo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3222612;
	Mon, 18 Mar 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746168; cv=none; b=HQJfVZvn4MSNC/XiKTrrSGEGIzSnFh2Qw7mhgbmrGeFp3o9QUDGNJsCoc4A6wXLPmMRHXTcMqU8uy3YnptP7Ub+Ab7KSCk6OEnbHkafA8NTiUht5w98XMENbx95fJXcipeUu5kPGvhPXuix7trev0J/0tik56wJ6U4mrUKviz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746168; c=relaxed/simple;
	bh=aLS6AX7W+AXgAh4hgoumByC0Igk0YWUJhR1plA7yRec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ui3Ds9ViYvE1a9PJCV6tAWz4DjBbDS59rlVii12pDpQbpdib1UrHHKtLdFxzCz2fxgVxQaNCqtxN7VtrJIROp6An5X5wN51syqYBn76Bw1iIuStICCNby01DXahF5b8SKUPkyuMa33PsFohdJQ4SKkSkumzkEtHxQjOjU3Ay/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=4qfo7+Bo; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42I7ETdi910464
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 18 Mar 2024 00:14:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42I7ETdi910464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1710746075;
	bh=lOgqPli4E6y6mgNZ3XzJ8MlzC1fqsi4wvgAp64a4zdg=;
	h=From:To:Cc:Subject:Date:From;
	b=4qfo7+Bopd2+cAB5JZREDFFnwJ9EUBUQzcTriimHV5zBacAHniCvGQvo/sA6muLna
	 r4PwVGXSNtnFAarpjPSIkcS/hfYgUg4ojZl9bimUFHmnM0P9CO9rh8dpDRYahLqOvt
	 jnGim1lPI+5C7q/LXw9w5uKxwMQXRUaNszLu95FjFea3zs0mFNXuwyPH5LagxqX0vC
	 DosUI2YMVafFXw+c4aHUHb5JuMOQj2w2l2V9R0IlbFLWugYYUIdGE6Z5Vy6yC1MuaW
	 vy1Q4stBFIJ3UVxNPttVvgPU9sLEwyljSMMwcFiw0pKIcgh2pkDHDqZRXAoNS8IABG
	 Eqfo27oqDTeqA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jgross@suse.com, boris.ostrovsky@oracle.com, arnd@arndb.de
Subject: [PATCH v2 1/1] x86: Rename __{start,end}_init_task to __{start,end}_init_stack
Date: Mon, 18 Mar 2024 00:14:29 -0700
Message-ID: <20240318071429.910454-1-xin@zytor.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The stack of a task has been separated from the memory of a task_struct
struture for a long time on x86, as a result __{start,end}_init_task no
longer mark the start and end of the init_task structure, but its stack
only.

Rename __{start,end}_init_task to __{start,end}_init_stack.

Note other architectures are not affected because __{start,end}_init_task
are used on x86 only.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Change since v1:
* Revert an accident insane change, init_task to init_stack (Jürgen Groß).
---
 arch/x86/include/asm/processor.h  | 4 ++--
 arch/x86/kernel/head_64.S         | 2 +-
 arch/x86/xen/xen-head.S           | 2 +-
 include/asm-generic/vmlinux.lds.h | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f131f4..8b3a3f3bb859 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -636,10 +636,10 @@ static __always_inline void prefetchw(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-extern unsigned long __end_init_task[];
+extern unsigned long __end_init_stack[];
 
 #define INIT_THREAD {							\
-	.sp	= (unsigned long)&__end_init_task -			\
+	.sp	= (unsigned long)&__end_init_stack -			\
 		  TOP_OF_KERNEL_STACK_PADDING -				\
 		  sizeof(struct pt_regs),				\
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8198fbd70e5..c7babd7ebb0f 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -66,7 +66,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	mov	%rsi, %r15
 
 	/* Set up the stack for verify_cpu() */
-	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
+	leaq	(__end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
 
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 04101b984f24..43eadf03f46d 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
 	ANNOTATE_NOENDBR
 	cld
 
-	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
+	leaq	(__end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
 
 	/* Set up %gs.
 	 *
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 514d3002ad8a..cdfdcca23045 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -399,13 +399,13 @@
 
 #define INIT_TASK_DATA(align)						\
 	. = ALIGN(align);						\
-	__start_init_task = .;						\
+	__start_init_stack = .;						\
 	init_thread_union = .;						\
 	init_stack = .;							\
 	KEEP(*(.data..init_task))					\
 	KEEP(*(.data..init_thread_info))				\
-	. = __start_init_task + THREAD_SIZE;				\
-	__end_init_task = .;
+	. = __start_init_stack + THREAD_SIZE;				\
+	__end_init_stack = .;
 
 #define JUMP_TABLE_DATA							\
 	. = ALIGN(8);							\

base-commit: 7e19a79344df2ed5e106091c29338962261b0290
-- 
2.44.0


