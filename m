Return-Path: <linux-arch+bounces-15041-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C2C7C66B
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 05:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 752C2362934
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 04:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6944D264612;
	Sat, 22 Nov 2025 04:39:40 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D3258EFF;
	Sat, 22 Nov 2025 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786380; cv=none; b=s9sqBx+LXM8zis2Y99G9uFmuuqeV9pUq8lv1X37+qaC65iSdAjIwC0CZ/MfXwS8m04fG0z6NJHQEmk7vLxcECtVK4s5MbFcnXALMqavd85L6OjXPloer/tl22V4vP78ZbDQHkuBIslsOjWjicmupvvKtNMorrNv1CjtECVBjeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786380; c=relaxed/simple;
	bh=2DyTattMOJ+L/fwbFXGMUTdkSAAP2m/xEF9Ja56dRI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmeNYXRY1Kp9Q4lEXZAUUZ0ZtklX8ENO7jt3zrgAynTATWiRmTOl48ggJfmhq0IwT+qyY5LR66AvdjBBOK9Iq08Mf0Xei/MOfiGBVX9WiQlJExt8KT1Jmf8ZKj9gEGOmGpQAubJ6bddjm9EPlqcpZhnu3oGdTUAvarJv77pTJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AE0C4CEF5;
	Sat, 22 Nov 2025 04:39:37 +0000 (UTC)
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
Subject: [PATCH V3 07/14] LoongArch: Adjust time routines for 32BIT/64BIT
Date: Sat, 22 Nov 2025 12:36:27 +0800
Message-ID: <20251122043634.3447854-8-chenhuacai@loongson.cn>
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

Adjust time routines for both 32BIT and 64BIT, including: rdtime_h() /
rdtime_l() definitions for 32BIT and rdtime_d() definition for 64BIT,
get_cycles() and get_cycles64() definitions for 32BIT/64BIT, show time
frequency info ("CPU MHz" and "BogoMIPS") in /proc/cpuinfo, etc.

Use do_div() for division which works on both 32BIT and 64BIT platforms.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/loongarch.h | 32 ++++++++++++++++++++++++-
 arch/loongarch/include/asm/timex.h     | 33 +++++++++++++++++++++++++-
 arch/loongarch/kernel/proc.c           | 10 ++++----
 arch/loongarch/kernel/syscall.c        |  2 +-
 arch/loongarch/kernel/time.c           | 15 ++++++------
 arch/loongarch/kvm/vcpu.c              |  5 ++--
 6 files changed, 80 insertions(+), 17 deletions(-)

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
index fb41e9e7a222..9ea52fad9690 100644
--- a/arch/loongarch/include/asm/timex.h
+++ b/arch/loongarch/include/asm/timex.h
@@ -18,7 +18,38 @@ typedef unsigned long cycles_t;
 
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
+#ifdef CONFIG_32BIT
+
+#define get_cycles_hi get_cycles_hi
+
+static inline cycles_t get_cycles_hi(void)
+{
+	return rdtime_h();
+}
+
+#endif
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
index 63d2b7e7e844..a8800d20e11b 100644
--- a/arch/loongarch/kernel/proc.c
+++ b/arch/loongarch/kernel/proc.c
@@ -20,11 +20,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	unsigned int prid = cpu_data[n].processor_id;
 	unsigned int version = cpu_data[n].processor_id & 0xff;
 	unsigned int fp_version = cpu_data[n].fpu_vers;
+	u64 freq = cpu_clock_freq, bogomips = lpj_fine * cpu_clock_freq;
 
 #ifdef CONFIG_SMP
 	if (!cpu_online(n))
 		return 0;
 #endif
+	do_div(freq, 10000);
+	do_div(bogomips, const_clock_freq * (5000/HZ));
 
 	/*
 	 * For the first processor also print the system type
@@ -41,11 +44,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "PRID\t\t\t: %s (%08x)\n", id_to_core_name(prid), prid);
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


