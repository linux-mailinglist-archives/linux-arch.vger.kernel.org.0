Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36267574C
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjATOfU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjATOfS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:35:18 -0500
Received: from fx405.security-mail.net (smtpout140.security-mail.net [85.31.212.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B097ED6C
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:35:03 -0800 (PST)
Received: from localhost (fx405.security-mail.net [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id EAE63335DF0
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:10:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674223835;
        bh=iujg4Ph3I/139elOqxsm2GEAdcANWZxNc2YUlfHOMPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=At427VLRx9KZBH1e/yv/uj8ny7ycEXrXirnyPoLQe2OWRM2ZUeLHSWZmMw3jsR+e+
         5TnrsE+Tt+dXb5kUqnLTKpoVNbR2w6GYCO8DfGPEZ+MuE1VC8GypSNw5gkW4Jjtb83
         /iMIeqyIZQOtZFhaycr2kz/efqq+PLlkVDCetw6Y=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 487B6335DF2; Fri, 20 Jan
 2023 15:10:34 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx405.security-mail.net (Postfix) with ESMTPS id 0EDD6335DF0; Fri, 20 Jan
 2023 15:10:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id B6A4527E0440; Fri, 20 Jan 2023
 15:10:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 9294827E043D; Fri, 20 Jan 2023 15:10:32 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 JVyjuwXZV6nO; Fri, 20 Jan 2023 15:10:32 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 0B0F627E0439; Fri, 20 Jan 2023
 15:10:32 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <16482.63caa0d9.d431.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 9294827E043D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223832;
 bh=j3u1+7jSeFlQ+R2vG1RMdQ6rymjVuATFjYu04HprmPk=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=bJCwUqYf1v/WbS/vZFq+PAILA35tNYon5tbMQndVY/zEuvJzRPP6XNc9TdSn69NRl
 r1nrOQyoJ8SkIAojICaqdqM9R42vB2lEIH2sPGEYNOtks6kAZhLSXC3cg4OkeS3YSZ
 pUnjQCtQdqnUilobABMuo4pUzCEtBqdHlf0tvWE0=
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
Subject: [RFC PATCH v2 17/31] irqchip: Add irq-kvx-apic-mailbox driver
Date:   Fri, 20 Jan 2023 15:09:48 +0100
Message-ID: <20230120141002.2442-18-ysionneau@kalray.eu>
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

The APIC includes a mailbox controller, containing 128 mailboxes.
Each mailbox is a word of 8 bytes in the controller internal memory.
Each mailbox can be independently configured with a trigger condition
and an input function.

After a write to a mailbox if the mailbox's trigger condition is met
then an interrupt will be generated.

Since this hardware block generates IRQs based on writes at some memory
locations, it is both an interrupt controller and an MSI controller.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Luc Michel <lmichel@kalray.eu>
Signed-off-by: Luc Michel <lmichel@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: new patch
     - removed print on probe success

 drivers/irqchip/Kconfig                |   8 +
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-kvx-apic-mailbox.c | 480 +++++++++++++++++++++++++
 3 files changed, 489 insertions(+)
 create mode 100644 drivers/irqchip/irq-kvx-apic-mailbox.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 546bc611f3f3..806adbc7b2a4 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -348,6 +348,14 @@ config KVX_ITGEN
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 
+config KVX_APIC_MAILBOX
+       bool
+       depends on KVX
+       select GENERIC_IRQ_IPI if SMP
+       select GENERIC_MSI_IRQ_DOMAIN
+       select IRQ_DOMAIN
+       select IRQ_DOMAIN_HIERARCHY
+
 config INGENIC_IRQ
 	bool
 	depends on MACH_INGENIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 6b8f459d8a21..7eaea87ca9ab 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_KVX_APIC_GIC)		+= irq-kvx-apic-gic.o
 obj-$(CONFIG_KVX_ITGEN)			+= irq-kvx-itgen.o
+obj-$(CONFIG_KVX_APIC_MAILBOX)		+= irq-kvx-apic-mailbox.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o irq-mtk-cirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
 obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
diff --git a/drivers/irqchip/irq-kvx-apic-mailbox.c b/drivers/irqchip/irq-kvx-apic-mailbox.c
new file mode 100644
index 000000000000..33249df047b6
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-apic-mailbox.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Jules Maselbas
+ */
+
+#define pr_fmt(fmt)	"kvx_apic_mailbox: " fmt
+
+#include <linux/irqchip/chained_irq.h>
+#include <linux/of_address.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/iommu.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/init.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+
+#define KVX_MAILBOX_MODE_WRITE  0x0
+#define KVX_MAILBOX_MODE_OR  0x1
+#define KVX_MAILBOX_MODE_ADD  0x2
+
+#define KVX_MAILBOX_TRIG_NO_TRIG 0x0
+#define KVX_MAILBOX_TRIG_DOORBELL 0x1
+#define KVX_MAILBOX_TRIG_MATCH 0x2
+#define KVX_MAILBOX_TRIG_BARRIER 0x3
+#define KVX_MAILBOX_TRIG_THRESHOLD 0x4
+
+#define KVX_MAILBOX_OFFSET 0x0
+#define KVX_MAILBOX_ELEM_SIZE 0x200
+#define KVX_MAILBOX_MASK_OFFSET     0x10
+#define KVX_MAILBOX_FUNCT_OFFSET     0x18
+#define KVX_MAILBOX_LAC_OFFSET     0x8
+#define KVX_MAILBOX_VALUE_OFFSET     0x0
+#define KVX_MAILBOX_FUNCT_MODE_SHIFT  0x0
+#define KVX_MAILBOX_FUNCT_TRIG_SHIFT 0x8
+
+#define MAILBOXES_MAX_COUNT 128
+
+/* Mailboxes are 64 bits wide */
+#define MAILBOXES_BIT_SIZE 64
+
+/* Maximum number of mailboxes available */
+#define MAILBOXES_MAX_BIT_COUNT (MAILBOXES_MAX_COUNT * MAILBOXES_BIT_SIZE)
+
+/* Mailboxes are grouped by 8 in a single page */
+#define MAILBOXES_BITS_PER_PAGE (8 * MAILBOXES_BIT_SIZE)
+
+/**
+ * struct mb_data - per mailbox data
+ * @cpu: CPU on which the mailbox is routed
+ * @parent_irq: Parent IRQ on the GIC
+ */
+struct mb_data {
+	unsigned int cpu;
+	unsigned int parent_irq;
+};
+
+/**
+ * struct kvx_apic_mailbox - kvx apic mailbox
+ * @base: base address of the controller
+ * @device_domain: IRQ device domain for mailboxes
+ * @msi_domain: platform MSI domain for MSI interface
+ * @domain_info: Domain information needed for the MSI domain
+ * @mb_count: Count of mailboxes we are handling
+ * @available: bitmap of availables bits in mailboxes
+ * @mailboxes_lock: lock for irq migration
+ * @mask_lock: lock for irq masking
+ * @mb_data: data associated to each mailbox
+ */
+struct kvx_apic_mailbox {
+	void __iomem *base;
+	phys_addr_t phys_base;
+	struct irq_domain *device_domain;
+	struct irq_domain *msi_domain;
+	struct msi_domain_info domain_info;
+	/* Start and count of device mailboxes */
+	unsigned int mb_count;
+	/* Bitmap of allocated bits in mailboxes */
+	DECLARE_BITMAP(available, MAILBOXES_MAX_BIT_COUNT);
+	spinlock_t mailboxes_lock;
+	raw_spinlock_t mask_lock;
+	struct mb_data mb_data[MAILBOXES_MAX_COUNT];
+};
+
+/**
+ * struct kvx_irq_data - per irq data
+ * @mb: Mailbox structure
+ */
+struct kvx_irq_data {
+	struct kvx_apic_mailbox *mb;
+};
+
+static void kvx_mailbox_get_from_hwirq(unsigned int hw_irq,
+				       unsigned int *mailbox_num,
+				       unsigned int *mailbox_bit)
+{
+	*mailbox_num = hw_irq / MAILBOXES_BIT_SIZE;
+	*mailbox_bit = hw_irq % MAILBOXES_BIT_SIZE;
+}
+
+static void __iomem *kvx_mailbox_get_addr(struct kvx_apic_mailbox *mb,
+				   unsigned int num)
+{
+	return mb->base + (num * KVX_MAILBOX_ELEM_SIZE);
+}
+
+static phys_addr_t kvx_mailbox_get_phys_addr(struct kvx_apic_mailbox *mb,
+				   unsigned int num)
+{
+	return mb->phys_base + (num * KVX_MAILBOX_ELEM_SIZE);
+}
+
+static void kvx_mailbox_msi_compose_msg(struct irq_data *data,
+					struct msi_msg *msg)
+{
+	struct kvx_irq_data *kd = irq_data_get_irq_chip_data(data);
+	struct kvx_apic_mailbox *mb = kd->mb;
+	unsigned int mb_num, mb_bit;
+	phys_addr_t mb_addr;
+
+	kvx_mailbox_get_from_hwirq(irqd_to_hwirq(data), &mb_num, &mb_bit);
+	mb_addr = kvx_mailbox_get_phys_addr(mb, mb_num);
+
+	msg->address_hi = upper_32_bits(mb_addr);
+	msg->address_lo = lower_32_bits(mb_addr);
+	msg->data = mb_bit;
+
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
+}
+
+static void kvx_mailbox_set_irq_enable(struct irq_data *data,
+				     bool enabled)
+{
+	struct kvx_irq_data *kd = irq_data_get_irq_chip_data(data);
+	struct kvx_apic_mailbox *mb = kd->mb;
+	unsigned int mb_num, mb_bit;
+	void __iomem *mb_addr;
+	u64 mask_value, mb_value;
+
+	kvx_mailbox_get_from_hwirq(irqd_to_hwirq(data), &mb_num, &mb_bit);
+	mb_addr = kvx_mailbox_get_addr(mb, mb_num);
+
+	raw_spin_lock(&mb->mask_lock);
+	mask_value = readq(mb_addr + KVX_MAILBOX_MASK_OFFSET);
+	if (enabled)
+		mask_value |= BIT_ULL(mb_bit);
+	else
+		mask_value &= ~BIT_ULL(mb_bit);
+
+	writeq(mask_value, mb_addr + KVX_MAILBOX_MASK_OFFSET);
+
+	raw_spin_unlock(&mb->mask_lock);
+
+	/**
+	 * Since interrupts on mailboxes are edge triggered and are only
+	 * triggered when writing the value, we need to trigger it manually
+	 * after updating the mask if enabled. If the interrupt was triggered by
+	 * the device just after the mask write, we can trigger a spurious
+	 * interrupt but that is still better than missing one...
+	 * Moreover, the mailbox is configured in OR mode which means that even
+	 * if we write a single bit, all other bits will be kept intact.
+	 */
+	if (enabled) {
+		mb_value = readq(mb_addr + KVX_MAILBOX_VALUE_OFFSET);
+		if (mb_value & BIT_ULL(mb_bit))
+			writeq(BIT_ULL(mb_bit),
+			       mb_addr + KVX_MAILBOX_VALUE_OFFSET);
+	}
+}
+
+static void kvx_mailbox_mask(struct irq_data *data)
+{
+	kvx_mailbox_set_irq_enable(data, false);
+}
+
+static void kvx_mailbox_unmask(struct irq_data *data)
+{
+	kvx_mailbox_set_irq_enable(data, true);
+}
+
+static void kvx_mailbox_set_cpu(struct kvx_apic_mailbox *mb, int mb_id,
+			       int new_cpu)
+{
+	irq_set_affinity(mb->mb_data[mb_id].parent_irq, cpumask_of(new_cpu));
+	mb->mb_data[mb_id].cpu = new_cpu;
+}
+
+static void kvx_mailbox_free_bit(struct kvx_apic_mailbox *mb, int hw_irq)
+{
+	unsigned int mb_num, mb_bit;
+
+	kvx_mailbox_get_from_hwirq(hw_irq, &mb_num, &mb_bit);
+	bitmap_clear(mb->available, hw_irq, 1);
+
+	/* If there is no more IRQ on this mailbox, reset it to CPU 0 */
+	if (mb->available[mb_num] == 0)
+		kvx_mailbox_set_cpu(mb, mb_num, 0);
+}
+
+struct irq_chip kvx_apic_mailbox_irq_chip = {
+	.name = "kvx apic mailbox",
+	.irq_compose_msi_msg = kvx_mailbox_msi_compose_msg,
+	.irq_mask = kvx_mailbox_mask,
+	.irq_unmask = kvx_mailbox_unmask,
+};
+
+static int kvx_mailbox_allocate_bits(struct kvx_apic_mailbox *mb, int num_req)
+{
+	int first, align_mask = 0;
+
+	/* This must be a power of 2 for bitmap_find_next_zero_area to work */
+	BUILD_BUG_ON((MAILBOXES_BITS_PER_PAGE & (MAILBOXES_BITS_PER_PAGE - 1)));
+
+	/*
+	 * If user requested more than 1 mailbox, we must make sure it will be
+	 * aligned on a page size for iommu_dma_prepare_msi to be correctly
+	 * mapped in a single page.
+	 */
+	if (num_req > 1)
+		align_mask = (MAILBOXES_BITS_PER_PAGE - 1);
+
+	spin_lock(&mb->mailboxes_lock);
+
+	first = bitmap_find_next_zero_area(mb->available,
+			mb->mb_count * MAILBOXES_BIT_SIZE, 0,
+			num_req, align_mask);
+	if (first >= MAILBOXES_MAX_BIT_COUNT) {
+		spin_unlock(&mb->mailboxes_lock);
+		return -ENOSPC;
+	}
+
+	bitmap_set(mb->available, first, num_req);
+
+	spin_unlock(&mb->mailboxes_lock);
+
+	return first;
+}
+
+static int kvx_apic_mailbox_msi_alloc(struct irq_domain *domain,
+				      unsigned int virq,
+				      unsigned int nr_irqs, void *args)
+{
+	int i, err;
+	int hwirq = 0;
+	u64 mb_addr;
+	struct irq_data *d;
+	struct kvx_irq_data *kd;
+	struct kvx_apic_mailbox *mb = domain->host_data;
+	struct msi_alloc_info *msi_info = (struct msi_alloc_info *)args;
+	struct msi_desc *desc = msi_info->desc;
+	unsigned int mb_num, mb_bit;
+
+	/* We will not be able to guarantee page alignment ! */
+	if (nr_irqs > MAILBOXES_BITS_PER_PAGE)
+		return -EINVAL;
+
+	hwirq = kvx_mailbox_allocate_bits(mb, nr_irqs);
+	if (hwirq < 0)
+		return hwirq;
+
+	kvx_mailbox_get_from_hwirq(hwirq, &mb_num, &mb_bit);
+	mb_addr = (u64) kvx_mailbox_get_phys_addr(mb, mb_num);
+	err = iommu_dma_prepare_msi(desc, mb_addr);
+	if (err)
+		goto free_mb_bits;
+
+	for (i = 0; i < nr_irqs; i++) {
+		kd = kmalloc(sizeof(*kd), GFP_KERNEL);
+		if (!kd) {
+			err = -ENOMEM;
+			goto free_irq_data;
+		}
+
+		kd->mb = mb;
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &kvx_apic_mailbox_irq_chip,
+				    kd, handle_simple_irq,
+				    NULL, NULL);
+	}
+
+	return 0;
+
+free_irq_data:
+	for (i--; i >= 0; i--) {
+		d = irq_domain_get_irq_data(domain, virq + i);
+		kd = irq_data_get_irq_chip_data(d);
+		kfree(kd);
+	}
+
+free_mb_bits:
+	spin_lock(&mb->mailboxes_lock);
+	bitmap_clear(mb->available, hwirq, nr_irqs);
+	spin_unlock(&mb->mailboxes_lock);
+
+	return err;
+}
+
+static void kvx_apic_mailbox_msi_free(struct irq_domain *domain,
+				      unsigned int virq,
+				      unsigned int nr_irqs)
+{
+	int i;
+	struct irq_data *d;
+	struct kvx_irq_data *kd;
+	struct kvx_apic_mailbox *mb = domain->host_data;
+
+	spin_lock(&mb->mailboxes_lock);
+
+	for (i = 0; i < nr_irqs; i++) {
+		d = irq_domain_get_irq_data(domain, virq + i);
+		kd = irq_data_get_irq_chip_data(d);
+		kfree(kd);
+		kvx_mailbox_free_bit(mb, d->hwirq);
+	}
+
+	spin_unlock(&mb->mailboxes_lock);
+}
+
+static const struct irq_domain_ops kvx_apic_mailbox_domain_ops = {
+	.alloc  = kvx_apic_mailbox_msi_alloc,
+	.free	= kvx_apic_mailbox_msi_free
+};
+
+static struct irq_chip kvx_msi_irq_chip = {
+	.name	= "KVX MSI",
+};
+
+static void kvx_apic_mailbox_handle_irq(struct irq_desc *desc)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct kvx_apic_mailbox *mb = irq_desc_get_handler_data(desc);
+	void __iomem *mb_addr = kvx_mailbox_get_addr(mb, irqd_to_hwirq(data));
+	unsigned int irqn, cascade_irq, bit;
+	u64 mask_value, masked_its;
+	u64 mb_value;
+	/* Since we allocate 64 interrupts for each mailbox, the scheme
+	 * to find the hwirq associated to a mailbox irq is the
+	 * following:
+	 * hw_irq = mb_num * MAILBOXES_BIT_SIZE + bit
+	 */
+	unsigned int mb_hwirq = irqd_to_hwirq(data) * MAILBOXES_BIT_SIZE;
+
+	mb_value = readq(mb_addr + KVX_MAILBOX_LAC_OFFSET);
+	mask_value = readq(mb_addr + KVX_MAILBOX_MASK_OFFSET);
+	/* Mask any disabled interrupts */
+	mb_value &= mask_value;
+
+	/**
+	 * Write all pending ITs that are masked to process them later
+	 * Since the mailbox is in OR mode, these bits will be merged with any
+	 * already set bits and thus avoid losing any interrupts.
+	 */
+	masked_its = (~mask_value) & mb_value;
+	if (masked_its)
+		writeq(masked_its, mb_addr + KVX_MAILBOX_LAC_OFFSET);
+
+	for_each_set_bit(bit, (unsigned long *) &mb_value, BITS_PER_LONG) {
+		irqn = bit + mb_hwirq;
+		cascade_irq = irq_find_mapping(mb->device_domain, irqn);
+		generic_handle_irq(cascade_irq);
+	}
+}
+
+static void __init
+apic_mailbox_reset(struct kvx_apic_mailbox *mb)
+{
+	unsigned int i;
+	unsigned int mb_end = mb->mb_count;
+	void __iomem *mb_addr;
+	u64 funct_val = (KVX_MAILBOX_MODE_OR << KVX_MAILBOX_FUNCT_MODE_SHIFT) |
+		(KVX_MAILBOX_TRIG_DOORBELL << KVX_MAILBOX_FUNCT_TRIG_SHIFT);
+
+	for (i = 0; i < mb_end; i++) {
+		mb_addr = kvx_mailbox_get_addr(mb, i);
+		/* Disable all interrupts */
+		writeq(0ULL, mb_addr + KVX_MAILBOX_MASK_OFFSET);
+		/* Set mailbox to OR mode + trigger */
+		writeq(funct_val, mb_addr + KVX_MAILBOX_FUNCT_OFFSET);
+		/* Load & Clear mailbox value */
+		readq(mb_addr + KVX_MAILBOX_LAC_OFFSET);
+	}
+}
+
+static struct msi_domain_ops kvx_msi_domain_ops = {
+};
+
+static struct msi_domain_info kvx_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	= &kvx_msi_domain_ops,
+	.chip	= &kvx_msi_irq_chip,
+};
+
+static int __init
+kvx_init_apic_mailbox(struct device_node *node,
+		      struct device_node *parent)
+{
+	struct kvx_apic_mailbox *mb;
+	unsigned int parent_irq, irq_count;
+	struct resource res;
+	int ret, i;
+
+	mb = kzalloc(sizeof(*mb), GFP_KERNEL);
+	if (!mb)
+		return -ENOMEM;
+
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret)
+		return -EINVAL;
+
+	mb->phys_base = res.start;
+	mb->base = of_io_request_and_map(node, 0, node->name);
+	if (!mb->base) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+
+	spin_lock_init(&mb->mailboxes_lock);
+	raw_spin_lock_init(&mb->mask_lock);
+
+	irq_count = of_irq_count(node);
+	if (irq_count == 0 || irq_count > MAILBOXES_MAX_COUNT) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+	mb->mb_count = irq_count;
+
+	apic_mailbox_reset(mb);
+
+	mb->device_domain = irq_domain_add_tree(node,
+						&kvx_apic_mailbox_domain_ops,
+						mb);
+	if (!mb->device_domain) {
+		pr_err("Failed to setup device domain\n");
+		ret = -EINVAL;
+		goto err_iounmap;
+	}
+
+	mb->msi_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
+						     &kvx_msi_domain_info,
+						     mb->device_domain);
+	if (!mb->msi_domain) {
+		ret = -EINVAL;
+		goto err_irq_domain_add_tree;
+	}
+
+	/* Chain all interrupts from gic to mailbox */
+	for (i = 0; i < irq_count; i++) {
+		parent_irq = irq_of_parse_and_map(node, i);
+		if (parent_irq == 0) {
+			pr_err("unable to parse irq\n");
+			ret = -EINVAL;
+			goto err_irq_domain_msi_create;
+		}
+		mb->mb_data[i].parent_irq = parent_irq;
+
+		irq_set_chained_handler_and_data(parent_irq,
+						 kvx_apic_mailbox_handle_irq,
+						 mb);
+	}
+
+	return 0;
+
+err_irq_domain_msi_create:
+	irq_domain_remove(mb->msi_domain);
+err_irq_domain_add_tree:
+	irq_domain_remove(mb->device_domain);
+err_iounmap:
+	iounmap(mb->base);
+err_kfree:
+	kfree(mb);
+
+	return ret;
+}
+
+IRQCHIP_DECLARE(kvx_apic_mailbox, "kalray,kvx-apic-mailbox",
+		kvx_init_apic_mailbox);
-- 
2.37.2





