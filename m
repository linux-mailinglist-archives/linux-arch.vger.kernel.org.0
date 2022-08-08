Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC99958C3D1
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 09:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiHHHPw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 03:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHHHPH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 03:15:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9093412605;
        Mon,  8 Aug 2022 00:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F516B80DCF;
        Mon,  8 Aug 2022 07:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AAFC4347C;
        Mon,  8 Aug 2022 07:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659942887;
        bh=SslN+97o/8qmyOuJZlGXnP7AnJZ3FRG2xQfQjrtJ2LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CG69qtZNcF3mL/S1wrqa9r5BjmaHJ/VCHxS560epiQFdTQc54EjGfA273we1XJp76
         auXMWdtz3AF0zhhO/4arAOOShDVMBsClvBZJ7GC+hmzm+EvFjNHrohYQwDf2+d8FLE
         mWPKCoB6Dn053BSkumSPVsjD950N1GlpTWbisoTjNA1NeMkqnF0DVRGoO6jNGWRlTj
         I/rDHxEIC7u/dP1VDx3l9OSryGNlATuJwLtyRbGwCuugxrg2IVbHQUMWeFxIWUOfZt
         GWWlFaXQuFI0PTZv8BVwbccuB3m4gRSDOElPOLP3DUGgM5pL/zn+lmKGcwGXReMyCt
         WCUUb57w6HSIA==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, shorne@gmail.com,
        conor.dooley@microchip.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V9 12/15] riscv: Add combo spinlock support
Date:   Mon,  8 Aug 2022 03:13:15 -0400
Message-Id: <20220808071318.3335746-13-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808071318.3335746-1-guoren@kernel.org>
References: <20220808071318.3335746-1-guoren@kernel.org>
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

Combo spinlock could support queued and ticket in one Linux Image and
select them during boot time with command line option. Here is the
func-size(Bytes) comparison table below:

TYPE			: COMBO | TICKET | QUEUED
arch_spin_lock		: 106	| 60     | 50
arch_spin_unlock	: 54    | 36     | 26
arch_spin_trylock	: 110   | 72     | 54
arch_spin_is_locked	: 48    | 34     | 20
arch_spin_is_contended	: 56    | 40     | 24
rch_spin_value_unlocked	: 48    | 34     | 24

One example of disassemble combo arch_spin_unlock:
   0xffffffff8000409c <+14>:    nop # jump label slot
   0xffffffff800040a0 <+18>:    fence   rw,w # queued spinlock start
   0xffffffff800040a4 <+22>:    sb      zero,0(a4) # queued spinlock end
   0xffffffff800040a8 <+26>:    ld      s0,8(sp)
   0xffffffff800040aa <+28>:    addi    sp,sp,16
   0xffffffff800040ac <+30>:    ret
   0xffffffff800040ae <+32>:    lw      a5,0(a4) # ticket spinlock start
   0xffffffff800040b0 <+34>:    sext.w  a5,a5
   0xffffffff800040b2 <+36>:    fence   rw,w
   0xffffffff800040b6 <+40>:    addiw   a5,a5,1
   0xffffffff800040b8 <+42>:    slli    a5,a5,0x30
   0xffffffff800040ba <+44>:    srli    a5,a5,0x30
   0xffffffff800040bc <+46>:    sh      a5,0(a4) # ticket spinlock end
   0xffffffff800040c0 <+50>:    ld      s0,8(sp)
   0xffffffff800040c2 <+52>:    addi    sp,sp,16
   0xffffffff800040c4 <+54>:    ret

The qspinlock is smaller and faster than ticket-lock when all is in
fast-path, and combo spinlock could provide a compatible Linux Image for
different micro-arch design (weak/strict fwd guarantee) processors.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                |  9 +++-
 arch/riscv/include/asm/Kbuild     |  1 -
 arch/riscv/include/asm/spinlock.h | 77 +++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c         | 22 +++++++++
 4 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/spinlock.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8b36a4307d03..6645f04c7da4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -361,7 +361,7 @@ config NODES_SHIFT
 
 choice
 	prompt "RISC-V spinlock type"
-	default RISCV_TICKET_SPINLOCKS
+	default RISCV_COMBO_SPINLOCKS
 
 config RISCV_TICKET_SPINLOCKS
 	bool "Using ticket spinlock"
@@ -373,6 +373,13 @@ config RISCV_QUEUED_SPINLOCKS
 	help
 	  Make sure your micro arch LL/SC has a strong forward progress guarantee.
 	  Otherwise, stay at ticket-lock.
+
+config RISCV_COMBO_SPINLOCKS
+	bool "Using combo spinlock"
+	depends on SMP && MMU
+	select ARCH_USE_QUEUED_SPINLOCKS
+	help
+	  Select queued spinlock or ticket-lock with jump_label.
 endchoice
 
 config RISCV_ALTERNATIVE
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 2cce98c7b653..59d5ea7390ea 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -5,7 +5,6 @@ generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += qspinlock.h
-generic-y += spinlock.h
 generic-y += spinlock_types.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
new file mode 100644
index 000000000000..b079462d818b
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_RISCV_SPINLOCK_H
+#define __ASM_RISCV_SPINLOCK_H
+
+#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
+#include <asm-generic/ticket_spinlock.h>
+
+#undef arch_spin_is_locked
+#undef arch_spin_is_contended
+#undef arch_spin_value_unlocked
+#undef arch_spin_lock
+#undef arch_spin_trylock
+#undef arch_spin_unlock
+
+#include <asm-generic/qspinlock.h>
+#include <linux/jump_label.h>
+
+#undef arch_spin_is_locked
+#undef arch_spin_is_contended
+#undef arch_spin_value_unlocked
+#undef arch_spin_lock
+#undef arch_spin_trylock
+#undef arch_spin_unlock
+
+DECLARE_STATIC_KEY_TRUE(qspinlock_key);
+
+static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	if (static_branch_likely(&qspinlock_key))
+		queued_spin_lock(lock);
+	else
+		ticket_spin_lock(lock);
+}
+
+static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
+{
+	if (static_branch_likely(&qspinlock_key))
+		return queued_spin_trylock(lock);
+	return ticket_spin_trylock(lock);
+}
+
+static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	if (static_branch_likely(&qspinlock_key))
+		queued_spin_unlock(lock);
+	else
+		ticket_spin_unlock(lock);
+}
+
+static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	if (static_branch_likely(&qspinlock_key))
+		return queued_spin_value_unlocked(lock);
+	else
+		return ticket_spin_value_unlocked(lock);
+}
+
+static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	if (static_branch_likely(&qspinlock_key))
+		return queued_spin_is_locked(lock);
+	return ticket_spin_is_locked(lock);
+}
+
+static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	if (static_branch_likely(&qspinlock_key))
+		return queued_spin_is_contended(lock);
+	return ticket_spin_is_contended(lock);
+}
+#include <asm/qrwlock.h>
+#else
+#include <asm-generic/spinlock.h>
+#endif /* CONFIG_RISCV_COMBO_SPINLOCKS */
+
+#endif /* __ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f0f36a4a0e9b..b763039bf49b 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -261,6 +261,13 @@ static void __init parse_dtb(void)
 #endif
 }
 
+#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
+DEFINE_STATIC_KEY_TRUE_RO(qspinlock_key);
+EXPORT_SYMBOL(qspinlock_key);
+
+static bool qspinlock_flag __initdata = false;
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	parse_dtb();
@@ -295,10 +302,25 @@ void __init setup_arch(char **cmdline_p)
 	setup_smp();
 #endif
 
+#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
+	if (!qspinlock_flag)
+		static_branch_disable(&qspinlock_key);
+#endif
+
 	riscv_fill_hwcap();
 	apply_boot_alternatives();
 }
 
+#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
+static int __init enable_qspinlock(char *p)
+{
+	qspinlock_flag = true;
+
+	return 0;
+}
+early_param("qspinlock", enable_qspinlock);
+#endif
+
 static int __init topology_init(void)
 {
 	int i, ret;
-- 
2.36.1

