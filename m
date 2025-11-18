Return-Path: <linux-arch+bounces-14864-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A48C6916F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 12:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 102992AE20
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8315353894;
	Tue, 18 Nov 2025 11:29:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68E351FA2;
	Tue, 18 Nov 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465370; cv=none; b=o66XK0SNtgTU08va7jedjA9Zq8Vq1Pj8EKzy+SSmrYscFRemx7t91cZMxBNSG9vadEdcxc5V8Yj4pIaxvR9XVDb/eNUxNhEXjfo6/+1H8pobeCMUlsPSoY5fGh2uw5Fs6ZKVOmE7nxvzTBwsjvghAxlTojQQoLm0Xo5DqSPYBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465370; c=relaxed/simple;
	bh=Pdde4Vww9SaDmeYG9SYusTP1ZmAbdmIocO2Kgmoe/LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUM9srmVpOLewCo30CYoqTs8nclm10rh3S9KtoeJFfIJQdp0sf1y+y6kkYlijhRQiHD/NIKsLUZSZA4MtE2vJTokKZoQC8Fqct9X5I27lz9dll5yE3wzNGbfnSoQUBETQBEaCmygNwAyx57NOKn2JVBMKl5UCNwIdtgOC/q2JeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A64C4CEFB;
	Tue, 18 Nov 2025 11:29:26 +0000 (UTC)
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
Subject: [PATCH V2 07/14] LoongArch: Adjust time routines for 32BIT/64BIT
Date: Tue, 18 Nov 2025 19:27:21 +0800
Message-ID: <20251118112728.571869-8-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118112728.571869-1-chenhuacai@loongson.cn>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust time routines for both 32BIT and 64BIT, including: rdtime_h() /
rdtime_l() definitions for 32BIT and rdtime_d() definition for 64BIT,
get_cycles() and get_cycles64() definitions for 32BIT/64BIT, show time
frequency info ("CPU MHz" and "BogoMIPS") in /proc/cpuinfo, etc.

Use do_div() for division which works on both 32BIT and 64BIT platforms.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/loongarch.h | 32 +++++++++++++++++++++++++-
 arch/loongarch/include/asm/timex.h     | 29 ++++++++++++++++++++++-
 arch/loongarch/kernel/proc.c           | 13 ++++++-----
 arch/loongarch/kernel/syscall.c        |  2 +-
 arch/loongarch/kernel/time.c           | 15 ++++++------
 arch/loongarch/kvm/vcpu.c              |  5 ++--
 6 files changed, 78 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 804341bd8d2e..19e3f2c183fe 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1238,7 +1238,35 @@
 
 #ifndef __ASSEMBLER__
 
-static __always_inline u64 drdtime(void)
+#ifdef CONFIG_32BIT
+
+static __always_inline u32 rdtime_h(void)
+{
+	u32 val = 0;
+
+	__asm__ __volatile__(
+		"rdtimeh.w %0, $zero\n\t"
+		: "=r"(val)
+		:
+		);
+	return val;
+}
+
+static __always_inline u32 rdtime_l(void)
+{
+	u32 val = 0;
+
+	__asm__ __volatile__(
+		"rdtimel.w %0, $zero\n\t"
+		: "=r"(val)
+		:
+		);
+	return val;
+}
+
+#else
+
+static __always_inline u64 rdtime_d(void)
 {
 	u64 val = 0;
 
@@ -1250,6 +1278,8 @@ static __always_inline u64 drdtime(void)
 	return val;
 }
 
+#endif
+
 static inline unsigned int get_csr_cpuid(void)
 {
 	return csr_read32(LOONGARCH_CSR_CPUID);
diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
index fb41e9e7a222..1640c66ab430 100644
--- a/arch/loongarch/include/asm/timex.h
+++ b/arch/loongarch/include/asm/timex.h
@@ -18,7 +18,34 @@ typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
 {
-	return drdtime();
+#ifdef CONFIG_32BIT
+	return rdtime_l();
+#else
+	return rdtime_d();
+#endif
+}
+
+#define get_cycles_hi get_cycles_hi
+
+static inline cycles_t get_cycles_hi(void)
+{
+	return rdtime_h();
+}
+
+static inline u64 get_cycles64(void)
+{
+#ifdef CONFIG_32BIT
+	u32 hi, lo;
+
+	do {
+		hi = rdtime_h();
+		lo = rdtime_l();
+	} while (hi != rdtime_h());
+
+	return ((u64)hi << 32) | lo;
+#else
+	return rdtime_d();
+#endif
 }
 
 #endif /* __KERNEL__ */
diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.c
index cea30768ae92..464efdafa586 100644
--- a/arch/loongarch/kernel/proc.c
+++ b/arch/loongarch/kernel/proc.c
@@ -19,6 +19,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	unsigned int isa = cpu_data[n].isa_level;
 	unsigned int version = cpu_data[n].processor_id & 0xff;
 	unsigned int fp_version = cpu_data[n].fpu_vers;
+	u64 freq = cpu_clock_freq, bogomips = lpj_fine * cpu_clock_freq;
 
 #ifdef CONFIG_SMP
 	if (!cpu_online(n))
@@ -28,8 +29,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	/*
 	 * For the first processor also print the system type
 	 */
-	if (n == 0)
+	if (n == 0) {
+		do_div(freq, 10000);
+		do_div(bogomips, const_clock_freq * (5000/HZ));
 		seq_printf(m, "system type\t\t: %s\n\n", get_system_type());
+	}
 
 	seq_printf(m, "processor\t\t: %ld\n", n);
 	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
@@ -39,11 +43,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "Model Name\t\t: %s\n", __cpu_full_name[n]);
 	seq_printf(m, "CPU Revision\t\t: 0x%02x\n", version);
 	seq_printf(m, "FPU Revision\t\t: 0x%02x\n", fp_version);
-	seq_printf(m, "CPU MHz\t\t\t: %llu.%02llu\n",
-		      cpu_clock_freq / 1000000, (cpu_clock_freq / 10000) % 100);
-	seq_printf(m, "BogoMIPS\t\t: %llu.%02llu\n",
-		      (lpj_fine * cpu_clock_freq / const_clock_freq) / (500000/HZ),
-		      ((lpj_fine * cpu_clock_freq / const_clock_freq) / (5000/HZ)) % 100);
+	seq_printf(m, "CPU MHz\t\t\t: %u.%02u\n", (u32)freq / 100, (u32)freq % 100);
+	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n", (u32)bogomips / 100, (u32)bogomips % 100);
 	seq_printf(m, "TLB Entries\t\t: %d\n", cpu_data[n].tlbsize);
 	seq_printf(m, "Address Sizes\t\t: %d bits physical, %d bits virtual\n",
 		      cpu_pabits + 1, cpu_vabits + 1);
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index 168bd97540f8..ab94eb5ce039 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -75,7 +75,7 @@ void noinstr __no_stack_protector do_syscall(struct pt_regs *regs)
 	 *
 	 * The resulting 6 bits of entropy is seen in SP[9:4].
 	 */
-	choose_random_kstack_offset(drdtime());
+	choose_random_kstack_offset(get_cycles());
 
 	syscall_exit_to_user_mode(regs);
 }
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 1c31bf3a16ed..5892f6da07a5 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -18,6 +18,7 @@
 #include <asm/loongarch.h>
 #include <asm/paravirt.h>
 #include <asm/time.h>
+#include <asm/timex.h>
 
 u64 cpu_clock_freq;
 EXPORT_SYMBOL(cpu_clock_freq);
@@ -62,12 +63,12 @@ static int constant_set_state_oneshot(struct clock_event_device *evt)
 
 static int constant_set_state_periodic(struct clock_event_device *evt)
 {
-	unsigned long period;
 	unsigned long timer_config;
+	u64 period = const_clock_freq;
 
 	raw_spin_lock(&state_lock);
 
-	period = const_clock_freq / HZ;
+	do_div(period, HZ);
 	timer_config = period & CSR_TCFG_VAL;
 	timer_config |= (CSR_TCFG_PERIOD | CSR_TCFG_EN);
 	csr_write(timer_config, LOONGARCH_CSR_TCFG);
@@ -120,7 +121,7 @@ static int arch_timer_dying(unsigned int cpu)
 
 static unsigned long get_loops_per_jiffy(void)
 {
-	unsigned long lpj = (unsigned long)const_clock_freq;
+	u64 lpj = const_clock_freq;
 
 	do_div(lpj, HZ);
 
@@ -131,7 +132,7 @@ static long init_offset;
 
 void save_counter(void)
 {
-	init_offset = drdtime();
+	init_offset = get_cycles();
 }
 
 void sync_counter(void)
@@ -197,12 +198,12 @@ int constant_clockevent_init(void)
 
 static u64 read_const_counter(struct clocksource *clk)
 {
-	return drdtime();
+	return get_cycles64();
 }
 
 static noinstr u64 sched_clock_read(void)
 {
-	return drdtime();
+	return get_cycles64();
 }
 
 static struct clocksource clocksource_const = {
@@ -235,7 +236,7 @@ void __init time_init(void)
 	else
 		const_clock_freq = calc_const_freq();
 
-	init_offset = -(drdtime() - csr_read(LOONGARCH_CSR_CNTC));
+	init_offset = -(get_cycles() - csr_read(LOONGARCH_CSR_CNTC));
 
 	constant_clockevent_init();
 	constant_clocksource_init();
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 1245a6b35896..803224d297eb 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -9,6 +9,7 @@
 #include <asm/loongarch.h>
 #include <asm/setup.h>
 #include <asm/time.h>
+#include <asm/timex.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -811,7 +812,7 @@ static int kvm_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_LOONGARCH_KVM:
 		switch (reg->id) {
 		case KVM_REG_LOONGARCH_COUNTER:
-			*v = drdtime() + vcpu->kvm->arch.time_offset;
+			*v = get_cycles() + vcpu->kvm->arch.time_offset;
 			break;
 		case KVM_REG_LOONGARCH_DEBUG_INST:
 			*v = INSN_HVCL | KVM_HCALL_SWDBG;
@@ -906,7 +907,7 @@ static int kvm_set_one_reg(struct kvm_vcpu *vcpu,
 			 * only set for the first time for smp system
 			 */
 			if (vcpu->vcpu_id == 0)
-				vcpu->kvm->arch.time_offset = (signed long)(v - drdtime());
+				vcpu->kvm->arch.time_offset = (signed long)(v - get_cycles());
 			break;
 		case KVM_REG_LOONGARCH_VCPU_RESET:
 			vcpu->arch.st.guest_addr = 0;
-- 
2.47.3


