Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1F6613FEB
	for <lists+linux-arch@lfdr.de>; Mon, 31 Oct 2022 22:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJaVcc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Oct 2022 17:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaVcc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Oct 2022 17:32:32 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00A3101C8
        for <linux-arch@vger.kernel.org>; Mon, 31 Oct 2022 14:32:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d3so18389449ljl.1
        for <linux-arch@vger.kernel.org>; Mon, 31 Oct 2022 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zw7CDIVenRFcPJl+eTzKC2/u+PfxOUaxmkZDA8+keAc=;
        b=ILnb3JB+B7liqY7o2WKAdpqoK5gihT2v8llDXZZ0JMYcfbVE3V3gi/9bUXfudKRGZk
         nnaib1MMEdtEdTj9Rs2bKu8gyHm/l3pr+QLyBeZzYU/n6EiO8FVbcUjVQGTHCvbMXkaw
         1nnBlHKEu+ejKvS0odBUz2LsXACwDGzHXtT73rNafufWk0IdyH8q//woc9TdT8dymURq
         7r38R6BQtctQRf2awaCqlEauT/KT4YtfvHGQ4AMi1YWHwsRmN6rfT4YWc+nPSnVAtHz8
         xxy2nTIv5C1Dl2TOd/7y/C0uPrHcZbVYS18kVcGObTB/xtHZgEn/8ICXNtKTtcH243Ua
         /szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zw7CDIVenRFcPJl+eTzKC2/u+PfxOUaxmkZDA8+keAc=;
        b=pKH0MDC7sQC1zBZJyRX9J1CQ4432WkGc6C6Sf0iPfIdER2p0mF/PTKFMoTFnipK2s3
         gY1sJmDSUycd7Xjlb87u/JRNk4H7Txg1AN3eyxyiAAPBKFn+oKaslzC7mnykAQ6uhhkY
         b9YZos2nAyBJDiA2Se0t+4B4pPhUg1a0USsQXqpd/tq50AEfEfiypn71nODNKoLp1VTr
         p6TQtskrDH26ATRFINM4FoRXmFr+ruOD/JVscLp8x+lUJUM7ezxl5Hg6qN9UA2IIuee8
         wCn2nL2sHg5pPTckLQyyB79Ji9vwQTk+1yxPsPbwwpWzuiWtdK5AxbPHhX+UltPb11PL
         3R9w==
X-Gm-Message-State: ACrzQf3axavuXJ8pVLxesBO7MLIzFX8dL2ZJVOuza0RWhE2qp/5Ch2QT
        Oy74HKuHqtN8SDr8/XRA9hojprQ/XS/U1Q==
X-Google-Smtp-Source: AMsMyM7vTcnrv2iDv/Aoh9ra+TcG05NWV9pVLnk9/4t9KOeFcIRELpVPnKveyczKsuBJlApBMhD/2Q==
X-Received: by 2002:a2e:a4bc:0:b0:260:206f:635d with SMTP id g28-20020a2ea4bc000000b00260206f635dmr38049ljm.231.1667251948013;
        Mon, 31 Oct 2022 14:32:28 -0700 (PDT)
Received: from localhost.localdomain ([5.188.167.245])
        by smtp.googlemail.com with ESMTPSA id q17-20020ac25fd1000000b004a2ae643b99sm1431902lfg.170.2022.10.31.14.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:32:27 -0700 (PDT)
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: [RFC PATCH v1] riscv: support for hardware breakpoints/watchpoints
Date:   Tue,  1 Nov 2022 00:32:25 +0300
Message-Id: <20221031213225.912258-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

RISC-V Debug specification includes Sdtrig ISA extension. This extension
describes Trigger Module. Triggers can cause a breakpoint exception,
entry into Debug Mode, or a trace action without having to execute a
special instruction. For native debugging triggers can be used to
implement hardware breakpoints and watchpoints.

Software support for RISC-V hardware triggers consists of the following
major components:
 - U-mode: gdb support for setting hw breakpoints/watchpoints
 - S/VS-mode: hardware breakpoints framework in Linux kernel
 - M-mode: SBI firmware code to handle hardware triggers

SBI Debug Trigger extension proposal has been posted by Anup Patel
to lists.riscv.org tech-debug mailing list, see:
https://lists.riscv.org/g/tech-debug/topic/92375492

This patch provides initial Linux support for RISC-V hardware breakpoints
and watchpoints based on the proposed SBI Debug Trigger extension. The
accompanying OpenSBI changes implementing new extension are also posted
for review, see:

http://lists.infradead.org/pipermail/opensbi/2022-October/003531.html

Initial version has the following limitations:
- userspace debug is not yet enabled: work on ptrace/gdb is in progress
- only mcontrol6 trigger type is supported
- no support for chained triggers
- no support for virtualization

Despite missing userspace debug, initial implementation can be tested
on QEMU using kernel breakpoints, e.g. see samples/hw_breakpoint and
register_wide_hw_breakpoint. Hardware breakpoints work on upstream QEMU.
However this is not the case for watchpoints since there is no way to
figure out which watchpoint is triggered. IIUC there are two possible
options for doing this: using 'hit' bit in tdata1 or reading faulting
virtual address from STVAL. QEMU implements neither of them. Current
implementation opts for STVAL. So the following experimental QEMU patch
is required to make watchpoints work:

:  diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
:  index 278d163803..8858be7411 100644
:  --- a/target/riscv/cpu_helper.c
:  +++ b/target/riscv/cpu_helper.c
:  @@ -1639,6 +1639,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
:           case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
:               tval = env->bins;
:               break;
:  +        case RISCV_EXCP_BREAKPOINT:
:  +            tval = env->badaddr;
:  +            env->badaddr = 0x0;
:  +            break;
:           default:
:               break;
:           }
:  diff --git a/target/riscv/debug.c b/target/riscv/debug.c
:  index 26ea764407..b4d1d566ab 100644
:  --- a/target/riscv/debug.c
:  +++ b/target/riscv/debug.c
:  @@ -560,6 +560,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
:
:       if (cs->watchpoint_hit) {
:           if (cs->watchpoint_hit->flags & BP_CPU) {
:  +            env->badaddr = cs->watchpoint_hit->hitaddr;
:               cs->watchpoint_hit = NULL;
:               do_trigger_action(env, DBG_ACTION_BP);
:           }

Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
---
 arch/riscv/Kconfig                     |   2 +
 arch/riscv/include/asm/hw_breakpoint.h | 131 ++++++++
 arch/riscv/include/asm/kdebug.h        |   3 +-
 arch/riscv/include/asm/processor.h     |   5 +
 arch/riscv/include/asm/sbi.h           |  24 ++
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/hw_breakpoint.c      | 416 +++++++++++++++++++++++++
 arch/riscv/kernel/process.c            |   1 +
 arch/riscv/kernel/traps.c              |   5 +
 9 files changed, 587 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa78595a6089..245ed0628211 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -95,10 +95,12 @@ config RISCV
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
+	select HAVE_MIXED_BREAKPOINTS_REGS
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
new file mode 100644
index 000000000000..7610b6be669d
--- /dev/null
+++ b/arch/riscv/include/asm/hw_breakpoint.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __RISCV_HW_BREAKPOINT_H
+#define __RISCV_HW_BREAKPOINT_H
+
+struct task_struct;
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+
+#include <uapi/linux/hw_breakpoint.h>
+
+enum {
+	RISCV_DBTR_BREAKPOINT	= 0,
+	RISCV_DBTR_WATCHPOINT	= 1,
+};
+
+enum {
+	RISCV_DBTR_TRIG_NONE = 0,
+	RISCV_DBTR_TRIG_LEGACY,
+	RISCV_DBTR_TRIG_MCONTROL,
+	RISCV_DBTR_TRIG_ICOUNT,
+	RISCV_DBTR_TRIG_ITRIGGER,
+	RISCV_DBTR_TRIG_ETRIGGER,
+	RISCV_DBTR_TRIG_MCONTROL6,
+};
+
+union riscv_dbtr_tdata1 {
+	unsigned long value;
+	struct {
+#if __riscv_xlen == 64
+		unsigned long data:59;
+#elif __riscv_xlen == 32
+		unsigned long data:27;
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+		unsigned long dmode:1;
+		unsigned long type:4;
+	};
+};
+
+union riscv_dbtr_tdata1_mcontrol6 {
+	unsigned long value;
+	struct {
+		unsigned long load:1;
+		unsigned long store:1;
+		unsigned long execute:1;
+		unsigned long u:1;
+		unsigned long s:1;
+		unsigned long _res2:1;
+		unsigned long m:1;
+		unsigned long match:4;
+		unsigned long chain:1;
+		unsigned long action:4;
+		unsigned long size:4;
+		unsigned long timing:1;
+		unsigned long select:1;
+		unsigned long hit:1;
+		unsigned long vu:1;
+		unsigned long vs:1;
+#if __riscv_xlen == 64
+		unsigned long _res1:34;
+#elif __riscv_xlen == 32
+		unsigned long _res1:2;
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+		unsigned long dmode:1;
+		unsigned long type:4;
+	};
+};
+
+struct arch_hw_breakpoint {
+	unsigned long address;
+	unsigned long len;
+	unsigned int type;
+
+	union riscv_dbtr_tdata1_mcontrol6 trig_data1;
+	unsigned long trig_data2;
+	unsigned long trig_data3;
+};
+
+/* Max supported HW breakpoints */
+#define HBP_NUM_MAX 32
+
+struct perf_event_attr;
+struct notifier_block;
+struct perf_event;
+struct pt_regs;
+
+int hw_breakpoint_slots(int type);
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw);
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data);
+
+void arch_enable_hw_breakpoint(struct perf_event *bp);
+void arch_update_hw_breakpoint(struct perf_event *bp);
+void arch_disable_hw_breakpoint(struct perf_event *bp);
+int arch_install_hw_breakpoint(struct perf_event *bp);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void hw_breakpoint_pmu_read(struct perf_event *bp);
+void clear_ptrace_hw_breakpoint(struct task_struct *tsk);
+
+#else
+
+int hw_breakpoint_slots(int type)
+{
+	return 0;
+}
+
+static inline void clear_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+}
+
+void arch_enable_hw_breakpoint(struct perf_event *bp)
+{
+}
+
+void arch_update_hw_breakpoint(struct perf_event *bp)
+{
+}
+
+void arch_disable_hw_breakpoint(struct perf_event *bp)
+{
+}
+
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+#endif /* __RISCV_HW_BREAKPOINT_H */
diff --git a/arch/riscv/include/asm/kdebug.h b/arch/riscv/include/asm/kdebug.h
index 85ac00411f6e..53e989781aa1 100644
--- a/arch/riscv/include/asm/kdebug.h
+++ b/arch/riscv/include/asm/kdebug.h
@@ -6,7 +6,8 @@
 enum die_val {
 	DIE_UNUSED,
 	DIE_TRAP,
-	DIE_OOPS
+	DIE_OOPS,
+	DIE_DEBUG
 };
 
 #endif
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 94a0590c6971..10c87fba2548 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -11,6 +11,7 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/hw_breakpoint.h>
 
 /*
  * This decides where the kernel will search for a free chunk of vm
@@ -29,6 +30,7 @@
 #ifndef __ASSEMBLY__
 
 struct task_struct;
+struct perf_event;
 struct pt_regs;
 
 /* CPU-specific state of a task */
@@ -39,6 +41,9 @@ struct thread_struct {
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	struct perf_event *ptrace_bps[HBP_NUM_MAX];
+#endif
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 2a0ef738695e..f7f5ef51c350 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -31,6 +31,9 @@ enum sbi_ext_id {
 	SBI_EXT_SRST = 0x53525354,
 	SBI_EXT_PMU = 0x504D55,
 
+	/* Experimental: Debug Trigger Extension */
+	SBI_EXT_DBTR = 0x44425452,
+
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
 	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
@@ -113,6 +116,27 @@ enum sbi_srst_reset_reason {
 	SBI_SRST_RESET_REASON_SYS_FAILURE,
 };
 
+enum sbi_ext_dbtr_fid {
+	SBI_EXT_DBTR_NUM_TRIGGERS = 0,
+	SBI_EXT_DBTR_TRIGGER_READ,
+	SBI_EXT_DBTR_TRIGGER_INSTALL,
+	SBI_EXT_DBTR_TRIGGER_UNINSTALL,
+	SBI_EXT_DBTR_TRIGGER_ENABLE,
+	SBI_EXT_DBTR_TRIGGER_UPDATE,
+	SBI_EXT_DBTR_TRIGGER_DISABLE,
+};
+
+struct sbi_dbtr_data_msg {
+	unsigned long tstate;
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+} __packed;
+
+struct sbi_dbtr_id_msg {
+	unsigned long idx;
+} __packed;
+
 enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_NUM_COUNTERS = 0,
 	SBI_EXT_PMU_COUNTER_GET_INFO,
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index db6e4b1294ba..116697d0ca1d 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_TRACE_IRQFLAGS)	+= trace_irq.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP) += cpu_ops_sbi.o
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
new file mode 100644
index 000000000000..32b7ca9ca694
--- /dev/null
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/percpu.h>
+#include <linux/kdebug.h>
+
+#include <asm/sbi.h>
+
+#define SBI_MSG_SZ_ALIGN(x) __roundup_pow_of_two(max_t(size_t, (x), SZ_16))
+
+/* bps/wps currently set on each debug trigger for each cpu */
+static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM_MAX]);
+
+/* number of debug triggers on this cpu . */
+static int dbtr_total_num __ro_after_init;
+
+int hw_breakpoint_slots(int type)
+{
+	union riscv_dbtr_tdata1 tdata1;
+	struct sbiret ret;
+
+	/*
+	 * We can be called early, so don't rely on
+	 * our static variables being initialised.
+	 */
+
+	tdata1.value = 0;
+	tdata1.type = RISCV_DBTR_TRIG_MCONTROL6;
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			tdata1.value, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to get hbp slots\n", __func__);
+		return 0;
+	}
+
+	return ret.value;
+}
+
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
+{
+	unsigned int len;
+	unsigned long va;
+
+	va = hw->address;
+	len = hw->len;
+
+	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
+}
+
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
+{
+	/* address */
+	hw->address = attr->bp_addr;
+	hw->trig_data2 = attr->bp_addr;
+	hw->trig_data3 = 0x0;
+
+	/* type */
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_X:
+		hw->type = RISCV_DBTR_BREAKPOINT;
+		hw->trig_data1.execute = 1;
+		break;
+	case HW_BREAKPOINT_R:
+		hw->type = RISCV_DBTR_WATCHPOINT;
+		hw->trig_data1.load = 1;
+		break;
+	case HW_BREAKPOINT_W:
+		hw->type = RISCV_DBTR_WATCHPOINT;
+		hw->trig_data1.store = 1;
+		break;
+	case HW_BREAKPOINT_RW:
+		hw->type = RISCV_DBTR_WATCHPOINT;
+		hw->trig_data1.store = 1;
+		hw->trig_data1.load = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* length */
+	switch (attr->bp_len) {
+	case HW_BREAKPOINT_LEN_1:
+		hw->len = 1;
+		hw->trig_data1.size = 1;
+		break;
+	case HW_BREAKPOINT_LEN_2:
+		hw->len = 2;
+		hw->trig_data1.size = 2;
+		break;
+	case HW_BREAKPOINT_LEN_4:
+		hw->len = 4;
+		hw->trig_data1.size = 3;
+		break;
+	case HW_BREAKPOINT_LEN_8:
+		hw->len = 8;
+		hw->trig_data1.size = 5;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	hw->trig_data1.type = RISCV_DBTR_TRIG_MCONTROL6;
+	hw->trig_data1.dmode = 0;
+	hw->trig_data1.select = 0;
+	hw->trig_data1.action = 0;
+	hw->trig_data1.chain = 0;
+	hw->trig_data1.match = 0;
+
+	hw->trig_data1.m = 0;
+	hw->trig_data1.s = 1;
+	hw->trig_data1.u = 1;
+	hw->trig_data1.vs = 0;
+	hw->trig_data1.vu = 0;
+
+	return 0;
+}
+
+/*
+ * Handle debug exception notifications.
+ */
+static int hw_breakpoint_handler(struct die_args *args)
+{
+	int ret = NOTIFY_DONE;
+	struct arch_hw_breakpoint *info;
+	struct perf_event *bp;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; ++i) {
+		bp = this_cpu_read(bp_per_reg[i]);
+		if (!bp)
+			continue;
+
+		info = counter_arch_bp(bp);
+		switch (info->type) {
+		case RISCV_DBTR_BREAKPOINT:
+			if (info->address == args->regs->epc) {
+				pr_debug("%s: breakpoint fired: pc[0x%lx]\n",
+					 __func__, args->regs->epc);
+				perf_bp_event(bp, args->regs);
+				ret = NOTIFY_STOP;
+			}
+
+			break;
+		case RISCV_DBTR_WATCHPOINT:
+			if (info->address == csr_read(CSR_STVAL)) {
+				pr_debug("%s: watchpoint fired: addr[0x%lx]\n",
+					 __func__, info->address);
+				perf_bp_event(bp, args->regs);
+				ret = NOTIFY_STOP;
+			}
+
+			break;
+		default:
+			pr_warn("%s: unexpected breakpoint type: %u\n",
+				__func__, info->type);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data)
+{
+	if (val != DIE_DEBUG)
+		return NOTIFY_DONE;
+
+	return hw_breakpoint_handler(data);
+}
+
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct sbi_dbtr_data_msg *xmit;
+	struct sbi_dbtr_id_msg *recv;
+	struct perf_event **slot;
+	struct sbiret ret;
+	int err = 0;
+
+	xmit = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*xmit)), GFP_ATOMIC);
+	if (!xmit) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	recv = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*recv)), GFP_ATOMIC);
+	if (!recv) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	xmit->tdata1 = info->trig_data1.value;
+	xmit->tdata2 = info->trig_data2;
+	xmit->tdata3 = info->trig_data3;
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_INSTALL,
+			1, __pa(xmit) >> 4, __pa(recv) >> 4,
+			0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to install trigger\n", __func__);
+		err = -EIO;
+		goto out;
+	}
+
+	if (recv->idx >= dbtr_total_num) {
+		pr_warn("%s: invalid trigger index %lu\n", __func__, recv->idx);
+		err = -EINVAL;
+		goto out;
+	}
+
+	slot = this_cpu_ptr(&bp_per_reg[recv->idx]);
+	if (*slot) {
+		pr_warn("%s: slot %lu is in use\n", __func__, recv->idx);
+		err = -EBUSY;
+		goto out;
+	}
+
+	*slot = bp;
+
+out:
+	kfree(xmit);
+	kfree(recv);
+
+	return err;
+}
+
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+
+		if (*slot == bp) {
+			*slot = NULL;
+			break;
+		}
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: unknown breakpoint\n", __func__);
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_UNINSTALL,
+			i, 1, 0, 0, 0, 0);
+	if (ret.error)
+		pr_warn("%s: failed to uninstall trigger %d\n", __func__, i);
+}
+
+void arch_enable_hw_breakpoint(struct perf_event *bp)
+{
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+
+		if (*slot == bp)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: unknown breakpoint\n", __func__);
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_ENABLE,
+			i, 1, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to install trigger %d\n", __func__, i);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(arch_enable_hw_breakpoint);
+
+void arch_update_hw_breakpoint(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct sbi_dbtr_data_msg *xmit;
+	struct perf_event **slot;
+	struct sbiret ret;
+	int i;
+
+	xmit = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*xmit)), GFP_ATOMIC);
+	if (!xmit)
+		return;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		slot = this_cpu_ptr(&bp_per_reg[i]);
+
+		if (*slot == bp)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: unknown breakpoint\n", __func__);
+		goto out;
+	}
+
+	xmit->tdata1 = info->trig_data1.value;
+	xmit->tdata2 = info->trig_data2;
+	xmit->tdata3 = info->trig_data3;
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_UPDATE,
+			i, 1, __pa(xmit) >> 4,
+			0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to update trigger %d\n", __func__, i);
+		goto out;
+	}
+
+out:
+	kfree(xmit);
+}
+EXPORT_SYMBOL_GPL(arch_update_hw_breakpoint);
+
+void arch_disable_hw_breakpoint(struct perf_event *bp)
+{
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+
+		if (*slot == bp)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: unknown breakpoint\n", __func__);
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_DISABLE,
+			i, 1, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to uninstall trigger %d\n", __func__, i);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(arch_disable_hw_breakpoint);
+
+void hw_breakpoint_pmu_read(struct perf_event *bp)
+{
+}
+
+/*
+ * Set ptrace breakpoint pointers to zero for this task.
+ * This is required in order to prevent child processes from unregistering
+ * breakpoints held by their parent.
+ */
+void clear_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	memset(tsk->thread.ptrace_bps, 0, sizeof(tsk->thread.ptrace_bps));
+}
+
+/*
+ * Unregister breakpoints from this task and reset the pointers in
+ * the thread_struct.
+ */
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	int i;
+	struct thread_struct *t = &tsk->thread;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		unregister_hw_breakpoint(t->ptrace_bps[i]);
+		t->ptrace_bps[i] = NULL;
+	}
+}
+
+static int __init arch_hw_breakpoint_init(void)
+{
+	union riscv_dbtr_tdata1 tdata1;
+	struct sbiret ret;
+
+	if (sbi_probe_extension(SBI_EXT_DBTR) <= 0) {
+		pr_info("%s: SBI_EXT_DBTR is not supported\n", __func__);
+		return 0;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to detect triggers\n", __func__);
+		return 0;
+	}
+
+	pr_info("%s: total number of triggers: %lu\n", __func__, ret.value);
+
+	tdata1.value = 0;
+	tdata1.type = RISCV_DBTR_TRIG_MCONTROL6;
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			tdata1.value, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to detect triggers\n", __func__);
+		dbtr_total_num = 0;
+		return 0;
+	}
+
+	pr_info("%s: total number of type %d triggers: %lu\n",
+		__func__, tdata1.type, ret.value);
+
+	dbtr_total_num = ret.value;
+
+	return 0;
+}
+arch_initcall(arch_hw_breakpoint_init);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index b0c63e8e867e..da379f6af3f3 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -185,5 +185,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		p->thread.ra = (unsigned long)ret_from_fork;
 	}
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
+	clear_ptrace_hw_breakpoint(p);
 	return 0;
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f3e96d60a2ff..97712c52348e 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -174,6 +174,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 
 	if (uprobe_breakpoint_handler(regs))
 		return;
+#endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (notify_die(DIE_DEBUG, "EBREAK", regs, 0, regs->cause, SIGTRAP)
+						       == NOTIFY_STOP)
+		return;
 #endif
 	current->thread.bad_cause = regs->cause;
 
-- 
2.38.1

