Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD43280D9
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 15:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhCAOaM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 09:30:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233264AbhCAOaK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 09:30:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E189E64DF1;
        Mon,  1 Mar 2021 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614608970;
        bh=En1eyk16wHgUtzj4bgZ6Lkm3+BcNkeqwMyBsqff5YVU=;
        h=From:To:Cc:Subject:Date:From;
        b=OXGPx7au4zoBbOrwHe2jnofxmBHdN4aamSiTgzpqK4KIuDZo88YLBPceJgG7j1C1K
         /6RannAhzjdydeHtqvbqEK66DqPXuPSFcZLf+PcqELnIJ5+I//1W19FPfl1NVl/YQj
         kXWcMY/BuWyA9SSPhfRl5ICU/DCUw8XKePBvmNs+BrHkxgjDKst6NGYbq3rjorl0Lh
         7d7hex16pmBcCijQXdqjgEsoFPGz7CyoSWcMMlKGTKC6gjRXDdGA8p1AQyoaGRr4Y+
         FsczAFUGC17IJzc9oMqSDS8HXVGP+Xf6IghdM0ytNT7ajoc0gGB9TfkvULFbIxAffr
         A4c0uzbWpqavA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] irqchip: riscv: Using CPUHP_AP_ONLINE_DYN
Date:   Mon,  1 Mar 2021 14:28:19 +0000
Message-Id: <1614608902-85038-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove RISC-V irqchip custom definitions in hotplug.h:
 - CPUHP_AP_IRQ_RISCV_STARTING
 - CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING

For coding convention.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Link: https://lore.kernel.org/lkml/CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com/
---
 drivers/irqchip/irq-riscv-intc.c  | 2 +-
 drivers/irqchip/irq-sifive-plic.c | 2 +-
 include/linux/cpuhotplug.h        | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 8017f6d..2c37f3a 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -125,7 +125,7 @@ static int __init riscv_intc_init(struct device_node *node,
 		return rc;
 	}
 
-	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 			  "irqchip/riscv/intc:starting",
 			  riscv_intc_cpu_starting,
 			  riscv_intc_cpu_dying);
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 6f432d2..f499f1b 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -375,7 +375,7 @@ static int __init plic_init(struct device_node *node,
 	 */
 	handler = this_cpu_ptr(&plic_handlers);
 	if (handler->present && !plic_cpuhp_setup_done) {
-		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+		cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "irqchip/sifive/plic:starting",
 				  plic_starting_cpu, plic_dying_cpu);
 		plic_cpuhp_setup_done = true;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f14adb8..14f49fd 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -103,8 +103,6 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
-	CPUHP_AP_IRQ_RISCV_STARTING,
-	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
-- 
2.7.4

