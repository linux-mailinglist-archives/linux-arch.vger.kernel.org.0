Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA405FF9EE
	for <lists+linux-arch@lfdr.de>; Sat, 15 Oct 2022 13:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJOLwK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Oct 2022 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJOLve (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2022 07:51:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B540481DE;
        Sat, 15 Oct 2022 04:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8758BB803F1;
        Sat, 15 Oct 2022 11:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F6BC433D6;
        Sat, 15 Oct 2022 11:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665834678;
        bh=TxUjoHq4rCqfK0kNHzvh6xhZsPO6l0oQ3VoILpocI+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivRt3FF2vJOnX815vISDKIYI9RuzvRdtpwgrhm6QsjX0vuCqvs0w99kPZzfLraTA+
         6GHrYAqo+JcINqQUHzKwAEEKZ9xO+mgmhbaFEB/lgfGHqbVxGcFNAkCoz7pWtfxzxw
         7tPg/4XW/YXny2Uxz02xG+vICFKIYPqzzT8XCvEpdnVNOsLErDWQVHSQNtWzCsajQE
         heAfZehJLOJIxY8409E9iC7dmjW6tJ+Azayz++fZACnKjWGqnu4lKmgOuXG2IP3ad8
         zTLQk6HnU6qC0ekEHDK60opsftgwkRhl8rbygJR+XLu7UpDPfrhWFqBAIrfqGvV6Go
         O2mr8oIPCdORQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Andreas Schwab <schwab@suse.de>
Subject: [PATCH V7 10/12] riscv: Add config of thread stack size
Date:   Sat, 15 Oct 2022 07:47:00 -0400
Message-Id: <20221015114702.3489989-11-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221015114702.3489989-1-guoren@kernel.org>
References: <20221015114702.3489989-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/riscv/Kconfig                   | 10 ++++++++++
 arch/riscv/include/asm/thread_info.h | 12 +-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7476ce9c72d5..2b72541f87b1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -453,6 +453,16 @@ config IRQ_STACKS
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
index 043da8ccc7e6..c970d41dc4c6 100644
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

