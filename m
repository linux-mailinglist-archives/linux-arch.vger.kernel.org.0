Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE276D462
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjHBQxw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 12:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHBQx0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 12:53:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575FE3C34;
        Wed,  2 Aug 2023 09:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45269619CB;
        Wed,  2 Aug 2023 16:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DBBC433C7;
        Wed,  2 Aug 2023 16:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995166;
        bh=qLA1GcmlLqlS/G9GD0l2jo6tFZm2YFKYDFEvmq8fWH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JbRaMX5uUEpDntEj6CsADqaoo1o4xqrMsuZKpnZpuW5guztpTHECFifz6plIF2Cu1
         pAwRR3jKsuDGKUrKsJxrpPlwr62BM3MwxqtvFJHl6JAgVCy/PTe8vVbCP/v/thApXy
         SJEhn0XoAeXpAmovhqc4Gqxz6e/FvjMsSg1F9G3/e8C3Tz+3zFH67PmNy9Hs2iz1AX
         HuV0tdgWXi+sqV+Pf53/SuZXZdsE+0uuZbRCaIzwmjSCDMV9miPlEDcM3GfjH8Cj6v
         MoA6RM5MjLl4wlZDm2DxW7Y6GONu+AlThJhHsvT6rBGHa0YSTPiYOmT7lthvsH9tu0
         oa46fefL6iKdg==
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
Subject: [PATCH V10 19/19] locking/qspinlock: riscv: Add Compact NUMA-aware lock support
Date:   Wed,  2 Aug 2023 12:47:01 -0400
Message-Id: <20230802164701.192791-20-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230802164701.192791-1-guoren@kernel.org>
References: <20230802164701.192791-1-guoren@kernel.org>
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

Connect riscv to Compact NUMA-aware lock (CNA), which uses
PRARAVIRT_SPINLOCKS static_call hooks. See numa_spinlock= of
Documentation/admin-guide/kernel-parameters.txt for trying.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                 | 18 ++++++++++++++++++
 arch/riscv/include/asm/qspinlock.h |  5 +++++
 arch/riscv/kernel/paravirt.c       | 12 +++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 13f345b54581..ff483ccd26b9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -800,6 +800,24 @@ config PARAVIRT_SPINLOCKS
 
 	  If you are unsure how to answer this question, answer Y.
 
+config NUMA_AWARE_SPINLOCKS
+	bool "Numa-aware spinlocks"
+	depends on NUMA
+	depends on QUEUED_SPINLOCKS
+	depends on 64BIT
+	# For now, we depend on PARAVIRT_SPINLOCKS to make the patching work.
+	depends on PARAVIRT_SPINLOCKS
+	default y
+	help
+	  Introduce NUMA (Non Uniform Memory Access) awareness into
+	  the slow path of spinlocks.
+
+	  In this variant of qspinlock, the kernel will try to keep the lock
+	  on the same node, thus reducing the number of remote cache misses,
+	  while trading some of the short term fairness for better performance.
+
+	  Say N if you want absolute first come first serve fairness.
+
 endmenu # "Kernel features"
 
 menu "Boot options"
diff --git a/arch/riscv/include/asm/qspinlock.h b/arch/riscv/include/asm/qspinlock.h
index 003e9560a0d1..e6f2a0621af0 100644
--- a/arch/riscv/include/asm/qspinlock.h
+++ b/arch/riscv/include/asm/qspinlock.h
@@ -12,6 +12,11 @@ void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 void __pv_init_lock_hash(void);
 void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 
+#ifdef CONFIG_NUMA_AWARE_SPINLOCKS
+bool cna_configure_spin_lock_slowpath(void);
+void __cna_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+#endif
+
 static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	static_call(pv_queued_spin_lock_slowpath)(lock, val);
diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
index cc80e968ab13..9466f693a98c 100644
--- a/arch/riscv/kernel/paravirt.c
+++ b/arch/riscv/kernel/paravirt.c
@@ -193,8 +193,10 @@ void __init pv_qspinlock_init(void)
 	if (num_possible_cpus() == 1)
 		return;
 
-	if(sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)
+	if(sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM) {
+		goto cna_qspinlock;
 		return;
+	}
 
 	if (!sbi_probe_extension(SBI_EXT_PVLOCK))
 		return;
@@ -204,5 +206,13 @@ void __init pv_qspinlock_init(void)
 
 	static_call_update(pv_queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
 	static_call_update(pv_queued_spin_unlock, __pv_queued_spin_unlock);
+	return;
+
+cna_qspinlock:
+#ifdef CONFIG_NUMA_AWARE_SPINLOCKS
+	if (cna_configure_spin_lock_slowpath())
+		static_call_update(pv_queued_spin_lock_slowpath,
+					__cna_queued_spin_lock_slowpath);
+#endif
 }
 #endif
-- 
2.36.1

