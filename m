Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B2B599348
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 05:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbiHSCzD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 22:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344144AbiHSCzC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 22:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464D3D4754;
        Thu, 18 Aug 2022 19:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C690061497;
        Fri, 19 Aug 2022 02:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8BEC43470;
        Fri, 19 Aug 2022 02:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660877701;
        bh=zq25NiQZz8wm9vgW2vXpq0gI46axFgfL/4UUq2ViQfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1wYDWHTZYUUxwYK/nj4O4YiPzJK1smkXVk3AeWY1NMnE69c+JJgpQc4q+VZnvVXB
         ZU2mPgiJie2AF9xGl9y8ujXfXJfN/GLRYvKusO7va6avKM+enAuxZsuES5oLyMKMPc
         b5y2ieqt+nrUoIw1Of58iJNwrCR//0ShziKdsrh66bm2TpoZuopmULalJVgdW5xPBy
         lRTqotAZTLAQ2tgMm1g/qjvonFJslubOOU3z2w68OizLn1Mq7aAl3cwfwYt+hqh9pt
         J2zE2TlQ67eX3dCYdP83LRsZ1yzECuFYONMTlY5ch5JnzuOSfxijxkyoxJtaXLgu9/
         szCHY15Cs+b8w==
From:   guoren@kernel.org
To:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        heiko@sntech.de, guoren@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will.deacon@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH V3 1/3] riscv: kexec: Disable all interrupts in kexec crash path
Date:   Thu, 18 Aug 2022 22:54:42 -0400
Message-Id: <20220819025444.2121315-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819025444.2121315-1-guoren@kernel.org>
References: <20220819025444.2121315-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

If a crash happens on cpu3 and all interrupts are binding on cpu0, the
bad irq routing will cause a crash kernel which can't receive any irq.
Because crash kernel won't clean up all harts' PLIC enable bits in
enable registers. This patch is similar to 9141a003a491 ("ARM: 7316/1:
kexec: EOI active and mask all interrupts in kexec crash path") and
78fd584cdec0 ("arm64: kdump: implement machine_crash_shutdown()"), and
PowerPC also has the same mechanism.

Fixes: fba8a8674f68 ("RISC-V: Add kexec support")
Reviewed-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Nick Kossifidis <mick@ics.forth.gr>
---
 arch/riscv/kernel/machine_kexec.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index ee79e6839b86..db41c676e5a2 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -15,6 +15,8 @@
 #include <linux/compiler.h>	/* For unreachable() */
 #include <linux/cpu.h>		/* For cpu_down() */
 #include <linux/reboot.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 
 /*
  * kexec_image_info - Print received image details
@@ -154,6 +156,37 @@ void crash_smp_send_stop(void)
 	cpus_stopped = 1;
 }
 
+static void machine_kexec_mask_interrupts(void)
+{
+	unsigned int i;
+	struct irq_desc *desc;
+
+	for_each_irq_desc(i, desc) {
+		struct irq_chip *chip;
+		int ret;
+
+		chip = irq_desc_get_chip(desc);
+		if (!chip)
+			continue;
+
+		/*
+		 * First try to remove the active state. If this
+		 * fails, try to EOI the interrupt.
+		 */
+		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+
+		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
+		    chip->irq_eoi)
+			chip->irq_eoi(&desc->irq_data);
+
+		if (chip->irq_mask)
+			chip->irq_mask(&desc->irq_data);
+
+		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
+			chip->irq_disable(&desc->irq_data);
+	}
+}
+
 /*
  * machine_crash_shutdown - Prepare to kexec after a kernel crash
  *
@@ -169,6 +202,8 @@ machine_crash_shutdown(struct pt_regs *regs)
 	crash_smp_send_stop();
 
 	crash_save_cpu(regs, smp_processor_id());
+	machine_kexec_mask_interrupts();
+
 	pr_info("Starting crashdump kernel...\n");
 }
 
-- 
2.36.1

