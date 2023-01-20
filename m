Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E898675686
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjATOLn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjATOLH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:11:07 -0500
Received: from fx601.security-mail.net (smtpout140.security-mail.net [85.31.212.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F63BCE0F
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:10:34 -0800 (PST)
Received: from localhost (fx601.security-mail.net [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id D9E7A3495A9
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:10:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674223832;
        bh=vEPzE4UPjrP9RfuxZKlBQyPh+DKkjOR0sWjN6rJGm/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=06XDYYWVaaBe4oynhWugxyv//L8HaJ6EcxS1VsYcIb/w//9apuuEqAUaIBiNeQ0jc
         Q/a1BdvvyrwdR9/goO65eEtzG871gOVNCFmPQQyVvXx7zD+YjJeSavade8wTW7lbaw
         DxVCd31sQrxIDopJO6kn6U3waVoqkv46CTsug3GE=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 8B72D34944C; Fri, 20 Jan
 2023 15:10:32 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx601.security-mail.net (Postfix) with ESMTPS id C5E7D3493C7; Fri, 20 Jan
 2023 15:10:31 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 362F127E0437; Fri, 20 Jan 2023
 15:10:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 193EE27E043D; Fri, 20 Jan 2023 15:10:31 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 jvSzDkK8KBKa; Fri, 20 Jan 2023 15:10:31 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 984F727E043A; Fri, 20 Jan 2023
 15:10:30 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <1837e.63caa0d7.737ff.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 193EE27E043D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223831;
 bh=DmzWtNbu9q/4tdr0s78bdEDa3viNBQUf7Z5t+96KI4s=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=fu0N7x6nnMzNoJzaoFf7v+P0ip4/vd3WETP3kcNxOV8lUW4FUEgIHhlGEaapCaaWz
 trFOuxwdKHhTQMjErede9J063YUB4llfkDR1AlG/RnHltlp+dT86cwzYEgc4+IcIMU
 vO/Z00O1Gtxz1AmibpXGVXxbhTaqAPWZbIWrCzPw=
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
Subject: [RFC PATCH v2 14/31] kvx: Add exception/interrupt handling
Date:   Fri, 20 Jan 2023 15:09:45 +0100
Message-ID: <20230120141002.2442-15-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add the exception and interrupt handling machanism for basic kvx
support.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Luc Michel <lmichel@kalray.eu>
Signed-off-by: Luc Michel <lmichel@kalray.eu>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2:
     - removed ipi.h headers and driver (moved into ipi driver patch)

 arch/kvx/include/asm/break_hook.h |  69 +++++++++
 arch/kvx/include/asm/bug.h        |  67 ++++++++
 arch/kvx/include/asm/dame.h       |  31 ++++
 arch/kvx/include/asm/hardirq.h    |  14 ++
 arch/kvx/include/asm/hw_irq.h     |  14 ++
 arch/kvx/include/asm/irqflags.h   |  58 +++++++
 arch/kvx/include/asm/stacktrace.h |  44 ++++++
 arch/kvx/include/asm/traps.h      |  76 ++++++++++
 arch/kvx/kernel/dame_handler.c    | 113 ++++++++++++++
 arch/kvx/kernel/irq.c             |  78 ++++++++++
 arch/kvx/kernel/traps.c           | 243 ++++++++++++++++++++++++++++++
 11 files changed, 807 insertions(+)
 create mode 100644 arch/kvx/include/asm/break_hook.h
 create mode 100644 arch/kvx/include/asm/bug.h
 create mode 100644 arch/kvx/include/asm/dame.h
 create mode 100644 arch/kvx/include/asm/hardirq.h
 create mode 100644 arch/kvx/include/asm/hw_irq.h
 create mode 100644 arch/kvx/include/asm/irqflags.h
 create mode 100644 arch/kvx/include/asm/stacktrace.h
 create mode 100644 arch/kvx/include/asm/traps.h
 create mode 100644 arch/kvx/kernel/dame_handler.c
 create mode 100644 arch/kvx/kernel/irq.c
 create mode 100644 arch/kvx/kernel/traps.c

diff --git a/arch/kvx/include/asm/break_hook.h b/arch/kvx/include/asm/break_hook.h
new file mode 100644
index 000000000000..333b2c440c81
--- /dev/null
+++ b/arch/kvx/include/asm/break_hook.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef __ASM_KVX_BREAK_HOOK_H_
+#define __ASM_KVX_BREAK_HOOK_H_
+
+#include <linux/types.h>
+
+#include <asm/sfr_defs.h>
+#include <asm/insns_defs.h>
+
+/*
+ * The following macros define the different causes of break:
+ * We use the `set $vsfr0 = $rXX` instruction which will raise a trap into the
+ * debugger. The trapping instruction is read and decoded to extract the source
+ * register number. The source register number is used to differentiate the
+ * trap cause.
+ */
+#define BREAK_CAUSE_BUG		KVX_REG_R1
+#define BREAK_CAUSE_KGDB_DYN	KVX_REG_R2
+#define BREAK_CAUSE_KGDB_COMP	KVX_REG_R3
+#define BREAK_CAUSE_BKPT	KVX_REG_R63
+
+/**
+ * enum break_ret - Break return value
+ * @BREAK_HOOK_HANDLED: Hook handled successfully
+ * @BREAK_HOOK_ERROR: Hook was not handled
+ */
+enum break_ret {
+	BREAK_HOOK_HANDLED = 0,
+	BREAK_HOOK_ERROR = 1,
+};
+
+/*
+ * The following macro assembles a `set` instruction targeting $vsfr0
+ * using the source register whose number is __id.
+ */
+#define KVX_BREAK_INSN(__id) \
+	KVX_INSN_SET_SYLLABLE_0(KVX_INSN_PARALLEL_EOB, KVX_SFR_VSFR0, __id)
+
+#define KVX_BREAK_INSN_SIZE (KVX_INSN_SET_SIZE * KVX_INSN_SYLLABLE_WIDTH)
+
+struct pt_regs;
+
+/**
+ * struct break_hook - Break hook description
+ * @node: List node
+ * @handler: handler called when break matches this hook
+ * @imm: Immediate value expected for break insn
+ * @mode: Hook mode (user/kernel)
+ */
+struct break_hook {
+	struct list_head node;
+	int (*handler)(struct break_hook *brk_hook, struct pt_regs *regs);
+	u8 id;
+	u8 mode;
+};
+
+void kvx_skip_break_insn(struct pt_regs *regs);
+
+void break_hook_register(struct break_hook *brk_hook);
+void break_hook_unregister(struct break_hook *brk_hook);
+
+int break_hook_handler(u64 es, struct pt_regs *regs);
+
+#endif /* __ASM_KVX_BREAK_HOOK_H_ */
diff --git a/arch/kvx/include/asm/bug.h b/arch/kvx/include/asm/bug.h
new file mode 100644
index 000000000000..62f556b00d5a
--- /dev/null
+++ b/arch/kvx/include/asm/bug.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BUG_H
+#define _ASM_KVX_BUG_H
+
+#include <linux/compiler.h>
+#include <linux/const.h>
+#include <linux/types.h>
+
+#include <asm/break_hook.h>
+
+#ifdef CONFIG_GENERIC_BUG
+
+#define BUG_INSN	KVX_BREAK_INSN(BREAK_CAUSE_BUG)
+
+#define __BUG_ENTRY_ADDR	".dword 1b"
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_ENTRY_LAST_MEMBER		flags
+#define __BUG_ENTRY			\
+	__BUG_ENTRY_ADDR "\n\t"		\
+	".dword %0\n\t"			\
+	".short %1\n\t"
+#else
+#define __BUG_ENTRY_LAST_MEMBER		file
+#define __BUG_ENTRY			\
+	__BUG_ENTRY_ADDR "\n\t"
+#endif
+
+#define BUG()							\
+do {								\
+	__asm__ __volatile__ (					\
+		"1:\n\t"					\
+			".word " __stringify(BUG_INSN) "\n"	\
+			".pushsection __bug_table,\"a\"\n\t"	\
+		"2:\n\t"					\
+			__BUG_ENTRY				\
+			".fill 1, %2, 0\n\t"			\
+			".popsection"				\
+		:						\
+		: "i" (__FILE__), "i" (__LINE__),		\
+		  "i" (sizeof(struct bug_entry) -		\
+		  offsetof(struct bug_entry, __BUG_ENTRY_LAST_MEMBER))); \
+	unreachable();						\
+} while (0)
+
+#else /* CONFIG_GENERIC_BUG */
+#define BUG()								\
+do {									\
+	__asm__ __volatile__ (".word " __stringify(BUG_INSN) "\n");	\
+	unreachable();							\
+} while (0)
+#endif /* CONFIG_GENERIC_BUG */
+
+#define HAVE_ARCH_BUG
+
+struct pt_regs;
+
+void die(struct pt_regs *regs, unsigned long ea, const char *str);
+
+#include <asm-generic/bug.h>
+
+#endif /* _ASM_KVX_BUG_H */
diff --git a/arch/kvx/include/asm/dame.h b/arch/kvx/include/asm/dame.h
new file mode 100644
index 000000000000..8befd767bbee
--- /dev/null
+++ b/arch/kvx/include/asm/dame.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_DAME_H
+#define _ASM_KVX_DAME_H
+
+#include <asm/sfr.h>
+#include <asm/ptrace.h>
+
+static inline void dame_irq_check(struct pt_regs *regs)
+{
+#ifdef CONFIG_SECURE_DAME_HANDLING
+	unsigned long ilr;
+	/* If we are returning to the kernel, no need to check for DAME */
+	if (!user_mode(regs))
+		return;
+
+	/* Else, make sure we do a barrier to trig any pending DAME IRQ */
+	__builtin_kvx_barrier();
+
+	/* Check if we triggered a DAME */
+	ilr = kvx_sfr_get(ILR);
+	if (ilr & KVX_SFR_ILR_IT16_MASK)
+		panic("DAME error encountered while in kernel !!!!\n");
+#endif
+}
+
+#endif /* _ASM_KVX_DAME_H */
diff --git a/arch/kvx/include/asm/hardirq.h b/arch/kvx/include/asm/hardirq.h
new file mode 100644
index 000000000000..f82630f7e4e2
--- /dev/null
+++ b/arch/kvx/include/asm/hardirq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_HARDIRQ_H
+#define _ASM_KVX_HARDIRQ_H
+
+#define __ARCH_IRQ_EXIT_IRQS_DISABLED 1
+
+#include <asm-generic/hardirq.h>
+
+#endif /* _ASM_KVX_HARDIRQ_H */
diff --git a/arch/kvx/include/asm/hw_irq.h b/arch/kvx/include/asm/hw_irq.h
new file mode 100644
index 000000000000..f073dba3b1c5
--- /dev/null
+++ b/arch/kvx/include/asm/hw_irq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * derived from arch/mips/include/asm/ide.h
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_HW_IRQ_H
+#define _ASM_KVX_HW_IRQ_H
+
+void kvx_init_core_irq(void);
+
+#endif	/* _ASM_KVX_HW_IRQ_H */
diff --git a/arch/kvx/include/asm/irqflags.h b/arch/kvx/include/asm/irqflags.h
new file mode 100644
index 000000000000..681c890b3fcd
--- /dev/null
+++ b/arch/kvx/include/asm/irqflags.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_IRQFLAGS_H
+#define _ASM_KVX_IRQFLAGS_H
+
+#include <linux/types.h>
+
+#include <asm/sfr.h>
+
+static inline notrace unsigned long arch_local_save_flags(void)
+{
+	return kvx_sfr_get(PS) & (1 << KVX_SFR_PS_IE_SHIFT);
+}
+
+static inline notrace unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags = arch_local_save_flags();
+
+	kvx_sfr_set_field(PS, IE, 0);
+
+	return flags;
+}
+
+static inline notrace void arch_local_irq_restore(unsigned long flags)
+{
+	/* If flags are set, interrupt are enabled), set the IE bit */
+	if (flags)
+		kvx_sfr_set_field(PS, IE, 1);
+	else
+		kvx_sfr_set_field(PS, IE, 0);
+}
+
+static inline notrace void arch_local_irq_enable(void)
+{
+	kvx_sfr_set_field(PS, IE, 1);
+}
+
+static inline notrace void arch_local_irq_disable(void)
+{
+	kvx_sfr_set_field(PS, IE, 0);
+}
+
+static inline notrace bool arch_irqs_disabled_flags(unsigned long flags)
+{
+	return (flags & (1 << KVX_SFR_PS_IE_SHIFT)) == 0;
+}
+
+static inline notrace bool arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(kvx_sfr_get(PS));
+}
+
+
+#endif	/* _ASM_KVX_IRQFLAGS_H */
diff --git a/arch/kvx/include/asm/stacktrace.h b/arch/kvx/include/asm/stacktrace.h
new file mode 100644
index 000000000000..0feed6bd4424
--- /dev/null
+++ b/arch/kvx/include/asm/stacktrace.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_STACKTRACE_H
+#define _ASM_KVX_STACKTRACE_H
+
+#include <linux/sched/task_stack.h>
+
+/**
+ * Structure of a frame on the stack
+ */
+struct stackframe {
+	unsigned long fp;	/* Next frame pointer */
+	unsigned long ra;	/* Return address */
+};
+
+static inline bool on_task_stack(struct task_struct *tsk, unsigned long sp)
+{
+	unsigned long low = (unsigned long) task_stack_page(tsk);
+	unsigned long high = low + THREAD_SIZE;
+
+	if (sp < low || sp >= high)
+		return false;
+
+	return true;
+}
+
+void show_stacktrace(struct task_struct *task, struct pt_regs *regs);
+
+
+void walk_stackframe(struct task_struct *task, struct stackframe *frame,
+			     bool (*fn)(unsigned long, void *), void *arg);
+
+static inline void start_stackframe(struct stackframe *frame,
+				    unsigned long fp,
+				    unsigned long pc)
+{
+	frame->fp = fp;
+	frame->ra = pc;
+}
+#endif /* _ASM_KVX_STACKTRACE_H */
diff --git a/arch/kvx/include/asm/traps.h b/arch/kvx/include/asm/traps.h
new file mode 100644
index 000000000000..77a663968135
--- /dev/null
+++ b/arch/kvx/include/asm/traps.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ */
+
+#ifndef _ASM_KVX_TRAPS_H
+#define _ASM_KVX_TRAPS_H
+
+#include <asm/sfr.h>
+
+#define KVX_TRAP_RESET          0x0
+#define KVX_TRAP_OPCODE         0x1
+#define KVX_TRAP_PRIVILEGE      0x2
+#define KVX_TRAP_DMISALIGN      0x3
+#define KVX_TRAP_PSYSERROR      0x4
+#define KVX_TRAP_DSYSERROR      0x5
+#define KVX_TRAP_PDECCERROR     0x6
+#define KVX_TRAP_DDECCERROR     0x7
+#define KVX_TRAP_PPARERROR      0x8
+#define KVX_TRAP_DPARERROR      0x9
+#define KVX_TRAP_PSECERROR      0xA
+#define KVX_TRAP_DSECERROR      0xB
+#define KVX_TRAP_NOMAPPING      0xC
+#define KVX_TRAP_PROTECTION     0xD
+#define KVX_TRAP_WRITETOCLEAN   0xE
+#define KVX_TRAP_ATOMICTOCLEAN  0xF
+#define KVX_TRAP_TPAR           0x10
+#define KVX_TRAP_DOUBLE_ECC     0x11
+#define KVX_TRAP_VSFR           0x12
+#define KVX_TRAP_PL_OVERFLOW    0x13
+
+#define KVX_TRAP_COUNT          0x14
+
+#define KVX_TRAP_SFRI_NOT_BCU	0
+#define KVX_TRAP_SFRI_GET	1
+#define KVX_TRAP_SFRI_IGET	2
+#define KVX_TRAP_SFRI_SET	4
+#define KVX_TRAP_SFRI_WFXL	5
+#define KVX_TRAP_SFRI_WFXM	6
+#define KVX_TRAP_SFRI_RSWAP	7
+
+/* Access type on memory trap */
+#define KVX_TRAP_RWX_FETCH	1
+#define KVX_TRAP_RWX_WRITE	2
+#define KVX_TRAP_RWX_READ	4
+#define KVX_TRAP_RWX_ATOMIC	6
+
+#ifndef __ASSEMBLY__
+
+typedef void (*trap_handler_func) (uint64_t es, uint64_t ea,
+				   struct pt_regs *regs);
+
+#define trap_cause(__es) kvx_sfr_field_val(__es, ES, HTC)
+
+#define trap_sfri(__es) \
+	kvx_sfr_field_val((__es), ES, SFRI)
+
+#define trap_gprp(__es) \
+	kvx_sfr_field_val((__es), ES, GPRP)
+
+#define trap_sfrp(__es) \
+	kvx_sfr_field_val((__es), ES, SFRP)
+
+#ifdef CONFIG_MMU
+extern void do_page_fault(uint64_t es, uint64_t ea, struct pt_regs *regs);
+extern void do_writetoclean(uint64_t es, uint64_t ea, struct pt_regs *regs);
+#endif
+
+void user_do_sig(struct pt_regs *regs, int signo, int code, unsigned long addr);
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/kvx/kernel/dame_handler.c b/arch/kvx/kernel/dame_handler.c
new file mode 100644
index 000000000000..ce190bee8211
--- /dev/null
+++ b/arch/kvx/kernel/dame_handler.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/of.h>
+#include <linux/bug.h>
+#include <linux/init.h>
+#include <linux/of_irq.h>
+#include <linux/hardirq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/cpuhotplug.h>
+#include <linux/sched/signal.h>
+
+static unsigned int kvx_dame_irq;
+
+static const char *error_str[KVX_SFR_ES_ITI_WIDTH] = {
+	"PSE",
+	"PILSY",
+	"PILDE",
+	"PILPA",
+	"DSE",
+	"DILSY",
+	"DILDE",
+	"DILPA",
+	"DDEE",
+	"DSYE"
+};
+
+static irqreturn_t dame_irq_handler(int irq, void *dev_id)
+{
+	int bit;
+	struct pt_regs *regs = get_irq_regs();
+	unsigned long error_status = kvx_sfr_field_val(regs->es, ES, ITI);
+
+	if (error_status) {
+		pr_err("Memory Error:\n");
+		for_each_set_bit(bit, &error_status, KVX_SFR_ES_ITI_WIDTH)
+			pr_err("- %s\n", error_str[bit]);
+	}
+
+	/*
+	 * If the DAME happened in user mode, we can handle it properly
+	 * by killing the user process.
+	 * Otherwise, if we are in kernel, we are fried...
+	 */
+	if (user_mode(regs))
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) NULL);
+	else
+		die(regs, 0, "DAME error encountered while in kernel !!!!\n");
+
+	return IRQ_HANDLED;
+}
+
+static int kvx_dame_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(kvx_dame_irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int kvx_dame_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(kvx_dame_irq);
+
+	return 0;
+}
+
+static int __init dame_handler_init(void)
+{
+	struct device_node *dame_node;
+	int ret;
+
+	dame_node = of_find_compatible_node(NULL, NULL,
+					    "kalray,kvx-dame-handler");
+	if (!dame_node) {
+		pr_err("Failed to find dame handler device tree node\n");
+		return -ENODEV;
+	}
+
+	kvx_dame_irq = irq_of_parse_and_map(dame_node, 0);
+	of_node_put(dame_node);
+
+	if (!kvx_dame_irq) {
+		pr_err("Failed to parse dame irq\n");
+		return -ENODEV;
+	}
+
+	ret = request_percpu_irq(kvx_dame_irq, dame_irq_handler, "dame",
+				 &kvx_dame_irq);
+	if (ret) {
+		pr_err("Failed to request dame irq\n");
+		return -ENODEV;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"kvx/dame_handler:online",
+				kvx_dame_starting_cpu,
+				kvx_dame_dying_cpu);
+	if (ret <= 0) {
+		pr_err("Failed to setup cpuhp\n");
+		return ret;
+	}
+
+	pr_info("DAME handler registered\n");
+
+	return 0;
+}
+
+core_initcall(dame_handler_init);
diff --git a/arch/kvx/kernel/irq.c b/arch/kvx/kernel/irq.c
new file mode 100644
index 000000000000..5d7c8cfba1dd
--- /dev/null
+++ b/arch/kvx/kernel/irq.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/irqdomain.h>
+#include <linux/irqflags.h>
+#include <linux/hardirq.h>
+#include <linux/irqchip.h>
+#include <linux/bitops.h>
+#include <linux/init.h>
+
+#include <asm/dame.h>
+
+#define IT_MASK(__it) (KVX_SFR_ILL_ ## __it ## _MASK)
+#define IT_LEVEL(__it, __level) \
+	(__level##ULL << KVX_SFR_ILL_ ## __it ## _SHIFT)
+
+void do_IRQ(unsigned long hwirq_mask, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	int irq;
+	unsigned int hwirq;
+
+	trace_hardirqs_off();
+
+	irq_enter();
+
+	while (hwirq_mask) {
+		hwirq = __ffs(hwirq_mask);
+		irq = irq_find_mapping(NULL, hwirq);
+		generic_handle_irq(irq);
+		hwirq_mask &= ~BIT_ULL(hwirq);
+	}
+
+	irq_exit();
+	set_irq_regs(old_regs);
+
+	dame_irq_check(regs);
+}
+
+/*
+ * Early Hardware specific Interrupt setup
+ * -Called very early (start_kernel -> setup_arch -> setup_processor)
+ * -Needed for each CPU
+ */
+void kvx_init_core_irq(void)
+{
+	/*
+	 * On KVX, Kernel only care about the following IT:
+	 * - IT0: Timer 0
+	 * - IT2: Watchdog
+	 * - IT4: APIC IT 1
+	 * - IT24: IPI
+	 */
+	uint64_t mask = IT_MASK(IT0) | IT_MASK(IT2) | IT_MASK(IT4) |
+			IT_MASK(IT24);
+
+	/*
+	 * Specific priorities for ITs:
+	 * - Watchdog has the highest priority: 3
+	 * - Timer has priority 2
+	 * - APIC entries have lowest priority: 1
+	 */
+	uint64_t value = IT_LEVEL(IT0, 0x2) | IT_LEVEL(IT2, 0x3) |
+			IT_LEVEL(IT4, 0x1) | IT_LEVEL(IT24, 0x1);
+
+	kvx_sfr_set_mask(ILL, mask, value);
+
+	/* Set core level to 0 */
+	kvx_sfr_set_field(PS, IL, 0);
+}
+
+void __init init_IRQ(void)
+{
+	irqchip_init();
+}
diff --git a/arch/kvx/kernel/traps.c b/arch/kvx/kernel/traps.c
new file mode 100644
index 000000000000..3a1706b666c2
--- /dev/null
+++ b/arch/kvx/kernel/traps.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ */
+
+#include <linux/context_tracking.h>
+#include <linux/sched/task_stack.h>
+#include <linux/sched/debug.h>
+#include <linux/irqflags.h>
+#include <linux/uaccess.h>
+#include <linux/kdebug.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/ptrace.h>
+
+#include <asm/dame.h>
+#include <asm/traps.h>
+#include <asm/ptrace.h>
+#include <asm/break_hook.h>
+#include <asm/stacktrace.h>
+
+int show_unhandled_signals = 1;
+
+static DEFINE_SPINLOCK(die_lock);
+
+static trap_handler_func trap_handler_table[KVX_TRAP_COUNT] = { NULL };
+
+/* Trap names associated to the trap numbers */
+static const char * const trap_name[] = {
+	"RESET",
+	"OPCODE",
+	"PRIVILEGE",
+	"DMISALIGN",
+	"PSYSERROR",
+	"DSYSERROR",
+	"PDECCERROR",
+	"DDECCERROR",
+	"PPARERROR",
+	"DPARERROR",
+	"PSECERROR",
+	"DSECERROR",
+	/* MMU related traps */
+	"NOMAPPING",
+	"PROTECTION",
+	"WRITETOCLEAN",
+	"ATOMICTOCLEAN",
+	"TPAR",
+	"DOUBLE_ECC",
+	"VSFR",
+	"PL_OVERFLOW"
+};
+
+void die(struct pt_regs *regs, unsigned long ea, const char *str)
+{
+	static int die_counter;
+	int ret;
+
+	oops_enter();
+
+	spin_lock_irq(&die_lock);
+	console_verbose();
+	bust_spinlocks(1);
+
+	pr_emerg("%s [#%d]\n", str, ++die_counter);
+	print_modules();
+	show_regs(regs);
+
+	if (!user_mode(regs))
+		show_stacktrace(NULL, regs);
+
+	ret = notify_die(DIE_OOPS, str, regs, ea, 0, SIGSEGV);
+
+	bust_spinlocks(0);
+	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
+	spin_unlock_irq(&die_lock);
+	oops_exit();
+
+	if (in_interrupt())
+		panic("Fatal exception in interrupt");
+	if (panic_on_oops)
+		panic("Fatal exception");
+	if (ret != NOTIFY_STOP)
+		make_task_dead(SIGSEGV);
+}
+
+void user_do_sig(struct pt_regs *regs, int signo, int code, unsigned long addr)
+{
+	struct task_struct *tsk = current;
+
+	if (show_unhandled_signals && unhandled_signal(tsk, signo)
+	    && printk_ratelimit()) {
+		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x%lx",
+			tsk->comm, task_pid_nr(tsk), signo, code, addr);
+		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
+		pr_cont("\n");
+		show_regs(regs);
+	}
+	if (signo == SIGKILL) {
+		force_sig(signo);
+		return;
+	}
+	force_sig_fault(signo, code, (void __user *) addr);
+}
+
+static void panic_or_kill(uint64_t es, uint64_t ea, struct pt_regs *regs,
+			  int signo, int sigcode)
+{
+	if (user_mode(regs)) {
+		user_do_sig(regs, signo, sigcode, ea);
+		return;
+	}
+
+	pr_alert(CUT_HERE "ERROR: TRAP %s received at 0x%.16llx\n",
+	      trap_name[trap_cause(es)], regs->spc);
+	die(regs, ea, "Oops");
+	make_task_dead(SIGKILL);
+}
+
+int is_valid_bugaddr(unsigned long pc)
+{
+	/*
+	 * Since the bug was reported, this means that the break hook handling
+	 * already check the faulting instruction so there is no need for
+	 * additionnal check here. This is a BUG for sure.
+	 */
+	return 1;
+}
+
+static int bug_break_handler(struct break_hook *brk_hook, struct pt_regs *regs)
+{
+	enum bug_trap_type type;
+
+	type = report_bug(regs->spc, regs);
+	switch (type) {
+	case BUG_TRAP_TYPE_NONE:
+		return BREAK_HOOK_ERROR;
+	case BUG_TRAP_TYPE_WARN:
+		break;
+	case BUG_TRAP_TYPE_BUG:
+		die(regs, regs->spc, "Kernel BUG");
+		break;
+	}
+
+	/* Skip over break insn if we survived ! */
+	kvx_skip_break_insn(regs);
+
+	return BREAK_HOOK_HANDLED;
+}
+
+static struct break_hook bug_break_hook = {
+	.handler = bug_break_handler,
+	.id = BREAK_CAUSE_BUG,
+	.mode = MODE_KERNEL,
+};
+
+#define GEN_TRAP_HANDLER(__name, __sig, __code) \
+static void __name ## _trap_handler(uint64_t es, uint64_t ea, \
+				 struct pt_regs *regs) \
+{ \
+	panic_or_kill(es, ea, regs, __sig, __code); \
+}
+
+GEN_TRAP_HANDLER(default, SIGKILL, SI_KERNEL);
+GEN_TRAP_HANDLER(privilege, SIGILL, ILL_PRVREG);
+GEN_TRAP_HANDLER(dmisalign, SIGBUS, BUS_ADRALN);
+GEN_TRAP_HANDLER(syserror, SIGBUS, BUS_ADRERR);
+GEN_TRAP_HANDLER(opcode, SIGILL, ILL_ILLOPC);
+
+static void register_trap_handler(unsigned int trap_nb, trap_handler_func fn)
+{
+
+	if (trap_nb >= KVX_TRAP_COUNT || fn == NULL)
+		panic("Failed to register handler #%d\n", trap_nb);
+
+	trap_handler_table[trap_nb] = fn;
+}
+
+static void do_vsfr_fault(uint64_t es, uint64_t ea, struct pt_regs *regs)
+{
+	if (break_hook_handler(es, regs) == BREAK_HOOK_HANDLED)
+		return;
+
+	panic_or_kill(es, ea, regs, SIGILL, ILL_PRVREG);
+}
+
+void __init trap_init(void)
+{
+	int i;
+
+	break_hook_register(&bug_break_hook);
+
+	for (i = 0; i < KVX_TRAP_COUNT; i++)
+		register_trap_handler(i, default_trap_handler);
+#ifdef CONFIG_MMU
+	register_trap_handler(KVX_TRAP_NOMAPPING, do_page_fault);
+	register_trap_handler(KVX_TRAP_PROTECTION, do_page_fault);
+	register_trap_handler(KVX_TRAP_WRITETOCLEAN, do_writetoclean);
+#endif
+
+	register_trap_handler(KVX_TRAP_PSYSERROR, syserror_trap_handler);
+	register_trap_handler(KVX_TRAP_DSYSERROR, syserror_trap_handler);
+	register_trap_handler(KVX_TRAP_PRIVILEGE, privilege_trap_handler);
+	register_trap_handler(KVX_TRAP_OPCODE, opcode_trap_handler);
+	register_trap_handler(KVX_TRAP_DMISALIGN, dmisalign_trap_handler);
+	register_trap_handler(KVX_TRAP_VSFR, do_vsfr_fault);
+}
+
+/**
+ * trap_handler - trap handler called by _trap_handler routine in trap_handler.S
+ * This handler will redirect to other trap handlers if present
+ * If not then it will do a generic action
+ * @es: Exception Syndrome register value
+ * @ea: Exception Address register
+ * @regs: pointer to registers saved when trapping
+ */
+void trap_handler(uint64_t es, uint64_t ea, struct pt_regs *regs)
+{
+	enum ctx_state prev_state = exception_enter();
+	int htc = trap_cause(es);
+	trap_handler_func trap_func = trap_handler_table[htc];
+
+	trace_hardirqs_off();
+
+	/* Normal traps number should and must be between 0 and 15 included */
+	if (unlikely(htc >= KVX_TRAP_COUNT)) {
+		pr_err("Invalid trap %d !\n", htc);
+		goto done;
+	}
+
+	/* If irqs were enabled in the preempted context, reenable them */
+	if (regs->sps & KVX_SFR_PS_IE_MASK)
+		local_irq_enable();
+
+	trap_func(es, ea, regs);
+
+done:
+	dame_irq_check(regs);
+	exception_exit(prev_state);
+}
-- 
2.37.2





