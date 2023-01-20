Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C94675754
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjATOfw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjATOfV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:35:21 -0500
Received: from fx306.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5669B80B95
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:35:04 -0800 (PST)
Received: from localhost (fx306.security-mail.net [127.0.0.1])
        by fx306.security-mail.net (Postfix) with ESMTP id 4022335CEE9
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:20:46 +0100 (CET)
Received: from fx306 (fx306.security-mail.net [127.0.0.1]) by
 fx306.security-mail.net (Postfix) with ESMTP id 9D66535CD8E; Fri, 20 Jan
 2023 15:20:45 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id 1B27135CCDC; Fri, 20 Jan
 2023 15:20:45 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id EF33327E047D; Fri, 20 Jan 2023
 15:10:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id D247E27E047C; Fri, 20 Jan 2023 15:10:38 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 N5fxZltrUQUh; Fri, 20 Jan 2023 15:10:38 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 5595327E0470; Fri, 20 Jan 2023
 15:10:38 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <2818.63caa33d.1a14f.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu D247E27E047C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223838;
 bh=Ulssifik/xqyxmseDcDCHWF7GqQfVZORENj6s4m7VYQ=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=c8htp1BmJN/ZqK2lC0okl9ZdmRBJrjLE0Xevwykd2j/+m7QLb63Zikx4OnmEIuo/W
 Di1UTV3iLdZyWQAIqMw8TerInA0DmSfQOa9dBTr2kbyPxrpdc6nurhUYWTcgOQZdlP
 MXGfL9njI9tpJ5KB86FGEG7jmsXmQo3UTpfRPdc0=
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
Subject: [RFC PATCH v2 30/31] kvx: Add power controller driver
Date:   Fri, 20 Jan 2023 15:10:01 +0100
Message-ID: <20230120141002.2442-31-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jules Maselbas <jmaselbas@kalray.eu>

The Power Controller (pwr-ctrl) control cores reset and wake-up
procedure.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Louis Morhet <lmorhet@kalray.eu>
Signed-off-by: Louis Morhet <lmorhet@kalray.eu>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: new patch

 arch/kvx/include/asm/pwr_ctrl.h | 45 ++++++++++++++++
 arch/kvx/platform/Makefile      |  6 +++
 arch/kvx/platform/pwr_ctrl.c    | 91 +++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 arch/kvx/include/asm/pwr_ctrl.h
 create mode 100644 arch/kvx/platform/Makefile
 create mode 100644 arch/kvx/platform/pwr_ctrl.c

diff --git a/arch/kvx/include/asm/pwr_ctrl.h b/arch/kvx/include/asm/pwr_ctrl.h
new file mode 100644
index 000000000000..25f403ba935a
--- /dev/null
+++ b/arch/kvx/include/asm/pwr_ctrl.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Marius Gligor
+ */
+
+#ifndef _ASM_KVX_PWR_CTRL_H
+#define _ASM_KVX_PWR_CTRL_H
+
+#ifndef __ASSEMBLY__
+
+int kvx_pwr_ctrl_probe(void);
+
+void kvx_pwr_ctrl_cpu_poweron(unsigned int cpu);
+
+#endif
+
+/* Power controller vector register definitions */
+#define KVX_PWR_CTRL_VEC_OFFSET 0x1000
+#define KVX_PWR_CTRL_VEC_WUP_SET_OFFSET     0x10
+#define KVX_PWR_CTRL_VEC_WUP_CLEAR_OFFSET     0x20
+
+/* Power controller PE reset PC register definitions */
+#define KVX_PWR_CTRL_RESET_PC_OFFSET               0x2000
+
+/* Power controller global register definitions */
+#define KVX_PWR_CTRL_GLOBAL_OFFSET 0x4040
+
+#define KVX_PWR_CTRL_GLOBAL_SET_OFFSET     0x10
+#define KVX_PWR_CTRL_GLOBAL_SET_PE_EN_SHIFT           0x1
+
+#define PWR_CTRL_WUP_SET_OFFSET  \
+		(KVX_PWR_CTRL_VEC_OFFSET + \
+		 KVX_PWR_CTRL_VEC_WUP_SET_OFFSET)
+
+#define PWR_CTRL_WUP_CLEAR_OFFSET  \
+		(KVX_PWR_CTRL_VEC_OFFSET + \
+		 KVX_PWR_CTRL_VEC_WUP_CLEAR_OFFSET)
+
+#define PWR_CTRL_GLOBAL_CONFIG_OFFSET \
+		(KVX_PWR_CTRL_GLOBAL_OFFSET + \
+		 KVX_PWR_CTRL_GLOBAL_SET_OFFSET)
+
+#endif /* _ASM_KVX_PWR_CTRL_H */
diff --git a/arch/kvx/platform/Makefile b/arch/kvx/platform/Makefile
new file mode 100644
index 000000000000..c7d0abb15c27
--- /dev/null
+++ b/arch/kvx/platform/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2018-2023 Kalray Inc.
+#
+
+obj-$(CONFIG_SMP) += pwr_ctrl.o
diff --git a/arch/kvx/platform/pwr_ctrl.c b/arch/kvx/platform/pwr_ctrl.c
new file mode 100644
index 000000000000..ee35d04845ae
--- /dev/null
+++ b/arch/kvx/platform/pwr_ctrl.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <asm/pwr_ctrl.h>
+#include <asm/symbols.h>
+
+struct kvx_pwr_ctrl {
+	void __iomem *regs;
+};
+
+static struct kvx_pwr_ctrl kvx_pwr_controller;
+
+/**
+ * kvx_pwr_ctrl_cpu_poweron() - Wakeup a cpu
+ * @cpu: cpu to wakeup
+ */
+void kvx_pwr_ctrl_cpu_poweron(unsigned int cpu)
+{
+	/* Set PE boot address */
+	writeq((unsigned long long)kvx_start,
+			kvx_pwr_controller.regs + KVX_PWR_CTRL_RESET_PC_OFFSET);
+	/* Wake up processor ! */
+	writeq(1ULL << cpu,
+	       kvx_pwr_controller.regs + PWR_CTRL_WUP_SET_OFFSET);
+	/* Then clear wakeup to allow processor to sleep */
+	writeq(1ULL << cpu,
+	       kvx_pwr_controller.regs + PWR_CTRL_WUP_CLEAR_OFFSET);
+}
+
+static struct device_node * __init get_pwr_ctrl_node(void)
+{
+	const phandle *ph;
+	struct device_node *cpu;
+	struct device_node *node;
+
+	cpu = of_get_cpu_node(raw_smp_processor_id(), NULL);
+	if (!cpu) {
+		pr_err("Failed to get CPU node\n");
+		return NULL;
+	}
+
+	ph = of_get_property(cpu, "power-controller", NULL);
+	if (!ph) {
+		pr_err("Failed to get power-controller phandle\n");
+		return NULL;
+	}
+
+	node = of_find_node_by_phandle(be32_to_cpup(ph));
+	if (!node) {
+		pr_err("Failed to get power-controller node\n");
+		return NULL;
+	}
+
+	return node;
+}
+
+int __init kvx_pwr_ctrl_probe(void)
+{
+	struct device_node *ctrl;
+
+	ctrl = get_pwr_ctrl_node();
+	if (!ctrl) {
+		pr_err("Failed to get power controller node\n");
+		return -EINVAL;
+	}
+
+	if (!of_device_is_compatible(ctrl, "kalray,kvx-pwr-ctrl")) {
+		pr_err("Failed to get power controller node\n");
+		return -EINVAL;
+	}
+
+	kvx_pwr_controller.regs = of_iomap(ctrl, 0);
+	if (!kvx_pwr_controller.regs) {
+		pr_err("Failed ioremap\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
-- 
2.37.2





