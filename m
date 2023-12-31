Return-Path: <linux-arch+bounces-1215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F22820A63
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 09:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9821F21EB8
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 08:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACA514F65;
	Sun, 31 Dec 2023 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1uk5UH4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iQJ+cNE0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkC6EgOJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973A14F69;
	Sun, 31 Dec 2023 08:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50866C433C7;
	Sun, 31 Dec 2023 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704011435;
	bh=dnHR257j+jKliUOroX7jMso8+9dco+Hs5nZRQGQYmtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d1uk5UH41V7wufapyLnymGetbYvcmf3WG3zRg64H+XZacA7jdyNXpDQgIGks5KUqb
	 6bi7r7C3CwQQv0VuSvFlUgng0nWsekir0F0AEdt3WSohTED5lHKuR4kItvPsdcSiX/
	 PsgW7DujbjoVT+gRM8Y8n9vKkEw/MLkUYTqAWgPNqzYEVrAu075+eCyViE1CjeBYVn
	 HDJ+bHBmr+6W1MWsY+gXvSSMej0kfShWq5Vemk9B7gvim93Z4yfcOyru+hZchQd+vC
	 VLOvTqIxUD5WxDP2XVu24aNW5BurmO/Ij0SliYmdBfL7KbDdUlVVngKqwUJAu1bTiA
	 qhKVi9IFCBYUw==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	guoren@kernel.org,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	leobras@redhat.com,
	peterz@infradead.org,
	keescook@chromium.org,
	wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	uwu@icenowy.me,
	jszhang@kernel.org,
	wefu@redhat.com,
	atishp@atishpatra.org,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mingo@redhat.com,
	will@kernel.org,
	palmer@rivosinc.com,
	longman@redhat.com,
	boqun.feng@gmail.com,
	tglx@linutronix.de,
	paulmck@kernel.org,
	rostedt@goodmis.org,
	rdunlap@infradead.org,
	catalin.marinas@arm.com,
	alexghiti@rivosinc.com,
	greentime.hu@sifive.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-csky@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Date: Sun, 31 Dec 2023 03:29:54 -0500
Message-Id: <20230910082911.3378782-4-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230910082911.3378782-1-guoren@kernel.org>
References: <20230910082911.3378782-1-guoren@kernel.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.lore.kernel.org (Postfix) with ESMTPS id 50958EEB580 for <linux-riscv@archiver.kernel.org>; Sun, 10 Sep 2023 08:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lists.infradead.org; s=bombadil.20210309; h=Sender: Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post: List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To: Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description: Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID: List-Owner; bh=4L0nrjop/yYiW0hH7bWnUJW3x1Y2/z29AccgRVRtGJQ=; b=iQJ+cNE0UPz98m csVnUhzqLl2rjuEOUfC+YpbtFNWCh2y+UNoXnbV8DhWN697TF18Q0nw5+MVq4R4lVhFd4SUReZi5G 0dQFD2Zmwm9IEEMuNkVjaQ2eRmeP1P3CAGM8BPioJecgfuph63p47wjl7zeaNZybr4wGkL6+rlXS9 XcRR4DO94575Yl84OvMg9VrhtSmHn7p1Eyz4VaXv5s2z1zaA/teyqEuioRkiYgTT+F88+XwxDhu25 SU4MrkqDYhkIGZD1mtB8gDj4dZi8An+Z9/5hpwiq6KW1LT/UxqVQay6mH62tDdZLWEFBMW4iVceKc kmzjURUL+ntk1RHUT1Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org) by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux)) id 1qfFpx-00GHdE-2K; Sun, 10 Sep 2023 08:30:33 +0000
Received: from ams.source.kernel.org ([145.40.68.75]) by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux)) id 1qfFpu-00GHcQ-0G for linux-riscv@lists.infradead.org; Sun, 10 Sep 2023 08:30:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519 server-signature RSA-PSS (2048 bits)) (No client certificate requested) by ams.source.kernel.org (Postfix) with ESMTPS id 4766DB80AF3; Sun, 10 Sep 2023 08:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0A2C433CC; Sun, 10 Sep 2023 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org; s=k20201202; t=1694334627; bh=JHxtCSFAXXj+aAh2d1UzrcmVnbP7XJ2TAFbFny2j3pM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From; b=gkC6EgOJCLxEIUZxkbIuR1YvLQRbsEdcIriRqReFcbydI85IYQob0oUNpPRgyojoN Ngd6SVyuYUJtvWMoqh6PbN8d13dOhFeQ6J2Gzu/aCowb49eOF7LBbcoUn40G3KqnDS Pdtvoj+iD080UL1k8d9qE19wDPh1uSP0OwUxMwi2n7mncnsNvPCJCMOyMx9hCYGlzd XwOnTEXflDp0+8Vfk/PHZSusn8wvbkhZFtrOifwwgZWYXuqhfdfpCog0ptjNWSqU6D Ig3SYK1z5xii6D7nfdzIEgQbg+tJf3vrftC1cnvT4pqDpP2WsggkJXCzcJPS5Hw+wr QhrAAJDCXpvvg==
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-BeenThere: linux-riscv@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+linux-riscv=archiver.kernel.org@lists.infradead.org
Content-Transfer-Encoding: 8bit

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


_______________________________________________
linux-riscv mailing list
linux-riscv@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-riscv


