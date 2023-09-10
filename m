Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBE1799D41
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 10:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbjIJIb4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 04:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjIJIb4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 04:31:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8890210F0;
        Sun, 10 Sep 2023 01:31:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBB0C433C9;
        Sun, 10 Sep 2023 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694334674;
        bh=CGbBQmlOMiU7KGhDaeYsvrtFbv9g7V9LknoZMK3XHU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCThd1tl2tykwK3eWiOPcnl54BI9mVFr+fDdyPCbtkpojBfLGMNDVVulF+O6+y3Pi
         a/UIQXm6F1pkP4NTkDdtFmtqHJEsWvz5qlSRaCi2ob3CwxdJ0TPGEv5BwpjtiBYtS/
         jXoIh671CI4UCjavdWqPK7z0oStaNzKhs2ySCztbPt71JH0S3floPylQ/ivZig0W33
         Rdvp+sXwCArfgZs//eEHJXowarZ1IiymCnXkKcPRHZNHK7i8s41ifWjY75cn6/TtSQ
         D+wgz/sZ9onk7/9mZcLYezW6yZUq7AhbIk6O289NricZFW75KXAEkEL37X8H+2t8iF
         SsPZ6CdUG0yJw==
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
Subject: [PATCH V11 11/17] RISC-V: paravirt: pvqspinlock: Add paravirt qspinlock skeleton
Date:   Sun, 10 Sep 2023 04:29:05 -0400
Message-Id: <20230910082911.3378782-12-guoren@kernel.org>
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

Using static_call to switch between:
  native_queued_spin_lock_slowpath()    __pv_queued_spin_lock_slowpath()
  native_queued_spin_unlock()           __pv_queued_spin_unlock()

Finish the pv_wait implementation, but pv_kick needs the SBI
definition of the next patches.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/Kbuild               |  1 -
 arch/riscv/include/asm/qspinlock.h          | 35 +++++++++++++
 arch/riscv/include/asm/qspinlock_paravirt.h | 29 +++++++++++
 arch/riscv/include/asm/spinlock.h           |  2 +-
 arch/riscv/kernel/qspinlock_paravirt.c      | 57 +++++++++++++++++++++
 arch/riscv/kernel/setup.c                   |  4 ++
 6 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/qspinlock.h
 create mode 100644 arch/riscv/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/riscv/kernel/qspinlock_paravirt.c

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index a0dc85e4a754..b89cb3b73c13 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -7,6 +7,5 @@ generic-y += parport.h
 generic-y += spinlock_types.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
-generic-y += qspinlock.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/riscv/include/asm/qspinlock.h b/arch/riscv/include/asm/qspinlock.h
new file mode 100644
index 000000000000..7d4f416c908c
--- /dev/null
+++ b/arch/riscv/include/asm/qspinlock.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c), 2023 Alibaba Cloud
+ * Authors:
+ *	Guo Ren <guoren@linux.alibaba.com>
+ */
+
+#ifndef _ASM_RISCV_QSPINLOCK_H
+#define _ASM_RISCV_QSPINLOCK_H
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#include <asm/qspinlock_paravirt.h>
+
+/* How long a lock should spin before we consider blocking */
+#define SPIN_THRESHOLD		(1 << 15)
+
+void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+void __pv_init_lock_hash(void);
+void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	static_call(pv_queued_spin_lock_slowpath)(lock, val);
+}
+
+#define queued_spin_unlock	queued_spin_unlock
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	static_call(pv_queued_spin_unlock)(lock);
+}
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
+
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_RISCV_QSPINLOCK_H */
diff --git a/arch/riscv/include/asm/qspinlock_paravirt.h b/arch/riscv/include/asm/qspinlock_paravirt.h
new file mode 100644
index 000000000000..9681e851f69d
--- /dev/null
+++ b/arch/riscv/include/asm/qspinlock_paravirt.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c), 2023 Alibaba Cloud
+ * Authors:
+ *	Guo Ren <guoren@linux.alibaba.com>
+ */
+
+#ifndef _ASM_RISCV_QSPINLOCK_PARAVIRT_H
+#define _ASM_RISCV_QSPINLOCK_PARAVIRT_H
+
+void pv_wait(u8 *ptr, u8 val);
+void pv_kick(int cpu);
+
+void dummy_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+void dummy_queued_spin_unlock(struct qspinlock *lock);
+
+DECLARE_STATIC_CALL(pv_queued_spin_lock_slowpath, dummy_queued_spin_lock_slowpath);
+DECLARE_STATIC_CALL(pv_queued_spin_unlock, dummy_queued_spin_unlock);
+
+void __init pv_qspinlock_init(void);
+
+static inline bool pv_is_native_spin_unlock(void)
+{
+	return false;
+}
+
+void __pv_queued_spin_unlock(struct qspinlock *lock);
+
+#endif /* _ASM_RISCV_QSPINLOCK_PARAVIRT_H */
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index 6b38d6616f14..ed4253f491fe 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -39,7 +39,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
 #undef arch_spin_trylock
 #undef arch_spin_unlock
 
-#include <asm-generic/qspinlock.h>
+#include <asm/qspinlock.h>
 #include <linux/jump_label.h>
 
 #undef arch_spin_is_locked
diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/qspinlock_paravirt.c
new file mode 100644
index 000000000000..85ff5a3ec234
--- /dev/null
+++ b/arch/riscv/kernel/qspinlock_paravirt.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c), 2023 Alibaba Cloud
+ * Authors:
+ *	Guo Ren <guoren@linux.alibaba.com>
+ */
+
+#include <linux/static_call.h>
+#include <asm/qspinlock_paravirt.h>
+#include <asm/sbi.h>
+
+void pv_kick(int cpu)
+{
+	return;
+}
+
+void pv_wait(u8 *ptr, u8 val)
+{
+	unsigned long flags;
+
+	if (in_nmi())
+		return;
+
+	local_irq_save(flags);
+	if (READ_ONCE(*ptr) != val)
+		goto out;
+
+	/* wait_for_interrupt(); */
+out:
+	local_irq_restore(flags);
+}
+
+static void native_queued_spin_unlock(struct qspinlock *lock)
+{
+	smp_store_release(&lock->locked, 0);
+}
+
+DEFINE_STATIC_CALL(pv_queued_spin_lock_slowpath, native_queued_spin_lock_slowpath);
+EXPORT_STATIC_CALL(pv_queued_spin_lock_slowpath);
+
+DEFINE_STATIC_CALL(pv_queued_spin_unlock, native_queued_spin_unlock);
+EXPORT_STATIC_CALL(pv_queued_spin_unlock);
+
+void __init pv_qspinlock_init(void)
+{
+	if (num_possible_cpus() == 1)
+		return;
+
+	if(sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)
+		return;
+
+	pr_info("PV qspinlocks enabled\n");
+	__pv_init_lock_hash();
+
+	static_call_update(pv_queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
+	static_call_update(pv_queued_spin_unlock, __pv_queued_spin_unlock);
+}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index c57d15b05160..88690751f2ee 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -321,6 +321,10 @@ static void __init riscv_spinlock_init(void)
 #ifdef CONFIG_QUEUED_SPINLOCKS
 	virt_spin_lock_init();
 #endif
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+	pv_qspinlock_init();
+#endif
 }
 
 extern void __init init_rt_signal_env(void);
-- 
2.36.1

