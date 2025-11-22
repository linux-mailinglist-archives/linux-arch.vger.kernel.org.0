Return-Path: <linux-arch+bounces-15036-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2883FC7C632
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 05:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFED73614DB
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 04:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E633322128D;
	Sat, 22 Nov 2025 04:37:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE02135AD;
	Sat, 22 Nov 2025 04:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786249; cv=none; b=T2/j3O8lEiP6L0+N5+dV6wdL6BkGzEgRBrbBGpe8vrdj1iYa7L1yEn/zaRdDhWLYH/QAjtUu8Yx2+DSpA8202bKMDVuaAd1lJKAZ9RUKu3uTXG7ZJga/Ov30tLAH+VUqxJey2b0M4P+SPlzwxnnr1Ch7SkG3d1ZXu8DlbJBPorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786249; c=relaxed/simple;
	bh=TUZW0Zlb6l31YjTEdTm+SgMmxGwmueWw+i6tiufLldg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVwijAu4ALrMsID6tcSkEPR2T/7NNj3rLGd8BS/YXwdnVLV3aqADbEjg21+15BHTtF4bsuk8S4SFtWEvThauU6zxD01gfCEmwahhtErYBNenjJhjhTVYFmxhxI2ZSEaYZzhrm/2JzE127Ie+/cyDYAoemIOxSyVCOBaLlnlFYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A110C4CEF5;
	Sat, 22 Nov 2025 04:37:26 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 02/14] LoongArch: Add adaptive CSR accessors for 32BIT/64BIT
Date: Sat, 22 Nov 2025 12:36:22 +0800
Message-ID: <20251122043634.3447854-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122043634.3447854-1-chenhuacai@loongson.cn>
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

32BIT platforms only have 32bit CSR/IOCSR registers, 64BIT platforms
have both 32bit/64bit CSR/IOCSR registers. Now there are both 32bit and
64bit CSR accessors:

csr_read32()/csr_write32()/csr_xchg32();
csr_read64()/csr_write64()/csr_xchg64();

Some CSR registers (address and timer registers) are 32bit length on
32BIT platform and 64bit length on 64BIT platform. To avoid #ifdefs here
and there, they need adaptive accessors, so we define and use:

csr_read()/csr_write()/csr_xchg();

IOCSR doesn't have a "natural length", which means a 64bit register can
be treated as two 32bit registers, so we just use two 32bit accessors to
emulate a 64bit accessors.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/loongarch.h   | 46 +++++++++++++++---------
 arch/loongarch/include/asm/percpu.h      |  2 +-
 arch/loongarch/kernel/cpu-probe.c        |  7 ++++
 arch/loongarch/kernel/time.c             | 16 ++++-----
 arch/loongarch/kernel/traps.c            | 15 ++++----
 arch/loongarch/lib/dump_tlb.c            |  6 ++--
 arch/loongarch/mm/tlb.c                  | 10 +++---
 arch/loongarch/power/hibernate.c         |  6 ++--
 arch/loongarch/power/suspend.c           | 24 ++++++-------
 drivers/firmware/efi/libstub/loongarch.c |  8 ++---
 10 files changed, 81 insertions(+), 59 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 3de03cb864b2..9f71a79271da 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -182,6 +182,16 @@
 #define csr_xchg32(val, mask, reg) __csrxchg_w(val, mask, reg)
 #define csr_xchg64(val, mask, reg) __csrxchg_d(val, mask, reg)
 
+#ifdef CONFIG_32BIT
+#define csr_read(reg) csr_read32(reg)
+#define csr_write(val, reg) csr_write32(val, reg)
+#define csr_xchg(val, mask, reg) csr_xchg32(val, mask, reg)
+#else
+#define csr_read(reg) csr_read64(reg)
+#define csr_write(val, reg) csr_write64(val, reg)
+#define csr_xchg(val, mask, reg) csr_xchg64(val, mask, reg)
+#endif
+
 /* IOCSR */
 #define iocsr_read32(reg) __iocsrrd_w(reg)
 #define iocsr_read64(reg) __iocsrrd_d(reg)
@@ -1223,6 +1233,7 @@ static inline unsigned int get_csr_cpuid(void)
 	return csr_read32(LOONGARCH_CSR_CPUID);
 }
 
+#ifdef CONFIG_64BIT
 static inline void csr_any_send(unsigned int addr, unsigned int data,
 				unsigned int data_mask, unsigned int cpu)
 {
@@ -1234,6 +1245,7 @@ static inline void csr_any_send(unsigned int addr, unsigned int data,
 	val |= ((uint64_t)data << IOCSR_ANY_SEND_BUF_SHIFT);
 	iocsr_write64(val, LOONGARCH_IOCSR_ANY_SEND);
 }
+#endif
 
 static inline unsigned int read_csr_excode(void)
 {
@@ -1257,22 +1269,22 @@ static inline void write_csr_pagesize(unsigned int size)
 
 static inline unsigned int read_csr_tlbrefill_pagesize(void)
 {
-	return (csr_read64(LOONGARCH_CSR_TLBREHI) & CSR_TLBREHI_PS) >> CSR_TLBREHI_PS_SHIFT;
+	return (csr_read(LOONGARCH_CSR_TLBREHI) & CSR_TLBREHI_PS) >> CSR_TLBREHI_PS_SHIFT;
 }
 
 static inline void write_csr_tlbrefill_pagesize(unsigned int size)
 {
-	csr_xchg64(size << CSR_TLBREHI_PS_SHIFT, CSR_TLBREHI_PS, LOONGARCH_CSR_TLBREHI);
+	csr_xchg(size << CSR_TLBREHI_PS_SHIFT, CSR_TLBREHI_PS, LOONGARCH_CSR_TLBREHI);
 }
 
 #define read_csr_asid()			csr_read32(LOONGARCH_CSR_ASID)
 #define write_csr_asid(val)		csr_write32(val, LOONGARCH_CSR_ASID)
-#define read_csr_entryhi()		csr_read64(LOONGARCH_CSR_TLBEHI)
-#define write_csr_entryhi(val)		csr_write64(val, LOONGARCH_CSR_TLBEHI)
-#define read_csr_entrylo0()		csr_read64(LOONGARCH_CSR_TLBELO0)
-#define write_csr_entrylo0(val)		csr_write64(val, LOONGARCH_CSR_TLBELO0)
-#define read_csr_entrylo1()		csr_read64(LOONGARCH_CSR_TLBELO1)
-#define write_csr_entrylo1(val)		csr_write64(val, LOONGARCH_CSR_TLBELO1)
+#define read_csr_entryhi()		csr_read(LOONGARCH_CSR_TLBEHI)
+#define write_csr_entryhi(val)		csr_write(val, LOONGARCH_CSR_TLBEHI)
+#define read_csr_entrylo0()		csr_read(LOONGARCH_CSR_TLBELO0)
+#define write_csr_entrylo0(val)		csr_write(val, LOONGARCH_CSR_TLBELO0)
+#define read_csr_entrylo1()		csr_read(LOONGARCH_CSR_TLBELO1)
+#define write_csr_entrylo1(val)		csr_write(val, LOONGARCH_CSR_TLBELO1)
 #define read_csr_ecfg()			csr_read32(LOONGARCH_CSR_ECFG)
 #define write_csr_ecfg(val)		csr_write32(val, LOONGARCH_CSR_ECFG)
 #define read_csr_estat()		csr_read32(LOONGARCH_CSR_ESTAT)
@@ -1282,20 +1294,20 @@ static inline void write_csr_tlbrefill_pagesize(unsigned int size)
 #define read_csr_euen()			csr_read32(LOONGARCH_CSR_EUEN)
 #define write_csr_euen(val)		csr_write32(val, LOONGARCH_CSR_EUEN)
 #define read_csr_cpuid()		csr_read32(LOONGARCH_CSR_CPUID)
-#define read_csr_prcfg1()		csr_read64(LOONGARCH_CSR_PRCFG1)
-#define write_csr_prcfg1(val)		csr_write64(val, LOONGARCH_CSR_PRCFG1)
-#define read_csr_prcfg2()		csr_read64(LOONGARCH_CSR_PRCFG2)
-#define write_csr_prcfg2(val)		csr_write64(val, LOONGARCH_CSR_PRCFG2)
-#define read_csr_prcfg3()		csr_read64(LOONGARCH_CSR_PRCFG3)
-#define write_csr_prcfg3(val)		csr_write64(val, LOONGARCH_CSR_PRCFG3)
+#define read_csr_prcfg1()		csr_read(LOONGARCH_CSR_PRCFG1)
+#define write_csr_prcfg1(val)		csr_write(val, LOONGARCH_CSR_PRCFG1)
+#define read_csr_prcfg2()		csr_read(LOONGARCH_CSR_PRCFG2)
+#define write_csr_prcfg2(val)		csr_write(val, LOONGARCH_CSR_PRCFG2)
+#define read_csr_prcfg3()		csr_read(LOONGARCH_CSR_PRCFG3)
+#define write_csr_prcfg3(val)		csr_write(val, LOONGARCH_CSR_PRCFG3)
 #define read_csr_stlbpgsize()		csr_read32(LOONGARCH_CSR_STLBPGSIZE)
 #define write_csr_stlbpgsize(val)	csr_write32(val, LOONGARCH_CSR_STLBPGSIZE)
 #define read_csr_rvacfg()		csr_read32(LOONGARCH_CSR_RVACFG)
 #define write_csr_rvacfg(val)		csr_write32(val, LOONGARCH_CSR_RVACFG)
 #define write_csr_tintclear(val)	csr_write32(val, LOONGARCH_CSR_TINTCLR)
-#define read_csr_impctl1()		csr_read64(LOONGARCH_CSR_IMPCTL1)
-#define write_csr_impctl1(val)		csr_write64(val, LOONGARCH_CSR_IMPCTL1)
-#define write_csr_impctl2(val)		csr_write64(val, LOONGARCH_CSR_IMPCTL2)
+#define read_csr_impctl1()		csr_read(LOONGARCH_CSR_IMPCTL1)
+#define write_csr_impctl1(val)		csr_write(val, LOONGARCH_CSR_IMPCTL1)
+#define write_csr_impctl2(val)		csr_write(val, LOONGARCH_CSR_IMPCTL2)
 
 #define read_csr_perfctrl0()		csr_read64(LOONGARCH_CSR_PERFCTRL0)
 #define read_csr_perfcntr0()		csr_read64(LOONGARCH_CSR_PERFCNTR0)
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index 1619c1d15e6b..44a8aea2b0e5 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -27,7 +27,7 @@ register unsigned long __my_cpu_offset __asm__("$r21");
 static inline void set_my_cpu_offset(unsigned long off)
 {
 	__my_cpu_offset = off;
-	csr_write64(off, PERCPU_BASE_KS);
+	csr_write(off, PERCPU_BASE_KS);
 }
 
 #define __my_cpu_offset					\
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index a2060a24b39f..3726cd0885b6 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -298,8 +298,15 @@ static inline void cpu_probe_loongson(struct cpuinfo_loongarch *c, unsigned int
 		return;
 	}
 
+#ifdef CONFIG_64BIT
 	*vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
 	*cpuname = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
+#else
+	*vendor = iocsr_read32(LOONGARCH_IOCSR_VENDOR) |
+		(u64)iocsr_read32(LOONGARCH_IOCSR_VENDOR + 4) << 32;
+	*cpuname = iocsr_read32(LOONGARCH_IOCSR_CPUNAME) |
+		(u64)iocsr_read32(LOONGARCH_IOCSR_CPUNAME + 4) << 32;
+#endif
 
 	if (!__cpu_full_name[cpu]) {
 		if (((char *)vendor)[0] == 0)
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 6fb92cc1a4c9..1c31bf3a16ed 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -50,10 +50,10 @@ static int constant_set_state_oneshot(struct clock_event_device *evt)
 
 	raw_spin_lock(&state_lock);
 
-	timer_config = csr_read64(LOONGARCH_CSR_TCFG);
+	timer_config = csr_read(LOONGARCH_CSR_TCFG);
 	timer_config |= CSR_TCFG_EN;
 	timer_config &= ~CSR_TCFG_PERIOD;
-	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
+	csr_write(timer_config, LOONGARCH_CSR_TCFG);
 
 	raw_spin_unlock(&state_lock);
 
@@ -70,7 +70,7 @@ static int constant_set_state_periodic(struct clock_event_device *evt)
 	period = const_clock_freq / HZ;
 	timer_config = period & CSR_TCFG_VAL;
 	timer_config |= (CSR_TCFG_PERIOD | CSR_TCFG_EN);
-	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
+	csr_write(timer_config, LOONGARCH_CSR_TCFG);
 
 	raw_spin_unlock(&state_lock);
 
@@ -83,9 +83,9 @@ static int constant_set_state_shutdown(struct clock_event_device *evt)
 
 	raw_spin_lock(&state_lock);
 
-	timer_config = csr_read64(LOONGARCH_CSR_TCFG);
+	timer_config = csr_read(LOONGARCH_CSR_TCFG);
 	timer_config &= ~CSR_TCFG_EN;
-	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
+	csr_write(timer_config, LOONGARCH_CSR_TCFG);
 
 	raw_spin_unlock(&state_lock);
 
@@ -98,7 +98,7 @@ static int constant_timer_next_event(unsigned long delta, struct clock_event_dev
 
 	delta &= CSR_TCFG_VAL;
 	timer_config = delta | CSR_TCFG_EN;
-	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
+	csr_write(timer_config, LOONGARCH_CSR_TCFG);
 
 	return 0;
 }
@@ -137,7 +137,7 @@ void save_counter(void)
 void sync_counter(void)
 {
 	/* Ensure counter begin at 0 */
-	csr_write64(init_offset, LOONGARCH_CSR_CNTC);
+	csr_write(init_offset, LOONGARCH_CSR_CNTC);
 }
 
 int constant_clockevent_init(void)
@@ -235,7 +235,7 @@ void __init time_init(void)
 	else
 		const_clock_freq = calc_const_freq();
 
-	init_offset = -(drdtime() - csr_read64(LOONGARCH_CSR_CNTC));
+	init_offset = -(drdtime() - csr_read(LOONGARCH_CSR_CNTC));
 
 	constant_clockevent_init();
 	constant_clocksource_init();
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index da5926fead4a..004b8ebf0051 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -625,7 +625,7 @@ asmlinkage void noinstr do_bce(struct pt_regs *regs)
 	bool user = user_mode(regs);
 	bool pie = regs_irqs_disabled(regs);
 	unsigned long era = exception_era(regs);
-	u64 badv = 0, lower = 0, upper = ULONG_MAX;
+	unsigned long badv = 0, lower = 0, upper = ULONG_MAX;
 	union loongarch_instruction insn;
 	irqentry_state_t state = irqentry_enter(regs);
 
@@ -1070,10 +1070,13 @@ asmlinkage void noinstr do_reserved(struct pt_regs *regs)
 
 asmlinkage void cache_parity_error(void)
 {
+	u32 merrctl = csr_read32(LOONGARCH_CSR_MERRCTL);
+	unsigned long merrera = csr_read(LOONGARCH_CSR_MERRERA);
+
 	/* For the moment, report the problem and hang. */
 	pr_err("Cache error exception:\n");
-	pr_err("csr_merrctl == %08x\n", csr_read32(LOONGARCH_CSR_MERRCTL));
-	pr_err("csr_merrera == %016lx\n", csr_read64(LOONGARCH_CSR_MERRERA));
+	pr_err("csr_merrctl == %08x\n", merrctl);
+	pr_err("csr_merrera == %016lx\n", merrera);
 	panic("Can't handle the cache error!");
 }
 
@@ -1130,9 +1133,9 @@ static void configure_exception_vector(void)
 	eentry    = (unsigned long)exception_handlers;
 	tlbrentry = (unsigned long)exception_handlers + 80*VECSIZE;
 
-	csr_write64(eentry, LOONGARCH_CSR_EENTRY);
-	csr_write64(__pa(eentry), LOONGARCH_CSR_MERRENTRY);
-	csr_write64(__pa(tlbrentry), LOONGARCH_CSR_TLBRENTRY);
+	csr_write(eentry, LOONGARCH_CSR_EENTRY);
+	csr_write(__pa(eentry), LOONGARCH_CSR_MERRENTRY);
+	csr_write(__pa(tlbrentry), LOONGARCH_CSR_TLBRENTRY);
 }
 
 void per_cpu_trap_init(int cpu)
diff --git a/arch/loongarch/lib/dump_tlb.c b/arch/loongarch/lib/dump_tlb.c
index 0b886a6e260f..116f21ea4e2c 100644
--- a/arch/loongarch/lib/dump_tlb.c
+++ b/arch/loongarch/lib/dump_tlb.c
@@ -20,9 +20,9 @@ void dump_tlb_regs(void)
 
 	pr_info("Index    : 0x%0x\n", read_csr_tlbidx());
 	pr_info("PageSize : 0x%0x\n", read_csr_pagesize());
-	pr_info("EntryHi  : 0x%0*lx\n", field, read_csr_entryhi());
-	pr_info("EntryLo0 : 0x%0*lx\n", field, read_csr_entrylo0());
-	pr_info("EntryLo1 : 0x%0*lx\n", field, read_csr_entrylo1());
+	pr_info("EntryHi  : 0x%0*lx\n", field, (unsigned long)read_csr_entryhi());
+	pr_info("EntryLo0 : 0x%0*lx\n", field, (unsigned long)read_csr_entrylo0());
+	pr_info("EntryLo1 : 0x%0*lx\n", field, (unsigned long)read_csr_entrylo1());
 }
 
 static void dump_tlb(int first, int last)
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 3b427b319db2..6e474469e210 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -229,11 +229,11 @@ static void setup_ptwalker(void)
 	if (cpu_has_ptw)
 		pwctl1 |= CSR_PWCTL1_PTW;
 
-	csr_write64(pwctl0, LOONGARCH_CSR_PWCTL0);
-	csr_write64(pwctl1, LOONGARCH_CSR_PWCTL1);
-	csr_write64((long)swapper_pg_dir, LOONGARCH_CSR_PGDH);
-	csr_write64((long)invalid_pg_dir, LOONGARCH_CSR_PGDL);
-	csr_write64((long)smp_processor_id(), LOONGARCH_CSR_TMID);
+	csr_write(pwctl0, LOONGARCH_CSR_PWCTL0);
+	csr_write(pwctl1, LOONGARCH_CSR_PWCTL1);
+	csr_write((long)swapper_pg_dir, LOONGARCH_CSR_PGDH);
+	csr_write((long)invalid_pg_dir, LOONGARCH_CSR_PGDL);
+	csr_write((long)smp_processor_id(), LOONGARCH_CSR_TMID);
 }
 
 static void output_pgtable_bits_defines(void)
diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hibernate.c
index e7b7346592cb..817270410ef9 100644
--- a/arch/loongarch/power/hibernate.c
+++ b/arch/loongarch/power/hibernate.c
@@ -10,7 +10,7 @@ static u32 saved_crmd;
 static u32 saved_prmd;
 static u32 saved_euen;
 static u32 saved_ecfg;
-static u64 saved_pcpu_base;
+static unsigned long saved_pcpu_base;
 struct pt_regs saved_regs;
 
 void save_processor_state(void)
@@ -20,7 +20,7 @@ void save_processor_state(void)
 	saved_prmd = csr_read32(LOONGARCH_CSR_PRMD);
 	saved_euen = csr_read32(LOONGARCH_CSR_EUEN);
 	saved_ecfg = csr_read32(LOONGARCH_CSR_ECFG);
-	saved_pcpu_base = csr_read64(PERCPU_BASE_KS);
+	saved_pcpu_base = csr_read(PERCPU_BASE_KS);
 
 	if (is_fpu_owner())
 		save_fp(current);
@@ -33,7 +33,7 @@ void restore_processor_state(void)
 	csr_write32(saved_prmd, LOONGARCH_CSR_PRMD);
 	csr_write32(saved_euen, LOONGARCH_CSR_EUEN);
 	csr_write32(saved_ecfg, LOONGARCH_CSR_ECFG);
-	csr_write64(saved_pcpu_base, PERCPU_BASE_KS);
+	csr_write(saved_pcpu_base, PERCPU_BASE_KS);
 
 	if (is_fpu_owner())
 		restore_fp(current);
diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspend.c
index c9e594925c47..7e3d79f8bbd4 100644
--- a/arch/loongarch/power/suspend.c
+++ b/arch/loongarch/power/suspend.c
@@ -20,24 +20,24 @@ u64 loongarch_suspend_addr;
 struct saved_registers {
 	u32 ecfg;
 	u32 euen;
-	u64 pgd;
-	u64 kpgd;
 	u32 pwctl0;
 	u32 pwctl1;
-	u64 pcpu_base;
+	unsigned long pgd;
+	unsigned long kpgd;
+	unsigned long pcpu_base;
 };
 static struct saved_registers saved_regs;
 
 void loongarch_common_suspend(void)
 {
 	save_counter();
-	saved_regs.pgd = csr_read64(LOONGARCH_CSR_PGDL);
-	saved_regs.kpgd = csr_read64(LOONGARCH_CSR_PGDH);
+	saved_regs.pgd = csr_read(LOONGARCH_CSR_PGDL);
+	saved_regs.kpgd = csr_read(LOONGARCH_CSR_PGDH);
 	saved_regs.pwctl0 = csr_read32(LOONGARCH_CSR_PWCTL0);
 	saved_regs.pwctl1 = csr_read32(LOONGARCH_CSR_PWCTL1);
 	saved_regs.ecfg = csr_read32(LOONGARCH_CSR_ECFG);
 	saved_regs.euen = csr_read32(LOONGARCH_CSR_EUEN);
-	saved_regs.pcpu_base = csr_read64(PERCPU_BASE_KS);
+	saved_regs.pcpu_base = csr_read(PERCPU_BASE_KS);
 
 	loongarch_suspend_addr = loongson_sysconf.suspend_addr;
 }
@@ -46,17 +46,17 @@ void loongarch_common_resume(void)
 {
 	sync_counter();
 	local_flush_tlb_all();
-	csr_write64(eentry, LOONGARCH_CSR_EENTRY);
-	csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
-	csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
+	csr_write(eentry, LOONGARCH_CSR_EENTRY);
+	csr_write(eentry, LOONGARCH_CSR_MERRENTRY);
+	csr_write(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
 
-	csr_write64(saved_regs.pgd, LOONGARCH_CSR_PGDL);
-	csr_write64(saved_regs.kpgd, LOONGARCH_CSR_PGDH);
+	csr_write(saved_regs.pgd, LOONGARCH_CSR_PGDL);
+	csr_write(saved_regs.kpgd, LOONGARCH_CSR_PGDH);
 	csr_write32(saved_regs.pwctl0, LOONGARCH_CSR_PWCTL0);
 	csr_write32(saved_regs.pwctl1, LOONGARCH_CSR_PWCTL1);
 	csr_write32(saved_regs.ecfg, LOONGARCH_CSR_ECFG);
 	csr_write32(saved_regs.euen, LOONGARCH_CSR_EUEN);
-	csr_write64(saved_regs.pcpu_base, PERCPU_BASE_KS);
+	csr_write(saved_regs.pcpu_base, PERCPU_BASE_KS);
 }
 
 int loongarch_acpi_suspend(void)
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 3782d0a187d1..9825f5218137 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -72,10 +72,10 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 		    desc_ver, priv.runtime_map);
 
 	/* Config Direct Mapping */
-	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
-	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
-	csr_write64(CSR_DMW2_INIT, LOONGARCH_CSR_DMWIN2);
-	csr_write64(CSR_DMW3_INIT, LOONGARCH_CSR_DMWIN3);
+	csr_write(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
+	csr_write(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
+	csr_write(CSR_DMW2_INIT, LOONGARCH_CSR_DMWIN2);
+	csr_write(CSR_DMW3_INIT, LOONGARCH_CSR_DMWIN3);
 
 	real_kernel_entry = (void *)kernel_entry_address(kernel_addr, image);
 
-- 
2.47.3


