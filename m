Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39F5ADE41
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 05:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiIFD4s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 23:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiIFDzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 23:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D27222AE;
        Mon,  5 Sep 2022 20:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD2761283;
        Tue,  6 Sep 2022 03:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C4EC43141;
        Tue,  6 Sep 2022 03:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662436524;
        bh=8Tzw/Kwo451JDguurnRXBTqnhiIZf0WJITLDKeAtvFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8eSEaII7FXw5gkzT8e3DX9whA4K3F2vb5Ubk0R7po4+q+dLQg9FmNCZOmT+XxmmM
         PdNGldoPuSHbrtUYVP5P8qBKdkoq+yD0YCmNofz/l1zeD9c4IeR3RPEubRmRWqmlS+
         n7KBTAHhQqMGnxSj9SAPCr3g1ZtkPS6w7HwOGokDrJWgM8QYtp0Eg3UrnqtYjcTpWx
         iMJq8cnzGOehiwrIATnxVyCDRVz4L/pYRjIoQ4A56WXAobQRoLEkEaK7pzt5YCOfqo
         erbVWRpcG/pGSJHFkiIJqMG5bkDpM14IbuoZt+tRoBtQj/TqeWJRnlMtdMeVtDr6et
         XLSCc1RVHQCzA==
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
Subject: [PATCH V3 7/7] riscv: Add config of thread stack size
Date:   Mon,  5 Sep 2022 23:54:23 -0400
Message-Id: <20220906035423.634617-8-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220906035423.634617-1-guoren@kernel.org>
References: <20220906035423.634617-1-guoren@kernel.org>
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

