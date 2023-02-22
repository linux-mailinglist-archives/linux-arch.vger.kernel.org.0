Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2FB69ED81
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 04:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjBVDcE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 22:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjBVDcA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 22:32:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F083B34F40;
        Tue, 21 Feb 2023 19:31:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60335B811CF;
        Wed, 22 Feb 2023 03:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31E8C433A7;
        Wed, 22 Feb 2023 03:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677036683;
        bh=ibXELA1fPqv+k0h/D45FA6m8vJh/UThmM0vYia8LTnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpd8vPuP2kNQY7MGDFINcyFS06S0mbaUlzJunre3i5vMxxfstwI0KepZ1+IiNv/qf
         bpWXnjVXoz9U691vLpaCjFrVdPSn1lTfzWxaLmMSUfp4hH3s8t/TTZ/LYUANQgtBw5
         X4AVV2rvvHTmKkrF61I4wVuICV5S7iHoJCfoKG7DNt5x6AiDjSiQxxokYufmgkdcgf
         T9ikETwgNuiUPZnrMW8GTZcHHAfeSaHYWV+I0fn1s4Az7jL4nHXxMOwzSPfuZ2GToJ
         d9gekZ8RHgoqFj0zbkEjPEWmI5jbv9OUX7GDxDuybzEyC+/mPP0PA7LoCnXqHt1tHj
         4lYpUVRirl00Q==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org,
        palmer@dabbelt.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH -next V17 5/7] riscv: entry: Remove extra level wrappers of trace_hardirqs_{on,off}
Date:   Tue, 21 Feb 2023 22:30:19 -0500
Message-Id: <20230222033021.983168-6-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230222033021.983168-1-guoren@kernel.org>
References: <20230222033021.983168-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
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

