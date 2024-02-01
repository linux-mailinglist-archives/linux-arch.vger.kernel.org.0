Return-Path: <linux-arch+bounces-1970-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6943845C02
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 16:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149F61C22290
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F4B779E4;
	Thu,  1 Feb 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="YxJn+2dF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TqSvgtZG"
X-Original-To: linux-arch@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC7E779E1;
	Thu,  1 Feb 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802396; cv=none; b=jDks2SfgMzlhjrXE8MDkqgCQFL70NNvoPQUZaCPzUAI145rr01olsAM+hQtj0anizcMzghpc0J41Y12kglKvQ3WQqDhzf8EeGdA6H56byNH1OR7RjvmseuJHb3kv6nfyj5GISVjLDPm4ypSPz5Mlh86PcWDbit0t4gXbA7/CDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802396; c=relaxed/simple;
	bh=To5vJPzytdUYzh0hXEDkOhoQVO7uNU4EWlR+7TGqcVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3INn0bv6eOFPQeWgA9Ely4IlptyGWsa+56jkDk4Z8MkvV5qFvGDo5Jh0CsXrFoOieMeSxAJBXRkvszaZJnk0T5wa5JU4xKVH/rw6KUEIXAyq6IEmUCdcTaFiXIBcyVn9r4sDcnt021b5swKedWvI6alfwXKCPH5rqVsnaTuqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=YxJn+2dF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TqSvgtZG; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 4F6425C0197;
	Thu,  1 Feb 2024 10:46:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 10:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706802393;
	 x=1706888793; bh=zM4ypLTsihhX4T85kzZYYbykGEdoiDtwYzxwA9PVkI8=; b=
	YxJn+2dFpph/Az50xTRg2kgNEk4jnjiA/7c50k8mKJEby/71UeM2LPcY/Y9fjjwf
	+LG/ieJnXn1YFyPj8okUh45Be+5bH69GxAxeYJMCpez5Pqt1FjPgjuzeu+CbuzQl
	qLiYVR/7s5CBpkSjys2xbYCd1HHZwKxwYmJk1jJ11jdJwMalcN0UT/3M3HUh3Qx8
	U58lPT0el0EgxqIQgbM+aMzSVhYKokAkE1qEeXRt6YxKRigKDcruB6CUX2zts0Co
	FFHpmVJPKh7BTanZzeBn/sKc+coZX5KAwHf2ccCQarMzE8/yGjVsCIcFJyiI7Elz
	5lLlFQo7hPAnlGbsVr8yjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706802393; x=
	1706888793; bh=zM4ypLTsihhX4T85kzZYYbykGEdoiDtwYzxwA9PVkI8=; b=T
	qSvgtZG3e5xUyV01ke2XtkIse8rzNIqZuMRHdi7J4XOZmbf+XbxygZgYx8T28jko
	CIQ1hiTtFx2NTSR8v97TSJLp6gZWC8m/c0Y1F9vsZ4KQSKx0bCh90uIWfWe3of6G
	fqO/ct9d7oZbtMsugZ8E+dCP4hhc748LAbC1//4ewM7w4elK0D00+4ohKU621a9j
	TPdByvTvjrpR6+C2/eF/o6BlpZTG+YNEsC3o9QF5i8nT+TJiFs3E7HLa0s9olxG8
	f6ZFifklewNXyK1yxUqPI39bhj6R5ZNAxvirwqbHJXZ08Pp4dO1pIQuZmS7GncvK
	a9R+tTEFR8NQpKHMQ9p+g==
X-ME-Sender: <xms:2by7ZX_HvtuxE301eHV6ks_ep-mGL9ywBKhnrAvsjQ-mUmvchu9EWA>
    <xme:2by7ZTsngUrpfq0cWhqcVrYjOMV4juBq-BVMn6s-ZORCnFBhKryj5HFXKaVpoBO6T
    pgzPLyAfPQCO8p73-s>
X-ME-Received: <xmr:2by7ZVAOAQ4KYm91C5rFp51ifUOOFewSaLLKLmHbDEdhzlm0FyvP8Y5s3aRavIfi3_XfTdIvdhfMZTKmCmD5Zu1Pyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvedujefhfffhveekhfffkeetvefgteejkeeutdduieehieeg
    feejtdelveejtedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:2by7ZTdk8r-6O8Hd9S5Jj-n72ohQITKx2uzmfl0NUSil8g_cfCcZRw>
    <xmx:2by7ZcPZNdFZcly_MqYJwLNv3eHEdFOlLC4wKjtUQ-bWzH9u_CIsog>
    <xmx:2by7ZVmGPdAkmhJNYWL5uYqBWfDfLngy4Zq0THCNwTPos_J-NpbYZw>
    <xmx:2by7ZTf2PsYpVAzLq1B7Z82Xw_nGDN409TN9pnCnlFiC4ZSWHxFsBA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 10:46:31 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 01 Feb 2024 15:46:27 +0000
Subject: [PATCH 1/3] ptrace: Introduce exception_ip arch hook
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-exception_ip-v1-1-aa26ab3ee0b5@flygoat.com>
References: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
In-Reply-To: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
To: Oleg Nesterov <oleg@redhat.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10340;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=To5vJPzytdUYzh0hXEDkOhoQVO7uNU4EWlR+7TGqcVA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtTde64K/ji8z21S7Jm/395wpbMFpN9JrrMJe8/mPdlSa
 661+KHwjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIq1CGvzL8M++/aFUVlX+p
 X2j3i+m6VfjJZeeZOfZcy531ripikQgjw9NLv2c8uLhn4rS3Eoeq1u6aG7ZSR4DzlaWGXVL3KTW
 /YH4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

On architectures with delay slot, architecture level instruction
pointer (or program counter) in pt_regs may differ from where
exception was triggered.

Introduce exception_ip hook to invoke architecture code and determine
actual instruction pointer to the exception.

Link: https://lore.kernel.org/lkml/00d1b813-c55f-4365-8d81-d70258e10b16@app.fastmail.com/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/alpha/include/asm/ptrace.h        | 1 +
 arch/arc/include/asm/ptrace.h          | 1 +
 arch/arm/include/asm/ptrace.h          | 1 +
 arch/csky/include/asm/ptrace.h         | 1 +
 arch/hexagon/include/uapi/asm/ptrace.h | 1 +
 arch/loongarch/include/asm/ptrace.h    | 1 +
 arch/m68k/include/asm/ptrace.h         | 1 +
 arch/microblaze/include/asm/ptrace.h   | 3 ++-
 arch/mips/include/asm/ptrace.h         | 1 +
 arch/mips/kernel/ptrace.c              | 7 +++++++
 arch/nios2/include/asm/ptrace.h        | 3 ++-
 arch/openrisc/include/asm/ptrace.h     | 1 +
 arch/parisc/include/asm/ptrace.h       | 1 +
 arch/s390/include/asm/ptrace.h         | 1 +
 arch/sparc/include/asm/ptrace.h        | 2 ++
 arch/um/include/asm/ptrace-generic.h   | 1 +
 16 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
index 3557ce64ed21..1ded3f2d09e9 100644
--- a/arch/alpha/include/asm/ptrace.h
+++ b/arch/alpha/include/asm/ptrace.h
@@ -8,6 +8,7 @@
 #define arch_has_single_step()		(1)
 #define user_mode(regs) (((regs)->ps & 8) != 0)
 #define instruction_pointer(regs) ((regs)->pc)
+#define exception_ip(regs) instruction_pointer(regs)
 #define profile_pc(regs) instruction_pointer(regs)
 #define current_user_stack_pointer() rdusp()
 
diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index 00b9318e551e..94084f1048df 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -105,6 +105,7 @@ struct callee_regs {
 #endif
 
 #define instruction_pointer(regs)	((regs)->ret)
+#define exception_ip(regs)		instruction_pointer(regs)
 #define profile_pc(regs)		instruction_pointer(regs)
 
 /* return 1 if user mode or 0 if kernel mode */
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 7f44e88d1f25..fb4dc23eba78 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -89,6 +89,7 @@ static inline long regs_return_value(struct pt_regs *regs)
 }
 
 #define instruction_pointer(regs)	(regs)->ARM_pc
+#define exception_ip(regs)			instruction_pointer(regs)
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define frame_pointer(regs) (regs)->ARM_r7
diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
index 0634b7895d81..a738630e64b0 100644
--- a/arch/csky/include/asm/ptrace.h
+++ b/arch/csky/include/asm/ptrace.h
@@ -22,6 +22,7 @@
 
 #define user_mode(regs) (!((regs)->sr & PS_S))
 #define instruction_pointer(regs) ((regs)->pc)
+#define exception_ip(regs) instruction_pointer(regs)
 #define profile_pc(regs) instruction_pointer(regs)
 #define trap_no(regs) ((regs->sr >> 16) & 0xff)
 
diff --git a/arch/hexagon/include/uapi/asm/ptrace.h b/arch/hexagon/include/uapi/asm/ptrace.h
index 2a3ea14ad9b9..846471936237 100644
--- a/arch/hexagon/include/uapi/asm/ptrace.h
+++ b/arch/hexagon/include/uapi/asm/ptrace.h
@@ -25,6 +25,7 @@
 #include <asm/registers.h>
 
 #define instruction_pointer(regs) pt_elr(regs)
+#define exception_ip(regs) instruction_pointer(regs)
 #define user_stack_pointer(regs) ((regs)->r29)
 
 #define profile_pc(regs) instruction_pointer(regs)
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index f3ddaed9ef7f..a34327f0e69d 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -160,6 +160,7 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long val
 }
 
 #define instruction_pointer(regs) ((regs)->csr_era)
+#define exception_ip(regs) instruction_pointer(regs)
 #define profile_pc(regs) instruction_pointer(regs)
 
 extern void die(const char *str, struct pt_regs *regs);
diff --git a/arch/m68k/include/asm/ptrace.h b/arch/m68k/include/asm/ptrace.h
index ea5a80ca1ab3..cb553e2ec73a 100644
--- a/arch/m68k/include/asm/ptrace.h
+++ b/arch/m68k/include/asm/ptrace.h
@@ -13,6 +13,7 @@
 
 #define user_mode(regs) (!((regs)->sr & PS_S))
 #define instruction_pointer(regs) ((regs)->pc)
+#define exception_ip(regs) instruction_pointer(regs)
 #define profile_pc(regs) instruction_pointer(regs)
 #define current_pt_regs() \
 	(struct pt_regs *)((char *)current_thread_info() + THREAD_SIZE) - 1
diff --git a/arch/microblaze/include/asm/ptrace.h b/arch/microblaze/include/asm/ptrace.h
index bfcb89df5e26..974c00fa7212 100644
--- a/arch/microblaze/include/asm/ptrace.h
+++ b/arch/microblaze/include/asm/ptrace.h
@@ -12,7 +12,8 @@
 #define user_mode(regs)			(!kernel_mode(regs))
 
 #define instruction_pointer(regs)	((regs)->pc)
-#define profile_pc(regs)		instruction_pointer(regs)
+#define exception_ip(regs)			instruction_pointer(regs)
+#define profile_pc(regs)			instruction_pointer(regs)
 #define user_stack_pointer(regs)	((regs)->r1)
 
 static inline long regs_return_value(struct pt_regs *regs)
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index daf3cf244ea9..97589731fd40 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -154,6 +154,7 @@ static inline long regs_return_value(struct pt_regs *regs)
 }
 
 #define instruction_pointer(regs) ((regs)->cp0_epc)
+extern unsigned long exception_ip(struct pt_regs *regs);
 #define profile_pc(regs) instruction_pointer(regs)
 
 extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index d9df543f7e2c..59288c13b581 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -31,6 +31,7 @@
 #include <linux/seccomp.h>
 #include <linux/ftrace.h>
 
+#include <asm/branch.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
@@ -48,6 +49,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+unsigned long exception_ip(struct pt_regs *regs)
+{
+	return exception_epc(regs);
+}
+EXPORT_SYMBOL(exception_ip);
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
diff --git a/arch/nios2/include/asm/ptrace.h b/arch/nios2/include/asm/ptrace.h
index 9da34c3022a2..136f5679ae79 100644
--- a/arch/nios2/include/asm/ptrace.h
+++ b/arch/nios2/include/asm/ptrace.h
@@ -66,7 +66,8 @@ struct switch_stack {
 #define user_mode(regs)	(((regs)->estatus & ESTATUS_EU))
 
 #define instruction_pointer(regs)	((regs)->ra)
-#define profile_pc(regs)		instruction_pointer(regs)
+#define exception_ip(regs)			instruction_pointer(regs)
+#define profile_pc(regs)			instruction_pointer(regs)
 #define user_stack_pointer(regs)	((regs)->sp)
 extern void show_regs(struct pt_regs *);
 
diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
index 375147ff71fc..67c28484d17e 100644
--- a/arch/openrisc/include/asm/ptrace.h
+++ b/arch/openrisc/include/asm/ptrace.h
@@ -67,6 +67,7 @@ struct pt_regs {
 #define STACK_FRAME_OVERHEAD  128  /* size of minimum stack frame */
 
 #define instruction_pointer(regs)	((regs)->pc)
+#define exception_ip(regs)			instruction_pointer(regs)
 #define user_mode(regs)			(((regs)->sr & SPR_SR_SM) == 0)
 #define user_stack_pointer(regs)	((unsigned long)(regs)->sp)
 #define profile_pc(regs)		instruction_pointer(regs)
diff --git a/arch/parisc/include/asm/ptrace.h b/arch/parisc/include/asm/ptrace.h
index eea3f3df0823..d7e8dcf26582 100644
--- a/arch/parisc/include/asm/ptrace.h
+++ b/arch/parisc/include/asm/ptrace.h
@@ -17,6 +17,7 @@
 #define user_mode(regs)			(((regs)->iaoq[0] & 3) != PRIV_KERNEL)
 #define user_space(regs)		((regs)->iasq[1] != PRIV_KERNEL)
 #define instruction_pointer(regs)	((regs)->iaoq[0] & ~3)
+#define exception_ip(regs)			instruction_pointer(regs)
 #define user_stack_pointer(regs)	((regs)->gr[30])
 unsigned long profile_pc(struct pt_regs *);
 
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index d28bf8fb2799..a5255b2337af 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -211,6 +211,7 @@ static inline int test_and_clear_pt_regs_flag(struct pt_regs *regs, int flag)
 
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
 #define instruction_pointer(regs) ((regs)->psw.addr)
+#define exception_ip(regs) instruction_pointer(regs)
 #define user_stack_pointer(regs)((regs)->gprs[15])
 #define profile_pc(regs) instruction_pointer(regs)
 
diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptrace.h
index d1419e669027..41ae186f2245 100644
--- a/arch/sparc/include/asm/ptrace.h
+++ b/arch/sparc/include/asm/ptrace.h
@@ -63,6 +63,7 @@ extern union global_cpu_snapshot global_cpu_snapshot[NR_CPUS];
 #define force_successful_syscall_return() set_thread_noerror(1)
 #define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))
 #define instruction_pointer(regs) ((regs)->tpc)
+#define exception_ip(regs) instruction_pointer(regs)
 #define instruction_pointer_set(regs, val) do { \
 		(regs)->tpc = (val); \
 		(regs)->tnpc = (val)+4; \
@@ -142,6 +143,7 @@ static inline bool pt_regs_clear_syscall(struct pt_regs *regs)
 
 #define user_mode(regs) (!((regs)->psr & PSR_PS))
 #define instruction_pointer(regs) ((regs)->pc)
+#define exception_ip(regs) instruction_pointer(regs)
 #define user_stack_pointer(regs) ((regs)->u_regs[UREG_FP])
 unsigned long profile_pc(struct pt_regs *);
 #else /* (!__ASSEMBLY__) */
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index adf91ef553ae..f9ada287ca12 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -26,6 +26,7 @@ struct pt_regs {
 #define PT_REGS_SYSCALL_NR(r) UPT_SYSCALL_NR(&(r)->regs)
 
 #define instruction_pointer(regs) PT_REGS_IP(regs)
+#define exception_ip(regs) instruction_pointer(regs)
 
 #define PTRACE_OLDSETOPTIONS 21
 

-- 
2.43.0


