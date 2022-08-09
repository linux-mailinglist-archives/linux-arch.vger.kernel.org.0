Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D12F58D4D7
	for <lists+linux-arch@lfdr.de>; Tue,  9 Aug 2022 09:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiHIHpt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Aug 2022 03:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbiHIHpk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2022 03:45:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD16EB481;
        Tue,  9 Aug 2022 00:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82119B811C0;
        Tue,  9 Aug 2022 07:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18DBC433D6;
        Tue,  9 Aug 2022 07:45:33 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Don't disable EIOINTC master core
Date:   Tue,  9 Aug 2022 15:45:22 +0800
Message-Id: <20220809074522.2444672-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch fix a CPU hotplug issue. The EIOINTC master core (the first
core of an EIOINTC node) should not be disabled at runtime, since it has
the responsibility of dispatching I/O interrupts.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/smp.c            | 9 +++++++++
 drivers/irqchip/irq-loongson-eiointc.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 09743103d9b3..54901716f8de 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -242,9 +242,18 @@ void loongson3_smp_finish(void)
 
 static bool io_master(int cpu)
 {
+	int i, node, master;
+
 	if (cpu == 0)
 		return true;
 
+	for (i = 1; i < loongson_sysconf.nr_io_pics; i++) {
+		node = eiointc_get_node(i);
+		master = cpu_number_map(node * CORES_PER_EIO_NODE);
+		if (cpu == master)
+			return true;
+	}
+
 	return false;
 }
 
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 170dbc96c7d3..6c99a2ff95f5 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -56,6 +56,11 @@ static void eiointc_enable(void)
 	iocsr_write64(misc, LOONGARCH_IOCSR_MISC_FUNC);
 }
 
+int eiointc_get_node(int id)
+{
+	return eiointc_priv[id]->node;
+}
+
 static int cpu_to_eio_node(int cpu)
 {
 	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
-- 
2.31.1

