Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9590C675690
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjATOLs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjATOLn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:11:43 -0500
Received: from fx405.security-mail.net (smtpout140.security-mail.net [85.31.212.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF78C4EBA
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:10:46 -0800 (PST)
Received: from localhost (fx405.security-mail.net [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id A2D47335E74
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:10:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674223833;
        bh=DkGjeJobKP1K/Idr8J6s3hrFSj+9CDHdOSWYtT+PQEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EA6X8RQHXq/W1BC7yIhoLzC7INk51IG9nlnP7Ce+JsEMdrlL9d36Qt3IwyX2AUHRf
         5nryYtNQP5GNypPJ0M89jMaF5OciOC4jsnHeAxWmw+M5quvMmaYpFOlz60qD+uA9lD
         6Kq2q1QB272m/Cl5XNhNFhycMmtfzXziIvXUdCK8=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 82D7D335CDD; Fri, 20 Jan
 2023 15:10:32 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx405.security-mail.net (Postfix) with ESMTPS id 0886E335CD8; Fri, 20 Jan
 2023 15:10:31 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id BF2A327E043E; Fri, 20 Jan 2023
 15:10:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id A0E8B27E043D; Fri, 20 Jan 2023 15:10:30 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 u2XWgG7WnkmB; Fri, 20 Jan 2023 15:10:30 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 20C9827E0439; Fri, 20 Jan 2023
 15:10:30 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <12bde.63caa0d7.5004.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu A0E8B27E043D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223830;
 bh=IOewO9S6DyRnSEgyDrfMjSJtY+brX2hbFJUBrk4tQOs=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=CMFBrBJsjLdbhmW5V7Q8LXfzWHjdqw/BBxCI1U8gKNKG3ZfPzHIQcvopNQVNkZ8MM
 Qe4QoaxpZ/t67pd61igfUkSK3LKI1kxUOPvzZfLdy3KLO+QC3Wx4SS80rnNl59Dc43
 2JzfEGzoLynfwNusHMBy6K9yMGsBsth1wy4XyWeI=
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
Subject: [RFC PATCH v2 13/31] kvx: Add boot and setup routines
Date:   Fri, 20 Jan 2023 15:09:44 +0100
Message-ID: <20230120141002.2442-14-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add basic boot, setup and reset routines for kvx.

Co-developed-by: Alex Michon <amichon@kalray.eu>
Signed-off-by: Alex Michon <amichon@kalray.eu>
Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Missonnier <gmissonnier@kalray.eu>
Signed-off-by: Guillaume Missonnier <gmissonnier@kalray.eu>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Julien Hascoet <jhascoet@kalray.eu>
Signed-off-by: Julien Hascoet <jhascoet@kalray.eu>
Co-developed-by: Julien Villette <jvillette@kalray.eu>
Signed-off-by: Julien Villette <jvillette@kalray.eu>
Co-developed-by: Marc Poulhiès <dkm@kataplop.net>
Signed-off-by: Marc Poulhiès <dkm@kataplop.net>
Co-developed-by: Luc Michel <lmichel@kalray.eu>
Signed-off-by: Luc Michel <lmichel@kalray.eu>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: removed L2 cache firmware starting code

 arch/kvx/include/asm/setup.h |  29 ++
 arch/kvx/kernel/common.c     |  11 +
 arch/kvx/kernel/head.S       | 568 +++++++++++++++++++++++++++++++++++
 arch/kvx/kernel/prom.c       |  24 ++
 arch/kvx/kernel/reset.c      |  37 +++
 arch/kvx/kernel/setup.c      | 177 +++++++++++
 arch/kvx/kernel/time.c       | 242 +++++++++++++++
 7 files changed, 1088 insertions(+)
 create mode 100644 arch/kvx/include/asm/setup.h
 create mode 100644 arch/kvx/kernel/common.c
 create mode 100644 arch/kvx/kernel/head.S
 create mode 100644 arch/kvx/kernel/prom.c
 create mode 100644 arch/kvx/kernel/reset.c
 create mode 100644 arch/kvx/kernel/setup.c
 create mode 100644 arch/kvx/kernel/time.c

diff --git a/arch/kvx/include/asm/setup.h b/arch/kvx/include/asm/setup.h
new file mode 100644
index 000000000000..9c27d5981442
--- /dev/null
+++ b/arch/kvx/include/asm/setup.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SETUP_H
+#define _ASM_KVX_SETUP_H
+
+#include <linux/const.h>
+
+#include <asm-generic/setup.h>
+
+/* Magic is found in r0 when some parameters are given to kernel */
+#define LINUX_BOOT_PARAM_MAGIC	ULL(0x31564752414E494C)
+
+#ifndef __ASSEMBLY__
+
+void early_fixmap_init(void);
+
+void setup_device_tree(void);
+
+void setup_arch_memory(void);
+
+void kvx_init_mmu(void);
+
+#endif
+
+#endif	/* _ASM_KVX_SETUP_H */
diff --git a/arch/kvx/kernel/common.c b/arch/kvx/kernel/common.c
new file mode 100644
index 000000000000..322498f034fd
--- /dev/null
+++ b/arch/kvx/kernel/common.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/percpu-defs.h>
+#include <linux/sched/task.h>
+
+DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
+EXPORT_PER_CPU_SYMBOL(__preempt_count);
diff --git a/arch/kvx/kernel/head.S b/arch/kvx/kernel/head.S
new file mode 100644
index 000000000000..6badd2f6a2a6
--- /dev/null
+++ b/arch/kvx/kernel/head.S
@@ -0,0 +1,568 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ *            Julian Vetter
+ *            Julien Hascoet
+ *            Yann Sionneau
+ *            Marc Poulhiès
+ */
+#include <asm/thread_info.h>
+#include <asm/page_size.h>
+#include <asm/pwr_ctrl.h>
+#include <asm/sfr_defs.h>
+#include <asm/sys_arch.h>
+#include <asm/privilege.h>
+#include <asm/tlb_defs.h>
+#include <asm/mem_map.h>
+#include <asm/rm_fw.h>
+#include <asm/setup.h>
+#include <asm/page.h>
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+#ifdef CONFIG_SMP
+#define SECONDARY_START_ADDR	smp_secondary_start
+#else
+#define SECONDARY_START_ADDR	proc_power_off
+#endif
+
+#define PS_VAL_WFXL(__field, __val) \
+	SFR_SET_VAL_WFXL(PS, __field, __val)
+
+#define PS_WFXL_VALUE	PS_VAL_WFXL(HLE, 1) | \
+			PS_VAL_WFXL(USE, 1) | \
+			PS_VAL_WFXL(DCE, 1) | \
+			PS_VAL_WFXL(ICE, 1) | \
+			PS_VAL_WFXL(MME, 1) | \
+			PS_VAL_WFXL(MMUP, 1) | \
+			PS_VAL_WFXL(ET, 0) | \
+			PS_VAL_WFXL(HTD, 0) | \
+			PS_VAL_WFXL(PMJ, KVX_SUPPORTED_PSIZE)
+
+#define PCR_VAL_WFXM(__field, __val) \
+	SFR_SET_VAL_WFXM(PCR, __field, __val)
+
+#define PCR_WFXM_VALUE	PCR_VAL_WFXM(L1CE, 1)
+
+/* 30 sec for primary watchdog timeout */
+#define PRIMARY_WATCHDOG_VALUE (30000000000UL)
+
+#define TCR_WFXL_VALUE SFR_SET_VAL_WFXL(TCR, WUI, 1) | \
+	SFR_SET_VAL_WFXL(TCR, WCE, 1)
+
+/* Enable STOP in WS */
+#define WS_ENABLE_WU2		(KVX_SFR_WS_WU2_MASK)
+/* We only want to clear bits in ws */
+#define WS_WFXL_VALUE		(WS_ENABLE_WU2)
+
+/* SMP stuff */
+#define RM_PID_MASK		((KVX_RM_ID) << KVX_SFR_PCR_PID_SHIFT)
+
+#define PWR_CTRL_ADDR 0xA40000
+
+#define PWR_CTRL_GLOBAL_CONFIG_VALUE \
+	(1 << KVX_PWR_CTRL_GLOBAL_SET_PE_EN_SHIFT)
+
+/* Clean error and selected buffer */
+#define MMC_CLEAR_ERROR (KVX_SFR_MMC_E_MASK)
+
+#define TEH_VIRTUAL_MEMORY \
+	TLB_MK_TEH_ENTRY(PAGE_OFFSET, 0, TLB_G_GLOBAL, 0)
+
+#define TEL_VIRTUAL_MEMORY \
+	TLB_MK_TEL_ENTRY(PHYS_OFFSET, TLB_PS_512M, TLB_ES_A_MODIFIED,\
+	TLB_CP_W_C, TLB_PA_NA_RWX)
+
+/* (TEH|TEL)_SHARED_MEMORY are mapping 0x0 to 0x0 */
+#define TEH_SHARED_MEMORY \
+	TLB_MK_TEH_ENTRY(0, 0, TLB_G_GLOBAL, 0)
+
+#define TEL_SHARED_MEMORY \
+	TLB_MK_TEL_ENTRY(0, TLB_PS_2M, TLB_ES_A_MODIFIED,\
+	TLB_CP_W_C, TLB_PA_NA_RWX)
+
+#define TEH_GDB_PAGE_MEMORY \
+	TLB_MK_TEH_ENTRY(0, 0, TLB_G_GLOBAL, 0)
+
+#define TEL_GDB_PAGE_MEMORY \
+	TLB_MK_TEL_ENTRY(0, TLB_PS_4K, TLB_ES_A_MODIFIED,\
+	TLB_CP_U_U, TLB_PA_RWX_RWX)
+
+/**
+ * Macros
+ */
+.altmacro
+
+/* To select the JTLB we clear SB from MMC */
+.macro select_jtlb scratch_reg
+	make \scratch_reg, KVX_SFR_MMC_SB_MASK
+	;;
+	wfxl $mmc, \scratch_reg
+.endm
+
+/* To select the LTLB we set SB from MMC */
+.macro select_ltlb scratch_reg
+	make \scratch_reg, KVX_SFR_MMC_SB_MASK << 32
+	;;
+	wfxl $mmc, \scratch_reg
+.endm
+
+/* Set SW of the MMC with number found in the reg register */
+.macro select_way_from_register reg scratch1 scratch2
+	slld \scratch1 = \reg, KVX_SFR_MMC_SW_SHIFT
+	make \scratch2 = KVX_SFR_MMC_SW_MASK
+	;;
+	slld \scratch1 = \scratch1, 32
+	;;
+	ord \scratch1 = \scratch1, \scratch2
+	;;
+	wfxl $mmc = \scratch1
+.endm
+
+/* Set SW of the MMC with the immediate */
+.macro select_way_from_immediate imm scratch1 scratch2
+	make \scratch1 = (\imm << KVX_SFR_MMC_SW_SHIFT) << 32
+	make \scratch2 = KVX_SFR_MMC_SW_MASK
+	;;
+	ord \scratch1 = \scratch1, \scratch2
+	;;
+	wfxl $mmc = \scratch1
+.endm
+
+/* write tlb after setting teh and tel registers */
+.macro write_tlb_entry teh tel
+	set $teh = \teh
+	;;
+	set $tel = \tel
+	;;
+	tlbwrite
+.endm
+
+/* Boot args */
+#define BOOT_ARGS_COUNT	2
+.align 16
+.section .boot.data, "aw", @progbits
+rm_boot_args:
+.skip BOOT_ARGS_COUNT * 8
+
+/*
+ * This is our entry point. When entering from bootloader,
+ * the following registers are set:
+ * $r0 is a magic (LINUX_BOOT_PARAM_MAGIC)
+ * $r1 device tree pointer
+ *
+ * WARNING WARNING WARNING
+ * ! DO NOT CLOBBER THEM !
+ * WARNING WARNING WARNING
+ *
+ * Try to use register above $r20 to ease parameter adding in future
+ */
+
+__HEAD
+
+.align 8
+.section .boot.startup, "ax", @progbits
+
+ENTRY(kvx_start)
+	/* Setup 64 bit really early to avoid bugs */
+	make $r21 = PS_VAL_WFXL(V64, 1)
+	;;
+	wfxl $ps = $r21
+	;;
+	call asm_init_pl
+	;;
+	get $r20 = $pcr
+	;;
+	andd $r21 = $r20, RM_PID_MASK
+	;;
+	cb.dnez $r21 ? asm_rm_cfg_pwr_ctrl
+	;;
+init_core:
+	/**
+	 * Setup watchdog early to catch potential
+	 * crash before watchdog driver probe
+	 */
+	make $r25 = PRIMARY_WATCHDOG_VALUE
+	make $r26 = TCR_WFXL_VALUE
+	;;
+	set $wdv = $r25
+	;;
+	wfxl $tcr, $r26
+	;;
+	call asm_init_mmu
+	;;
+	/* Setup default processor status */
+	make $r25 = PS_WFXL_VALUE
+	make $r26 = PCR_WFXM_VALUE
+	;;
+	/**
+	 * There is nothing much we can do if we take a early trap since the
+	 * kernel is not yet ready to handle them.
+	 * Register this as the early exception handler to at least avoid
+	 * going in a black hole.
+	 */
+	make $r27 = __early_exception_start
+	;;
+	set $ev = $r27
+	;;
+	wfxm $pcr = $r26
+	;;
+	wfxl $ps = $r25
+	;;
+	/* Use as break point for debugging purpose.
+	   See Documentation/kvx/kvx.txt for more details. */
+gdb_mmu_enabled:
+	/* Extract processor identifier */
+	get $r24 = $pcr
+	;;
+	extfz $r24 = $r24, KVX_SFR_END(PCR_PID), KVX_SFR_START(PCR_PID)
+	;;
+	/* If proc 0, then go to clear bss and do normal boot */
+	cb.deqz $r24? clear_bss
+	make $r25 = SECONDARY_START_ADDR
+	;;
+	icall $r25
+	;;
+clear_bss:
+	/* Copy bootloader arguments before cloberring them */
+	copyd $r20 = $r0
+	copyd $r21 = $r1
+	;;
+	/* Clear BSS */
+	make $r0 = __bss_start
+	make $r1 = __bss_stop
+	call asm_memzero
+	;;
+	/* Setup stack */
+	make $r40 = init_thread_union
+	make $r41 = init_task
+	;;
+	set $sr = $r41
+	copyd $r0 = $r20
+	copyd $r1 = $r21
+	;;
+	addd $sp = $r40, THREAD_SIZE
+	/* Clear frame pointer */
+	make $fp = 0x0
+	/* Setup the exception handler */
+	make $r27 = __exception_start
+	;;
+	set $ev = $r27
+	/* Here we go ! start the C stuff */
+	make $r20 = arch_low_level_start
+	;;
+	icall $r20
+	;;
+	make $r20 = proc_power_off
+	;;
+	igoto $r20
+	;;
+ENDPROC(kvx_start)
+
+/**
+ * When PE 0 is started from the RM, arguments from the bootloaders are copied
+ * into rm_boot_args. It allows to give parameters from RM to PE.
+ * Note that the 4K alignment is required by the reset pc register...
+ */
+.align (4 * 1024)
+ENTRY(pe_start_wrapper)
+	make $r0 = rm_boot_args
+	make $r27 = PWR_CTRL_ADDR
+	make $r28 = kvx_start
+	;;
+	lq $r0r1 = 0[$r0]
+	;;
+	/* Set reset PC back to original value for SMP start */
+	sd KVX_PWR_CTRL_RESET_PC_OFFSET[$r27] = $r28
+	;;
+	fence
+	goto kvx_start
+	;;
+ENDPROC(pe_start_wrapper)
+
+/**
+ * asm_memzero - Clear a memory zone with zeroes
+ * $r0 is the start of memory zone (must be align on 32 bytes boundary)
+ * $r1 is the end of memory zone (must be align on 32 bytes boundary)
+ */
+ENTRY(asm_memzero)
+	sbfd $r32 = $r0, $r1
+	make $r36 = 0
+	make $r37 = 0
+	;;
+	make $r38 = 0
+	make $r39 = 0
+	/* Divide by 32 for hardware loop */
+	srld $r32, $r32, 5
+	;;
+	/* Clear memory with hardware loop */
+	loopdo $r32, clear_mem_done
+		;;
+		so 0[$r0] = $r36r37r38r39
+		addd $r0 = $r0, 32
+		;;
+	clear_mem_done:
+	ret
+	;;
+ENDPROC(asm_memzero)
+
+/**
+ * Configure the power controller to be accessible by PEs
+ */
+ENTRY(asm_rm_cfg_pwr_ctrl)
+	/* Enable hwloop for memzero */
+	make $r32 = PS_VAL_WFXL(HLE, 1)
+	;;
+	wfxl $ps = $r32
+	;;
+	make $r26 = PWR_CTRL_ADDR
+	make $r27 = PWR_CTRL_GLOBAL_CONFIG_VALUE
+	;;
+	/* Set PE enable in power controller */
+	sd PWR_CTRL_GLOBAL_CONFIG_OFFSET[$r26] = $r27
+	make $r28 = rm_boot_args
+	;;
+	/* Store parameters for PE0 */
+	sq 0[$r28] = $r0r1
+	make $r29 = pe_start_wrapper
+	;;
+	/* Set PE reset PC to arguments wrapper */
+	sd KVX_PWR_CTRL_RESET_PC_OFFSET[$r26] = $r29
+	;;
+	/* Fence to make sure parameters will be visible by PE 0 */
+	fence
+	;;
+	/* Start PE 0 (1 << cpu) */
+	make $r27 = 1
+	make $r26 = PWR_CTRL_ADDR
+	;;
+	/* Wake up PE0 */
+	sd PWR_CTRL_WUP_SET_OFFSET[$r26] = $r27
+	;;
+	/* And clear wakeup to allow PE0 to sleep */
+	sd PWR_CTRL_WUP_CLEAR_OFFSET[$r26] = $r27
+	;;
+	make $r20 = proc_power_off
+	;;
+	igoto $r20
+	;;
+ENDPROC(asm_rm_cfg_pwr_ctrl)
+
+#define request_ownership(__pl) ;\
+	make $r21 = SYO_WFXL_VALUE_##__pl ;\
+	;; ;\
+	wfxl $syow = $r21 ;\
+	;; ;\
+	make $r21 = HTO_WFXL_VALUE_##__pl ;\
+	;; ;\
+	wfxl $htow = $r21 ;\
+	;; ;\
+	make $r21 = MO_WFXL_VALUE_##__pl ;\
+	make $r22 = MO_WFXM_VALUE_##__pl ;\
+	;; ;\
+	wfxl $mow = $r21 ;\
+	;; ;\
+	wfxm $mow = $r22 ;\
+	;; ;\
+	make $r21 = ITO_WFXL_VALUE_##__pl ;\
+	make $r22 = ITO_WFXM_VALUE_##__pl ;\
+	;; ;\
+	wfxl $itow = $r21 ;\
+	;; ;\
+	wfxm $itow = $r22 ;\
+	;; ;\
+	make $r21 = PSO_WFXL_VALUE_##__pl ;\
+	make $r22 = PSO_WFXM_VALUE_##__pl ;\
+	;; ;\
+	wfxl $psow = $r21 ;\
+	;; ;\
+	wfxm $psow = $r22 ;\
+	;; ;\
+	make $r21 = DO_WFXL_VALUE_##__pl ;\
+	;; ;\
+	wfxl $dow = $r21 ;\
+	;;
+
+/**
+ * Initialize privilege level for Kernel
+ */
+ENTRY(asm_init_pl)
+	get $r21 = $ps
+	;;
+	/* Extract privilege level from $ps to check if we need to
+	 * lower our privilege level
+	 */
+	extfz $r20 = $r21, KVX_SFR_END(PS_PL), KVX_SFR_START(PS_PL)
+	;;
+	/* If our privilege level is 0, then we need to lower in execution level
+	 * to ring 1 in order to let the debug routines be inserted at runtime
+	 * by the JTAG. In both case, we will request the resources we need for
+	 * linux to run.
+	 */
+	cb.deqz $r20? delegate_pl
+	;;
+	/*
+	 * When someone is already above us, request the resources we need to
+	 * run the kernel. No need to request double exception or ECC traps for
+	 * instance. When doing so, the more privileged level will trap for
+	 * permission and delegate us the required resources.
+	 */
+	request_ownership(PL_CUR)
+	;;
+	ret
+	;;
+delegate_pl:
+	request_ownership(PL_CUR_PLUS_1)
+	;;
+	/* Copy our $ps into $sps for 1:1 restoration */
+	get $r22 = $ps
+	;;
+	/* We will return to $ra after rfe */
+	get $r21 = $ra
+	/* Set privilege level to +1 is $sps */
+	addd $r22 = $r22, PL_CUR_PLUS_1
+	;;
+	set $spc = $r21
+	;;
+	set $sps = $r22
+	;;
+	rfe
+	;;
+ENDPROC(asm_init_pl)
+
+/**
+ * Reset and initialize minimal tlb entries
+ */
+ENTRY(asm_init_mmu)
+	make $r20 = MMC_CLEAR_ERROR
+	;;
+	wfxl $mmc = $r20
+	;;
+	/* Reset the JTLB */
+	select_jtlb $r20
+	;;
+	make $r20 = (MMU_JTLB_SETS - 1) /* Used to select the set */
+	make $r21 = 0  /* Used for shifting and as scratch register */
+	;;
+	set $tel = $r21	 /* tel is always equal to 0 */
+	;;
+	clear_jtlb:
+		slld $r21 = $r20, KVX_SFR_TEH_PN_SHIFT
+		addd $r20 = $r20, -1
+		;;
+		set $teh = $r21
+		;;
+		make $r22 = (MMU_JTLB_WAYS - 1) /* Used to select the way */
+		;;
+		loop_jtlb_way:
+			select_way_from_register $r22 $r23 $r24
+			;;
+			tlbwrite
+			;;
+			addd $r22 = $r22, -1
+			;;
+			cb.dgez $r22? loop_jtlb_way
+			;;
+		/* loop_jtlb_way done */
+		cb.dgez $r20? clear_jtlb
+		;;
+	clear_jtlb_done:
+	/* Reset the LTLB */
+	select_ltlb $r20
+	;;
+	clear_ltlb:
+		/* There is only one set that is 0 so we can reuse the same
+		   values for TEH and TEL. */
+		make $r20 = (MMU_LTLB_WAYS - 1)
+		;;
+		loop_ltlb_way:
+			select_way_from_register $r20, $r21, $r22
+			;;
+			tlbwrite
+			;;
+			addd $r20 = $r20, -1
+			;;
+			cb.dgez $r20? loop_ltlb_way
+			;;
+	clear_ltlb_done:
+
+	/* See Documentation/kvx/kvx.txt for details about the settings of
+	   the LTLB */
+	select_way_from_immediate LTLB_ENTRY_KERNEL_TEXT, $r20, $r21
+	;;
+	make $r20 = TEH_VIRTUAL_MEMORY
+	make $r21 = TEL_VIRTUAL_MEMORY
+	;;
+	write_tlb_entry $r20, $r21
+	;;
+	select_way_from_immediate LTLB_ENTRY_EARLY_SMEM, $r20, $r21
+	;;
+	make $r20 = TEH_SHARED_MEMORY
+	make $r21 = TEL_SHARED_MEMORY
+	;;
+	write_tlb_entry $r20, $r21
+	;;
+	select_way_from_immediate LTLB_ENTRY_GDB_PAGE, $r20, $r21
+	;;
+	make $r20 = _debug_start_lma
+	make $r21 = _debug_start
+	;;
+	andd $r20 = $r20, KVX_SFR_TEH_PN_MASK
+	andd $r21 = $r21, KVX_SFR_TEL_FN_MASK
+	;;
+	addd $r20 = $r20, TEH_GDB_PAGE_MEMORY
+	addd $r21 = $r21, TEL_GDB_PAGE_MEMORY
+	;;
+	write_tlb_entry $r20, $r21
+	;;
+	ret
+	;;
+ENDPROC(asm_init_mmu)
+
+/**
+ * Entry point for secondary processors
+ * $r24 has been set in caller and is the proc id
+ */
+ENTRY(smp_secondary_start)
+#ifdef CONFIG_SMP
+	dinval
+	;;
+	iinval
+	;;
+	barrier
+	;;
+	make $r25 = __cpu_up_task_pointer
+	make $r26 = __cpu_up_stack_pointer
+	;;
+	ld.xs $sp = $r24[$r26]
+	/* Clear frame pointer */
+	make $fp = 0x0
+	;;
+	ld.xs $r25 = $r24[$r25]
+	;;
+	set $sr = $r25
+	make $r27 = __exception_start
+	;;
+	set $ev = $r27
+	make $r26 = start_kernel_secondary
+	;;
+	icall $r26
+	;;
+#endif
+ENDPROC(smp_secondary_start)
+
+ENTRY(proc_power_off)
+	make $r1 = WS_WFXL_VALUE
+	;;
+	/* Enable STOP */
+	wfxl $ws, $r1
+	;;
+1:	stop
+	;;
+	goto 1b
+	;;
+ENDPROC(proc_power_off)
diff --git a/arch/kvx/kernel/prom.c b/arch/kvx/kernel/prom.c
new file mode 100644
index 000000000000..a5241aa66903
--- /dev/null
+++ b/arch/kvx/kernel/prom.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+
+void __init setup_device_tree(void)
+{
+	const char *name;
+
+	name = of_flat_dt_get_machine_name();
+	if (!name)
+		return;
+
+	pr_info("Machine model: %s\n", name);
+	dump_stack_set_arch_desc("%s (DT)", name);
+
+	unflatten_device_tree();
+}
diff --git a/arch/kvx/kernel/reset.c b/arch/kvx/kernel/reset.c
new file mode 100644
index 000000000000..afa0ceb9d7e9
--- /dev/null
+++ b/arch/kvx/kernel/reset.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/pm.h>
+#include <linux/reboot.h>
+
+#include <asm/processor.h>
+
+static void kvx_default_power_off(void)
+{
+	smp_send_stop();
+	local_cpu_stop();
+}
+
+void (*pm_power_off)(void) = kvx_default_power_off;
+EXPORT_SYMBOL(pm_power_off);
+
+void machine_restart(char *cmd)
+{
+	smp_send_stop();
+	do_kernel_restart(cmd);
+	pr_err("Reboot failed -- System halted\n");
+	local_cpu_stop();
+}
+
+void machine_halt(void)
+{
+	pm_power_off();
+}
+
+void machine_power_off(void)
+{
+	pm_power_off();
+}
diff --git a/arch/kvx/kernel/setup.c b/arch/kvx/kernel/setup.c
new file mode 100644
index 000000000000..e155341a37fd
--- /dev/null
+++ b/arch/kvx/kernel/setup.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/start_kernel.h>
+#include <linux/screen_info.h>
+#include <linux/console.h>
+#include <linux/linkage.h>
+#include <linux/export.h>
+#include <linux/of_fdt.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+
+#include <asm/processor.h>
+#include <asm/sections.h>
+#include <asm/hw_irq.h>
+#include <asm/setup.h>
+#include <asm/rm_fw.h>
+#include <asm/page.h>
+#include <asm/sfr.h>
+#include <asm/mmu.h>
+#include <asm/smp.h>
+
+struct screen_info screen_info;
+
+unsigned long memory_start;
+EXPORT_SYMBOL(memory_start);
+unsigned long memory_end;
+EXPORT_SYMBOL(memory_end);
+
+DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_kvx, cpu_info);
+EXPORT_PER_CPU_SYMBOL(cpu_info);
+
+static bool use_streaming = true;
+static int __init parse_kvx_streaming(char *arg)
+{
+	strtobool(arg, &use_streaming);
+
+	if (!use_streaming) {
+		pr_info("disabling streaming\n");
+		kvx_sfr_set_field(PS, USE, 0);
+	}
+
+	return 0;
+}
+early_param("kvx.streaming", parse_kvx_streaming);
+
+static void __init setup_user_privilege(void)
+{
+	/*
+	 * We want to let the user control various fields of ps:
+	 * - hardware loop
+	 * - instruction cache enable
+	 * - streaming enable
+	 */
+	uint64_t mask = KVX_SFR_PSOW_HLE_MASK |
+			KVX_SFR_PSOW_ICE_MASK |
+			KVX_SFR_PSOW_USE_MASK;
+
+	uint64_t value = (1 << KVX_SFR_PSOW_HLE_SHIFT) |
+			(1 << KVX_SFR_PSOW_ICE_SHIFT) |
+			(1 << KVX_SFR_PSOW_USE_SHIFT);
+
+	kvx_sfr_set_mask(PSOW, mask, value);
+}
+
+void __init setup_cpuinfo(void)
+{
+	struct cpuinfo_kvx *n = this_cpu_ptr(&cpu_info);
+	u64 pcr = kvx_sfr_get(PCR);
+
+	n->copro_enable = kvx_sfr_field_val(pcr, PCR, COE);
+	n->arch_rev = kvx_sfr_field_val(pcr, PCR, CAR);
+	n->uarch_rev = kvx_sfr_field_val(pcr, PCR, CMA);
+}
+
+/*
+ * Everything that needs to be setup PER cpu should be put here.
+ * This function will be called by per-cpu setup routine.
+ */
+void __init setup_processor(void)
+{
+	/* Clear performance monitor 0 */
+	kvx_sfr_set_field(PMC, PM0C, 0);
+
+#ifdef CONFIG_ENABLE_TCA
+	/* Enable TCA (COE = Coprocessor Enable) */
+	kvx_sfr_set_field(PCR, COE, 1);
+#else
+	kvx_sfr_set_field(PCR, COE, 0);
+#endif
+
+	/*
+	 * On kvx, we have speculative accesses which differ from normal
+	 * accesses by the fact their trapping policy is directed by mmc.sne
+	 * (speculative no-mapping enable) and mmc.spe (speculative protection
+	 * enabled).
+	 * To handle these accesses properly, we disable all traps on
+	 * speculative accesses while in kernel and user (sne & spe)
+	 * in order to silently discard data if fetched.
+	 * This allows to do an effective prefetch.
+	 */
+	kvx_sfr_set_field(MMC, SNE, 0);
+	kvx_sfr_set_field(MMC, SPE, 0);
+
+	if (!use_streaming)
+		kvx_sfr_set_field(PS, USE, 0);
+
+	kvx_init_core_irq();
+
+	setup_user_privilege();
+
+	setup_cpuinfo();
+}
+
+static char builtin_cmdline[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
+
+void __init setup_arch(char **cmdline_p)
+{
+	if (builtin_cmdline[0]) {
+		/* append boot loader cmdline to builtin */
+		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
+		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+	}
+
+	*cmdline_p = boot_command_line;
+
+	setup_processor();
+
+	/* Jump labels needs fixmap to be setup for text modifications */
+	early_fixmap_init();
+
+	/* Parameters might set static keys */
+	jump_label_init();
+	/*
+	 * Parse early param after setting up arch memory since
+	 * we need fixmap for earlycon and fixedmap need to do
+	 * memory allocation (fixed_range_init).
+	 */
+	parse_early_param();
+
+	setup_arch_memory();
+
+	paging_init();
+
+	setup_device_tree();
+
+	smp_init_cpus();
+
+#ifdef CONFIG_VT
+	conswitchp = &dummy_con;
+#endif
+}
+
+asmlinkage __visible void __init arch_low_level_start(unsigned long r0,
+						      void *dtb_ptr)
+{
+	void *dt = __dtb_start;
+
+	kvx_mmu_early_setup();
+
+	if (r0 == LINUX_BOOT_PARAM_MAGIC)
+		dt = __va(dtb_ptr);
+
+	if (!early_init_dt_scan(dt))
+		panic("Missing device tree\n");
+
+	start_kernel();
+}
diff --git a/arch/kvx/kernel/time.c b/arch/kvx/kernel/time.c
new file mode 100644
index 000000000000..f27103a1a6f4
--- /dev/null
+++ b/arch/kvx/kernel/time.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ *            Guillaume Thouvenin
+ *            Luc Michel
+ *            Julian Vetter
+ */
+
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/of_irq.h>
+#include <linux/interrupt.h>
+#include <linux/cpuhotplug.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/sched_clock.h>
+
+#include <asm/sfr_defs.h>
+
+#define KVX_TIMER_MIN_DELTA	1
+#define KVX_TIMER_MAX_DELTA	0xFFFFFFFFFFFFFFFFULL
+#define KVX_TIMER_MAX_VALUE	0xFFFFFFFFFFFFFFFFULL
+
+/*
+ * Clockevent
+ */
+static unsigned int kvx_timer_frequency;
+static unsigned int kvx_periodic_timer_value;
+static unsigned int kvx_timer_irq;
+
+static void kvx_timer_set_value(unsigned long value, unsigned long reload_value)
+{
+	kvx_sfr_set(T0R, reload_value);
+	kvx_sfr_set(T0V, value);
+	/* Enable timer */
+	kvx_sfr_set_field(TCR, T0CE, 1);
+}
+
+static int kvx_clkevent_set_next_event(unsigned long cycles,
+				      struct clock_event_device *dev)
+{
+	/*
+	 * Hardware does not support oneshot mode.
+	 * In order to support it, set a really high reload value.
+	 * Then, during the interrupt handler, disable the timer if
+	 * in oneshot mode
+	 */
+	kvx_timer_set_value(cycles - 1, KVX_TIMER_MAX_VALUE);
+
+	return 0;
+}
+
+/*
+ * Configure the rtc to periodically tick HZ times per second
+ */
+static int kvx_clkevent_set_state_periodic(struct clock_event_device *dev)
+{
+	kvx_timer_set_value(kvx_periodic_timer_value,
+					kvx_periodic_timer_value);
+
+	return 0;
+}
+
+static int kvx_clkevent_set_state_oneshot(struct clock_event_device *dev)
+{
+	/* Same as for kvx_clkevent_set_next_event */
+	kvx_clkevent_set_next_event(kvx_periodic_timer_value, dev);
+
+	return 0;
+}
+
+static int kvx_clkevent_set_state_shutdown(struct clock_event_device *dev)
+{
+	kvx_sfr_set_field(TCR, T0CE, 0);
+
+	return 0;
+}
+
+static DEFINE_PER_CPU(struct clock_event_device, kvx_clockevent_device) = {
+	.name = "kvx-timer-0",
+	.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+	/* arbitrary rating for this clockevent */
+	.rating = 300,
+	.set_next_event = kvx_clkevent_set_next_event,
+	.set_state_periodic = kvx_clkevent_set_state_periodic,
+	.set_state_oneshot = kvx_clkevent_set_state_oneshot,
+	.set_state_shutdown = kvx_clkevent_set_state_shutdown,
+};
+
+irqreturn_t kvx_timer_irq_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = this_cpu_ptr(&kvx_clockevent_device);
+
+	/* Disable timer if in oneshot mode before reloading */
+	if (likely(clockevent_state_oneshot(evt)))
+		kvx_sfr_set_field(TCR, T0CE, 0);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int kvx_timer_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt = this_cpu_ptr(&kvx_clockevent_device);
+
+	evt->cpumask = cpumask_of(cpu);
+	evt->irq = kvx_timer_irq;
+
+	clockevents_config_and_register(evt, kvx_timer_frequency,
+					KVX_TIMER_MIN_DELTA,
+					KVX_TIMER_MAX_DELTA);
+
+	/* Enable timer interrupt */
+	kvx_sfr_set_field(TCR, T0IE, 1);
+
+	enable_percpu_irq(kvx_timer_irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int kvx_timer_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(kvx_timer_irq);
+
+	return 0;
+}
+
+static int __init kvx_setup_core_timer(struct device_node *np)
+{
+	struct clock_event_device *evt = this_cpu_ptr(&kvx_clockevent_device);
+	struct clk *clk;
+	int err;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("kvx_core_timer: Failed to get CPU clock: %ld\n",
+							PTR_ERR(clk));
+		return 1;
+	}
+
+	kvx_timer_frequency = clk_get_rate(clk);
+	clk_put(clk);
+	kvx_periodic_timer_value = kvx_timer_frequency / HZ;
+
+	kvx_timer_irq = irq_of_parse_and_map(np, 0);
+	if (!kvx_timer_irq) {
+		pr_err("kvx_core_timer: Failed to parse irq: %d\n",
+							kvx_timer_irq);
+		return -EINVAL;
+	}
+
+	err = request_percpu_irq(kvx_timer_irq, kvx_timer_irq_handler,
+						"kvx_core_timer", evt);
+	if (err) {
+		pr_err("kvx_core_timer: can't register interrupt %d (%d)\n",
+						kvx_timer_irq, err);
+		return err;
+	}
+
+	err = cpuhp_setup_state(CPUHP_AP_KVX_TIMER_STARTING,
+				"kvx/time:online",
+				kvx_timer_starting_cpu,
+				kvx_timer_dying_cpu);
+	if (err < 0) {
+		pr_err("kvx_core_timer: Failed to setup hotplug state");
+		return err;
+	}
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(kvx_core_timer, "kalray,kvx-core-timer",
+						kvx_setup_core_timer);
+
+/*
+ * Clocksource
+ */
+static u64 kvx_dsu_clocksource_read(struct clocksource *cs)
+{
+	return readq(cs->archdata.regs);
+}
+
+static struct clocksource kvx_dsu_clocksource = {
+	.name = "kvx-dsu-clock",
+	.rating = 400,
+	.read = kvx_dsu_clocksource_read,
+	.mask = CLOCKSOURCE_MASK(64),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u64 notrace kvx_dsu_sched_read(void)
+{
+	return readq_relaxed(kvx_dsu_clocksource.archdata.regs);
+}
+
+static int __init kvx_setup_dsu_clock(struct device_node *np)
+{
+	int ret;
+	struct clk *clk;
+	unsigned long kvx_dsu_frequency;
+
+	kvx_dsu_clocksource.archdata.regs = of_iomap(np, 0);
+
+	WARN_ON(!kvx_dsu_clocksource.archdata.regs);
+	if (!kvx_dsu_clocksource.archdata.regs)
+		return -ENXIO;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get CPU clock: %ld\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	kvx_dsu_frequency = clk_get_rate(clk);
+	clk_put(clk);
+
+	ret = clocksource_register_hz(&kvx_dsu_clocksource,
+				       kvx_dsu_frequency);
+	if (ret) {
+		pr_err("failed to register dsu clocksource");
+		return ret;
+	}
+
+	sched_clock_register(kvx_dsu_sched_read, 64, kvx_dsu_frequency);
+	return 0;
+}
+
+TIMER_OF_DECLARE(kvx_dsu_clock, "kalray,kvx-dsu-clock",
+						kvx_setup_dsu_clock);
+
+void __init time_init(void)
+{
+	of_clk_init(NULL);
+
+	timer_probe();
+}
-- 
2.37.2





