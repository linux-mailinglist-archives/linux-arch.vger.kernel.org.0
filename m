Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBF6C7898
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 08:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjCXHPD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 03:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjCXHOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 03:14:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327E61448B;
        Fri, 24 Mar 2023 00:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 998A7B819BA;
        Fri, 24 Mar 2023 07:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368CCC4339C;
        Fri, 24 Mar 2023 07:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679642083;
        bh=5Apt43PtNAwm2BzPLMCNMaIA3jE930gvw1frsSZwRcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSt7xWTQ8EDfBmF/+gfDgrXxNbsKZkHQIvgyzDiebEdRbBPRSb1kfXqq5toIXzX4j
         kGptgJX058jI4BaeNWwWfyeES3V32qD5jH2NS7vJuzJSpzO6vxogJtaIi8WYVxb4mm
         VkfxphQZwF9/rbxXG85b/eCA3CTomFMfh3UzG8ywV5v1R3HlMfgqn32TU9tq1OXDdr
         G3+lDp17cBvLCYZN9q4itL2xe205klcxvA8xj9qT7FEwQE5m6cl3lLTNsitVXfo0ru
         Rox0R2BkH1VIj3g1lgyAVWtbA5qfWD6nVC2s6IZ7UOEgPVXA5YeSXq/dY4md4iroBb
         uSrC7JorAVjsA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V11 3/3] riscv: stack: Add config of thread stack size
Date:   Fri, 24 Mar 2023 03:12:39 -0400
Message-Id: <20230324071239.151677-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230324071239.151677-1-guoren@kernel.org>
References: <20230324071239.151677-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The commit 0cac21b02ba5 ("riscv: use 16KB kernel stack on 64-bit")
increases the thread size mandatory, but some scenarios, such as D1 with
a small memory footprint, would suffer from that. After independent irq
stack support, let's give users a choice to determine their custom stack
size.

Link: https://lore.kernel.org/linux-riscv/5f6e6c39-b846-4392-b468-02202404de28@www.fastmail.com/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                   | 10 ++++++++++
 arch/riscv/include/asm/thread_info.h | 12 +-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7b10af7d2479..f58a8e37f1d5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -502,6 +502,16 @@ config IRQ_STACKS
 	  Add independent irq & softirq stacks for percpu to prevent kernel stack
 	  overflows. We may save some memory footprint by disabling IRQ_STACKS.
 
+config THREAD_SIZE_ORDER
+	int "Kernel stack size (in power-of-two numbers of page size)" if VMAP_STACK && EXPERT
+	range 0 4
+	default 1 if 32BIT && !KASAN
+	default 3 if 64BIT && KASAN
+	default 2
+	help
+	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
+	  affects irq stack size, which is equal to thread stack size.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index ab60593eed99..41556ee84290 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -11,18 +11,8 @@
 #include <asm/page.h>
 #include <linux/const.h>
 
-#ifdef CONFIG_KASAN
-#define KASAN_STACK_ORDER 1
-#else
-#define KASAN_STACK_ORDER 0
-#endif
-
 /* thread information allocation */
-#ifdef CONFIG_64BIT
-#define THREAD_SIZE_ORDER	(2 + KASAN_STACK_ORDER)
-#else
-#define THREAD_SIZE_ORDER	(1 + KASAN_STACK_ORDER)
-#endif
+#define THREAD_SIZE_ORDER	CONFIG_THREAD_SIZE_ORDER
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
 /*
-- 
2.36.1

