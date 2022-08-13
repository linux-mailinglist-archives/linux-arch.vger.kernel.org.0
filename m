Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94792591980
	for <lists+linux-arch@lfdr.de>; Sat, 13 Aug 2022 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiHMJCv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Aug 2022 05:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJCu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Aug 2022 05:02:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1B111C3C;
        Sat, 13 Aug 2022 02:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0D90B81038;
        Sat, 13 Aug 2022 09:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC33C433C1;
        Sat, 13 Aug 2022 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660381367;
        bh=7e+kgiDyQchI7IpfFU7s3X+s8cbbMe7jVfntxFeG6MQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jJDCTHqWkCuMtmBQT9h4NXMhtKNslfQ6xRe7zU0Zzbf94eh7cya1UFZlS4hLlm0F2
         VUfbvyDRwV4eIRCWG6Ei20KFFOvJgDVYzP+dcfOFh0WS7KNqPCeRWG/LgoF/KKX5fB
         nHibwzTDP10mWv2vckVdN5fIYQUq7WnOyDWdlT9l9Be8APQ2oBiJJPAt2gtacr38NB
         T+TgLctblduU/UAmIFSwzlz+m0XHZAWdk77lhQe/oqfwjr6AHf8MxZ+5LJjt3ik5ie
         bSc4UJT7cLCW45lZ2uh8ksk/G8DboEFfwKR8V0y8vtR+JYPhzBVsLPZQtl+9+vujCe
         KJNfgoyCKTU6w==
From:   guoren@kernel.org
To:     chenhuacai@kernel.org, kernel@xen0n.name, zhangqing@loongson.cn,
        arnd@arndb.de, linux-arch@vger.kernel.org, mark.rutland@arm.com,
        frederic@kernel.org
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        jiaxun.yang@flygoat.com, yangtiezhu@loongson.cn,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [RESEND PATCH] loongarch: irq: Move to generic_handle_arch_irq
Date:   Sat, 13 Aug 2022 05:02:40 -0400
Message-Id: <20220813090240.60481-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

No reason to keep handle_loongarch_irq, and move to the generic one. The
patch also fixup HAVE_CONTEXT_TRACKING_USER feature because
handle_loongarch_irq missed ct_irq_enter/exit.

Fixes: 0603839b18f4 ("LoongArch: Add exception/interrupt handling")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/loongarch/kernel/traps.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index aa1c95aaf595..06211640ba1f 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -588,17 +588,6 @@ asmlinkage void cache_parity_error(void)
 	panic("Can't handle the cache error!");
 }
 
-asmlinkage void noinstr handle_loongarch_irq(struct pt_regs *regs)
-{
-	struct pt_regs *old_regs;
-
-	irq_enter_rcu();
-	old_regs = set_irq_regs(regs);
-	handle_arch_irq(regs);
-	set_irq_regs(old_regs);
-	irq_exit_rcu();
-}
-
 asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
 {
 	register int cpu;
@@ -608,7 +597,7 @@ asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
 	cpu = smp_processor_id();
 
 	if (on_irq_stack(cpu, sp))
-		handle_loongarch_irq(regs);
+		generic_handle_arch_irq(regs);
 	else {
 		stack = per_cpu(irq_stack, cpu) + IRQ_STACK_START;
 
@@ -619,7 +608,7 @@ asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
 		"move	$s0, $sp		\n" /* Preserve sp */
 		"move	$sp, %[stk]		\n" /* Switch stack */
 		"move	$a0, %[regs]		\n"
-		"bl	handle_loongarch_irq	\n"
+		"bl	generic_handle_arch_irq	\n"
 		"move	$sp, $s0		\n" /* Restore sp */
 		: /* No outputs */
 		: [stk] "r" (stack), [regs] "r" (regs)
-- 
2.36.1

