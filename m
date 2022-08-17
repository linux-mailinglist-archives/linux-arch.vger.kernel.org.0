Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8C5973E5
	for <lists+linux-arch@lfdr.de>; Wed, 17 Aug 2022 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbiHQQOV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Aug 2022 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbiHQQN4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Aug 2022 12:13:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4639DB64;
        Wed, 17 Aug 2022 09:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E255D615BA;
        Wed, 17 Aug 2022 16:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994C1C433D7;
        Wed, 17 Aug 2022 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660752806;
        bh=FD9SlMuXmlO3EOLgvahsW7Sboc7tOAmKtseKYIHuBRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ah5/K3cXDTS7baUu/TIrWjvNn+9m0c6m5JvUszJKBu0/TJl/x2/pDBmxiw6sfiGNQ
         S/7avkGq3x3P8dZf1nk411ED/E46+npxlrDFLYcykiJdSxFxotEHkFignzhkOHTbZZ
         v2r565TKUAQuvbOCwXCFYpIKfhevWvz2BjtM2HPYEAuGqkrMLKPhSEp4zaD0eu3snu
         85sIdhoIkC2NT1fm/oSU+L5OLxu0My+ZwfvNhqaSITJ1y3kNB/xljyvDumwjpa80Ob
         yt+ID+1IY1R+gLK2/Jud9lBbo8BuflEkjxGZwgjHOXdkQeXFCDSasFcA8LNtFU0RCI
         xau/qaFtdJ8fw==
From:   guoren@kernel.org
To:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        heiko@sntech.de, guoren@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will.deacon@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH V2 1/2] riscv: kexec: Disable all interrupts in kexec crash path
Date:   Wed, 17 Aug 2022 12:12:57 -0400
Message-Id: <20220817161258.748836-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220817161258.748836-1-guoren@kernel.org>
References: <20220817161258.748836-1-guoren@kernel.org>
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

