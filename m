Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C44C799D1E
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 10:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346528AbjIJIah (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 04:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346506AbjIJIaf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 04:30:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4ECC0;
        Sun, 10 Sep 2023 01:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0A2C433CC;
        Sun, 10 Sep 2023 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694334627;
        bh=JHxtCSFAXXj+aAh2d1UzrcmVnbP7XJ2TAFbFny2j3pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkC6EgOJCLxEIUZxkbIuR1YvLQRbsEdcIriRqReFcbydI85IYQob0oUNpPRgyojoN
         Ngd6SVyuYUJtvWMoqh6PbN8d13dOhFeQ6J2Gzu/aCowb49eOF7LBbcoUn40G3KqnDS
         Pdtvoj+iD080UL1k8d9qE19wDPh1uSP0OwUxMwi2n7mncnsNvPCJCMOyMx9hCYGlzd
         XwOnTEXflDp0+8Vfk/PHZSusn8wvbkhZFtrOifwwgZWYXuqhfdfpCog0ptjNWSqU6D
         Ig3SYK1z5xii6D7nfdzIEgQbg+tJf3vrftC1cnvT4pqDpP2WsggkJXCzcJPS5Hw+wr
         QhrAAJDCXpvvg==
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
Subject: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Date:   Sun, 10 Sep 2023 04:28:57 -0400
Message-Id: <20230910082911.3378782-4-guoren@kernel.org>
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

Cache-block prefetch instructions are HINTs to the hardware to
indicate that software intends to perform a particular type of
memory access in the near future. Enable ARCH_HAS_PREFETCHW and
improve the arch_xchg for qspinlock xchg_tail.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                 | 15 +++++++++++++++
 arch/riscv/include/asm/cmpxchg.h   |  4 +++-
 arch/riscv/include/asm/hwcap.h     |  1 +
 arch/riscv/include/asm/insn-def.h  |  5 +++++
 arch/riscv/include/asm/processor.h | 13 +++++++++++++
 arch/riscv/kernel/cpufeature.c     |  1 +
 6 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e9ae6fa232c3..2c346fe169c1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -617,6 +617,21 @@ config RISCV_ISA_ZICBOZ
 
 	   If you don't know what to do here, say Y.
 
+config RISCV_ISA_ZICBOP
+	bool "Zicbop extension support for cache block prefetch"
+	depends on MMU
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the ZICBOP
+	   extension (Cache Block Prefetch Operations) and enable its
+	   usage.
+
+	   The Zicbop extension can be used to prefetch cache block for
+	   read/write/instruction fetch.
+
+	   If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZIHINTPAUSE
 	bool
 	default y
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 702725727671..56eff7a9d2d2 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,6 +11,7 @@
 
 #include <asm/barrier.h>
 #include <asm/fence.h>
+#include <asm/processor.h>
 
 #define __arch_xchg_masked(prepend, append, r, p, n)			\
 ({									\
@@ -25,6 +26,7 @@
 									\
 	__asm__ __volatile__ (						\
 	       prepend							\
+	       PREFETCHW_ASM(%5)					\
 	       "0:	lr.w %0, %2\n"					\
 	       "	and  %1, %0, %z4\n"				\
 	       "	or   %1, %1, %z3\n"				\
@@ -32,7 +34,7 @@
 	       "	bnez %1, 0b\n"					\
 	       append							\
 	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
-	       : "rJ" (__newx), "rJ" (~__mask)				\
+	       : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)		\
 	       : "memory");						\
 									\
 	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7b58258f6c7..78b7b8b53778 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -58,6 +58,7 @@
 #define RISCV_ISA_EXT_ZICSR		40
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
+#define RISCV_ISA_EXT_ZICBOP		43
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index 6960beb75f32..dc590d331894 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -134,6 +134,7 @@
 
 #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
 #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
+#define RV_OPCODE_PREFETCH	RV_OPCODE(19)
 
 #define HFENCE_VVMA(vaddr, asid)				\
 	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17),		\
@@ -196,4 +197,8 @@
 	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
 	       RS1(base), SIMM12(4))
 
+#define CBO_prefetchw(base)					\
+	INSN_R(OPCODE_PREFETCH, FUNC3(6), FUNC7(0),		\
+	       RD(x0), RS1(base), RS2(x0))
+
 #endif /* __ASM_INSN_DEF_H */
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index de9da852f78d..7ad3a24212e8 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -12,6 +12,8 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/insn-def.h>
+#include <asm/hwcap.h>
 
 #ifdef CONFIG_64BIT
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
@@ -103,6 +105,17 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 #define KSTK_EIP(tsk)		(ulong)(task_pt_regs(tsk)->epc)
 #define KSTK_ESP(tsk)		(ulong)(task_pt_regs(tsk)->sp)
 
+#define ARCH_HAS_PREFETCHW
+#define PREFETCHW_ASM(base)	ALTERNATIVE(__nops(1), \
+					    CBO_prefetchw(base), \
+					    0, \
+					    RISCV_ISA_EXT_ZICBOP, \
+					    CONFIG_RISCV_ISA_ZICBOP)
+static inline void prefetchw(const void *ptr)
+{
+	asm volatile(PREFETCHW_ASM(%0)
+		: : "r" (ptr) : "memory");
+}
 
 /* Do necessary setup to start up a newly executed thread. */
 extern void start_thread(struct pt_regs *regs,
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index ef7b4fd9e876..e0b897db0b97 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -159,6 +159,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
 	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
 	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
+	__RISCV_ISA_EXT_DATA(zicbop, RISCV_ISA_EXT_ZICBOP),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
 	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
-- 
2.36.1

