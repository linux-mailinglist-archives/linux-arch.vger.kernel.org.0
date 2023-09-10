Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DB4799D31
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 10:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjIJIbQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346538AbjIJIbO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 04:31:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377FF10D4;
        Sun, 10 Sep 2023 01:30:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C15C433D9;
        Sun, 10 Sep 2023 08:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694334650;
        bh=SoZvKFZXtbiskPhol9IbrrRdWVVYxE0tEnebIhQLYjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWrcngtzC02RvUnRT/XTeVpudmXjw3I1qeGhGggw3Iq9PSZxVJwmBblHZvCiFPaQc
         1tKRdtRI/VPiltgsxVs7id5SPtt+CGH6TLvl7trrg/AD0PmC+/gyiabYMAJuYYpaND
         BupmgNGxEAL3Lc/D+TS7Gxeacs2qGBGMSVfeIBlobhUCMbhKCmrLofJoAR27zMnAHD
         MgUMuDrZY7p1ouq9HWZmI1LZR1gbRvDph7p5rjaYpNWRv/hYXfTYZmE/0kcKcvJ96H
         qpbnT7fIx9lqxnOaeZ4XiPRWmmSK2nAc1C9FBmnpFD0BBm/Fk52hHbKi1xdE/YZIyg
         Wl35o60jfaamQ==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V11 07/17] riscv: qspinlock: Introduce qspinlock param for command line
Date:   Sun, 10 Sep 2023 04:29:01 -0400
Message-Id: <20230910082911.3378782-8-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230910082911.3378782-1-guoren@kernel.org>
References: <20230910082911.3378782-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Allow cmdline to force the kernel to use queued_spinlock when
CONFIG_RISCV_COMBO_SPINLOCKS=y.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/riscv/kernel/setup.c                       | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7dfb540c4f6c..61cacb8dfd0e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4693,6 +4693,8 @@
 			[KNL] Number of legacy pty's. Overwrites compiled-in
 			default number.
 
+	qspinlock	[RISCV] Force to use qspinlock or auto-detect spinlock.
+
 	qspinlock.numa_spinlock_threshold_ns=	[NUMA, PV_OPS]
 			Set the time threshold in nanoseconds for the
 			number of intra-node lock hand-offs before the
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index a447cf360a18..0f084f037651 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -270,6 +270,15 @@ static void __init parse_dtb(void)
 }
 
 #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
+bool enable_qspinlock_key = false;
+static int __init queued_spinlock_setup(char *p)
+{
+	enable_qspinlock_key = true;
+
+	return 0;
+}
+early_param("qspinlock", queued_spinlock_setup);
+
 DEFINE_STATIC_KEY_TRUE(combo_qspinlock_key);
 EXPORT_SYMBOL(combo_qspinlock_key);
 #endif
@@ -277,7 +286,12 @@ EXPORT_SYMBOL(combo_qspinlock_key);
 static void __init riscv_spinlock_init(void)
 {
 #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
-	static_branch_disable(&combo_qspinlock_key);
+	if (!enable_qspinlock_key) {
+		static_branch_disable(&combo_qspinlock_key);
+		pr_info("Ticket spinlock: enabled\n");
+	} else {
+		pr_info("Queued spinlock: enabled\n");
+	}
 #endif
 }
 
-- 
2.36.1

