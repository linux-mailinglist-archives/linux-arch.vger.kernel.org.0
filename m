Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10274C1E5
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jul 2023 12:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjGIK20 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jul 2023 06:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGIK2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2023 06:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D1C12A;
        Sun,  9 Jul 2023 03:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD09060BBE;
        Sun,  9 Jul 2023 10:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD141C433C8;
        Sun,  9 Jul 2023 10:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688898503;
        bh=3sPwX4GVTHH+apYt2dKBk43WvXcfJBHi7r9smnLvACE=;
        h=From:To:Cc:Subject:Date:From;
        b=lYtFlNfTAA3tzzCsF5XPl5cdaF4pDoSIR4OXiGBZwf1uVoC0y/782/ax77YFkq+dx
         HneYNDBK60xClp0GRzi2efpbIArOF+5gCm81Hp4PVvQiE9EUotpox3RlJhp1e6MCqS
         7G+2zA5VaMB0WO4sfXCbHViLzpvPhFWmDLeDSCCYu0iee/Zo2WuAbjhDrKZZRuQN72
         AL1dr44g8+MKXM8LvXjAoCdiwgZLjt7sT3ezMhkX4oX6Ahkbz0lnyAqhqTaw5ALV9Z
         Vxm6gqbMi3NBaEY6rF7/4wmzaI+VxTWoJklhOsH922ffrHGk0JZldKIn0gm6OXNlCx
         HzQJNAG5kA61g==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH] riscv: support PREEMPT_DYNAMIC with static keys
Date:   Sun,  9 Jul 2023 18:16:53 +0800
Message-Id: <20230709101653.720-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, each architecture can support PREEMPT_DYNAMIC through
either static calls or static keys. To support PREEMPT_DYNAMIC on
riscv, we face three choices:

1. only add static calls support to riscv
As Mark pointed out in commit 99cf983cc8bc ("sched/preempt: Add
PREEMPT_DYNAMIC using static keys"), static keys "...should have
slightly lower overhead than non-inline static calls, as this
effectively inlines each trampoline into the start of its callee. This
may avoid redundant work, and may integrate better with CFI schemes."
So even we add static calls(without inline static calls) to riscv,
static keys is still a better choice.

2. add static calls and inline static calls to riscv
Per my understanding, inline static calls requires objtool support
which is not easy.

3. use static keys

While riscv doesn't have static calls support, it supports static keys
perfectly. So this patch selects HAVE_PREEMPT_DYNAMIC_KEY to enable
support for PREEMPT_DYNAMIC on riscv, so that the preemption model can
be chosen at boot time. It also patches asm-generic/preempt.h, mainly
to add __preempt_schedule() and __preempt_schedule_notrace() macros
for PREEMPT_DYNAMIC case. Other architectures which use generic
preempt.h can also benefit from this patch by simply selecting
HAVE_PREEMPT_DYNAMIC_KEY to enable PREEMPT_DYNAMIC if they supports
static keys.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig            |  1 +
 include/asm-generic/preempt.h | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..bdea2e5a9f34 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -129,6 +129,7 @@ config RISCV
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_DYNAMIC_KEY if !XIP_KERNEL
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index b4d43a4af5f7..1f476aec7e4c 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -80,9 +80,21 @@ static __always_inline bool should_resched(int preempt_offset)
 
 #ifdef CONFIG_PREEMPTION
 extern asmlinkage void preempt_schedule(void);
-#define __preempt_schedule() preempt_schedule()
 extern asmlinkage void preempt_schedule_notrace(void);
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+void dynamic_preempt_schedule(void);
+void dynamic_preempt_schedule_notrace(void);
+#define __preempt_schedule()		dynamic_preempt_schedule()
+#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
+
+#else /* CONFIG_PREEMPT_DYNAMIC */
+
+#define __preempt_schedule() preempt_schedule()
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 #endif /* CONFIG_PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
-- 
2.40.1

