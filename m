Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57A5BF4CF
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 05:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiIUDfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 23:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiIUDeC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 23:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B041816AD;
        Tue, 20 Sep 2022 20:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C36B662F29;
        Wed, 21 Sep 2022 03:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B73C4347C;
        Wed, 21 Sep 2022 03:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663731121;
        bh=PqtTeTuX/9cuTV4f8ppEtuFHBczU7wArbGTDlrJgeWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nldOaCBpVw+C+u8TmKEqYZhhSaCX2zQBHYnsztEFpbDtw4ZpzaAQyFaXislCWDIcI
         3xWCJ70+m/yKVADuEPGTE/kyzj1c8IPnawBARucJCBzW9KgSA4Ftqw+hvAn71lsw0p
         5dRRwAKx207iFs3INCyKoTGCgqWxMtqOJxoPPjJlmuPxJL2wdYxZhEp/JHp3CK970B
         QM+EXvLmlwy9dSUWyKc7X5pKJ1PtmhbvlHMKbCkIIetUFT4MEzWGCWchzCMwqVEa6L
         hKbZEtTKGfl/qcDMcSczaLH614kCQJlQuz7UuKqa1k5HaSvoDDrOAYNvmlnpY3+JBJ
         tkG9h6e9iAG/g==
From:   guoren@kernel.org
To:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        palmer@rivosinc.com, heiko@sntech.de, liaochang1@huawei.com,
        jszhang@kernel.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH V4 2/3] riscv: kexec: Fixup crash_smp_send_stop without multi cores
Date:   Tue, 20 Sep 2022 23:31:33 -0400
Message-Id: <20220921033134.3133319-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220921033134.3133319-1-guoren@kernel.org>
References: <20220921033134.3133319-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current crash_smp_send_stop is the same as the generic one in
kernel/panic and misses crash_save_cpu in percpu. This patch is inspired
by 78fd584cdec0 ("arm64: kdump: implement machine_crash_shutdown()")
and adds the same mechanism for riscv.

Fixes: ad943893d5f1 ("RISC-V: Fixup schedule out issue in machine_crash_shutdown()")
Reviewed-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Nick Kossifidis <mick@ics.forth.gr>
---
 arch/riscv/include/asm/smp.h      |  3 +
 arch/riscv/kernel/machine_kexec.c | 21 ++-----
 arch/riscv/kernel/smp.c           | 97 ++++++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index d3443be7eedc..3831b638ecab 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -50,6 +50,9 @@ void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
 /* Clear IPI for current CPU */
 void riscv_clear_ipi(void);
 
+/* Check other CPUs stop or not */
+bool smp_crash_stop_failed(void);
+
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
 
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index db41c676e5a2..2d139b724bc8 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -140,22 +140,6 @@ void machine_shutdown(void)
 #endif
 }
 
-/* Override the weak function in kernel/panic.c */
-void crash_smp_send_stop(void)
-{
-	static int cpus_stopped;
-
-	/*
-	 * This function can be called twice in panic path, but obviously
-	 * we execute this only once.
-	 */
-	if (cpus_stopped)
-		return;
-
-	smp_send_stop();
-	cpus_stopped = 1;
-}
-
 static void machine_kexec_mask_interrupts(void)
 {
 	unsigned int i;
@@ -230,6 +214,11 @@ machine_kexec(struct kimage *image)
 	void *control_code_buffer = page_address(image->control_code_page);
 	riscv_kexec_method kexec_method = NULL;
 
+#ifdef CONFIG_SMP
+	WARN(smp_crash_stop_failed(),
+		"Some CPUs may be stale, kdump will be unreliable.\n");
+#endif
+
 	if (image->type != KEXEC_TYPE_CRASH)
 		kexec_method = control_code_buffer;
 	else
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 760a64518c58..8c3b59f1f9b8 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -12,6 +12,7 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/kexec.h>
 #include <linux/profile.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
@@ -22,11 +23,13 @@
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
+#include <asm/cpu_ops.h>
 
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
+	IPI_CPU_CRASH_STOP,
 	IPI_IRQ_WORK,
 	IPI_TIMER,
 	IPI_MAX
@@ -71,6 +74,32 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
+#ifdef CONFIG_KEXEC_CORE
+static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
+
+static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+{
+	crash_save_cpu(regs, cpu);
+
+	atomic_dec(&waiting_for_crash_ipi);
+
+	local_irq_disable();
+
+#ifdef CONFIG_HOTPLUG_CPU
+	if (cpu_has_hotplug(cpu))
+		cpu_ops[cpu]->cpu_stop();
+#endif
+
+	for(;;)
+		wait_for_interrupt();
+}
+#else
+static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+{
+	unreachable();
+}
+#endif
+
 static const struct riscv_ipi_ops *ipi_ops __ro_after_init;
 
 void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
@@ -124,8 +153,9 @@ void arch_irq_work_raise(void)
 
 void handle_IPI(struct pt_regs *regs)
 {
-	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
-	unsigned long *stats = ipi_data[smp_processor_id()].stats;
+	unsigned int cpu = smp_processor_id();
+	unsigned long *pending_ipis = &ipi_data[cpu].bits;
+	unsigned long *stats = ipi_data[cpu].stats;
 
 	riscv_clear_ipi();
 
@@ -154,6 +184,10 @@ void handle_IPI(struct pt_regs *regs)
 			ipi_stop();
 		}
 
+		if (ops & (1 << IPI_CPU_CRASH_STOP)) {
+			ipi_cpu_crash_stop(cpu, get_irq_regs());
+		}
+
 		if (ops & (1 << IPI_IRQ_WORK)) {
 			stats[IPI_IRQ_WORK]++;
 			irq_work_run();
@@ -176,6 +210,7 @@ static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
+	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 };
@@ -235,6 +270,64 @@ void smp_send_stop(void)
 			   cpumask_pr_args(cpu_online_mask));
 }
 
+#ifdef CONFIG_KEXEC_CORE
+/*
+ * The number of CPUs online, not counting this CPU (which may not be
+ * fully online and so not counted in num_online_cpus()).
+ */
+static inline unsigned int num_other_online_cpus(void)
+{
+	unsigned int this_cpu_online = cpu_online(smp_processor_id());
+
+	return num_online_cpus() - this_cpu_online;
+}
+
+void crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+	cpumask_t mask;
+	unsigned long timeout;
+
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we execute this only once.
+	 */
+	if (cpus_stopped)
+		return;
+
+	cpus_stopped = 1;
+
+	/*
+	 * If this cpu is the only one alive at this point in time, online or
+	 * not, there are no stop messages to be sent around, so just back out.
+	 */
+	if (num_other_online_cpus() == 0)
+		return;
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &mask);
+
+	atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
+
+	pr_crit("SMP: stopping secondary CPUs\n");
+	send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
+
+	/* Wait up to one second for other CPUs to stop */
+	timeout = USEC_PER_SEC;
+	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
+		udelay(1);
+
+	if (atomic_read(&waiting_for_crash_ipi) > 0)
+		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
+			cpumask_pr_args(&mask));
+}
+
+bool smp_crash_stop_failed(void)
+{
+	return (atomic_read(&waiting_for_crash_ipi) > 0);
+}
+#endif
+
 void smp_send_reschedule(int cpu)
 {
 	send_ipi_single(cpu, IPI_RESCHEDULE);
-- 
2.36.1

