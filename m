Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12814E41C9
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 15:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiCVOna (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 10:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiCVOmo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 10:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F0B76E1F;
        Tue, 22 Mar 2022 07:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 685CC61419;
        Tue, 22 Mar 2022 14:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48F9C340EC;
        Tue, 22 Mar 2022 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647960074;
        bh=3QpDYc4UsPikK9K7KOMeBSfoK4aIqfy4gPHknaJLEVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQ61qYSXQxsH6CkSaB3tVfroduOeQBnoD4TW1ro56XKWCuxTKCSB3s8NAeFMcqzWw
         G3lG/GXvdDFbuQpQHnOW+qDgVcG7dvMNND1Jibo1tKWEORkjQKFMuh9+oNIWtsI+NV
         cHnIRPn0YIPwfXtQjaSelGRv0EIGpXFCc5+e7aFpVK4hCr5WWeZLe8Q/Xm+Xg8GTGf
         Pag+AunkkW/7xdoN99vpA32Hlnyuyaqp0dy2MJxJyF4Nqe9TYnPcFax0U38FJFL7hC
         pPMPKehgUaBbVvN3rGQyhrjxAp731Mgp90jWVkjPX4httseUFXdVHoia5wPlZZRQUz
         8rnOULEZ8OzOw==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V9 09/20] riscv: compat: Add basic compat data type implementation
Date:   Tue, 22 Mar 2022 22:39:52 +0800
Message-Id: <20220322144003.2357128-10-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322144003.2357128-1-guoren@kernel.org>
References: <20220322144003.2357128-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement riscv asm/compat.h for struct compat_xxx,
is_compat_task, compat_user_regset, regset convert.

The rv64 compat.h has inherited most of the structs
from the generic one.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/compat.h      | 129 +++++++++++++++++++++++++++
 arch/riscv/include/asm/thread_info.h |   1 +
 2 files changed, 130 insertions(+)
 create mode 100644 arch/riscv/include/asm/compat.h

diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
new file mode 100644
index 000000000000..2ac955b51148
--- /dev/null
+++ b/arch/riscv/include/asm/compat.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_COMPAT_H
+#define __ASM_COMPAT_H
+
+#define COMPAT_UTS_MACHINE	"riscv\0\0"
+
+/*
+ * Architecture specific compatibility types
+ */
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <asm-generic/compat.h>
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
index 60da0dcacf14..e1ad5131944b 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -91,6 +91,7 @@ struct thread_info {
 #define TIF_SECCOMP		8	/* syscall secure computing */
 #define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
 #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
+#define TIF_32BIT		11	/* compat-mode 32bit process */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-- 
2.25.1

