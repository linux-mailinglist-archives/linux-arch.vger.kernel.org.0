Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C565B1280
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 04:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiIHC1J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Sep 2022 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiIHC0S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Sep 2022 22:26:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94617D790;
        Wed,  7 Sep 2022 19:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7D30FCE1E5C;
        Thu,  8 Sep 2022 02:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B97AC43144;
        Thu,  8 Sep 2022 02:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662603972;
        bh=8Tzw/Kwo451JDguurnRXBTqnhiIZf0WJITLDKeAtvFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhT5s8kvvDpsphLtgApzIPqE6hBrZBriJ0zJqSucoJnY0Pt/75Yok5HTf+XYLeCC+
         9znWL8KN+HTg9fXQnGa6NeR54fe2S/dvSQKDBTBbUojmwCl/qdiWA4NLmWBoHC+l1d
         xIECepF0v2tRBdCsTVBJ+zOiJ8j6CpcGFim3KB9eDySw9v2fsbh7uZPfQ8Yzxx/YAI
         NbEZoy6X7HiTNN/UUnmZA4Qli0tJRjfFRT5Mn726MQr+namWq7H9O1s0gv5VsSDWTM
         wtBKS+/PPAElgHvPmSF+vxJyrfjzWqQ1R9GI1i6n41Ghtg+LYJGBz5UGxr1M7zU9GR
         4LLdtUOlRhElA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Andreas Schwab <schwab@suse.de>
Subject: [PATCH V4 8/8] riscv: Add config of thread stack size
Date:   Wed,  7 Sep 2022 22:25:06 -0400
Message-Id: <20220908022506.1275799-9-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220908022506.1275799-1-guoren@kernel.org>
References: <20220908022506.1275799-1-guoren@kernel.org>
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

0cac21b02ba5 ("risc v: use 16KB kernel stack on 64-bit") increase the
thread size mandatory, but some scenarios, such as D1 with a small
memory footprint, would suffer from that. After independent irq stack
support, let's give users a choice to determine their custom stack size.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Andreas Schwab <schwab@suse.de>
---
 arch/riscv/Kconfig                   | 9 +++++++++
 arch/riscv/include/asm/thread_info.h | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index da548ed7d107..e436b5793ab6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -442,6 +442,15 @@ config IRQ_STACKS
 	  Add independent irq & softirq stacks for percpu to prevent kernel stack
 	  overflows. We may save some memory footprint by disabling IRQ_STACKS.
 
+config THREAD_SIZE_ORDER
+	int "Pages of thread stack size (as a power of 2)"
+	range 1 4
+	default "1" if 32BIT
+	default "2" if 64BIT
+	help
+	  Specify the Pages of thread stack size (from 8KB to 64KB), which also
+	  affects irq stack size, which is equal to thread stack size.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 043da8ccc7e6..c64d995df6e1 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -19,9 +19,9 @@
 
 /* thread information allocation */
 #ifdef CONFIG_64BIT
-#define THREAD_SIZE_ORDER	(2 + KASAN_STACK_ORDER)
+#define THREAD_SIZE_ORDER	(CONFIG_THREAD_SIZE_ORDER + KASAN_STACK_ORDER)
 #else
-#define THREAD_SIZE_ORDER	(1 + KASAN_STACK_ORDER)
+#define THREAD_SIZE_ORDER	(CONFIG_THREAD_SIZE_ORDER + KASAN_STACK_ORDER)
 #endif
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
-- 
2.36.1

