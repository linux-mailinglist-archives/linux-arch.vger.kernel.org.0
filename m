Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC0776D419
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 18:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjHBQtZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 12:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjHBQtT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 12:49:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D979C1706;
        Wed,  2 Aug 2023 09:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EAE161A17;
        Wed,  2 Aug 2023 16:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E672FC433C8;
        Wed,  2 Aug 2023 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690994956;
        bh=zXadGqM9fefJG2o17N1iiWReM7OXWmGr0IUdQMbdNag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDcnqDZRSZQ9uG7QJ0aVY5DisKCP515Eyzx7mvxzsL6P5Ul/fPNNvSb32twmSd8it
         qieRnrGYw7HOj5JqJemsIUZpitoct9zldeVgAPk7BGpFg0GqYqJrv50b/Z50HtqDUp
         XfHXw9O4jBEhAnsasVvlR0HBZpfDl0V9JUrXc6qihxYjkweOOXC8REcSnqv4d0waYU
         Ty7CSFAQ8X4j0hWebV+aGG0czYf6lnmYjfkJgXTCQOf2LMxmrFOHxHh5eICKrAlpgx
         5lH/Q2Jf841KXPYPQlDJkI+zB0CjAaKJphP5IvKA5WhjLlqlnxheOJQxLDirACCoiI
         aGGEYb4YF7f3w==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V10 06/19] riscv: qspinlock: Allow force qspinlock from the command line
Date:   Wed,  2 Aug 2023 12:46:48 -0400
Message-Id: <20230802164701.192791-7-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230802164701.192791-1-guoren@kernel.org>
References: <20230802164701.192791-1-guoren@kernel.org>
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

From: Guo Ren <guoren@linux.alibaba.com>

Allow cmdline to force the kernel to use queued_spinlock when
CONFIG_RISCV_COMBO_SPINLOCKS=y.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/riscv/include/asm/cpufeature.h             |  2 ++
 arch/riscv/kernel/cpufeature.c                  | 15 ++++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index be40bfbf4380..de6b7ee752cd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4666,6 +4666,9 @@
 
 	quiet		[KNL] Disable most log messages
 
+	qspinlock	[RISCV] Forces kernel to use queued_spinlock when
+			CONFIG_RISCV_COMBO_SPINLOCKS=y.
+
 	r128=		[HW,DRM]
 
 	radix_hcall_invalidate=on  [PPC/PSERIES]
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 23fed53b8815..2bf0343661da 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -30,4 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
+extern bool force_qspinlock;
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index e65b0e54152d..f8dbbe1bbd34 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -99,6 +99,17 @@ static bool riscv_isa_extension_check(int id)
 	return true;
 }
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+bool force_qspinlock = false;
+static int __init force_queued_spinlock(char *p)
+{
+	force_qspinlock = true;
+	pr_info("Force kernel to use queued_spinlock");
+	return 0;
+}
+early_param("qspinlock", force_queued_spinlock);
+#endif
+
 void __init riscv_fill_hwcap(void)
 {
 	struct device_node *node;
@@ -331,7 +342,9 @@ void __init riscv_fill_hwcap(void)
 		 * spinlock value, the only way is to change from queued_spinlock to
 		 * ticket_spinlock, but can not be vice.
 		 */
-		set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa);
+		if (!force_qspinlock) {
+			set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa);
+		}
 #endif
 
 		/*
-- 
2.36.1

