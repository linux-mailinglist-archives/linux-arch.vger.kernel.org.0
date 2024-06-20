Return-Path: <linux-arch+bounces-4973-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF1890FFB2
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2024 10:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AAD1F23065
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2024 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BFE22611;
	Thu, 20 Jun 2024 08:57:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2D3D994;
	Thu, 20 Jun 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873875; cv=none; b=QQDOJb7PygJ4BaziaIGOmC4AJ5M+AcQ/WK61xdMpdhfJPBBNcm1MGyf3bn7I7PHOIp6A7ZFtnJMXIqazezYuLJ7a4hXJJ4nCv+2u7GPENwv2QXEGAayDCYWThPunH4Q3m1DNa3o4FEZ959AKTRDmo2A6TPzJbIgvxHia6HIuRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873875; c=relaxed/simple;
	bh=XgzNzZ8L8ltW19SqsoIuK9JjrbcbCq/OTmEX3INyHVo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oM+A5JG8cbx1AZD2Rzks09/T6jBpJ8HlRbDAslmYGRVKa+qDddH3jHiBEA3Nb1HI8HwinCrC9RgWNSqxmEPRSGskSyig5/olKYa8m9Lgmv8sA2lhpT814U/Fw5Jg2N/2OxW3AaGTsxiGzjHtF/HH2/GkfcEzg5uA48/EEjwO9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W4Z4z5c2vznWPy;
	Thu, 20 Jun 2024 16:52:51 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A0D82180064;
	Thu, 20 Jun 2024 16:57:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 16:57:46 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>, <robh@kernel.org>,
	<vincent.whitchurch@axis.com>, <bhe@redhat.com>, <nico@fluxnic.net>,
	<ardb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] ARM: support PREEMPT_DYNAMIC
Date: Thu, 20 Jun 2024 17:00:28 +0800
Message-ID: <20240620090028.729373-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Enable support for PREEMPT_DYNAMIC on arm32, allowing the preemption model
to be chosen at boot time.

Similar to arm64, arm32 does not yet use the generic entry code, we must
define our own `sk_dynamic_irqentry_exit_cond_resched`, which will be
enabled/disabled by the common code in kernel/sched/core.c.

And arm32 use generic preempt.h, so declare
`sk_dynamic_irqentry_exit_cond_resched` if the arch do not use generic
entry. Other architectures which use generic preempt.h but not use generic
entry can benefit from it.

Test ok with the below cmdline parameters on Qemu versatilepb board:
	`preempt=none`
	`preempt=voluntary`
	`preempt=full`

Update preempt mode with debugfs interface on above Qemu board is also
tested ok:
	# cd /sys/kernel/debug/sched
	# echo none > preempt
	# echo voluntary > preempt
	# echo full > preempt

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm/Kconfig                 |  1 +
 arch/arm/include/asm/exception.h |  2 ++
 arch/arm/kernel/Makefile         |  2 +-
 arch/arm/kernel/common.c         | 13 +++++++++++++
 arch/arm/kernel/entry-armv.S     |  7 ++++++-
 include/asm-generic/preempt.h    |  5 +++++
 6 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/kernel/common.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 036381c5d42f..843f320dde7f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -124,6 +124,7 @@ config ARM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_DYNAMIC_KEY
 	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
diff --git a/arch/arm/include/asm/exception.h b/arch/arm/include/asm/exception.h
index 3c82975d46db..ac96b76b394e 100644
--- a/arch/arm/include/asm/exception.h
+++ b/arch/arm/include/asm/exception.h
@@ -12,4 +12,6 @@
 
 #define __exception_irq_entry	__irq_entry
 
+bool need_irq_preemption(void);
+
 #endif /* __ASM_ARM_EXCEPTION_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 89a77e3f51d2..58acd62dc5e9 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -17,7 +17,7 @@ CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
 
-obj-y		:= elf.o entry-common.o irq.o opcodes.o \
+obj-y		:= common.o elf.o entry-common.o irq.o opcodes.o \
 		   process.o ptrace.o reboot.o io.o \
 		   setup.o signal.o sigreturn_codes.o \
 		   stacktrace.o sys_arm.o time.o traps.o
diff --git a/arch/arm/kernel/common.c b/arch/arm/kernel/common.c
new file mode 100644
index 000000000000..52b0abcae07e
--- /dev/null
+++ b/arch/arm/kernel/common.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/jump_label.h>
+#include <asm/exception.h>
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+
+bool need_irq_preemption(void)
+{
+	return static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched);
+}
+#endif
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 6150a716828c..571e86433833 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -221,6 +221,11 @@ __irq_svc:
 	irq_handler from_user=0
 
 #ifdef CONFIG_PREEMPTION
+#ifdef CONFIG_PREEMPT_DYNAMIC
+	bl	need_irq_preemption
+	cmp	r0, #0
+	beq	2f
+#endif
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
 	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
 	teq	r8, #0				@ if preempt count != 0
@@ -228,7 +233,7 @@ __irq_svc:
 	tst	r0, #_TIF_NEED_RESCHED
 	blne	svc_preempt
 #endif
-
+2:
 	svc_exit r5, irq = 1			@ return from exception
  UNWIND(.fnend		)
 ENDPROC(__irq_svc)
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 51f8f3881523..2db7a3e86303 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_PREEMPT_H
 #define __ASM_PREEMPT_H
 
+#include <linux/jump_label.h>
 #include <linux/thread_info.h>
 
 #define PREEMPT_ENABLED	(0)
@@ -89,6 +90,10 @@ void dynamic_preempt_schedule_notrace(void);
 #define __preempt_schedule()		dynamic_preempt_schedule()
 #define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
 
+#ifndef CONFIG_GENERIC_ENTRY
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+#endif
+
 #else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
 
 #define __preempt_schedule() preempt_schedule()
-- 
2.34.1


