Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEF8754FEE
	for <lists+linux-arch@lfdr.de>; Sun, 16 Jul 2023 19:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjGPRBA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Jul 2023 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGPRBA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Jul 2023 13:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E661B1;
        Sun, 16 Jul 2023 10:00:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D294360C63;
        Sun, 16 Jul 2023 17:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E623C433C8;
        Sun, 16 Jul 2023 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689526858;
        bh=sO+ETVQWwYmOPn5mUIbEvZ8OhqTGaw4+3C16oa1rjoY=;
        h=From:To:Cc:Subject:Date:From;
        b=D9WTZ//zIycNG2Zu7PGosYaEot35CiRW0/6tu5BYDDX0BJiybw2teSY/UupPPP3O4
         F13Qqp0KRsPkUJ8YIGJsPnS9J967sf9o4YNeKD9fbDPMCNMqw27Uh+cMmIRvXSK0tY
         cCQ9R2a5H54xVQZWGvw7d5xl8Y+0DuXvB2RoyETmpCI6CJa5sWsfK3GebTvZyQYmtZ
         gglw5j6oZj1Q+3j7oCdAvKBZIPpmAn9obwu8mFK8KjDsKAoNl9wuDttRXJRSMKmUfh
         aW6tJI6+c3xqYi/EK3YdJErbBKinpfXloKd2jBlbsLXHp7TwBToQvoBjfhtWokgeCS
         PmW8po/y6zc4w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2] riscv: support PREEMPT_DYNAMIC with static keys
Date:   Mon, 17 Jul 2023 00:49:25 +0800
Message-Id: <20230716164925.1858-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
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
since v1:
 - keep Kconfig entries sorted
 - group asm-generic modifications under CONFIG_PREEMPT_DYNAMIC &&
   CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)

 arch/riscv/Kconfig            |  1 +
 include/asm-generic/preempt.h | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..686df6902947 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -130,6 +130,7 @@ config RISCV
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select HAVE_PREEMPT_DYNAMIC_KEY if !XIP_KERNEL
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_RSEQ
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index b4d43a4af5f7..51f8f3881523 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -80,9 +80,21 @@ static __always_inline bool should_resched(int preempt_offset)
 
 #ifdef CONFIG_PREEMPTION
 extern asmlinkage void preempt_schedule(void);
-#define __preempt_schedule() preempt_schedule()
 extern asmlinkage void preempt_schedule_notrace(void);
+
+#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+
+void dynamic_preempt_schedule(void);
+void dynamic_preempt_schedule_notrace(void);
+#define __preempt_schedule()		dynamic_preempt_schedule()
+#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
+
+#else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
+
+#define __preempt_schedule() preempt_schedule()
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
+
+#endif /* CONFIG_PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
 #endif /* CONFIG_PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
-- 
2.40.1

