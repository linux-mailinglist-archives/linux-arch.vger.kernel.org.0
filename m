Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFB4799D35
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 10:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbjIJIbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 04:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjIJIbX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 04:31:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BA110FB;
        Sun, 10 Sep 2023 01:30:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D41C433C8;
        Sun, 10 Sep 2023 08:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694334656;
        bh=b/96e8ctDdPWQM+BjwYA3uNNS7hx8TS7HxYP5gGaMAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fm0Let9OCBGIoNmVO+tWV2aF3bPlay5iI8Eg7PyWvfi7GFcR5h1ddebm76ADuzdV7
         zlubzUhzZnN7ilI1SHCW7LnbefedHejQCfbyv+YDibAe25M1WWhJ9HM9Ygu0MKgpjg
         PKSfW55K9A1jzU6xGL6jPhfzwTc9IUt0MaV2II6TtCd7IS6usoMlN/ZAWvixkzjOtq
         rNv5W9HtexkqJSf7hSzpCXV6D7KKxWjve2+8hp9N0bAmWZ4eg3LOdV9hAVxEpYjXJq
         ERqn1H+ZIRbtVR34pV7D++ZQWT9jRN0vpbpKgjQ8Vr9eBPWd1mHOtDfm7kL9MJO2mb
         D2Tzp6TLhUQkg==
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
Subject: [PATCH V11 08/17] riscv: qspinlock: Add virt_spin_lock() support for KVM guest
Date:   Sun, 10 Sep 2023 04:29:02 -0400
Message-Id: <20230910082911.3378782-9-guoren@kernel.org>
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

Add a static key controlling whether virt_spin_lock() should be
called or not. When running on bare metal set the new key to
false.

The KVM guests fall back to a Test-and-Set spinlock, because fair
locks have horrible lock 'holder' preemption issues. The
virt_spin_lock_key would shortcut for the
queued_spin_lock_slowpath() function that allow virt_spin_lock to
hijack it.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 arch/riscv/include/asm/sbi.h                  |  8 +++++
 arch/riscv/include/asm/spinlock.h             | 22 ++++++++++++++
 arch/riscv/kernel/sbi.c                       |  2 +-
 arch/riscv/kernel/setup.c                     | 30 ++++++++++++++++++-
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 61cacb8dfd0e..f75bedc50e00 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3927,6 +3927,10 @@
 	no_uaccess_flush
 	                [PPC] Don't flush the L1-D cache after accessing user data.
 
+	no_virt_spin	[RISC-V] Disable virt_spin_lock in KVM guest to use
+			native_queued_spinlock when the nopvspin option is enabled.
+			This would help vcpu=pcpu scenarios.
+
 	novmcoredd	[KNL,KDUMP]
 			Disable device dump. Device dump allows drivers to
 			append dump data to vmcore so you can collect driver
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 501e06e52078..e0233b3d7a5f 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -50,6 +50,13 @@ enum sbi_ext_base_fid {
 	SBI_EXT_BASE_GET_MIMPID,
 };
 
+enum sbi_ext_base_impl_id {
+	SBI_EXT_BASE_IMPL_ID_BBL = 0,
+	SBI_EXT_BASE_IMPL_ID_OPENSBI,
+	SBI_EXT_BASE_IMPL_ID_XVISOR,
+	SBI_EXT_BASE_IMPL_ID_KVM,
+};
+
 enum sbi_ext_time_fid {
 	SBI_EXT_TIME_SET_TIMER = 0,
 };
@@ -269,6 +276,7 @@ int sbi_console_getchar(void);
 long sbi_get_mvendorid(void);
 long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
+long sbi_get_firmware_id(void);
 void sbi_set_timer(uint64_t stime_value);
 void sbi_shutdown(void);
 void sbi_send_ipi(unsigned int cpu);
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index 8ea0fee80652..6b38d6616f14 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -4,6 +4,28 @@
 #define __ASM_RISCV_SPINLOCK_H
 
 #ifdef CONFIG_QUEUED_SPINLOCKS
+/*
+ * The KVM guests fall back to a Test-and-Set spinlock, because fair locks
+ * have horrible lock 'holder' preemption issues. The virt_spin_lock_key
+ * would shortcut for the queued_spin_lock_slowpath() function that allow
+ * virt_spin_lock to hijack it.
+ */
+DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
+
+#define virt_spin_lock virt_spin_lock
+static inline bool virt_spin_lock(struct qspinlock *lock)
+{
+	if (!static_branch_likely(&virt_spin_lock_key))
+		return false;
+
+	do {
+		while (atomic_read(&lock->val) != 0)
+			cpu_relax();
+	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
+
+	return true;
+}
+
 #define _Q_PENDING_LOOPS	(1 << 9)
 #endif
 
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 88eea3a99ee0..cdd45edc8db4 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -555,7 +555,7 @@ static inline long sbi_get_spec_version(void)
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
 }
 
-static inline long sbi_get_firmware_id(void)
+long sbi_get_firmware_id(void)
 {
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_ID);
 }
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 0f084f037651..c57d15b05160 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -26,6 +26,7 @@
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/cpufeature.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable.h>
 #include <asm/setup.h>
@@ -283,16 +284,43 @@ DEFINE_STATIC_KEY_TRUE(combo_qspinlock_key);
 EXPORT_SYMBOL(combo_qspinlock_key);
 #endif
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+static bool no_virt_spin_key = false;
+DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
+
+static int __init no_virt_spin_setup(char *p)
+{
+	no_virt_spin_key = true;
+
+	return 0;
+}
+early_param("no_virt_spin", no_virt_spin_setup);
+
+static void __init virt_spin_lock_init(void)
+{
+	if (sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM ||
+	    no_virt_spin_key)
+		static_branch_disable(&virt_spin_lock_key);
+	else
+		pr_info("Enable virt_spin_lock\n");
+}
+#endif
+
 static void __init riscv_spinlock_init(void)
 {
 #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
-	if (!enable_qspinlock_key) {
+	if (!enable_qspinlock_key &&
+	    (sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)) {
 		static_branch_disable(&combo_qspinlock_key);
 		pr_info("Ticket spinlock: enabled\n");
 	} else {
 		pr_info("Queued spinlock: enabled\n");
 	}
 #endif
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
+	virt_spin_lock_init();
+#endif
 }
 
 extern void __init init_rt_signal_env(void);
-- 
2.36.1

