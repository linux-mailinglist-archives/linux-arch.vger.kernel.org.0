Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415B19E8F1
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfH0NSn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Aug 2019 09:18:43 -0400
Received: from foss.arm.com ([217.140.110.172]:44452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbfH0NSn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F85F15AD;
        Tue, 27 Aug 2019 06:18:42 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C8AF3F246;
        Tue, 27 Aug 2019 06:18:41 -0700 (PDT)
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5/6] arm64: mm: Ignore spurious translation faults taken from the kernel
Date:   Tue, 27 Aug 2019 14:18:17 +0100
Message-Id: <20190827131818.14724-6-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190827131818.14724-1-will@kernel.org>
References: <20190827131818.14724-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks to address translation being performed out of order with respect to
loads and stores, it is possible for a CPU to take a translation fault when
accessing a page that was mapped by a different CPU.

For example, in the case that one CPU maps a page and then sets a flag to
tell another CPU:

	CPU 0
	-----

	MOV	X0, <valid pte>
	STR	X0, [Xptep]	// Store new PTE to page table
	DSB	ISHST
	ISB
	MOV	X1, #1
	STR	X1, [Xflag]	// Set the flag

	CPU 1
	-----

loop:	LDAR	X0, [Xflag]	// Poll flag with Acquire semantics
	CBZ	X0, loop
	LDR	X1, [X2]	// Translates using the new PTE

then the final load on CPU 1 can raise a translation fault because the
translation can be performed speculatively before the read of the flag and
marked as "faulting" by the CPU. This isn't quite as bad as it sounds
since, in reality, code such as:

	CPU 0				CPU 1
	-----				-----
	spin_lock(&lock);		spin_lock(&lock);
	*ptr = vmalloc(size);		if (*ptr)
	spin_unlock(&lock);			foo = **ptr;
					spin_unlock(&lock);

will not trigger the fault because there is an address dependency on CPU 1
which prevents the speculative translation. However, more exotic code where
the virtual address is known ahead of time, such as:

	CPU 0				CPU 1
	-----				-----
	spin_lock(&lock);		spin_lock(&lock);
	set_fixmap(0, paddr, prot);	if (mapped)
	mapped = true;				foo = *fix_to_virt(0);
	spin_unlock(&lock);		spin_unlock(&lock);

could fault. This can be avoided by any of:

	* Introducing broadcast TLB maintenance on the map path
	* Adding a DSB;ISB sequence after checking a flag which indicates
	  that a virtual address is now mapped
	* Handling the spurious fault

Given that we have never observed a problem due to this under Linux and
future revisions of the architecture are being tightened so that
translation table walks are effectively ordered in the same way as explicit
memory accesses, we no longer treat spurious kernel faults as fatal if an
AT instruction indicates that the access does not trigger a translation
fault.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/mm/fault.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index cfd65b63f36f..9808da29a653 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/extable.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
@@ -242,6 +243,34 @@ static inline bool is_el1_permission_fault(unsigned long addr, unsigned int esr,
 	return false;
 }
 
+static bool __kprobes is_spurious_el1_translation_fault(unsigned long addr,
+							unsigned int esr,
+							struct pt_regs *regs)
+{
+	unsigned long flags;
+	u64 par, dfsc;
+
+	if (ESR_ELx_EC(esr) != ESR_ELx_EC_DABT_CUR ||
+	    (esr & ESR_ELx_FSC_TYPE) != ESR_ELx_FSC_FAULT)
+		return false;
+
+	local_irq_save(flags);
+	asm volatile("at s1e1r, %0" :: "r" (addr));
+	isb();
+	par = read_sysreg(par_el1);
+	local_irq_restore(flags);
+
+	if (!(par & SYS_PAR_EL1_F))
+		return false;
+
+	/*
+	 * If we got a different type of fault from the AT instruction,
+	 * treat the translation fault as spurious.
+	 */
+	dfsc = FIELD_PREP(SYS_PAR_EL1_FST, par);
+	return (dfsc & ESR_ELx_FSC_TYPE) != ESR_ELx_FSC_FAULT;
+}
+
 static void die_kernel_fault(const char *msg, unsigned long addr,
 			     unsigned int esr, struct pt_regs *regs)
 {
@@ -270,6 +299,10 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	if (!is_el1_instruction_abort(esr) && fixup_exception(regs))
 		return;
 
+	if (WARN_RATELIMIT(is_spurious_el1_translation_fault(addr, esr, regs),
+	    "Ignoring spurious kernel translation fault at virtual address %016lx\n", addr))
+		return;
+
 	if (is_el1_permission_fault(addr, esr, regs)) {
 		if (esr & ESR_ELx_WNR)
 			msg = "write to read-only memory";
-- 
2.11.0

