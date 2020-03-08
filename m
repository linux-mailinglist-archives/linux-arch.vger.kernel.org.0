Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5217D31B
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 10:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgCHJxo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 05:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgCHJxn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 05:53:43 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D6E20866;
        Sun,  8 Mar 2020 09:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661222;
        bh=V7gPdzyeicVBf+c/v7Jw8A8D52Ma7QKNk/3pIdn8KqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6pZOHM0oy0/0mT7hpajF2+Xb7Ke8PgZuYX9lLQsQGVGiXup5yxCQWUz3zrAIP2h1
         ggHFs+FN1t0dMrUeu8ckbZBM6IBJ6VYzc/a8A4BYJ8VEN64CUFPHyQvUCzu58UfekY
         +SQHUAfqhrTOIOvnR38mNjvlGXwUswJTuQtwFqdo=
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com,
        greentime.hu@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH V3 09/11] riscv: Add task switch support for VECTOR
Date:   Sun,  8 Mar 2020 17:49:52 +0800
Message-Id: <20200308094954.13258-10-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
References: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch add task switch and task create for VECTOR, and now
the applications with vector instructions wouldn't be broken by
linux task switch.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/asm/switch_to.h | 48 +++++++++++++++++
 arch/riscv/kernel/Makefile         |  1 +
 arch/riscv/kernel/process.c        | 10 ++++
 arch/riscv/kernel/vector.S         | 84 ++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+)
 create mode 100644 arch/riscv/kernel/vector.S

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index b9234e7178d0..6e1c7fa599be 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -63,6 +63,52 @@ extern bool has_fpu;
 #define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
+#ifdef CONFIG_VECTOR
+extern void __vstate_save(struct task_struct *save_to);
+extern void __vstate_restore(struct task_struct *restore_from);
+
+static inline void __vstate_clean(struct pt_regs *regs)
+{
+	regs->status |= (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
+}
+
+static inline void vstate_save(struct task_struct *task,
+			       struct pt_regs *regs)
+{
+	if ((regs->status & SR_VS) == SR_VS_DIRTY) {
+		__vstate_save(task);
+		__vstate_clean(regs);
+	}
+}
+
+static inline void vstate_restore(struct task_struct *task,
+				  struct pt_regs *regs)
+{
+	if ((regs->status & SR_VS) != SR_VS_OFF) {
+		__vstate_restore(task);
+		__vstate_clean(regs);
+	}
+}
+
+static inline void __switch_to_vector(struct task_struct *prev,
+				   struct task_struct *next)
+{
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(prev);
+	if (unlikely(regs->status & SR_SD))
+		vstate_save(prev, regs);
+	vstate_restore(next, task_pt_regs(next));
+}
+
+extern bool has_vector;
+#else
+#define has_vector false
+#define vstate_save(task, regs) do { } while (0)
+#define vstate_restore(task, regs) do { } while (0)
+#define __switch_to_vector(__prev, __next) do { } while (0)
+#endif
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -72,6 +118,8 @@ do {							\
 	struct task_struct *__next = (next);		\
 	if (has_fpu)					\
 		__switch_to_fpu(__prev, __next);	\
+	if (has_vector)					\
+		__switch_to_vector(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f40205cb9a22..e5276c3bdffc 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_M_MODE)	+= clint.o
 obj-$(CONFIG_FPU)		+= fpu.o
+obj-$(CONFIG_VECTOR)		+= vector.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_MODULES)		+= module.o
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 817cf7b0974c..c572557701b4 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -74,6 +74,16 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 		 */
 		fstate_restore(current, regs);
 	}
+
+	if (has_vector) {
+		regs->status |= SR_VS_INITIAL;
+		/*
+		 * Restore the initial value to the vector register
+		 * before starting the user program.
+		 */
+		vstate_restore(current, regs);
+	}
+
 	regs->epc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
new file mode 100644
index 000000000000..dbe1989fa9d7
--- /dev/null
+++ b/arch/riscv/kernel/vector.S
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ * Copyright (C) 2019 Alibaba Group Holding Limited
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/csr.h>
+#include <asm/asm-offsets.h>
+
+ENTRY(__vstate_save)
+	li	a2,  TASK_THREAD_V0
+	add	a0,  a0, a2
+
+	li	t1, (SR_VS | SR_FS)
+	csrs	sstatus, t1
+
+	csrr	t0,  CSR_VSTART
+	sd	t0,  TASK_THREAD_VSTART_V0(a0)
+	csrr	t0,  CSR_VXSAT
+	sd	t0,  TASK_THREAD_VXSAT_V0(a0)
+	csrr	t0,  CSR_VXRM
+	sd	t0,  TASK_THREAD_VXRM_V0(a0)
+	csrr	t0,  CSR_VL
+	sd	t0,  TASK_THREAD_VL_V0(a0)
+	csrr	t0,  CSR_VTYPE
+	sd	t0,  TASK_THREAD_VTYPE_V0(a0)
+
+	vsetvli	t0, x0, e8,m8
+	vsb.v	v0,  (a0)
+	addi	a0, a0, 128*8
+	vsb.v	v8,  (a0)
+	addi	a0, a0, 128*8
+	vsb.v	v16, (a0)
+	addi	a0, a0, 128*8
+	vsb.v	v24, (a0)
+
+	csrc	sstatus, t1
+	ret
+ENDPROC(__vstate_save)
+
+ENTRY(__vstate_restore)
+	li	a2,  TASK_THREAD_V0
+	add	a0,  a0, a2
+	mv	t2,  a0
+
+	li	t1, (SR_VS | SR_FS)
+	csrs	sstatus, t1
+
+	vsetvli	t0, x0, e8,m8
+	vlb.v	v0,  (a0)
+	addi	a0, a0, 128*8
+	vlb.v	v8,  (a0)
+	addi	a0, a0, 128*8
+	vlb.v	v16, (a0)
+	addi	a0, a0, 128*8
+	vlb.v	v24, (a0)
+
+	mv	a0,  t2
+	ld	t0,  TASK_THREAD_VSTART_V0(a0)
+	csrw	CSR_VSTART, t0
+	ld	t0,  TASK_THREAD_VXSAT_V0(a0)
+	csrw	CSR_VXSAT, t0
+	ld	t0,  TASK_THREAD_VXRM_V0(a0)
+	csrw	CSR_VXRM, t0
+	ld	t0,  TASK_THREAD_VL_V0(a0)
+	ld	t2,  TASK_THREAD_VTYPE_V0(a0)
+	vsetvl	t0, t0, t2
+
+	csrc	sstatus, t1
+	ret
+ENDPROC(__vstate_restore)
-- 
2.17.0

