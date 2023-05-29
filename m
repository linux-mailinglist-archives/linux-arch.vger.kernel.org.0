Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9106714681
	for <lists+linux-arch@lfdr.de>; Mon, 29 May 2023 10:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjE2Iqx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 May 2023 04:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjE2Iqw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2023 04:46:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20F110;
        Mon, 29 May 2023 01:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC7B76142D;
        Mon, 29 May 2023 08:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25966C433D2;
        Mon, 29 May 2023 08:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685349998;
        bh=pWzn7wo88vvYCHCgitlDzyBp4bmFmsyhuqUhKxMt8uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=go44EOeN3HCIMumIdRYVxxfdiB8ceIrb1h2GOkJGsvb0XgdX9T8j52X+WA4MaSTGk
         KCUxijiy+h9l8kehiVFSui4vuFOS581B1I2Rsp8nmclq2iIlsXTPFAha1hZNpn0E40
         jSxE3HMZMwQP/iEX9/UDvirq+GHhaaRQ3ZeV1bsr3ZLE3THWrlcCqWozTViAh7c2kL
         9WXWCtbPzruxihqEnH183ai0WN3av7oMCXQ3pvtZWzP6/Yvzi2Lpchw3IczTsxj8gB
         6F+gnPgNPA+PhXzcYxM48602eZkWqyPCr6HgWKn6WAodNs/RJdQ60HSRIrrLjZwJbu
         bMNixPzLjFo3g==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        bjorn@kernel.org, greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, paul.walmsley@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V12 3/3] riscv: stack: Add config of thread stack size
Date:   Mon, 29 May 2023 04:46:00 -0400
Message-Id: <20230529084600.2878130-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230529084600.2878130-1-guoren@kernel.org>
References: <20230529084600.2878130-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 9567bf5fd5ed..e82be82882fd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -597,6 +597,16 @@ config IRQ_STACKS
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
index 2f32875276b0..1833beb00489 100644
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

