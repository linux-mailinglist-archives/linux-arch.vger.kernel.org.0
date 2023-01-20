Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF57B6756C3
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjATORJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjATORG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:17:06 -0500
Received: from fx405.security-mail.net (smtpout140.security-mail.net [85.31.212.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56E1C9260
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:16:19 -0800 (PST)
Received: from localhost (fx405.security-mail.net [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id 86E87335EE0
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:10:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674223835;
        bh=s0s3ZiOaChe4IspP/f0FkJ7Hvx4yiDNnsro9YJeTTzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NYJxumxS5LYrv2pTdomRPl+OVVvqaBAo4kNGq82kihiJ/5wQ7SlfSX7xOgCn4eap3
         znUNdtPG5/oTviicrKfq3onCFfDdKnu0k4btzE+wMjV2ydtEmcILjWCQaRGtTMrQO8
         Wps+yMH/FjQAoJiHRgTcL2AxDIyH+bzK4T1KDcTI=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id CA918335E9B; Fri, 20 Jan
 2023 15:10:34 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx405.security-mail.net (Postfix) with ESMTPS id C95DC335B8A; Fri, 20 Jan
 2023 15:10:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 884B127E0444; Fri, 20 Jan 2023
 15:10:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 7018427E043D; Fri, 20 Jan 2023 15:10:33 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 qVvk-rOi_LrW; Fri, 20 Jan 2023 15:10:33 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 0003627E0439; Fri, 20 Jan 2023
 15:10:32 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <113d2.63caa0d9.c7c9d.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 7018427E043D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223833;
 bh=1jVxsLsovn3fhaiWW+YOhEGV9C0R95VwjQdE5el+poY=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=lAi9EcZrOVnADHSlLn0HzqUHXd/OoVYz+1r4Pur0oLkIW89a5cu55ZEBVKaE81NSr
 33VCPt0tq/2HWar0ALkfU+wvbyjMTEbO3NJrHfMZKcPQcwPkZHrzHWoRLcRVOuqooS
 hVnD0bnQbK/OUm35vmHbIDQ8ijLOINjegpqpvtoI=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 19/31] kvx: Add process management
Date:   Fri, 20 Jan 2023 15:09:50 +0100
Message-ID: <20230120141002.2442-20-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add process management support for kvx, including: thread info
definition, context switch and process tracing.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: no change

 arch/kvx/include/asm/current.h     |  22 +++
 arch/kvx/include/asm/ptrace.h      | 217 +++++++++++++++++++++++
 arch/kvx/include/asm/switch_to.h   |  21 +++
 arch/kvx/include/asm/thread_info.h |  78 ++++++++
 arch/kvx/include/uapi/asm/ptrace.h | 114 ++++++++++++
 arch/kvx/kernel/process.c          | 203 +++++++++++++++++++++
 arch/kvx/kernel/ptrace.c           | 276 +++++++++++++++++++++++++++++
 arch/kvx/kernel/stacktrace.c       | 173 ++++++++++++++++++
 8 files changed, 1104 insertions(+)
 create mode 100644 arch/kvx/include/asm/current.h
 create mode 100644 arch/kvx/include/asm/ptrace.h
 create mode 100644 arch/kvx/include/asm/switch_to.h
 create mode 100644 arch/kvx/include/asm/thread_info.h
 create mode 100644 arch/kvx/include/uapi/asm/ptrace.h
 create mode 100644 arch/kvx/kernel/process.c
 create mode 100644 arch/kvx/kernel/ptrace.c
 create mode 100644 arch/kvx/kernel/stacktrace.c

diff --git a/arch/kvx/include/asm/current.h b/arch/kvx/include/asm/current.h
new file mode 100644
index 000000000000..b5fd0f076ec9
--- /dev/null
+++ b/arch/kvx/include/asm/current.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_CURRENT_H
+#define _ASM_KVX_CURRENT_H
+
+#include <asm/percpu.h>
+#include <asm/sfr.h>
+
+struct task_struct;
+
+static __always_inline struct task_struct *get_current(void)
+{
+	return (struct task_struct *) kvx_sfr_get(SR);
+}
+
+#define current get_current()
+
+#endif	/* _ASM_KVX_CURRENT_H */
diff --git a/arch/kvx/include/asm/ptrace.h b/arch/kvx/include/asm/ptrace.h
new file mode 100644
index 000000000000..d1b1e0975d9e
--- /dev/null
+++ b/arch/kvx/include/asm/ptrace.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Marius Gligor
+ *            Yann Sionneau
+ */
+
+#ifndef _ASM_KVX_PTRACE_H
+#define _ASM_KVX_PTRACE_H
+
+#include <asm/types.h>
+#include <asm/sfr.h>
+#include <uapi/asm/ptrace.h>
+
+#define GPR_COUNT	64
+#define SFR_COUNT	9
+#define VIRT_COUNT	1
+
+#define ES_SYSCALL	0x3
+
+#define KVX_HW_BREAKPOINT_COUNT		2
+#define KVX_HW_WATCHPOINT_COUNT		1
+
+#define REG_SIZE	sizeof(u64)
+
+/**
+ * When updating pt_regs structure, this size must be updated.
+ * This is the expected size of the pt_regs struct.
+ * It ensures the structure layout from gcc is the same as the one we
+ * expect in order to do packed load (load/store octuple) in assembly.
+ * Conclusion: never put sizeof(pt_regs) in here or we lose this check
+ * (build time check done in asm-offsets.c via BUILD_BUG_ON)
+ */
+#define PT_REGS_STRUCT_EXPECTED_SIZE \
+			((GPR_COUNT + SFR_COUNT + VIRT_COUNT) * REG_SIZE + \
+			2 * REG_SIZE) /* Padding for stack alignment */
+
+/**
+ * Saved register structure. Note that we should save only the necessary
+ * registers.
+ * When you modify it, please read carefully the comment above.
+ * Moreover, you will need to modify user_pt_regs to match the beginning
+ * of this struct 1:1
+ */
+struct pt_regs {
+	union {
+		struct user_pt_regs user_regs;
+		struct {
+			/* GPR */
+			uint64_t r0;
+			uint64_t r1;
+			uint64_t r2;
+			uint64_t r3;
+			uint64_t r4;
+			uint64_t r5;
+			uint64_t r6;
+			uint64_t r7;
+			uint64_t r8;
+			uint64_t r9;
+			uint64_t r10;
+			uint64_t r11;
+			union {
+				uint64_t r12;
+				uint64_t sp;
+			};
+			union {
+				uint64_t r13;
+				uint64_t tp;
+			};
+			union {
+				uint64_t r14;
+				uint64_t fp;
+			};
+			uint64_t r15;
+			uint64_t r16;
+			uint64_t r17;
+			uint64_t r18;
+			uint64_t r19;
+			uint64_t r20;
+			uint64_t r21;
+			uint64_t r22;
+			uint64_t r23;
+			uint64_t r24;
+			uint64_t r25;
+			uint64_t r26;
+			uint64_t r27;
+			uint64_t r28;
+			uint64_t r29;
+			uint64_t r30;
+			uint64_t r31;
+			uint64_t r32;
+			uint64_t r33;
+			uint64_t r34;
+			uint64_t r35;
+			uint64_t r36;
+			uint64_t r37;
+			uint64_t r38;
+			uint64_t r39;
+			uint64_t r40;
+			uint64_t r41;
+			uint64_t r42;
+			uint64_t r43;
+			uint64_t r44;
+			uint64_t r45;
+			uint64_t r46;
+			uint64_t r47;
+			uint64_t r48;
+			uint64_t r49;
+			uint64_t r50;
+			uint64_t r51;
+			uint64_t r52;
+			uint64_t r53;
+			uint64_t r54;
+			uint64_t r55;
+			uint64_t r56;
+			uint64_t r57;
+			uint64_t r58;
+			uint64_t r59;
+			uint64_t r60;
+			uint64_t r61;
+			uint64_t r62;
+			uint64_t r63;
+
+			/* SFR */
+			uint64_t lc;
+			uint64_t le;
+			uint64_t ls;
+			uint64_t ra;
+
+			uint64_t cs;
+			uint64_t spc;
+		};
+	};
+	uint64_t sps;
+	uint64_t es;
+
+	uint64_t ilr;
+
+	/* "Virtual" registers */
+	uint64_t orig_r0;
+
+	/* Padding for stack alignment (see STACK_ALIGN) */
+	uint64_t padding[2];
+
+	/**
+	 * If you add some fields, please read carefully the comment for
+	 * PT_REGS_STRUCT_EXPECTED_SIZE.
+	 */
+};
+
+#define pl(__reg) kvx_sfr_field_val(__reg, PS, PL)
+
+#define MODE_KERNEL	0
+#define MODE_USER	1
+
+/* Privilege level is relative in $sps, so 1 indicates current PL + 1 */
+#define user_mode(regs)	(pl((regs)->sps) == MODE_USER)
+#define es_ec(regs) kvx_sfr_field_val(regs->es, ES, EC)
+#define es_sysno(regs) kvx_sfr_field_val(regs->es, ES, SN)
+
+#define debug_dc(es) kvx_sfr_field_val((es), ES, DC)
+
+/* ptrace */
+#define PTRACE_GET_HW_PT_REGS	20
+#define PTRACE_SET_HW_PT_REGS	21
+#define arch_has_single_step()	1
+
+#define DEBUG_CAUSE_BREAKPOINT	0
+#define DEBUG_CAUSE_WATCHPOINT	1
+#define DEBUG_CAUSE_STEPI	2
+#define DEBUG_CAUSE_DSU_BREAK	3
+
+static inline void enable_single_step(struct pt_regs *regs)
+{
+	regs->sps |= KVX_SFR_PS_SME_MASK;
+}
+
+static inline void disable_single_step(struct pt_regs *regs)
+{
+	regs->sps &= ~KVX_SFR_PS_SME_MASK;
+}
+
+static inline bool in_syscall(struct pt_regs const *regs)
+{
+	return es_ec(regs) == ES_SYSCALL;
+}
+
+int do_syscall_trace_enter(struct pt_regs *regs, unsigned long syscall);
+void do_syscall_trace_exit(struct pt_regs *regs);
+
+static inline unsigned long get_current_sp(void)
+{
+	register const unsigned long current_sp __asm__ ("$r12");
+
+	return current_sp;
+}
+
+extern char *user_scall_rt_sigreturn_end;
+extern char *user_scall_rt_sigreturn;
+
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->spc;
+}
+
+static inline long regs_return_value(struct pt_regs *regs)
+{
+	return regs->r0;
+}
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->sp;
+}
+
+#endif	/* _ASM_KVX_PTRACE_H */
diff --git a/arch/kvx/include/asm/switch_to.h b/arch/kvx/include/asm/switch_to.h
new file mode 100644
index 000000000000..2b1fda06dea8
--- /dev/null
+++ b/arch/kvx/include/asm/switch_to.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SWITCH_TO_H
+#define _ASM_KVX_SWITCH_TO_H
+
+struct task_struct;
+
+/* context switching is now performed out-of-line in switch_to.S */
+extern struct task_struct *__switch_to(struct task_struct *prev,
+				       struct task_struct *next);
+
+#define switch_to(prev, next, last)					\
+	do {								\
+		((last) = __switch_to((prev), (next)));			\
+	} while (0)
+
+#endif	/* _ASM_KVX_SWITCH_TO_H */
diff --git a/arch/kvx/include/asm/thread_info.h b/arch/kvx/include/asm/thread_info.h
new file mode 100644
index 000000000000..4ce0154813ef
--- /dev/null
+++ b/arch/kvx/include/asm/thread_info.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#ifndef _ASM_KVX_THREAD_INFO_H
+#define _ASM_KVX_THREAD_INFO_H
+
+#include <asm/page.h>
+
+/*
+ * Size of the kernel stack for each process.
+ */
+#define THREAD_SIZE_ORDER       2
+#define THREAD_SIZE             (PAGE_SIZE << THREAD_SIZE_ORDER)
+
+/*
+ * Thread information flags
+ *   these are process state flags that various assembly files may need to
+ *   access
+ *   - pending work-to-be-done flags are in LSW
+ *   - other flags in MSW
+ */
+#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
+#define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
+#define TIF_SIGPENDING		2	/* signal pending */
+#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
+#define TIF_UPROBE		5
+#define TIF_SYSCALL_TRACEPOINT  6	/* syscall tracepoint instrumentation */
+#define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
+#define TIF_RESTORE_SIGMASK     9
+#define TIF_NOTIFY_SIGNAL	10	/* signal notifications exist */
+#define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE              17
+
+#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
+#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+
+#define _TIF_WORK_MASK \
+	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED)
+
+#define _TIF_SYSCALL_WORK \
+	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
+
+#ifndef __ASSEMBLY__
+/*
+ * We are using THREAD_INFO_IN_TASK so this struct is almost useless
+ * please prefer adding fields in thread_struct (processor.h) rather
+ * than here.
+ * This struct is merely a remnant of distant times where it was placed
+ * on the stack to avoid large task_struct.
+ *
+ * cf https://lwn.net/Articles/700615/
+ */
+struct thread_info {
+	unsigned long flags;				/* low level flags */
+	int preempt_count;
+#ifdef CONFIG_SMP
+	u32 cpu;					/* current CPU */
+#endif
+};
+
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.flags		= 0,			\
+	.preempt_count  = INIT_PREEMPT_COUNT,	\
+}
+#endif /* __ASSEMBLY__*/
+#endif /* _ASM_KVX_THREAD_INFO_H */
diff --git a/arch/kvx/include/uapi/asm/ptrace.h b/arch/kvx/include/uapi/asm/ptrace.h
new file mode 100644
index 000000000000..f5febe830526
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/ptrace.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#ifndef _UAPI_ASM_KVX_PTRACE_H
+#define _UAPI_ASM_KVX_PTRACE_H
+
+#include <linux/types.h>
+/*
+ * User-mode register state for core dumps, ptrace, sigcontext
+ *
+ * This decouples struct pt_regs from the userspace ABI.
+ * The struct pt_regs must start with the same layout as struct user_pt_regs.
+ */
+struct user_pt_regs {
+	/* GPR */
+	unsigned long r0;
+	unsigned long r1;
+	unsigned long r2;
+	unsigned long r3;
+	unsigned long r4;
+	unsigned long r5;
+	unsigned long r6;
+	unsigned long r7;
+	unsigned long r8;
+	unsigned long r9;
+	unsigned long r10;
+	unsigned long r11;
+	union {
+		unsigned long r12;
+		unsigned long sp;
+	};
+	union {
+		unsigned long r13;
+		unsigned long tp;
+	};
+	union {
+		unsigned long r14;
+		unsigned long fp;
+	};
+	unsigned long r15;
+	unsigned long r16;
+	unsigned long r17;
+	unsigned long r18;
+	unsigned long r19;
+	unsigned long r20;
+	unsigned long r21;
+	unsigned long r22;
+	unsigned long r23;
+	unsigned long r24;
+	unsigned long r25;
+	unsigned long r26;
+	unsigned long r27;
+	unsigned long r28;
+	unsigned long r29;
+	unsigned long r30;
+	unsigned long r31;
+	unsigned long r32;
+	unsigned long r33;
+	unsigned long r34;
+	unsigned long r35;
+	unsigned long r36;
+	unsigned long r37;
+	unsigned long r38;
+	unsigned long r39;
+	unsigned long r40;
+	unsigned long r41;
+	unsigned long r42;
+	unsigned long r43;
+	unsigned long r44;
+	unsigned long r45;
+	unsigned long r46;
+	unsigned long r47;
+	unsigned long r48;
+	unsigned long r49;
+	unsigned long r50;
+	unsigned long r51;
+	unsigned long r52;
+	unsigned long r53;
+	unsigned long r54;
+	unsigned long r55;
+	unsigned long r56;
+	unsigned long r57;
+	unsigned long r58;
+	unsigned long r59;
+	unsigned long r60;
+	unsigned long r61;
+	unsigned long r62;
+	unsigned long r63;
+
+	/* SFR */
+	unsigned long lc;
+	unsigned long le;
+	unsigned long ls;
+	unsigned long ra;
+
+	unsigned long cs;
+	unsigned long spc;
+};
+
+/* TCA registers structure exposed to user */
+struct user_tca_regs {
+	struct {
+		__u64 x;
+		__u64 y;
+		__u64 z;
+		__u64 t;
+	} regs[48];
+};
+
+#endif /* _UAPI_ASM_KVX_PTRACE_H */
diff --git a/arch/kvx/kernel/process.c b/arch/kvx/kernel/process.c
new file mode 100644
index 000000000000..2a1cd0509604
--- /dev/null
+++ b/arch/kvx/kernel/process.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ *            Yann Sionneau
+ */
+
+#include <linux/elf.h>
+#include <linux/sched.h>
+#include <linux/ptrace.h>
+#include <linux/printk.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
+
+#include <asm/ptrace.h>
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <asm/stacktrace.h>
+
+#if defined(CONFIG_STACKPROTECTOR)
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
+#define SCALL_NUM_EXIT	"0xfff"
+
+void arch_cpu_idle(void)
+{
+	wait_for_interrupt();
+	local_irq_enable();
+}
+
+void show_regs(struct pt_regs *regs)
+{
+
+	int in_kernel = 1;
+	unsigned short i, reg_offset;
+	void *ptr;
+
+	show_regs_print_info(KERN_DEFAULT);
+
+	if (user_mode(regs))
+		in_kernel = 0;
+
+	pr_info("\nmode: %s\n"
+	       "    PC: %016llx    PS: %016llx\n"
+	       "    CS: %016llx    RA: %016llx\n"
+	       "    LS: %016llx    LE: %016llx\n"
+	       "    LC: %016llx\n\n",
+	       in_kernel ? "kernel" : "user",
+	       regs->spc, regs->sps,
+	       regs->cs, regs->ra, regs->ls, regs->le, regs->lc);
+
+	/* GPR */
+	ptr = regs;
+	ptr += offsetof(struct pt_regs, r0);
+	reg_offset = offsetof(struct pt_regs, r1) -
+		     offsetof(struct pt_regs, r0);
+
+	/**
+	 * Display all the 64 GPRs assuming they are ordered correctly
+	 * in the pt_regs struct...
+	 */
+	for (i = 0; i < GPR_COUNT; i += 2) {
+		pr_info("    R%d: %016llx    R%d: %016llx\n",
+			 i, *(uint64_t *)ptr,
+			 i + 1, *(uint64_t *)(ptr + reg_offset));
+		ptr += reg_offset * 2;
+	}
+
+	pr_info("\n\n");
+}
+
+/**
+ * Prepare a thread to return to userspace
+ */
+void start_thread(struct pt_regs *regs,
+			unsigned long pc, unsigned long sp)
+{
+	/* Remove MMUP bit (user is not privilege in current virtual space) */
+	u64 clear_bit = KVX_SFR_PS_MMUP_MASK | KVX_SFR_PS_SME_MASK |
+			KVX_SFR_PS_SMR_MASK;
+	regs->spc = pc;
+	regs->sp = sp;
+	regs->sps = kvx_sfr_get(PS);
+
+	regs->sps &= ~clear_bit;
+
+	/* Set privilege level to +1 (relative) */
+	regs->sps &= ~KVX_SFR_PS_PL_MASK;
+	regs->sps |= (1 << KVX_SFR_PS_PL_SHIFT);
+}
+
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
+{
+	struct pt_regs *regs, *childregs = task_pt_regs(p);
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long tls = args->tls;
+
+	/* p->thread holds context to be restored by __switch_to() */
+	if (unlikely(args->fn)) {
+		/* Kernel thread */
+		memset(childregs, 0, sizeof(struct pt_regs));
+
+		p->thread.ctx_switch.r20 = (uint64_t)args->fn; /* fn */
+		p->thread.ctx_switch.r21 = (uint64_t)args->fn_arg;
+		p->thread.ctx_switch.ra =
+				(unsigned long) ret_from_kernel_thread;
+	} else {
+		regs = current_pt_regs();
+
+		/* Copy current process registers */
+		*childregs = *regs;
+
+		/* Store tracing status in r20 to avoid computing it
+		 * in assembly
+		 */
+		p->thread.ctx_switch.r20 =
+			task_thread_info(p)->flags & _TIF_SYSCALL_WORK;
+		p->thread.ctx_switch.ra = (unsigned long) ret_from_fork;
+
+		childregs->r0 = 0; /* Return value of fork() */
+		/* Set stack pointer if any */
+		if (usp)
+			childregs->sp = usp;
+
+		/* Set a new TLS ?  */
+		if (clone_flags & CLONE_SETTLS)
+			childregs->r13 = tls;
+	}
+	p->thread.kernel_sp =
+		(unsigned long) (task_stack_page(p) + THREAD_SIZE);
+	p->thread.ctx_switch.sp = (unsigned long) childregs;
+
+	return 0;
+}
+
+void release_thread(struct task_struct *dead_task)
+{
+}
+
+void flush_thread(void)
+{
+}
+
+/* Fill in the fpu structure for a core dump.  */
+int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
+{
+	/*
+	 * On kvx, FPU uses standard registers + $cs which is a common register
+	 * also needed for non-fpu execution, so there is no additional
+	 * register to dump.
+	 */
+	return 0;
+}
+
+static bool find_wchan(unsigned long pc, void *arg)
+{
+	unsigned long *p = arg;
+
+	/*
+	 * If the pc is in a scheduler function (waiting), then, this is the
+	 * address where the process is currently stuck. Note that scheduler
+	 * functions also include lock functions. This functions are
+	 * materialized using annotation to put them is special text sections.
+	 */
+	if (!in_sched_functions(pc)) {
+		*p = pc;
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * __get_wchan is called to obtain "schedule()" caller function address.
+ */
+unsigned long __get_wchan(struct task_struct *p)
+{
+	unsigned long pc = 0;
+	struct stackframe frame;
+
+	/*
+	 * We need to obtain the task stack since we don't want the stack to
+	 * move under our feet.
+	 */
+	if (!try_get_task_stack(p))
+		return 0;
+
+	start_stackframe(&frame, thread_saved_reg(p, fp),
+			 thread_saved_reg(p, ra));
+	walk_stackframe(p, &frame, find_wchan, &pc);
+
+	put_task_stack(p);
+
+	return pc;
+}
+
diff --git a/arch/kvx/kernel/ptrace.c b/arch/kvx/kernel/ptrace.c
new file mode 100644
index 000000000000..aacae5883cb5
--- /dev/null
+++ b/arch/kvx/kernel/ptrace.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/riscv/kernel/ptrace.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Marius Gligor
+ *            Clement Leger
+ */
+
+#include <linux/sched.h>
+#include <linux/sched.h>
+#include <linux/audit.h>
+#include <linux/irqflags.h>
+#include <linux/thread_info.h>
+#include <linux/context_tracking.h>
+#include <linux/uaccess.h>
+#include <linux/syscalls.h>
+#include <linux/signal.h>
+#include <linux/regset.h>
+#include <linux/hw_breakpoint.h>
+
+#include <asm/dame.h>
+#include <asm/ptrace.h>
+#include <asm/syscall.h>
+#include <asm/break_hook.h>
+#include <asm/debug.h>
+#include <asm/cacheflush.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
+#define HW_PT_CMD_GET_CAPS	0
+#define HW_PT_CMD_GET_PT	1
+#define HW_PT_CMD_SET_RESERVE	0
+#define HW_PT_CMD_SET_ENABLE	1
+
+#define FROM_GDB_CMD_MASK 3
+#define FROM_GDB_HP_TYPE_SHIFT 2
+#define FROM_GDB_HP_TYPE_MASK 4
+#define FROM_GDB_WP_TYPE_SHIFT 3
+#define FROM_GDB_WP_TYPE_MASK 0x18
+#define FROM_GDB_HP_IDX_SHIFT 5
+
+#define hw_pt_cmd(addr) ((addr) & FROM_GDB_CMD_MASK)
+#define hw_pt_is_bkp(addr) ((((addr) & FROM_GDB_HP_TYPE_MASK) >> \
+			     FROM_GDB_HP_TYPE_SHIFT) == KVX_HW_BREAKPOINT_TYPE)
+#define get_hw_pt_wp_type(addr) ((((addr) & FROM_GDB_WP_TYPE_MASK)) >> \
+				 FROM_GDB_WP_TYPE_SHIFT)
+#define get_hw_pt_idx(addr) ((addr) >> FROM_GDB_HP_IDX_SHIFT)
+#define get_hw_pt_addr(data) ((data)[0])
+#define get_hw_pt_len(data) ((data)[1] >> 1)
+#define hw_pt_is_enabled(data) ((data)[1] & 1)
+
+enum kvx_regset {
+	REGSET_GPR,
+#ifdef CONFIG_ENABLE_TCA
+	REGSET_TCA,
+#endif
+};
+
+void ptrace_disable(struct task_struct *child)
+{
+	/* nothing to do */
+}
+
+static int kvx_gpr_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 struct membuf to)
+{
+	struct user_pt_regs *regs = &task_pt_regs(target)->user_regs;
+
+	return membuf_write(&to, regs, sizeof(*regs));
+}
+
+static int kvx_gpr_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	struct user_pt_regs *regs = &task_pt_regs(target)->user_regs;
+
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
+}
+
+#ifdef CONFIG_ENABLE_TCA
+static int kvx_tca_reg_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 struct membuf to)
+{
+	struct ctx_switch_regs *ctx_regs = &target->thread.ctx_switch;
+	struct tca_reg *regs = ctx_regs->tca_regs;
+	int ret;
+
+	if (!ctx_regs->tca_regs_saved)
+		ret = membuf_zero(&to, sizeof(*regs));
+	else
+		ret = membuf_write(&to, regs, sizeof(*regs));
+
+	return ret;
+}
+
+static int kvx_tca_reg_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	struct ctx_switch_regs *ctx_regs = &target->thread.ctx_switch;
+	struct tca_reg *regs = ctx_regs->tca_regs;
+	int ret;
+
+	if (!ctx_regs->tca_regs_saved)
+		ret = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+						0, -1);
+	else
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs,
+					 0, -1);
+
+	return ret;
+}
+#endif
+
+static const struct user_regset kvx_user_regset[] = {
+	[REGSET_GPR] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = ELF_NGREG,
+		.size = sizeof(elf_greg_t),
+		.align = sizeof(elf_greg_t),
+		.regset_get = &kvx_gpr_get,
+		.set = &kvx_gpr_set,
+	},
+#ifdef CONFIG_ENABLE_TCA
+	[REGSET_TCA] = {
+		.core_note_type = NT_KVX_TCA,
+		.n = TCA_REG_COUNT,
+		.size = sizeof(struct tca_reg),
+		.align = sizeof(struct tca_reg),
+		.regset_get = &kvx_tca_reg_get,
+		.set = &kvx_tca_reg_set,
+	},
+#endif
+};
+
+static const struct user_regset_view user_kvx_view = {
+	.name = "kvx",
+	.e_machine = EM_KVX,
+	.regsets = kvx_user_regset,
+	.n = ARRAY_SIZE(kvx_user_regset)
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &user_kvx_view;
+}
+
+long arch_ptrace(struct task_struct *child, long request,
+		unsigned long addr, unsigned long data)
+{
+	return ptrace_request(child, request, addr, data);
+}
+
+/*
+ * Allows PTRACE_SYSCALL to work.  These are called from entry.S in
+ * {handle,ret_from}_syscall.
+ */
+int do_syscall_trace_enter(struct pt_regs *regs, unsigned long syscall)
+{
+	int ret = 0;
+
+#ifdef CONFIG_CONTEXT_TRACKING_USER
+	user_exit_callable();
+#endif
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		ret = ptrace_report_syscall_entry(regs);
+
+#ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_enter(regs, syscall_get_nr(current, regs));
+#endif
+
+	audit_syscall_entry(syscall, regs->r0, regs->r1, regs->r2, regs->r3);
+
+	return ret;
+}
+
+void do_syscall_trace_exit(struct pt_regs *regs)
+{
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		ptrace_report_syscall_exit(regs, 0);
+
+	audit_syscall_exit(regs);
+
+#ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_exit(regs, regs_return_value(regs));
+#endif
+
+#ifdef CONFIG_CONTEXT_TRACKING_USER
+	user_enter_callable();
+#endif
+}
+
+static int kvx_bkpt_handler(struct break_hook *brk_hook, struct pt_regs *regs)
+{
+	/* Unexpected breakpoint */
+	if (!(current->ptrace & PT_PTRACED))
+		return BREAK_HOOK_ERROR;
+
+	/* deliver the signal to userspace */
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *) regs->spc);
+
+	return BREAK_HOOK_HANDLED;
+}
+
+static void kvx_stepi(struct pt_regs *regs)
+{
+	/* deliver the signal to userspace */
+	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *) regs->spc);
+}
+
+void user_enable_single_step(struct task_struct *child)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+
+	enable_single_step(regs);
+}
+
+void user_disable_single_step(struct task_struct *child)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+
+	disable_single_step(regs);
+}
+
+/**
+ * Main debug handler called by the _debug_handler routine in entry.S
+ * This handler will perform the required action
+ * @es: Exception Syndrome register value
+ * @ea: Exception Address register
+ * @regs: pointer to registers saved when enter debug
+ */
+int ptrace_debug_handler(u64 ea, struct pt_regs *regs)
+{
+
+	int debug_cause = debug_dc(regs->es);
+
+	switch (debug_cause) {
+	case DEBUG_CAUSE_STEPI:
+		kvx_stepi(regs);
+		break;
+	default:
+		break;
+	}
+
+	return DEBUG_HOOK_HANDLED;
+}
+
+static struct debug_hook ptrace_debug_hook = {
+	.handler = ptrace_debug_handler,
+	.mode = MODE_USER,
+};
+
+static struct break_hook bkpt_break_hook = {
+	.id = BREAK_CAUSE_BKPT,
+	.handler = kvx_bkpt_handler,
+	.mode = MODE_USER,
+};
+
+static int __init arch_init_breakpoint(void)
+{
+	break_hook_register(&bkpt_break_hook);
+	debug_hook_register(&ptrace_debug_hook);
+
+	return 0;
+}
+
+postcore_initcall(arch_init_breakpoint);
diff --git a/arch/kvx/kernel/stacktrace.c b/arch/kvx/kernel/stacktrace.c
new file mode 100644
index 000000000000..85d52ba2d082
--- /dev/null
+++ b/arch/kvx/kernel/stacktrace.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Vincent Chardon
+ */
+
+#include <linux/context_tracking.h>
+#include <linux/kallsyms.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+
+#include <asm/stacktrace.h>
+#include <asm/ptrace.h>
+
+#define STACK_SLOT_PER_LINE		4
+#define STACK_MAX_SLOT_PRINT		(STACK_SLOT_PER_LINE * 8)
+
+static int notrace unwind_frame(struct task_struct *task,
+				struct stackframe *frame)
+{
+	unsigned long fp = frame->fp;
+
+	/* Frame pointer must be aligned on 8 bytes */
+	if (fp & 0x7)
+		return -EINVAL;
+
+	if (!task)
+		task = current;
+
+	if (!on_task_stack(task, fp))
+		return -EINVAL;
+
+	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
+	frame->ra = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
+
+	/*
+	 * When starting, we set the frame pointer to 0, hence end of
+	 * frame linked list is signal by that
+	 */
+	if (!frame->fp)
+		return -EINVAL;
+
+	return 0;
+}
+
+void notrace walk_stackframe(struct task_struct *task, struct stackframe *frame,
+			     bool (*fn)(unsigned long, void *), void *arg)
+{
+	unsigned long addr;
+	int ret;
+
+	while (1) {
+		addr = frame->ra;
+
+		if (fn(addr, arg))
+			break;
+
+		ret = unwind_frame(task, frame);
+		if (ret)
+			break;
+	}
+}
+
+#ifdef CONFIG_STACKTRACE
+bool append_stack_addr(unsigned long pc, void *arg)
+{
+	struct stack_trace *trace;
+
+	trace = (struct stack_trace *)arg;
+	if (trace->skip == 0) {
+		trace->entries[trace->nr_entries++] = pc;
+		if (trace->nr_entries == trace->max_entries)
+			return true;
+	} else {
+		trace->skip--;
+	}
+
+	return false;
+}
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ */
+void save_stack_trace(struct stack_trace *trace)
+{
+	struct stackframe frame;
+
+	trace->nr_entries = 0;
+	/* We want to skip this function and the caller */
+	trace->skip += 2;
+
+	start_stackframe(&frame, (unsigned long) __builtin_frame_address(0),
+			 (unsigned long) save_stack_trace);
+	walk_stackframe(current, &frame, append_stack_addr, trace);
+}
+EXPORT_SYMBOL(save_stack_trace);
+#endif /* CONFIG_STACKTRACE */
+
+static bool print_pc(unsigned long pc, void *arg)
+{
+	unsigned long *skip = arg;
+
+	if (*skip == 0)
+		print_ip_sym(KERN_INFO, pc);
+	else
+		(*skip)--;
+
+	return false;
+}
+
+void show_stacktrace(struct task_struct *task, struct pt_regs *regs)
+{
+	struct stackframe frame;
+	unsigned long skip = 0;
+
+	/* Obviously, we can't backtrace on usermode ! */
+	if (regs && user_mode(regs))
+		return;
+
+	if (!task)
+		task = current;
+
+	if (!try_get_task_stack(task))
+		return;
+
+	if (regs) {
+		start_stackframe(&frame, regs->fp, regs->spc);
+	} else if (task == current) {
+		/* Skip current function and caller */
+		skip = 2;
+		start_stackframe(&frame,
+				 (unsigned long) __builtin_frame_address(0),
+				 (unsigned long) show_stacktrace);
+	} else {
+		/* task blocked in __switch_to */
+		start_stackframe(&frame,
+				 thread_saved_reg(task, fp),
+				 thread_saved_reg(task, ra));
+	}
+
+	pr_info("Call Trace:\n");
+	walk_stackframe(task, &frame, print_pc, &skip);
+
+	put_task_stack(task);
+}
+
+/*
+ * If show_stack is called with a non-null task, then the task will have been
+ * claimed with try_get_task_stack by the caller. If task is NULL or current
+ * then there is no need to get task stack since it's our current stack...
+ */
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	int i = 0;
+
+	if (!sp)
+		sp = (unsigned long *) get_current_sp();
+
+	pr_info("Stack dump (@%p):\n", sp);
+	for (i = 0; i < STACK_MAX_SLOT_PRINT; i++) {
+		if (kstack_end(sp))
+			break;
+
+		if (i && (i % STACK_SLOT_PER_LINE) == 0)
+			pr_cont("\n\t");
+
+		pr_cont("%016lx ", *sp++);
+	}
+	pr_cont("\n");
+
+	show_stacktrace(task, NULL);
+}
-- 
2.37.2





