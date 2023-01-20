Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0D675749
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjATOfR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjATOfP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:35:15 -0500
Received: from fx601.security-mail.net (smtpout140.security-mail.net [85.31.212.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC58879EB6
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:35:03 -0800 (PST)
Received: from localhost (fx601.security-mail.net [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id BE4C7349867
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:20:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674224445;
        bh=ZFm4jn2qVc3XxQ8bbXqM98MO1bH7PPorSUVJmGe9zIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NRRvyDRZ5VwOwVQfZDqU+46NQRlyLDL0W3bsNHuZTtmWfvdYPbnL8A8JWp8oPd0br
         xkajvWR64O8gXlZ1cyBHGFf5LFUuYo1EbpRau8jt+s5Y6qvQmdt2CzKHwmAwdyUODQ
         QR27+dNxyo6iaIgN6wpI2ZaqsOcbK47b8FxkLvYg=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 3138A3497F3; Fri, 20 Jan
 2023 15:20:45 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx601.security-mail.net (Postfix) with ESMTPS id 33F923496B9; Fri, 20 Jan
 2023 15:20:44 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 74EE327E045E; Fri, 20 Jan 2023
 15:10:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 5882427E0463; Fri, 20 Jan 2023 15:10:38 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 D11lu3OG-umz; Fri, 20 Jan 2023 15:10:38 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id DE5A427E0458; Fri, 20 Jan 2023
 15:10:37 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <62f4.63caa33c.3169e.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 5882427E0463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223838;
 bh=r0jAYvZMgDHNmtYPIBemAGb6cgybEgHcmW3NkzN/0Bc=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=JKNRyzm7+8sxXJUhLzONaUXzidzmY7QHybfABV02MMeEolEK1l0P/zyCPivr0qi3X
 cMk6eiWHc8wcM/3mwaZc92PFr6HmcHLhtp6SGUL9n/464kv1zJak07VGMurb1BFNSB
 JEfwZjhbgtlfk55C9aauCac0b4/oyWiVvpTX7xMY=
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
Subject: [RFC PATCH v2 29/31] kvx: Add support for cpuinfo
Date:   Fri, 20 Jan 2023 15:10:00 +0100
Message-ID: <20230120141002.2442-30-ysionneau@kalray.eu>
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

Add support for cpuinfo on kvx arch.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: no changes

 arch/kvx/kernel/cpuinfo.c | 96 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 arch/kvx/kernel/cpuinfo.c

diff --git a/arch/kvx/kernel/cpuinfo.c b/arch/kvx/kernel/cpuinfo.c
new file mode 100644
index 000000000000..f44c46c1e4ba
--- /dev/null
+++ b/arch/kvx/kernel/cpuinfo.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#include <linux/seq_file.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+
+unsigned long elf_hwcap __read_mostly;
+
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	int cpu_num = *(unsigned int *)v;
+	struct cpuinfo_kvx *n = per_cpu_ptr(&cpu_info, cpu_num);
+
+	seq_printf(m, "processor\t: %d\nvendor_id\t: Kalray\n", cpu_num);
+
+	seq_printf(m,
+		   "copro enabled\t: %s\n"
+		   "arch revision\t: %d\n"
+		   "uarch revision\t: %d\n",
+		   n->copro_enable ? "yes" : "no",
+		   n->arch_rev,
+		   n->uarch_rev);
+
+	seq_printf(m,
+		   "bogomips\t: %lu.%02lu\n"
+		   "cpu MHz\t\t: %llu.%03llu\n\n",
+		   (loops_per_jiffy * HZ) / 500000,
+		   ((loops_per_jiffy * HZ) / 5000) % 100,
+		   n->freq / 1000000, (n->freq / 10000) % 100);
+
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	if (*pos == 0)
+		*pos = cpumask_first(cpu_online_mask);
+	if (*pos >= num_online_cpus())
+		return NULL;
+
+	return pos;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	*pos = cpumask_next(*pos, cpu_online_mask);
+
+	return c_start(m, pos);
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start = c_start,
+	.next = c_next,
+	.stop = c_stop,
+	.show = show_cpuinfo,
+};
+
+static int __init setup_cpuinfo(void)
+{
+	int cpu;
+	struct clk *clk;
+	unsigned long cpu_freq = 1000000000;
+	struct device_node *node = of_get_cpu_node(0, NULL);
+
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		printk(KERN_WARNING
+		       "Device tree missing CPU 'clock' parameter. Assuming frequency is 1GHZ");
+		goto setup_cpu_freq;
+	}
+
+	cpu_freq = clk_get_rate(clk);
+
+	clk_put(clk);
+
+setup_cpu_freq:
+	of_node_put(node);
+
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(&cpu_info, cpu)->freq = cpu_freq;
+
+	return 0;
+}
+
+late_initcall(setup_cpuinfo);
-- 
2.37.2





