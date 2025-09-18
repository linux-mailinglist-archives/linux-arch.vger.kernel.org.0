Return-Path: <linux-arch+bounces-13466-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB71B509A3
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 02:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074691C281AB
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 00:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F5186E2E;
	Wed, 10 Sep 2025 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fshkTLLz"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B313E02A;
	Wed, 10 Sep 2025 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463037; cv=none; b=KZ7GwLEejedpVCXULyAkQkL9wXtWxdHeM2l/oHiBgKz5Oo37LiA4HVBa/ln6/8KgkvMpiHwHRykGB6scUvQ/OTiYC9D8pq8wbtDvs7QEHHMMB4KP1Jdmb8dtir3lZB+L4EnAdRRGQE//0461zqG2wUlhhy1i/4cT8D0EYebM5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463037; c=relaxed/simple;
	bh=0fiF7TVmOHve/0i+CB+eZc6YHFzzxecxe0zo+fkjgdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ivM2hy8Uy9AGfOFwYMp6xjljGRNKJoUVWipLWBZoW860QWuQD6IlmipXz60aVL5fp52pqG9f9EFLy8OrmpQH/Uz5hYv7brPAdd6qqqLUVg9BUGCGzuUSC6xa326ECmf9QuzX3NSePIfRPzpA3w3REjmbKY11pzqKA2SdORIgWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fshkTLLz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6497D2018E56;
	Tue,  9 Sep 2025 17:10:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6497D2018E56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757463033;
	bh=2FTn4CnQ7KJcElNbW/o0VAiSZfvCKgszKBMRoUHO02Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fshkTLLzfkZdHlIQxZZfS228c2ClxzdG5obDTgQ1n7357acZXXlNLhwimNo4H1rDH
	 S+LCYQhmH9rgTr4MKeOOqR/9ORqVG6KmLyF4BRf/WXsxF2zDQEdslf/bEhcMm1HEBr
	 Syb2wOHHrQwGG+Hs6j2dhG8R3xFiitfVbVcho2kQ=
From: Mukesh Rathor <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Subject: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection into vmcore
Date: Tue,  9 Sep 2025 17:10:08 -0700
Message-Id: <20250910001009.2651481-6-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new file to implement collection of hypervisor ram into the
vmcore collected by linux. By default, the hypervisor ram is locked, ie,
protected via hw page table. Hyper-V implements a disable hypercall which
essentially devirtualizes the system on the fly. This mechanism makes the
hypervisor ram accessible to linux. Because the hypervisor ram is already
mapped into linux address space (as reserved ram), it is automatically
collected into the vmcore without extra work. More details of the
implementation are available in the file prologue.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/hv_crash.c | 622 +++++++++++++++++++++++++++++++++++++
 1 file changed, 622 insertions(+)
 create mode 100644 arch/x86/hyperv/hv_crash.c

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
new file mode 100644
index 000000000000..531bac79d598
--- /dev/null
+++ b/arch/x86/hyperv/hv_crash.c
@@ -0,0 +1,622 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * X86 specific Hyper-V kdump/crash support module
+ *
+ * Copyright (C) 2025, Microsoft, Inc.
+ *
+ * This module implements hypervisor ram collection into vmcore for both
+ * cases of the hypervisor crash and linux dom0/root crash. Hyper-V implements
+ * a devirtualization hypercall with a 32bit protected mode ABI callback. This
+ * mechanism must be used to unlock hypervisor ram. Since the hypervisor ram
+ * is already mapped in linux, it is automatically collected into linux vmcore,
+ * and can be examined by the crash command (raw ram dump) or windbg.
+ *
+ * At a high level:
+ *
+ *  Hypervisor Crash:
+ *    Upon crash, hypervisor goes into an emergency minimal dispatch loop, a
+ *    restrictive mode with very limited hypercall and msr support. Each cpu
+ *    then injects NMIs into dom0/root vcpus. A shared page is used to check
+ *    by linux in the nmi handler if the hypervisor has crashed. This shared
+ *    page is setup in hv_root_crash_init during boot.
+ *
+ *  Linux Crash:
+ *    In case of linux crash, the callback hv_crash_stop_other_cpus will send
+ *    NMIs to all cpus, then proceed to the crash_nmi_callback where it waits
+ *    for all cpus to be in NMI.
+ *
+ *  NMI Handler (upon quorum):
+ *    Eventually, in both cases, all cpus wil end up in the nmi hanlder.
+ *    Hyper-V requires the disable hypervisor must be done from the bsp. So
+ *    the bsp nmi handler saves current context, does some fixups and makes
+ *    the hypercall to disable the hypervisor, ie, devirtualize. Hypervisor
+ *    at that point will suspend all vcpus (except the bsp), unlock all its
+ *    ram, and return to linux at the 32bit mode entry RIP.
+ *
+ *  Linux 32bit entry trampoline will then restore long mode and call C
+ *  function here to restore context and continue execution to crash kexec.
+ */
+
+#include <linux/delay.h>
+#include <linux/kexec.h>
+#include <linux/crash_dump.h>
+#include <linux/panic.h>
+#include <asm/apic.h>
+#include <asm/desc.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/mshyperv.h>
+#include <asm/nmi.h>
+#include <asm/idtentry.h>
+#include <asm/reboot.h>
+#include <asm/intel_pt.h>
+
+int hv_crash_enabled;
+EXPORT_SYMBOL_GPL(hv_crash_enabled);
+
+struct hv_crash_ctxt {
+	ulong rsp;
+	ulong cr0;
+	ulong cr2;
+	ulong cr4;
+	ulong cr8;
+
+	u16 cs;
+	u16 ss;
+	u16 ds;
+	u16 es;
+	u16 fs;
+	u16 gs;
+
+	u16 gdt_fill;
+	struct desc_ptr gdtr;
+	char idt_fill[6];
+	struct desc_ptr idtr;
+
+	u64 gsbase;
+	u64 efer;
+	u64 pat;
+};
+static struct hv_crash_ctxt hv_crash_ctxt;
+
+/* Shared hypervisor page that contains crash dump area we peek into.
+ * NB: windbg looks for "hv_cda" symbol so don't change it.
+ */
+static struct hv_crashdump_area *hv_cda;
+
+static u32 trampoline_pa, devirt_cr3arg;
+static atomic_t crash_cpus_wait;
+static void *hv_crash_ptpgs[4];
+static int hv_has_crashed, lx_has_crashed;
+
+/* This cannot be inlined as it needs stack */
+static noinline __noclone void hv_crash_restore_tss(void)
+{
+	load_TR_desc();
+}
+
+/* This cannot be inlined as it needs stack */
+static noinline void hv_crash_clear_kernpt(void)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+
+	/* Clear entry so it's not confusing to someone looking at the core */
+	pgd = pgd_offset_k(trampoline_pa);
+	p4d = p4d_offset(pgd, trampoline_pa);
+	native_p4d_clear(p4d);
+}
+
+/*
+ * This is the C entry point from the asm glue code after the devirt hypercall.
+ * We enter here in IA32-e long mode, ie, full 64bit mode running on kernel
+ * page tables with our below 4G page identity mapped, but using a temporary
+ * GDT. ds/fs/gs/es are null. ss is not usable. bp is null. stack is not
+ * available. We restore kernel GDT, and rest of the context, and continue
+ * to kexec.
+ */
+static asmlinkage void __noreturn hv_crash_c_entry(void)
+{
+	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
+
+	/* first thing, restore kernel gdt */
+	native_load_gdt(&ctxt->gdtr);
+
+	asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
+	asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
+
+	asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
+	asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
+	asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
+	asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
+
+	native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
+	asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
+
+	asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
+	asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
+	asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
+
+	native_load_idt(&ctxt->idtr);
+	native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
+	native_wrmsrq(MSR_EFER, ctxt->efer);
+
+	/* restore the original kernel CS now via far return */
+	asm volatile("movzwq %0, %%rax\n\t"
+		     "pushq %%rax\n\t"
+		     "pushq $1f\n\t"
+		     "lretq\n\t"
+		     "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
+
+	/* We are in asmlinkage without stack frame, hence make a C function
+	 * call which will buy stack frame to restore the tss or clear PT entry.
+	 */
+	hv_crash_restore_tss();
+	hv_crash_clear_kernpt();
+
+	/* we are now fully in devirtualized normal kernel mode */
+	__crash_kexec(NULL);
+
+	for (;;)
+		cpu_relax();
+}
+/* Tell gcc we are using lretq long jump in the above function intentionally */
+STACK_FRAME_NON_STANDARD(hv_crash_c_entry);
+
+static void hv_mark_tss_not_busy(void)
+{
+	struct desc_struct *desc = get_current_gdt_rw();
+	tss_desc tss;
+
+	memcpy(&tss, &desc[GDT_ENTRY_TSS], sizeof(tss_desc));
+	tss.type = 0x9;        /* available 64-bit TSS. 0xB is busy TSS */
+	write_gdt_entry(desc, GDT_ENTRY_TSS, &tss, DESC_TSS);
+}
+
+/* Save essential context */
+static void hv_hvcrash_ctxt_save(void)
+{
+	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
+
+	asm volatile("movq %%rsp,%0" : "=m"(ctxt->rsp));
+
+	ctxt->cr0 = native_read_cr0();
+	ctxt->cr4 = native_read_cr4();
+
+	asm volatile("movq %%cr2, %0" : "=a"(ctxt->cr2));
+	asm volatile("movq %%cr8, %0" : "=a"(ctxt->cr8));
+
+	asm volatile("movl %%cs, %%eax" : "=a"(ctxt->cs));
+	asm volatile("movl %%ss, %%eax" : "=a"(ctxt->ss));
+	asm volatile("movl %%ds, %%eax" : "=a"(ctxt->ds));
+	asm volatile("movl %%es, %%eax" : "=a"(ctxt->es));
+	asm volatile("movl %%fs, %%eax" : "=a"(ctxt->fs));
+	asm volatile("movl %%gs, %%eax" : "=a"(ctxt->gs));
+
+	native_store_gdt(&ctxt->gdtr);
+	store_idt(&ctxt->idtr);
+
+	ctxt->gsbase = __rdmsr(MSR_GS_BASE);
+	ctxt->efer = __rdmsr(MSR_EFER);
+	ctxt->pat = __rdmsr(MSR_IA32_CR_PAT);
+}
+
+/* Add trampoline page to the kernel pagetable for transition to kernel PT */
+static void hv_crash_fixup_kernpt(void)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+
+	pgd = pgd_offset_k(trampoline_pa);
+	p4d = p4d_offset(pgd, trampoline_pa);
+
+	/* trampoline_pa is below 4G, so no pre-existing entry to clobber */
+	p4d_populate(&init_mm, p4d, (pud_t *)hv_crash_ptpgs[1]);
+	p4d->p4d = p4d->p4d & ~(_PAGE_NX);    /* enable execute */
+}
+
+/*
+ * Now that all cpus are in nmi and spinning, we notify the hyp that linux has
+ * crashed and will collect core. This will cause the hyp to quiesce and
+ * suspend all VPs except the bsp. Called if linux crashed and not the hyp.
+ */
+static void hv_notify_prepare_hyp(void)
+{
+	u64 status;
+	struct hv_input_notify_partition_event *input;
+	struct hv_partition_event_root_crashdump_input *cda;
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	cda = &input->input.crashdump_input;
+	memset(input, 0, sizeof(*input));
+	input->event = HV_PARTITION_EVENT_ROOT_CRASHDUMP;
+
+	cda->crashdump_action = HV_CRASHDUMP_ENTRY;
+	status = hv_do_hypercall(HVCALL_NOTIFY_PARTITION_EVENT, input, NULL);
+	if (!hv_result_success(status))
+		return;
+
+	cda->crashdump_action = HV_CRASHDUMP_SUSPEND_ALL_VPS;
+	hv_do_hypercall(HVCALL_NOTIFY_PARTITION_EVENT, input, NULL);
+}
+
+/*
+ * Common function for all cpus before devirtualization.
+ *
+ * Hypervisor crash: all cpus get here in nmi context.
+ * Linux crash: the panicing cpu gets here at base level, all others in nmi
+ *		context. Note, panicing cpu may not be the bsp.
+ *
+ * The function is not inlined so it will show on the stack. It is named so
+ * because the crash cmd looks for certain well known function names on the
+ * stack before looking into the cpu saved note in the elf section, and
+ * that work is currently incomplete.
+ *
+ * Notes:
+ *  Hypervisor crash:
+ *    - the hypervisor is in a very restrictive mode at this point and any
+ *	vmexit it cannot handle would result in reboot. For example, console
+ *	output from here would result in synic ipi hcall, which would result
+ *	in reboot. So, no mumbo jumbo, just get to kexec as quickly as possible.
+ *
+ *  Devirtualization is supported from the bsp only.
+ */
+static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
+{
+	struct hv_input_disable_hyp_ex *input;
+	u64 status;
+	int msecs = 1000, ccpu = smp_processor_id();
+
+	if (ccpu == 0) {
+		/* crash_save_cpu() will be done in the kexec path */
+		cpu_emergency_stop_pt();	/* disable performance trace */
+		atomic_inc(&crash_cpus_wait);
+	} else {
+		crash_save_cpu(regs, ccpu);
+		cpu_emergency_stop_pt();	/* disable performance trace */
+		atomic_inc(&crash_cpus_wait);
+		for (;;);			/* cause no vmexits */
+	}
+
+	while (atomic_read(&crash_cpus_wait) < num_online_cpus() && msecs--)
+		mdelay(1);
+
+	stop_nmi();
+	if (!hv_has_crashed)
+		hv_notify_prepare_hyp();
+
+	if (crashing_cpu == -1)
+		crashing_cpu = ccpu;		/* crash cmd uses this */
+
+	hv_hvcrash_ctxt_save();
+	hv_mark_tss_not_busy();
+	hv_crash_fixup_kernpt();
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->rip = trampoline_pa;	/* PA of hv_crash_asm32 */
+	input->arg = devirt_cr3arg;	/* PA of trampoline page table L4 */
+
+	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
+
+	/* Devirt failed, just reboot as things are in very bad state now */
+	native_wrmsrq(HV_X64_MSR_RESET, 1);    /* get hv to reboot */
+}
+
+/*
+ * Generic nmi callback handler: could be called without any crash also.
+ *   hv crash: hypervisor injects nmi's into all cpus
+ *   lx crash: panicing cpu sends nmi to all but self via crash_stop_other_cpus
+ */
+static int hv_crash_nmi_local(unsigned int cmd, struct pt_regs *regs)
+{
+	int ccpu = smp_processor_id();
+
+	if (!hv_has_crashed && hv_cda && hv_cda->cda_valid)
+		hv_has_crashed = 1;
+
+	if (!hv_has_crashed && !lx_has_crashed)
+		return NMI_DONE;	/* ignore the nmi */
+
+	if (hv_has_crashed) {
+		if (!kexec_crash_loaded() || !hv_crash_enabled) {
+			if (ccpu == 0) {
+				native_wrmsrq(HV_X64_MSR_RESET, 1); /* reboot */
+			} else
+				for (;;);	/* cause no vmexits */
+		}
+	}
+
+	crash_nmi_callback(regs);
+
+	return NMI_DONE;
+}
+
+/*
+ * hv_crash_stop_other_cpus() == smp_ops.crash_stop_other_cpus
+ *
+ * On normal linux panic, this is called twice: first from panic and then again
+ * from native_machine_crash_shutdown.
+ *
+ * In case of mshv, 3 ways to get here:
+ *  1. hv crash (only bsp will get here):
+ *	BSP : nmi callback -> DisableHv -> hv_crash_asm32 -> hv_crash_c_entry
+ *		  -> __crash_kexec -> native_machine_crash_shutdown
+ *		  -> crash_smp_send_stop -> smp_ops.crash_stop_other_cpus
+ *  linux panic:
+ *	2. panic cpu x: panic() -> crash_smp_send_stop
+ *				     -> smp_ops.crash_stop_other_cpus
+ *	3. bsp: native_machine_crash_shutdown -> crash_smp_send_stop
+ *
+ * NB: noclone and non standard stack because of call to crash_setup_regs().
+ */
+static void __noclone hv_crash_stop_other_cpus(void)
+{
+	static int crash_stop_done;
+	struct pt_regs lregs;
+	int ccpu = smp_processor_id();
+
+	if (hv_has_crashed)
+		return;		/* all cpus already in nmi handler path */
+
+	if (!kexec_crash_loaded())
+		return;
+
+	if (crash_stop_done)
+		return;
+	crash_stop_done = 1;
+
+	/* linux has crashed: hv is healthy, we can ipi safely */
+	lx_has_crashed = 1;
+	wmb();			/* nmi handlers look at lx_has_crashed */
+
+	apic->send_IPI_allbutself(NMI_VECTOR);
+
+	if (crashing_cpu == -1)
+		crashing_cpu = ccpu;		/* crash cmd uses this */
+
+	/* crash_setup_regs() happens in kexec also, but for the kexec cpu which
+	 * is the bsp. We could be here on non-bsp cpu, collect regs if so.
+	 */
+	if (ccpu)
+		crash_setup_regs(&lregs, NULL);
+
+	crash_nmi_callback(&lregs);
+}
+STACK_FRAME_NON_STANDARD(hv_crash_stop_other_cpus);
+
+/* This GDT is accessed in IA32-e compat mode which uses 32bits addresses */
+struct hv_gdtreg_32 {
+	u16 fill;
+	u16 limit;
+	u32 address;
+} __packed;
+
+/* We need a CS with L bit to goto IA32-e long mode from 32bit compat mode */
+struct hv_crash_tramp_gdt {
+	u64 null;	/* index 0, selector 0, null selector */
+	u64 cs64;	/* index 1, selector 8, cs64 selector */
+} __packed;
+
+/* No stack, so jump via far ptr in memory to load the 64bit CS */
+struct hv_cs_jmptgt {
+	u32 address;
+	u16 csval;
+	u16 fill;
+} __packed;
+
+/* This trampoline data is copied onto the trampoline page after the asm code */
+struct hv_crash_tramp_data {
+	u64 tramp32_cr3;
+	u64 kernel_cr3;
+	struct hv_gdtreg_32 gdtr32;
+	struct hv_crash_tramp_gdt tramp_gdt;
+	struct hv_cs_jmptgt cs_jmptgt;
+	u64 c_entry_addr;
+} __packed;
+
+/*
+ * Setup a temporary gdt to allow the asm code to switch to the long mode.
+ * Since the asm code is relocated/copied to a below 4G page, it cannot use rip
+ * relative addressing, hence we must use trampoline_pa here. Also, save other
+ * info like jmp and C entry targets for same reasons.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+static int hv_crash_setup_trampdata(u64 trampoline_va)
+{
+	int size, offs;
+	void *dest;
+	struct hv_crash_tramp_data *tramp;
+
+	/* These must match exactly the ones in the corresponding asm file */
+	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, tramp32_cr3) != 0);
+	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, kernel_cr3) != 8);
+	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, gdtr32.limit) != 18);
+	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data,
+						     cs_jmptgt.address) != 40);
+
+	/* hv_crash_asm_end is beyond last byte by 1 */
+	size = &hv_crash_asm_end - &hv_crash_asm32;
+	if (size + sizeof(struct hv_crash_tramp_data) > PAGE_SIZE) {
+		pr_err("%s: trampoline page overflow\n", __func__);
+		return -1;
+	}
+
+	dest = (void *)trampoline_va;
+	memcpy(dest, &hv_crash_asm32, size);
+
+	dest += size;
+	dest = (void *)round_up((ulong)dest, 16);
+	tramp = (struct hv_crash_tramp_data *)dest;
+
+	/* see MAX_ASID_AVAILABLE in tlb.c: "PCID 0 is reserved for use by
+	 * non-PCID-aware users". Build cr3 with pcid 0
+	 */
+	tramp->tramp32_cr3 = __sme_pa(hv_crash_ptpgs[0]);
+
+	/* Note, when restoring X86_CR4_PCIDE, cr3[11:0] must be zero */
+	tramp->kernel_cr3 = __sme_pa(init_mm.pgd);
+
+	tramp->gdtr32.limit = sizeof(struct hv_crash_tramp_gdt);
+	tramp->gdtr32.address = trampoline_pa +
+				   (ulong)&tramp->tramp_gdt - trampoline_va;
+
+	 /* base:0 limit:0xfffff type:b dpl:0 P:1 L:1 D:0 avl:0 G:1 */
+	tramp->tramp_gdt.cs64 = 0x00af9a000000ffff;
+
+	tramp->cs_jmptgt.csval = 0x8;
+	offs = (ulong)&hv_crash_asm64_lbl - (ulong)&hv_crash_asm32;
+	tramp->cs_jmptgt.address = trampoline_pa + offs;
+
+	tramp->c_entry_addr = (u64)&hv_crash_c_entry;
+
+	devirt_cr3arg = trampoline_pa + (ulong)dest - trampoline_va;
+
+	return 0;
+}
+
+/*
+ * Build 32bit trampoline page table for transition from protected mode
+ * non-paging to long-mode paging. This transition needs pagetables below 4G.
+ */
+static void hv_crash_build_tramp_pt(void)
+{
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	u64 pa, addr = trampoline_pa;
+
+	p4d = hv_crash_ptpgs[0] + pgd_index(addr) * sizeof(p4d);
+	pa = virt_to_phys(hv_crash_ptpgs[1]);
+	set_p4d(p4d, __p4d(_PAGE_TABLE | pa));
+	p4d->p4d &= ~(_PAGE_NX);	/* disable no execute */
+
+	pud = hv_crash_ptpgs[1] + pud_index(addr) * sizeof(pud);
+	pa = virt_to_phys(hv_crash_ptpgs[2]);
+	set_pud(pud, __pud(_PAGE_TABLE | pa));
+
+	pmd = hv_crash_ptpgs[2] + pmd_index(addr) * sizeof(pmd);
+	pa = virt_to_phys(hv_crash_ptpgs[3]);
+	set_pmd(pmd, __pmd(_PAGE_TABLE | pa));
+
+	pte = hv_crash_ptpgs[3] + pte_index(addr) * sizeof(pte);
+	set_pte(pte, pfn_pte(addr >> PAGE_SHIFT, PAGE_KERNEL_EXEC));
+}
+
+/*
+ * Setup trampoline for devirtualization:
+ *  - a page below 4G, ie 32bit addr containing asm glue code that mshv jmps to
+ *    in protected mode.
+ *  - 4 pages for a temporary page table that asm code uses to turn paging on
+ *  - a temporary gdt to use in the compat mode.
+ *
+ *  Returns: 0 on success
+ */
+static int hv_crash_trampoline_setup(void)
+{
+	int i, rc, order;
+	struct page *page;
+	u64 trampoline_va;
+	gfp_t flags32 = GFP_KERNEL | GFP_DMA32 | __GFP_ZERO;
+
+	/* page for 32bit trampoline assembly code + hv_crash_tramp_data */
+	page = alloc_page(flags32);
+	if (page == NULL) {
+		pr_err("%s: failed to alloc asm stub page\n", __func__);
+		return -1;
+	}
+
+	trampoline_va = (u64)page_to_virt(page);
+	trampoline_pa = (u32)page_to_phys(page);
+
+	order = 2;	   /* alloc 2^2 pages */
+	page = alloc_pages(flags32, order);
+	if (page == NULL) {
+		pr_err("%s: failed to alloc pt pages\n", __func__);
+		free_page(trampoline_va);
+		return -1;
+	}
+
+	for (i = 0; i < 4; i++, page++)
+		hv_crash_ptpgs[i] = page_to_virt(page);
+
+	hv_crash_build_tramp_pt();
+
+	rc = hv_crash_setup_trampdata(trampoline_va);
+	if (rc)
+		goto errout;
+
+	return 0;
+
+errout:
+	free_page(trampoline_va);
+	free_pages((ulong)hv_crash_ptpgs[0], order);
+
+	return rc;
+}
+
+/* Setup for kdump kexec to collect hypervisor ram when running as mshv root */
+void hv_root_crash_init(void)
+{
+	int rc;
+	struct hv_input_get_system_property *input;
+	struct hv_output_get_system_property *output;
+	unsigned long flags;
+	u64 status;
+	union hv_pfn_range cda_info;
+
+	if (pgtable_l5_enabled()) {
+		pr_err("Hyper-V: crash dump not yet supported on 5level PTs\n");
+		return;
+	}
+
+	rc = register_nmi_handler(NMI_LOCAL, hv_crash_nmi_local, NMI_FLAG_FIRST,
+				  "hv_crash_nmi");
+	if (rc) {
+		pr_err("Hyper-V: failed to register crash nmi handler\n");
+		return;
+	}
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	memset(input, 0, sizeof(*input));
+	memset(output, 0, sizeof(*output));
+	input->property_id = HV_SYSTEM_PROPERTY_CRASHDUMPAREA;
+
+	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
+	cda_info.as_uint64 = output->hv_cda_info.as_uint64;
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("Hyper-V: %s: property:%d %s\n", __func__,
+		       input->property_id, hv_result_to_string(status));
+		goto err_out;
+	}
+
+	if (cda_info.base_pfn == 0) {
+		pr_err("Hyper-V: hypervisor crash dump area pfn is 0\n");
+		goto err_out;
+	}
+
+	hv_cda = phys_to_virt(cda_info.base_pfn << PAGE_SHIFT);
+
+	rc = hv_crash_trampoline_setup();
+	if (rc)
+		goto err_out;
+
+	smp_ops.crash_stop_other_cpus = hv_crash_stop_other_cpus;
+
+	crash_kexec_post_notifiers = true;
+	hv_crash_enabled = 1;
+	pr_info("Hyper-V: linux and hv kdump support enabled\n");
+
+	return;
+
+err_out:
+	unregister_nmi_handler(NMI_LOCAL, "hv_crash_nmi");
+	pr_err("Hyper-V: only linux (but not hyp) kdump support enabled\n");
+}
-- 
2.36.1.vfs.0.0


