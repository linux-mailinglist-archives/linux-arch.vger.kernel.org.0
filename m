Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD421675714
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjATO0i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjATO0T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:26:19 -0500
Received: from fx408.security-mail.net (smtpout140.security-mail.net [85.31.212.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28669CD208
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:25:46 -0800 (PST)
Received: from localhost (fx408.security-mail.net [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id ECBE03229F5
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:25:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674224745;
        bh=C4JX2KDfJMf+kd6dGlNUF/l2OL1SVZPZi+/ckEfH3UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OEAowwf4PHI9aHodicAZw2OmPCkxNfZ9jczBNGXv9tGymDEannLiE1LP+n9nmqO7+
         1cckPFYv4q6PFzmYhvScsOqu9QykuhINoOX3RAbhMQi3QQnGdmISLPYDox5zSNMbnO
         qegSyV5aWJrnc3PEAdTLgoFhK+tO7nBwmqbmlamA=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id B5716322547; Fri, 20 Jan
 2023 15:25:44 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 1C87E322929; Fri, 20 Jan
 2023 15:25:44 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 2A48827E0437; Fri, 20 Jan 2023
 15:10:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 0210427E043D; Fri, 20 Jan 2023 15:10:33 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 ImWCZZGcWW5W; Fri, 20 Jan 2023 15:10:32 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 8995D27E043A; Fri, 20 Jan 2023
 15:10:32 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <f780.63caa468.1b48f.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 0210427E043D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223833;
 bh=5XXrgrQzCfc4vEIClRHO/5PBD+bYAS7ERJgrp4OCvF8=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=FSrUM33In5SGjg9c4LwAoWf/AQZS0QSN3rkfGHBE+hEzpy/Vbg1dnPf32zDa8kKMa
 MP0vhwj3UfQzIUAbEwlHIAX+q89B2EfKjyUFxpR38io82dkQQDXMofBuaYRqLg7798
 JotwpQrZZ+Hy6YLcj2fPGriS/JxTFf2hsIWLvBEE=
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
Subject: [RFC PATCH v2 18/31] irqchip: Add kvx-core-intc core interupt
 controller driver
Date:   Fri, 20 Jan 2023 15:09:49 +0100
Message-ID: <20230120141002.2442-19-ysionneau@kalray.eu>
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

From: Jules Maselbas <jmaselbas@kalray.eu>

Each kvx core includes a hardware interrupt controller (core INTC)
with the following features:
 - 32 independent interrupt sources
 - 4-bit priotity level
 - Individual interrupt enable bit
 - Interrupt status bit displaying the pending interrupts
 - Priority management between the 32 interrupts

Among those 32 interrupt sources, the first are hard-wired to hardware
sources. The remaining interrupt sources can be triggered via software
by directly writing to the ILR SFR.

The hard-wired interrupt sources are the following:
  0: Timer 0
  1: Timer 1
  2: Watchdog
  3: Performance Monitors
  4: APIC GIC line 0
  5: APIC GIC line 1
  6: APIC GIC line 2
  7: APIC GIC line 3
 12: SECC error from memory system
 13: Arithmetic exception (carry and IEEE 754 flags)
 16: Data Asynchronous Memory Error (DAME), raised for DECC/DSYS errors
 17: CLI (Cache Line Invalidation) for L1D or L1I following
     DECC/DSYS/Parity errors

The APIC GIC lines will be used to route interrupts coming from SoC
peripherals from outside the Cluster to the kvx core. Those peripherals
include USB host controller, eMMC/SD host controller, i2c, spi, PCIe,
IOMMUs etc...

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: new patch
     - removed print on probe success

 drivers/irqchip/Kconfig             |  5 ++
 drivers/irqchip/Makefile            |  1 +
 drivers/irqchip/irq-kvx-core-intc.c | 80 +++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 drivers/irqchip/irq-kvx-core-intc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 806adbc7b2a4..d242e02771e3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -334,6 +334,11 @@ config MIPS_GIC
 	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
+config KVX_CORE_INTC
+	bool
+	depends on KVX
+	select IRQ_DOMAIN
+
 config KVX_APIC_GIC
 	bool
 	depends on KVX
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 7eaea87ca9ab..d931f2eb38b6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
 obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
+obj-$(CONFIG_KVX_CORE_INTC)		+= irq-kvx-core-intc.o
 obj-$(CONFIG_KVX_APIC_GIC)		+= irq-kvx-apic-gic.o
 obj-$(CONFIG_KVX_ITGEN)			+= irq-kvx-itgen.o
 obj-$(CONFIG_KVX_APIC_MAILBOX)		+= irq-kvx-apic-mailbox.o
diff --git a/drivers/irqchip/irq-kvx-core-intc.c b/drivers/irqchip/irq-kvx-core-intc.c
new file mode 100644
index 000000000000..145f1248925b
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-core-intc.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#define pr_fmt(fmt)	"kvx_core_intc: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <asm/irq.h>
+
+#define KVX_CORE_INTC_IRQ	32
+
+
+static void kvx_irq_mask(struct irq_data *data)
+{
+	kvx_sfr_clear_bit(ILE, data->hwirq);
+}
+
+static void kvx_irq_unmask(struct irq_data *data)
+{
+	kvx_sfr_set_bit(ILE, data->hwirq);
+}
+
+static struct irq_chip kvx_irq_chip = {
+	.name           = "kvx core Intc",
+	.irq_mask	= kvx_irq_mask,
+	.irq_unmask	= kvx_irq_unmask,
+};
+
+static int kvx_irq_map(struct irq_domain *d, unsigned int irq,
+			 irq_hw_number_t hw)
+{
+	/* All interrupts for core are per cpu */
+	irq_set_percpu_devid(irq);
+	irq_set_chip_and_handler(irq, &kvx_irq_chip, handle_percpu_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops kvx_irq_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = kvx_irq_map,
+};
+
+static int __init
+kvx_init_core_intc(struct device_node *intc, struct device_node *parent)
+{
+	struct irq_domain *root_domain;
+	uint32_t core_nr_irqs;
+
+	if (parent)
+		panic("DeviceTree core intc not a root irq controller\n");
+
+	if (of_property_read_u32(intc, "kalray,intc-nr-irqs", &core_nr_irqs))
+		core_nr_irqs = KVX_CORE_INTC_IRQ;
+
+	/* We only have up to 32 interrupts, according to IRQ-domain.txt,
+	 * linear is likely to be the best choice
+	 */
+	root_domain = irq_domain_add_linear(intc, core_nr_irqs,
+						&kvx_irq_ops, NULL);
+	if (!root_domain)
+		panic("root irq domain not avail\n");
+
+	/*
+	 * Needed for primary domain lookup to succeed
+	 * This is a primary irqchip, and can never have a parent
+	 */
+	irq_set_default_host(root_domain);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(kvx_core_intc, "kalray,kvx-core-intc", kvx_init_core_intc);
-- 
2.37.2





