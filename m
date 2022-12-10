Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D04648FEE
	for <lists+linux-arch@lfdr.de>; Sat, 10 Dec 2022 18:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLJRNs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Dec 2022 12:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiLJRNK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Dec 2022 12:13:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E008186C8;
        Sat, 10 Dec 2022 09:13:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3E03B808C7;
        Sat, 10 Dec 2022 17:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFB9C43396;
        Sat, 10 Dec 2022 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670692382;
        bh=omeDF8ywxGZ2tZfV8A15PC5eT0KOt0dg5z6qlDtCSIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDf1ZD6RmH08RRGkoFCzK2wzaK4f026RHn/elvkQZ6ETR11ZCp3SlJWSHGczjnfb1
         aEhxXUVjQlTsua1VBsfTUb/17sryYFJr+prbcxZr3jGfEAEsRXSNWpXA40W2QTHLun
         doVIASdvmvox3fdZDMz8JyEd1o0cPW2NiU22CnN7Y004AOgkfaSCWKhlbG+aU9RgTR
         g/ubIj3z6ARuTs5l1xep4qGrdIH7Fu7Sb/PVwOk1vmuYAd2mnJh0+gDARTEKk1Bw8N
         3NfpphRQIZSdI7dNZhB/YqgLJavqAABaaHevNtvMINoQf/67kDs37hxJ/LU8k1zj4Q
         LzFCUjydNYsgg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk,
        bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH -next V11 5/7] riscv: entry: Remove extra level wrappers of trace_hardirqs_{on,off}
Date:   Sat, 10 Dec 2022 12:11:39 -0500
Message-Id: <20221210171141.1120123-6-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221210171141.1120123-1-guoren@kernel.org>
References: <20221210171141.1120123-1-guoren@kernel.org>
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

From: Jisheng Zhang <jszhang@kernel.org>

Since riscv is converted to generic entry, there's no need for the
extra wrappers of trace_hardirqs_{on,off}.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/Makefile    |  2 --
 arch/riscv/kernel/trace_irq.c | 27 ---------------------------
 arch/riscv/kernel/trace_irq.h | 11 -----------
 3 files changed, 40 deletions(-)
 delete mode 100644 arch/riscv/kernel/trace_irq.c
 delete mode 100644 arch/riscv/kernel/trace_irq.h

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4cf303a779ab..392fa6e35d4a 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -68,8 +68,6 @@ obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
-obj-$(CONFIG_TRACE_IRQFLAGS)	+= trace_irq.o
-
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
diff --git a/arch/riscv/kernel/trace_irq.c b/arch/riscv/kernel/trace_irq.c
deleted file mode 100644
index 095ac976d7da..000000000000
--- a/arch/riscv/kernel/trace_irq.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2022 Changbin Du <changbin.du@gmail.com>
- */
-
-#include <linux/irqflags.h>
-#include <linux/kprobes.h>
-#include "trace_irq.h"
-
-/*
- * trace_hardirqs_on/off require the caller to setup frame pointer properly.
- * Otherwise, CALLER_ADDR1 might trigger an pagging exception in kernel.
- * Here we add one extra level so they can be safely called by low
- * level entry code which $fp is used for other purpose.
- */
-
-void __trace_hardirqs_on(void)
-{
-	trace_hardirqs_on();
-}
-NOKPROBE_SYMBOL(__trace_hardirqs_on);
-
-void __trace_hardirqs_off(void)
-{
-	trace_hardirqs_off();
-}
-NOKPROBE_SYMBOL(__trace_hardirqs_off);
diff --git a/arch/riscv/kernel/trace_irq.h b/arch/riscv/kernel/trace_irq.h
deleted file mode 100644
index 99fe67377e5e..000000000000
--- a/arch/riscv/kernel/trace_irq.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2022 Changbin Du <changbin.du@gmail.com>
- */
-#ifndef __TRACE_IRQ_H
-#define __TRACE_IRQ_H
-
-void __trace_hardirqs_on(void);
-void __trace_hardirqs_off(void);
-
-#endif /* __TRACE_IRQ_H */
-- 
2.36.1

