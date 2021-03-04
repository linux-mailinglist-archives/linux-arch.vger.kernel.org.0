Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8678232DC37
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbhCDVme (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbhCDVmT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 16:42:19 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B468C0613D8;
        Thu,  4 Mar 2021 13:41:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 66664426F7;
        Thu,  4 Mar 2021 21:41:14 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v3 16/27] irqchip/apple-aic: Add support for the Apple Interrupt Controller
Date:   Fri,  5 Mar 2021 06:38:51 +0900
Message-Id: <20210304213902.83903-17-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the root interrupt controller used on Apple ARM SoCs such as the
M1. This irqchip driver performs multiple functions:

* Handles both IRQs and FIQs

* Drives the AIC peripheral itself (which handles IRQs)

* Dispatches FIQs to downstream hard-wired clients (currently the ARM
  timer).

* Implements a virtual IPI multiplexer to funnel multiple Linux IPIs
  into a single hardware IPI

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 MAINTAINERS                     |   2 +
 drivers/irqchip/Kconfig         |   8 +
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-apple-aic.c | 710 ++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h      |   1 +
 5 files changed, 722 insertions(+)
 create mode 100644 drivers/irqchip/irq-apple-aic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 744e086d28cd..28bd46f4f7a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1648,6 +1648,8 @@ T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:	arch/arm64/include/asm/sysreg_apple.h
+F:	drivers/irqchip/irq-apple-aic.c
+F:	include/dt-bindings/interrupt-controller/apple-aic.h
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15536e321df5..d3a14f304ec8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -577,4 +577,12 @@ config MST_IRQ
 	help
 	  Support MStar Interrupt Controller.
 
+config APPLE_AIC
+	bool "Apple Interrupt Controller (AIC)"
+	depends on ARM64
+	default ARCH_APPLE
+	help
+	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
+	  such as the M1.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c59b95a0532c..eb6a515f0f64 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -113,3 +113,4 @@ obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
 obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
+obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
new file mode 100644
index 000000000000..ddc0856f36a5
--- /dev/null
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -0,0 +1,710 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright The Asahi Linux Contributors
+ *
+ * Based on irq-lpc32xx:
+ *   Copyright 2015-2016 Vladimir Zapolskiy <vz@mleia.com>
+ * Based on irq-bcm2836:
+ *   Copyright 2015 Broadcom
+ */
+
+/*
+ * AIC is a fairly simple interrupt controller with the following features:
+ *
+ * - 896 level-triggered hardware IRQs
+ *   - Single mask bit per IRQ
+ *   - Per-IRQ affinity setting
+ *   - Automatic masking on event delivery (auto-ack)
+ *   - Software triggering (ORed with hw line)
+ * - 2 per-CPU IPIs (meant as "self" and "other", but they are
+ *   interchangeable if not symmetric)
+ * - Automatic prioritization (single event/ack register per CPU, lower IRQs =
+ *   higher priority)
+ * - Automatic masking on ack
+ * - Default "this CPU" register view and explicit per-CPU views
+ *
+ * In addition, this driver also handles FIQs, as these are routed to the same
+ * IRQ vector. These are used for Fast IPIs (TODO), the ARMv8 timer IRQs, and
+ * performance counters (TODO).
+ *
+ * Implementation notes:
+ *
+ * - This driver creates two IRQ domains, one for HW IRQs and internal FIQs,
+ *   and one for IPIs.
+ * - Since Linux needs more than 2 IPIs, we implement a software IRQ controller
+ *   and funnel all IPIs into one per-CPU IPI (the second "self" IPI is unused).
+ * - FIQ hwirq numbers are assigned after true hwirqs, and are per-cpu.
+ * - DT bindings use 3-cell form (like GIC):
+ *   - <0 nr flags> - hwirq #nr
+ *   - <1 nr flags> - FIQ #nr
+ *     - nr=0  Physical HV timer
+ *     - nr=1  Virtual HV timer
+ *     - nr=2  Physical guest timer
+ *     - nr=3  Virtual guest timer
+ *
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/cpuhotplug.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <asm/exception.h>
+#include <asm/sysreg.h>
+#include <asm/sysreg_apple.h>
+
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+
+#define AIC_INFO		0x0004
+#define AIC_INFO_NR_HW		GENMASK(15, 0)
+
+#define AIC_CONFIG		0x0010
+
+#define AIC_WHOAMI		0x2000
+#define AIC_EVENT		0x2004
+#define AIC_EVENT_TYPE		GENMASK(31, 16)
+#define AIC_EVENT_NUM		GENMASK(15, 0)
+
+#define AIC_EVENT_TYPE_HW	1
+#define AIC_EVENT_TYPE_IPI	4
+#define AIC_EVENT_IPI_OTHER	1
+#define AIC_EVENT_IPI_SELF	2
+
+#define AIC_IPI_SEND		0x2008
+#define AIC_IPI_ACK		0x200c
+#define AIC_IPI_MASK_SET	0x2024
+#define AIC_IPI_MASK_CLR	0x2028
+
+#define AIC_IPI_SEND_CPU(cpu)	BIT(cpu)
+
+#define AIC_IPI_OTHER		BIT(0)
+#define AIC_IPI_SELF		BIT(31)
+
+#define AIC_TARGET_CPU		0x3000
+#define AIC_SW_SET		0x4000
+#define AIC_SW_CLR		0x4080
+#define AIC_MASK_SET		0x4100
+#define AIC_MASK_CLR		0x4180
+
+#define AIC_CPU_IPI_SET(cpu)	(0x5008 + ((cpu) << 7))
+#define AIC_CPU_IPI_CLR(cpu)	(0x500c + ((cpu) << 7))
+#define AIC_CPU_IPI_MASK_SET(cpu) (0x5024 + ((cpu) << 7))
+#define AIC_CPU_IPI_MASK_CLR(cpu) (0x5028 + ((cpu) << 7))
+
+#define MASK_REG(x)		(4 * ((x) >> 5))
+#define MASK_BIT(x)		BIT((x) & 0x1f)
+
+#define AIC_NR_FIQ		4
+#define AIC_NR_SWIPI		32
+
+/*
+ * Max 31 bits in IPI SEND register (top bit is self).
+ * >=32-core chips will need code changes anyway.
+ */
+#define AIC_MAX_CPUS		31
+
+struct aic_irq_chip {
+	void __iomem *base;
+	struct irq_domain *hw_domain;
+	struct irq_domain *ipi_domain;
+	int nr_hw;
+	int ipi_hwirq;
+};
+
+static atomic_t aic_vipi_flag[AIC_MAX_CPUS];
+static atomic_t aic_vipi_enable[AIC_MAX_CPUS];
+
+static struct aic_irq_chip *aic_irqc;
+
+static void aic_handle_ipi(struct pt_regs *regs);
+
+static u32 aic_ic_read(struct aic_irq_chip *ic, u32 reg)
+{
+	return readl_relaxed(ic->base + reg);
+}
+
+static void aic_ic_write(struct aic_irq_chip *ic, u32 reg, u32 val)
+{
+	writel_relaxed(val, ic->base + reg);
+}
+
+/*
+ * IRQ irqchip
+ */
+
+static void aic_irq_mask(struct irq_data *d)
+{
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+
+	aic_ic_write(ic, AIC_MASK_SET + MASK_REG(d->hwirq),
+		     MASK_BIT(d->hwirq));
+}
+
+static void aic_irq_unmask(struct irq_data *d)
+{
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+
+	aic_ic_write(ic, AIC_MASK_CLR + MASK_REG(d->hwirq),
+		     MASK_BIT(d->hwirq));
+}
+
+static void aic_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * Reading the interrupt reason automatically acknowledges and masks
+	 * the IRQ, so we just unmask it here if needed.
+	 */
+	if (!irqd_irq_disabled(d) && !irqd_irq_masked(d))
+		aic_irq_unmask(d);
+}
+
+static void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
+{
+	struct aic_irq_chip *ic = aic_irqc;
+	u32 event, type, irq;
+
+	do {
+		/*
+		 * We cannot use a relaxed read here, as DMA needs to be
+		 * ordered with respect to the IRQ firing.
+		 */
+		event = readl(ic->base + AIC_EVENT);
+		type = FIELD_GET(AIC_EVENT_TYPE, event);
+		irq = FIELD_GET(AIC_EVENT_NUM, event);
+
+		if (type == AIC_EVENT_TYPE_HW)
+			handle_domain_irq(aic_irqc->hw_domain, irq, regs);
+		else if (type == AIC_EVENT_TYPE_IPI && irq == 1)
+			aic_handle_ipi(regs);
+		else if (event != 0)
+			pr_err("Unknown IRQ event %d, %d\n", type, irq);
+	} while (event);
+
+	/*
+	 * vGIC maintenance interrupts end up here too, so we need to check
+	 * for them separately. Just report and disable vGIC for now, until
+	 * we implement this properly.
+	 */
+	if ((read_sysreg_s(SYS_ICH_HCR_EL2) & ICH_HCR_EN) &&
+		read_sysreg_s(SYS_ICH_MISR_EL2) != 0) {
+		pr_err("vGIC IRQ fired, disabling.\n");
+		sysreg_clear_set_s(SYS_ICH_HCR_EL2, ICH_HCR_EN, 0);
+	}
+}
+
+static int aic_irq_set_affinity(struct irq_data *d,
+				const struct cpumask *mask_val, bool force)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+	int cpu;
+
+	if (hwirq > ic->nr_hw)
+		return -EINVAL;
+
+	if (force)
+		cpu = cpumask_first(mask_val);
+	else
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+
+	aic_ic_write(ic, AIC_TARGET_CPU + hwirq * 4, BIT(cpu));
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK;
+}
+
+static int aic_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	return (type == IRQ_TYPE_LEVEL_HIGH) ? 0 : -EINVAL;
+}
+
+static struct irq_chip aic_chip = {
+	.name = "AIC",
+	.irq_mask = aic_irq_mask,
+	.irq_unmask = aic_irq_unmask,
+	.irq_eoi = aic_irq_eoi,
+	.irq_set_affinity = aic_irq_set_affinity,
+	.irq_set_type = aic_irq_set_type,
+};
+
+/*
+ * FIQ irqchip
+ */
+
+static void aic_fiq_mask(struct irq_data *d)
+{
+	/* Only the guest timers have real mask bits, unfortunately. */
+	switch (d->hwirq) {
+	case AIC_TMR_GUEST_PHYS:
+		sysreg_clear_set_s(SYS_APL_VM_TMR_FIQ_ENA_EL1, VM_TMR_FIQ_ENABLE_P, 0);
+		break;
+	case AIC_TMR_GUEST_VIRT:
+		sysreg_clear_set_s(SYS_APL_VM_TMR_FIQ_ENA_EL1, VM_TMR_FIQ_ENABLE_V, 0);
+		break;
+	}
+}
+
+static void aic_fiq_unmask(struct irq_data *d)
+{
+	switch (d->hwirq) {
+	case AIC_TMR_GUEST_PHYS:
+		sysreg_clear_set_s(SYS_APL_VM_TMR_FIQ_ENA_EL1, 0, VM_TMR_FIQ_ENABLE_P);
+		break;
+	case AIC_TMR_GUEST_VIRT:
+		sysreg_clear_set_s(SYS_APL_VM_TMR_FIQ_ENA_EL1, 0, VM_TMR_FIQ_ENABLE_V);
+		break;
+	}
+}
+
+static void aic_fiq_eoi(struct irq_data *d)
+{
+	/* We mask to ack (where we can), so we need to unmask at EOI. */
+	if (!irqd_irq_disabled(d) && !irqd_irq_masked(d))
+		aic_fiq_unmask(d);
+}
+
+#define TIMER_FIRING(x)                                                        \
+	(((x) & (ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_MASK |            \
+		 ARCH_TIMER_CTRL_IT_STAT)) ==                                  \
+	 (ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_STAT))
+
+static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
+{
+	/*
+	 * It would be really nice if we had a system register that lets us get
+	 * the FIQ source state without having to peek down into sources...
+	 * but such a register does not seem to exist.
+	 *
+	 * So, we have these potential sources to test for:
+	 *  - Fast IPIs (not yet used)
+	 *  - The 4 timers (CNTP, CNTV for each of HV and guest)
+	 *  - Per-core PMCs (not yet supported)
+	 *  - Per-cluster uncore PMCs (not yet supported)
+	 *
+	 * Since not dealing with any of these results in a FIQ storm,
+	 * we check for everything here, even things we don't support yet.
+	 */
+
+	if (read_sysreg_s(SYS_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
+		pr_warn("Fast IPI fired. Acking.\n");
+		write_sysreg_s(IPI_SR_PENDING, SYS_APL_IPI_SR_EL1);
+	}
+
+	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
+		handle_domain_irq(aic_irqc->hw_domain,
+				  aic_irqc->nr_hw + AIC_TMR_HV_PHYS, regs);
+
+	if (TIMER_FIRING(read_sysreg(cntv_ctl_el0)))
+		handle_domain_irq(aic_irqc->hw_domain,
+				  aic_irqc->nr_hw + AIC_TMR_HV_VIRT, regs);
+
+	if (TIMER_FIRING(read_sysreg_s(SYS_CNTP_CTL_EL02)))
+		handle_domain_irq(aic_irqc->hw_domain,
+				  aic_irqc->nr_hw + AIC_TMR_GUEST_PHYS, regs);
+
+	if (TIMER_FIRING(read_sysreg_s(SYS_CNTV_CTL_EL02)))
+		handle_domain_irq(aic_irqc->hw_domain,
+				  aic_irqc->nr_hw + AIC_TMR_GUEST_VIRT, regs);
+
+	if ((read_sysreg_s(SYS_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT))
+			== (FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
+		/*
+		 * Not supported yet, let's figure out how to handle this when
+		 * we implement these proprietary performance counters. For now,
+		 * just mask it and move on.
+		 */
+		pr_warn("PMC FIQ fired. Masking.\n");
+		sysreg_clear_set_s(SYS_APL_PMCR0_EL1, PMCR0_IMODE | PMCR0_IACT,
+				   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
+	}
+
+	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
+			(read_sysreg_s(SYS_APL_UPMSR_EL1) & UPMSR_IACT)) {
+		/* Same story with uncore PMCs */
+		pr_warn("Uncore PMC FIQ fired. Masking.\n");
+		sysreg_clear_set_s(SYS_APL_UPMCR0_EL1, UPMCR0_IMODE,
+				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	}
+}
+
+static struct irq_chip fiq_chip = {
+	.name = "AIC-FIQ",
+	.irq_mask = aic_fiq_mask,
+	.irq_unmask = aic_fiq_unmask,
+	.irq_ack = aic_fiq_mask,
+	.irq_eoi = aic_fiq_eoi,
+	.irq_set_type = aic_irq_set_type,
+};
+
+/*
+ * Main IRQ domain
+ */
+
+static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
+			      irq_hw_number_t hw)
+{
+	struct aic_irq_chip *ic = id->host_data;
+
+	if (hw < ic->nr_hw) {
+		irq_domain_set_info(id, irq, hw, &aic_chip, id->host_data,
+				    handle_fasteoi_irq, NULL, NULL);
+		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+	} else {
+		irq_set_percpu_devid(irq);
+		irq_domain_set_info(id, irq, hw, &fiq_chip, id->host_data,
+				    handle_percpu_devid_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static int aic_irq_domain_translate(struct irq_domain *id,
+				    struct irq_fwspec *fwspec,
+				    unsigned long *hwirq,
+				    unsigned int *type)
+{
+	struct aic_irq_chip *ic = id->host_data;
+
+	if (fwspec->param_count != 3 || !is_of_node(fwspec->fwnode))
+		return -EINVAL;
+
+	switch (fwspec->param[0]) {
+	case AIC_IRQ:
+		if (fwspec->param[1] >= ic->nr_hw)
+			return -EINVAL;
+		*hwirq = 0;
+		break;
+	case AIC_FIQ:
+		if (fwspec->param[1] >= AIC_NR_FIQ)
+			return -EINVAL;
+		*hwirq = ic->nr_hw;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*hwirq += fwspec->param[1];
+	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int aic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+	irq_hw_number_t hwirq;
+	int i, ret;
+
+	ret = aic_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = aic_irq_domain_map(domain, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void aic_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
+
+		irq_set_handler(virq + i, NULL);
+		irq_domain_reset_irq_data(d);
+	}
+}
+
+static const struct irq_domain_ops aic_irq_domain_ops = {
+	.translate	= aic_irq_domain_translate,
+	.alloc		= aic_irq_domain_alloc,
+	.free		= aic_irq_domain_free,
+};
+
+/*
+ * IPI irqchip
+ */
+
+static void aic_ipi_mask(struct irq_data *d)
+{
+	u32 irq_bit = BIT(irqd_to_hwirq(d));
+	int this_cpu = smp_processor_id();
+
+	/* No specific ordering requirements needed here. */
+	atomic_andnot(irq_bit, &aic_vipi_enable[this_cpu]);
+}
+
+static void aic_ipi_unmask(struct irq_data *d)
+{
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+	u32 irq_bit = BIT(irqd_to_hwirq(d));
+	int this_cpu = smp_processor_id();
+
+	/*
+	 * This must complete before the atomic_read_acquire() below to avoid
+	 * racing aic_ipi_send_mask(). Use a dummy fetch op with release
+	 * semantics for this. This is arch-specific: ARMv8 B2.3.3 specifies
+	 * that writes with Release semantics are Barrier-ordered-before reads
+	 * with Acquire semantics, even though the Linux arch-independent
+	 * definition of these atomic ops does not.
+	 */
+	(void)atomic_fetch_or_release(irq_bit, &aic_vipi_enable[this_cpu]);
+
+	/*
+	 * If a pending vIPI was unmasked, raise a HW IPI to ourselves.
+	 * No barriers needed here since this is a self-IPI.
+	 */
+	if (atomic_read_acquire(&aic_vipi_flag[this_cpu]) & irq_bit)
+		aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(this_cpu));
+}
+
+static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
+{
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+	u32 irq_bit = BIT(irqd_to_hwirq(d));
+	u32 send = 0;
+	int cpu;
+	unsigned long pending;
+
+	for_each_cpu(cpu, mask) {
+		/*
+		 * This sequence is the mirror of the one in aic_ipi_unmask();
+		 * see the comment there. Additionally, release semantics
+		 * ensure that the vIPI flag set is ordered after any shared
+		 * memory accesses that precede it. This therefore also pairs
+		 * with the atomic_fetch_andnot in aic_handle_ipi().
+		 */
+		pending = atomic_fetch_or_release(irq_bit, &aic_vipi_flag[cpu]);
+
+		if (!(pending & irq_bit) && (atomic_read_acquire(&aic_vipi_enable[cpu]) & irq_bit))
+			send |= AIC_IPI_SEND_CPU(cpu);
+	}
+
+	/*
+	 * The flag writes must complete before the physical IPI is issued
+	 * to another CPU. This is implied by the control dependency on
+	 * the result of atomic_read_acquire() above, which is itself
+	 * already ordered after the vIPI flag write.
+	 */
+	if (send)
+		aic_ic_write(ic, AIC_IPI_SEND, send);
+}
+
+static struct irq_chip ipi_chip = {
+	.name = "AIC-IPI",
+	.irq_mask = aic_ipi_mask,
+	.irq_unmask = aic_ipi_unmask,
+	.ipi_send_mask = aic_ipi_send_mask,
+};
+
+/*
+ * IPI IRQ domain
+ */
+
+static void aic_handle_ipi(struct pt_regs *regs)
+{
+	int this_cpu = smp_processor_id();
+	int i;
+	unsigned long enabled, firing;
+
+	/*
+	 * Ack the IPI. We need to order this after the AIC event read, but
+	 * that is enforced by normal MMIO ordering guarantees.
+	 */
+	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
+
+	/*
+	 * The mask read does not need to be ordered. Only we can change
+	 * our own mask anyway, so no races are possible here, as long as
+	 * we are properly in the interrupt handler (which is covered by
+	 * the barrier that is part of the top-level AIC handler's readl()).
+	 */
+	enabled = atomic_read(&aic_vipi_enable[this_cpu]);
+
+	/*
+	 * Clear the IPIs we are about to handle. This pairs with the
+	 * atomic_fetch_or_release() in aic_ipi_send_mask(), and needs to be
+	 * ordered after the aic_ic_write() above (to avoid dropping vIPIs) and
+	 * before IPI handling code (to avoid races handling vIPIs before they
+	 * are signaled). The former is taken care of by the release semantics
+	 * of the write portion, while the latter is taken care of by the
+	 * acquire semantics of the read portion.
+	 */
+	firing = atomic_fetch_andnot(enabled, &aic_vipi_flag[this_cpu]) & enabled;
+
+	for_each_set_bit(i, &firing, AIC_NR_SWIPI) {
+		handle_domain_irq(aic_irqc->ipi_domain, i, regs);
+	}
+
+	/*
+	 * No ordering needed here; at worst this just changes the timing of
+	 * when the next IPI will be delivered.
+	 */
+	aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+}
+
+static int aic_ipi_alloc(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs, void *args)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, i, &ipi_chip, d->host_data,
+				    handle_percpu_devid_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void aic_ipi_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
+{
+	/* Not freeing IPIs */
+}
+
+static const struct irq_domain_ops aic_ipi_domain_ops = {
+	.alloc = aic_ipi_alloc,
+	.free = aic_ipi_free,
+};
+
+static int aic_init_smp(struct aic_irq_chip *irqc, struct device_node *node)
+{
+	int base_ipi;
+
+	irqc->ipi_domain = irq_domain_create_linear(irqc->hw_domain->fwnode, AIC_NR_SWIPI,
+						    &aic_ipi_domain_ops, irqc);
+	if (WARN_ON(!irqc->ipi_domain))
+		return -ENODEV;
+
+	irqc->ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
+	irq_domain_update_bus_token(irqc->ipi_domain, DOMAIN_BUS_IPI);
+
+	base_ipi = __irq_domain_alloc_irqs(irqc->ipi_domain, -1, AIC_NR_SWIPI,
+					   NUMA_NO_NODE, NULL, false, NULL);
+
+	if (WARN_ON(!base_ipi)) {
+		irq_domain_remove(irqc->ipi_domain);
+		return -ENODEV;
+	}
+
+	set_smp_ipi_range(base_ipi, AIC_NR_SWIPI);
+
+	return 0;
+}
+
+static int aic_init_cpu(unsigned int cpu)
+{
+	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
+
+	/* vGIC maintenance IRQ */
+	sysreg_clear_set_s(SYS_ICH_HCR_EL2, ICH_HCR_EN, 0);
+
+	/* Pending Fast IPI FIQs */
+	write_sysreg_s(IPI_SR_PENDING, SYS_APL_IPI_SR_EL1);
+
+	/* Timer FIQs */
+	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
+	sysreg_clear_set(cntv_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
+	sysreg_clear_set_s(SYS_CNTP_CTL_EL02, 0, ARCH_TIMER_CTRL_IT_MASK);
+	sysreg_clear_set_s(SYS_CNTV_CTL_EL02, 0, ARCH_TIMER_CTRL_IT_MASK);
+
+	/* PMC FIQ */
+	sysreg_clear_set_s(SYS_APL_PMCR0_EL1, PMCR0_IMODE | PMCR0_IACT,
+			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
+
+	/* Uncore PMC FIQ */
+	sysreg_clear_set_s(SYS_APL_UPMCR0_EL1, UPMCR0_IMODE,
+			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+
+	/*
+	 * Make sure the kernel's idea of logical CPU order is the same as AIC's
+	 * If we ever end up with a mismatch here, we will have to introduce
+	 * a mapping table similar to what other irqchip drivers do.
+	 */
+	WARN_ON(aic_ic_read(aic_irqc, AIC_WHOAMI) != smp_processor_id());
+
+	/*
+	 * Always keep IPIs unmasked at the hardware level (except auto-masking
+	 * by AIC during processing). We manage masks at the vIPI level.
+	 */
+	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_SELF | AIC_IPI_OTHER);
+	aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
+	aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+
+	return 0;
+
+}
+
+static int __init aic_of_ic_init(struct device_node *node, struct device_node *parent)
+{
+	int i;
+	void __iomem *regs;
+	u32 info;
+	struct aic_irq_chip *irqc;
+
+	regs = of_iomap(node, 0);
+	if (WARN_ON(!regs))
+		return -EIO;
+
+	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
+	if (!irqc)
+		return -ENOMEM;
+
+	aic_irqc = irqc;
+	irqc->base = regs;
+
+	info = aic_ic_read(irqc, AIC_INFO);
+	irqc->nr_hw = FIELD_GET(AIC_INFO_NR_HW, info);
+
+	irqc->hw_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+						   irqc->nr_hw + AIC_NR_FIQ,
+						   &aic_irq_domain_ops, irqc);
+	if (WARN_ON(!irqc->hw_domain)) {
+		iounmap(irqc->base);
+		kfree(irqc);
+		return -ENODEV;
+	}
+
+	irq_domain_update_bus_token(irqc->hw_domain, DOMAIN_BUS_WIRED);
+
+	if (aic_init_smp(irqc, node)) {
+		irq_domain_remove(irqc->hw_domain);
+		iounmap(irqc->base);
+		kfree(irqc);
+		return -ENODEV;
+	}
+
+	set_handle_irq(aic_handle_irq);
+	set_handle_fiq(aic_handle_fiq);
+
+	for (i = 0; i < BITS_TO_U32(irqc->nr_hw); i++)
+		aic_ic_write(irqc, AIC_MASK_SET + i * 4, ~0);
+	for (i = 0; i < BITS_TO_U32(irqc->nr_hw); i++)
+		aic_ic_write(irqc, AIC_SW_CLR + i * 4, ~0);
+	for (i = 0; i < irqc->nr_hw; i++)
+		aic_ic_write(irqc, AIC_TARGET_CPU + i * 4, 1);
+
+	cpuhp_setup_state(CPUHP_AP_IRQ_APPLE_AIC_STARTING,
+			  "irqchip/apple-aic/ipi:starting",
+			  aic_init_cpu, NULL);
+
+	pr_info("AIC: initialized with %d IRQs, %d FIQs, %d vIPIs\n",
+		irqc->nr_hw, AIC_NR_FIQ, AIC_NR_SWIPI);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(apple_m1_aic, "apple,aic", aic_of_ic_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f14adb882338..f56eee992c75 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -100,6 +100,7 @@ enum cpuhp_state {
 	CPUHP_AP_CPU_PM_STARTING,
 	CPUHP_AP_IRQ_GIC_STARTING,
 	CPUHP_AP_IRQ_HIP04_STARTING,
+	CPUHP_AP_IRQ_APPLE_AIC_STARTING,
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
-- 
2.30.0

