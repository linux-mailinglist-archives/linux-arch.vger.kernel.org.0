Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408C876D41D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjHBQt0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 12:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjHBQtH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 12:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C436173A;
        Wed,  2 Aug 2023 09:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D47619D7;
        Wed,  2 Aug 2023 16:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D0EC433C8;
        Wed,  2 Aug 2023 16:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690994940;
        bh=aihpQWSsOm2PcncftaveeMsJLoT6t46RobNm6fedvI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbOQExxxuCtl7NH7eEJ6hZqSndwRoPGdr6xkLNldxD4i6d4f0tfBTN5SijbtBjNvx
         fdi8poo5hOLsGtXmkhJcW1h9mQKVPkjqiGLD7kBl5pDcvzZgngOHIN7AMts+s5i3Qj
         fdBVjn6mxmEqIbXZUouDJ4xRfdc78I8Z3VWhBuxUmvUAX/2fkI46rYY93zJKRTAnfZ
         8qSJXsZETG38yrWe6xpLlaUj5vllcbH/4ubvCaSE6xiccTKV+nHZLKQAqK1nkFTZ7J
         igQd0L4wWlGyOVq+znHVp7JrBhdfRkz+eb4jb9ntBJcSScgyImGIJd8jyTdlAD3Kq6
         BC8aj1j1UYJXw==
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
Subject: [PATCH V10 05/19] riscv: qspinlock: Introduce combo spinlock
Date:   Wed,  2 Aug 2023 12:46:47 -0400
Message-Id: <20230802164701.192791-6-guoren@kernel.org>
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

Combo spinlock could support queued and ticket in one Linux Image and
select them during boot time via errata mechanism. Here is the func
size (Bytes) comparison table below:

TYPE			: COMBO | TICKET | QUEUED
arch_spin_lock		: 106	| 60     | 50
arch_spin_unlock	: 54    | 36     | 26
arch_spin_trylock	: 110   | 72     | 54
arch_spin_is_locked	: 48    | 34     | 20
arch_spin_is_contended	: 56    | 40     | 24
rch_spin_value_unlocked	: 48    | 34     | 24

One example of disassemble combo arch_spin_unlock:
   0xffffffff8000409c <+14>:    nop                # detour slot
   0xffffffff800040a0 <+18>:    fence   rw,w       # queued spinlock start
   0xffffffff800040a4 <+22>:    sb      zero,0(a4) # queued spinlock end
   0xffffffff800040a8 <+26>:    ld      s0,8(sp)
   0xffffffff800040aa <+28>:    addi    sp,sp,16
   0xffffffff800040ac <+30>:    ret
   0xffffffff800040ae <+32>:    lw      a5,0(a4)   # ticket spinlock start
   0xffffffff800040b0 <+34>:    sext.w  a5,a5
   0xffffffff800040b2 <+36>:    fence   rw,w
   0xffffffff800040b6 <+40>:    addiw   a5,a5,1
   0xffffffff800040b8 <+42>:    slli    a5,a5,0x30
   0xffffffff800040ba <+44>:    srli    a5,a5,0x30
   0xffffffff800040bc <+46>:    sh      a5,0(a4)   # ticket spinlock end
   0xffffffff800040c0 <+50>:    ld      s0,8(sp)
   0xffffffff800040c2 <+52>:    addi    sp,sp,16
   0xffffffff800040c4 <+54>:    ret

The qspinlock is smaller and faster than ticket-lock when all are in
fast-path, and combo spinlock could provide a compatible Linux Image
for different micro-arch design (weak/strict fwd guarantee) processors.

Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Kconfig                |  9 +++-
 arch/riscv/include/asm/hwcap.h    |  1 +
 arch/riscv/include/asm/spinlock.h | 87 ++++++++++++++++++++++++++++++-
 arch/riscv/kernel/cpufeature.c    | 10 ++++
 4 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e89a3bea3dc1..119e774a3dcf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -440,7 +440,7 @@ config NODES_SHIFT
 
 choice
 	prompt "RISC-V spinlock type"
-	default RISCV_TICKET_SPINLOCKS
+	default RISCV_COMBO_SPINLOCKS
 
 config RISCV_TICKET_SPINLOCKS
 	bool "Using ticket spinlock"
@@ -452,6 +452,13 @@ config RISCV_QUEUED_SPINLOCKS
 	help
 	  Make sure your micro arch LL/SC has a strong forward progress guarantee.
 	  Otherwise, stay at ticket-lock.
+
+config RISCV_COMBO_SPINLOCKS
+	bool "Using combo spinlock"
+	depends on SMP && MMU
+	select ARCH_USE_QUEUED_SPINLOCKS
+	help
+	  Select queued spinlock or ticket-lock via errata.
 endchoice
 
 config RISCV_ALTERNATIVE
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index f041bfa7f6a0..08ae75a694c2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -54,6 +54,7 @@
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
 
+#define RISCV_ISA_EXT_XTICKETLOCK	63
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
 
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index c644a92d4548..9eb3ad31e564 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -7,11 +7,94 @@
 #define _Q_PENDING_LOOPS	(1 << 9)
 #endif
 
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
+#include <asm/hwcap.h>
+
+#undef arch_spin_is_locked
+#undef arch_spin_is_contended
+#undef arch_spin_value_unlocked
+#undef arch_spin_lock
+#undef arch_spin_trylock
+#undef arch_spin_unlock
+
+#define COMBO_DETOUR				\
+	asm_volatile_goto(ALTERNATIVE(		\
+		"nop",				\
+		"j %l[ticket_spin_lock]",	\
+		0,				\
+		RISCV_ISA_EXT_XTICKETLOCK,	\
+		CONFIG_RISCV_COMBO_SPINLOCKS)	\
+		: : : : ticket_spin_lock);
+
+static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	COMBO_DETOUR
+	queued_spin_lock(lock);
+	return;
+ticket_spin_lock:
+	ticket_spin_lock(lock);
+}
+
+static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
+{
+	COMBO_DETOUR
+	return queued_spin_trylock(lock);
+ticket_spin_lock:
+	return ticket_spin_trylock(lock);
+}
+
+static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	COMBO_DETOUR
+	queued_spin_unlock(lock);
+	return;
+ticket_spin_lock:
+	ticket_spin_unlock(lock);
+}
+
+static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	COMBO_DETOUR
+	return queued_spin_value_unlocked(lock);
+ticket_spin_lock:
+	return ticket_spin_value_unlocked(lock);
+}
+
+static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	COMBO_DETOUR
+	return queued_spin_is_locked(lock);
+ticket_spin_lock:
+	return ticket_spin_is_locked(lock);
+}
+
+static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	COMBO_DETOUR
+	return queued_spin_is_contended(lock);
+ticket_spin_lock:
+	return ticket_spin_is_contended(lock);
+}
+#else /* CONFIG_RISCV_COMBO_SPINLOCKS */
+
 #ifdef CONFIG_QUEUED_SPINLOCKS
 #include <asm/qspinlock.h>
-#include <asm/qrwlock.h>
 #else
-#include <asm-generic/spinlock.h>
+#include <asm-generic/ticket_spinlock.h>
 #endif
 
+#endif /* CONFIG_RISCV_COMBO_SPINLOCKS */
+
+#include <asm/qrwlock.h>
+
 #endif /* __ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index bdcf460ea53d..e65b0e54152d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -324,6 +324,16 @@ void __init riscv_fill_hwcap(void)
 		set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
 		set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
 
+#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
+		/*
+		 * The RISC-V Linux used queued spinlock at first; then, we used ticket_lock
+		 * as default or queued spinlock by choice. Because ticket_lock would dirty
+		 * spinlock value, the only way is to change from queued_spinlock to
+		 * ticket_spinlock, but can not be vice.
+		 */
+		set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa);
+#endif
+
 		/*
 		 * These ones were as they were part of the base ISA when the
 		 * port & dt-bindings were upstreamed, and so can be set
-- 
2.36.1

