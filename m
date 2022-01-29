Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB2B4A2EF4
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344365AbiA2MS4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jan 2022 07:18:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47870 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344923AbiA2MSa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jan 2022 07:18:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7CB3B827B2;
        Sat, 29 Jan 2022 12:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AA4C340EB;
        Sat, 29 Jan 2022 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643458705;
        bh=G4Z4BRARasIgrFuOvbwy5pdapZpEjfE9N+vqaSNYHgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4QxYcjgrS/TlI5KLCOuy0d/DDY4s1M5bGRwIuAv/fZpLjXRTJUgzPyicftEX3vz0
         cZMPDDZ9WCHSz4zxH64+MZ1h1331j9sDwvxxkbcUu5rebcftv3Ad2+5pD3RsPXAdOl
         hX5OkgY6JfSWvXCDSrd2OVJHsZt73oY0T2G/qBkeubnPZJyHh88RFrFG5mmVzP2j+A
         0JwSJ936cOOaNJAmXrBA+8PbOTGvk5W2wDadxt7IN4T7zsJHCJ51trluipSyf5qdXD
         LCkY/k6kPcQ6LLFHcdjyeaydVQEN/jEi/XN9bBmNl9gvfSlea6df+t84S19kwNBjHK
         lNyH0FrHUM6VQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de, hch@infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 06/17] riscv: compat: Add basic compat date type implementation
Date:   Sat, 29 Jan 2022 20:17:17 +0800
Message-Id: <20220129121728.1079364-7-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220129121728.1079364-1-guoren@kernel.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement asm/compat.h for struct compat_xxx, RLIM_INFINITY,
OFF_T_MAX, is_compat_task, compat_user_regset, regset convert.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/include/asm/compat.h      | 135 +++++++++++++++++++++++++++
 arch/riscv/include/asm/thread_info.h |   1 +
 2 files changed, 136 insertions(+)
 create mode 100644 arch/riscv/include/asm/compat.h

diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
new file mode 100644
index 000000000000..3d3e89629e3b
--- /dev/null
+++ b/arch/riscv/include/asm/compat.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_COMPAT_H
+#define __ASM_COMPAT_H
+
+#define COMPAT_UTS_MACHINE	"riscv\0\0"
+
+#define COMPAT_RLIM_INFINITY	0x7fffffff
+
+/*
+ * Architecture specific compatibility types
+ */
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <asm-generic/compat.h>
+
+#define F_GETLK64	12
+#define F_SETLK64	13
+#define F_SETLKW64	14
+
+static inline int is_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT);
+}
+
+struct compat_user_regs_struct {
+	compat_ulong_t pc;
+	compat_ulong_t ra;
+	compat_ulong_t sp;
+	compat_ulong_t gp;
+	compat_ulong_t tp;
+	compat_ulong_t t0;
+	compat_ulong_t t1;
+	compat_ulong_t t2;
+	compat_ulong_t s0;
+	compat_ulong_t s1;
+	compat_ulong_t a0;
+	compat_ulong_t a1;
+	compat_ulong_t a2;
+	compat_ulong_t a3;
+	compat_ulong_t a4;
+	compat_ulong_t a5;
+	compat_ulong_t a6;
+	compat_ulong_t a7;
+	compat_ulong_t s2;
+	compat_ulong_t s3;
+	compat_ulong_t s4;
+	compat_ulong_t s5;
+	compat_ulong_t s6;
+	compat_ulong_t s7;
+	compat_ulong_t s8;
+	compat_ulong_t s9;
+	compat_ulong_t s10;
+	compat_ulong_t s11;
+	compat_ulong_t t3;
+	compat_ulong_t t4;
+	compat_ulong_t t5;
+	compat_ulong_t t6;
+};
+
+static inline void regs_to_cregs(struct compat_user_regs_struct *cregs,
+				 struct pt_regs *regs)
+{
+	cregs->pc	= (compat_ulong_t) regs->epc;
+	cregs->ra	= (compat_ulong_t) regs->ra;
+	cregs->sp	= (compat_ulong_t) regs->sp;
+	cregs->gp	= (compat_ulong_t) regs->gp;
+	cregs->tp	= (compat_ulong_t) regs->tp;
+	cregs->t0	= (compat_ulong_t) regs->t0;
+	cregs->t1	= (compat_ulong_t) regs->t1;
+	cregs->t2	= (compat_ulong_t) regs->t2;
+	cregs->s0	= (compat_ulong_t) regs->s0;
+	cregs->s1	= (compat_ulong_t) regs->s1;
+	cregs->a0	= (compat_ulong_t) regs->a0;
+	cregs->a1	= (compat_ulong_t) regs->a1;
+	cregs->a2	= (compat_ulong_t) regs->a2;
+	cregs->a3	= (compat_ulong_t) regs->a3;
+	cregs->a4	= (compat_ulong_t) regs->a4;
+	cregs->a5	= (compat_ulong_t) regs->a5;
+	cregs->a6	= (compat_ulong_t) regs->a6;
+	cregs->a7	= (compat_ulong_t) regs->a7;
+	cregs->s2	= (compat_ulong_t) regs->s2;
+	cregs->s3	= (compat_ulong_t) regs->s3;
+	cregs->s4	= (compat_ulong_t) regs->s4;
+	cregs->s5	= (compat_ulong_t) regs->s5;
+	cregs->s6	= (compat_ulong_t) regs->s6;
+	cregs->s7	= (compat_ulong_t) regs->s7;
+	cregs->s8	= (compat_ulong_t) regs->s8;
+	cregs->s9	= (compat_ulong_t) regs->s9;
+	cregs->s10	= (compat_ulong_t) regs->s10;
+	cregs->s11	= (compat_ulong_t) regs->s11;
+	cregs->t3	= (compat_ulong_t) regs->t3;
+	cregs->t4	= (compat_ulong_t) regs->t4;
+	cregs->t5	= (compat_ulong_t) regs->t5;
+	cregs->t6	= (compat_ulong_t) regs->t6;
+};
+
+static inline void cregs_to_regs(struct compat_user_regs_struct *cregs,
+				 struct pt_regs *regs)
+{
+	regs->epc	= (unsigned long) cregs->pc;
+	regs->ra	= (unsigned long) cregs->ra;
+	regs->sp	= (unsigned long) cregs->sp;
+	regs->gp	= (unsigned long) cregs->gp;
+	regs->tp	= (unsigned long) cregs->tp;
+	regs->t0	= (unsigned long) cregs->t0;
+	regs->t1	= (unsigned long) cregs->t1;
+	regs->t2	= (unsigned long) cregs->t2;
+	regs->s0	= (unsigned long) cregs->s0;
+	regs->s1	= (unsigned long) cregs->s1;
+	regs->a0	= (unsigned long) cregs->a0;
+	regs->a1	= (unsigned long) cregs->a1;
+	regs->a2	= (unsigned long) cregs->a2;
+	regs->a3	= (unsigned long) cregs->a3;
+	regs->a4	= (unsigned long) cregs->a4;
+	regs->a5	= (unsigned long) cregs->a5;
+	regs->a6	= (unsigned long) cregs->a6;
+	regs->a7	= (unsigned long) cregs->a7;
+	regs->s2	= (unsigned long) cregs->s2;
+	regs->s3	= (unsigned long) cregs->s3;
+	regs->s4	= (unsigned long) cregs->s4;
+	regs->s5	= (unsigned long) cregs->s5;
+	regs->s6	= (unsigned long) cregs->s6;
+	regs->s7	= (unsigned long) cregs->s7;
+	regs->s8	= (unsigned long) cregs->s8;
+	regs->s9	= (unsigned long) cregs->s9;
+	regs->s10	= (unsigned long) cregs->s10;
+	regs->s11	= (unsigned long) cregs->s11;
+	regs->t3	= (unsigned long) cregs->t3;
+	regs->t4	= (unsigned long) cregs->t4;
+	regs->t5	= (unsigned long) cregs->t5;
+	regs->t6	= (unsigned long) cregs->t6;
+};
+
+#endif /* __ASM_COMPAT_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 60da0dcacf14..9392e35c689d 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -91,6 +91,7 @@ struct thread_info {
 #define TIF_SECCOMP		8	/* syscall secure computing */
 #define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
 #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
+#define TIF_32BIT		11	/* 32bit process */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-- 
2.25.1

