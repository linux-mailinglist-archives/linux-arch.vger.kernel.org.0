Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2795675767
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjATOgH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjATOgB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:36:01 -0500
Received: from fx601.security-mail.net (smtpout140.security-mail.net [85.31.212.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ADCCE88C
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:35:15 -0800 (PST)
Received: from localhost (fx601.security-mail.net [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id CC9FB3498A6
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:20:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674224445;
        bh=EHbGeTQPzFxRydvAjCAKTJptA7pNhkmTqYf6aPqpaxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=yWCwrwkzQCLQMcBRPseO+n4EUGXwVUuzwcsuLGwIe2DyGGzgC6Wbv9A6xYGwpajAU
         Qlq5x30oSBZqvKVFNtFKp5PcU+P4fBLmI2ilZhrpztF6nkIBBTiub6KCCTFOitXLlb
         crNVBEnRsafnrMh82aEPeNEtEH99xbkMliPQvBP8=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 429EC349859; Fri, 20 Jan
 2023 15:20:45 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx601.security-mail.net (Postfix) with ESMTPS id 1F87634967F; Fri, 20 Jan
 2023 15:20:44 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 7BC3F27E0481; Fri, 20 Jan 2023
 15:10:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 62F6427E047C; Fri, 20 Jan 2023 15:10:39 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 efK8YWmnYQbb; Fri, 20 Jan 2023 15:10:39 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id C9CA227E0474; Fri, 20 Jan 2023
 15:10:38 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <5b1f.63caa33c.1c743.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 62F6427E047C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223839;
 bh=5C/8QjxVUf/DelpGCfD/Pp9BdUc2vZv56uJsfxSlXPA=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=P6BtAyPM/IrloLG30cdWTPBhk6bnzZeuu0JK6hHT1AvSOjTEjV23l2HTVSkWp3YOM
 JxhQxnIr6MpJR9Ve5OwsqaqYSpuYPPXnuoM+q+2xD3d01z+Z0ef6cKxQqGtJg6OcUa
 Z5LRxJhk4HSsThMlK536n8tiuxt0/9UzyH8L0fvI=
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
Subject: [RFC PATCH v2 31/31] kvx: Add IPI driver
Date:   Fri, 20 Jan 2023 15:10:02 +0100
Message-ID: <20230120141002.2442-32-ysionneau@kalray.eu>
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

From: Jules Maselbas <jmaselbas@kalray.eu>

The Inter-Processor Interrupt Controller (IPI) provides a fast
synchronization mechanism to the software. It exposes eight independent
set of registers that can be use to notify each processor in the cluster.
test

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Luc Michel <lmichel@kalray.eu>
Signed-off-by: Luc Michel <lmichel@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: new patch

 arch/kvx/include/asm/ipi.h |  16 ++++++
 arch/kvx/platform/Makefile |   1 +
 arch/kvx/platform/ipi.c    | 108 +++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 arch/kvx/include/asm/ipi.h
 create mode 100644 arch/kvx/platform/ipi.c

diff --git a/arch/kvx/include/asm/ipi.h b/arch/kvx/include/asm/ipi.h
new file mode 100644
index 000000000000..137407a075e6
--- /dev/null
+++ b/arch/kvx/include/asm/ipi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_IPI_H
+#define _ASM_KVX_IPI_H
+
+#include <linux/irqreturn.h>
+
+int kvx_ipi_ctrl_probe(irqreturn_t (*ipi_irq_handler)(int, void *));
+
+void kvx_ipi_send(const struct cpumask *mask);
+
+#endif /* _ASM_KVX_IPI_H */
diff --git a/arch/kvx/platform/Makefile b/arch/kvx/platform/Makefile
index c7d0abb15c27..27f0914e0de5 100644
--- a/arch/kvx/platform/Makefile
+++ b/arch/kvx/platform/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_SMP) += pwr_ctrl.o
+obj-$(CONFIG_SMP) += ipi.o
diff --git a/arch/kvx/platform/ipi.c b/arch/kvx/platform/ipi.c
new file mode 100644
index 000000000000..a471039b1643
--- /dev/null
+++ b/arch/kvx/platform/ipi.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Luc Michel
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/cpuhotplug.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#define IPI_INTERRUPT_OFFSET	0x0
+#define IPI_MASK_OFFSET		0x20
+
+/*
+ * IPI controller can signal RM and PE0 -> 15
+ * In order to restrict that to the PE, write the corresponding mask
+ */
+#define KVX_IPI_CPU_MASK	(~0xFFFF)
+
+struct kvx_ipi_ctrl {
+	void __iomem *regs;
+	unsigned int ipi_irq;
+};
+
+static struct kvx_ipi_ctrl kvx_ipi_controller;
+
+/**
+ * @kvx_pwr_ctrl_cpu_poweron Wakeup a cpu
+ *
+ * cpu: cpu to wakeup
+ */
+void kvx_ipi_send(const struct cpumask *mask)
+{
+	const unsigned long *maskb = cpumask_bits(mask);
+
+	WARN_ON(*maskb & KVX_IPI_CPU_MASK);
+	writel(*maskb, kvx_ipi_controller.regs + IPI_INTERRUPT_OFFSET);
+}
+
+static int kvx_ipi_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(kvx_ipi_controller.ipi_irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int kvx_ipi_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(kvx_ipi_controller.ipi_irq);
+
+	return 0;
+}
+
+int __init kvx_ipi_ctrl_probe(irqreturn_t (*ipi_irq_handler)(int, void *))
+{
+	struct device_node *np;
+	int ret;
+	unsigned int ipi_irq;
+	void __iomem *ipi_base;
+
+	np = of_find_compatible_node(NULL, NULL, "kalray,kvx-ipi-ctrl");
+	BUG_ON(!np);
+
+	ipi_base = of_iomap(np, 0);
+	BUG_ON(!ipi_base);
+
+	kvx_ipi_controller.regs = ipi_base;
+
+	/* Init mask for interrupts to PE0 -> PE15 */
+	writel(KVX_IPI_CPU_MASK, kvx_ipi_controller.regs + IPI_MASK_OFFSET);
+
+	ipi_irq = irq_of_parse_and_map(np, 0);
+	of_node_put(np);
+	if (!ipi_irq) {
+		pr_err("Failed to parse irq: %d\n", ipi_irq);
+		return -EINVAL;
+	}
+
+	ret = request_percpu_irq(ipi_irq, ipi_irq_handler,
+						"kvx_ipi", &kvx_ipi_controller);
+	if (ret) {
+		pr_err("can't register interrupt %d (%d)\n",
+						ipi_irq, ret);
+		return ret;
+	}
+	kvx_ipi_controller.ipi_irq = ipi_irq;
+
+	ret = cpuhp_setup_state(CPUHP_AP_IRQ_KVX_STARTING,
+				"kvx/ipi:online",
+				kvx_ipi_starting_cpu,
+				kvx_ipi_dying_cpu);
+	if (ret < 0) {
+		pr_err("Failed to setup hotplug state");
+		return ret;
+	}
+
+	return 0;
+}
-- 
2.37.2





