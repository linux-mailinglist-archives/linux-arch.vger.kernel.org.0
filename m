Return-Path: <linux-arch+bounces-9689-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E2A09B23
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 19:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00093AABF8
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA24224B0D;
	Fri, 10 Jan 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beALCmiN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED84821D5A5
	for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534487; cv=none; b=EV9QICGbuHbNuMzGjp2DQWEdWYFTh63yjehdClI0F5WSoNQ5PrtspOJQAyN4yI8Dy/9xJEh930IW6SbuaUNIiA3VW7/0sLPnTGiMb9wK5ayZijcDtLJMLPFsayRFM+T4mcP+kAvypxhlr5IIdb0WdYTbxIH6HpQCR7quEPoEOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534487; c=relaxed/simple;
	bh=x2YRvd2PJrOVmRl1EDQ1QR7VsXzIRAuxYJ+jR+SOTII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HA8HMB9mFRGlRt9ZOM0qjgpxTiSNEHHrT2eqYrXS/Kq/1SGUvPV6O31m+fD0M5TGSDJzzbblkz/or3DEFeYdV18oZn197VT1inKQUpaPVPIBvkeOQXZ/j3niah/0dwLJwODNMkq/1MIJINxNZTNToqVmkaRs6hcd0z8u7AF3iK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=beALCmiN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so19029365e9.3
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 10:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534468; x=1737139268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffc/jeUEwcE9NsWtGdDMnxjVfG4g8pYiskW7P1F5M34=;
        b=beALCmiN1ZxeRodmJ+TQnuW8T+kX0EJPj5cDpOtEPFeMOWFj+4IKu+B1OHoYFouUL4
         qm/i/gbDgTYe0kJHGDI8D1dd48KZK+3oVOUWDCpxET1fEw+H81+T/5KwG7YE8d4AEw70
         /obIDpWnLNNEeMc9eFjd5Z7QW1uc5fdgReciijNcwqn0dB+V3k2X7VbIhhnUEOSP3T+3
         H94GJA8oMWYWyQbmnswkB2HlfwU944nbX3I0BSdfGWFELIAAPcHu/73rq/LY71iL+PKu
         EGje6xEl4yRYIRE7F6nDpRz3f3XRLVlDvsdQ++cG55QKJ4HIZ+kMq09s6ScwpPHlroPY
         Cv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534468; x=1737139268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffc/jeUEwcE9NsWtGdDMnxjVfG4g8pYiskW7P1F5M34=;
        b=pExpx5HwbPYSFvp/1AEp5amsuqSotlauB9upKFKK6guUL6EU1jle4mUQzeT40SY2Qz
         656tv1xThzwrB/JF9q1BbF9GA5p/4Daurva9zJffCJ7A0ie9yNE82yM+Q2EEdQ6mnich
         AnXSUSA5ORgFZkcBhw6BvYQoGbocYYSmgJXt0AHfDb5WUSSNJvnAvC2q7u7aymWk2xKV
         N5oER8pirTNe5erC2aXS1/p5hnnvITFW8WgWAFwI1DApchPPFyc3z7hq4pV7DTxx6XwP
         07p3kMX1gQ8OJaAbRMM3/zw3jML1fK3pKzajy6/yP5L4mvZ7zuWjZ1q/ECpTRZPJmh4y
         x4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh+gyk8iqHSk9Xhy9PG3/7wXrxfjtX1hrGGrYHjbvnrBBw1rdIjQPuoiDIrObcAsDdiAYWl40wVg4v@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDXUvYXfE7PDao+Ba+XQK0WRoWK3W+1L0qaw+Igt0tQ3LNgn8
	G2YHGNH+l/7+ePXjQp+Z1GSXxPFzjqqjOU+Iz4rmedBjqJrUvtPNmJ6/DRs9Gw7J9U9/XIw4iMd
	B9vOnkeZUgQ==
X-Google-Smtp-Source: AGHT+IF/q1QCp5xw/vI+ho6WzVZa4JA3GTBWKWx8cvSyaKNRoxJopmgrWWLxru20teHN6JHe+1fTI5ygNpFhkw==
X-Received: from wmso37.prod.google.com ([2002:a05:600c:5125:b0:434:a98d:6a1c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524f:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-436e26d0cf9mr103592725e9.19.1736534468098;
 Fri, 10 Jan 2025 10:41:08 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:36 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-10-8419288bc805@google.com>
Subject: [PATCH RFC v2 10/29] mm: asi: asi_exit() on PF, skip handling if
 address is accessible
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, Ofir Weisse <oweisse@google.com>
Content-Type: text/plain; charset="utf-8"

From: Ofir Weisse <oweisse@google.com>

On a page-fault - do asi_exit(). Then check if now after the exit the
address is accessible. We do this by refactoring spurious_kernel_fault()
into two parts:

1. Verify that the error code value is something that could arise from a
lazy TLB update.
2. Walk the page table and verify permissions, which is now called
is_address_accessible(). We also define PTE_PRESENT() and PMD_PRESENT()
which are suitable for checking userspace pages. For the sake of
spurious faults,  pte_present() and pmd_present() are only good for
kernelspace pages. This is because these macros might return true even
if the present bit is 0 (only relevant for userspace).

checkpatch.pl VSPRINTF_SPECIFIER_PX - it's in a WARN that only fires in
a debug build of the kernel when we hit a disastrous bug, seems OK to
leak addresses.

RFC note: A separate refactoring/prep commit should be split out of this
patch.

Checkpatch-args: --ignore=VSPRINTF_SPECIFIER_PX
Signed-off-by: Ofir Weisse <oweisse@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/fault.c | 118 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b323ccb748de22adc7d9f0a16dd195edad..ee8f5417174e2956391d538f41e2475553ca4972 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -948,7 +948,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
 
-static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
+static __always_inline int kernel_protection_ok(unsigned long error_code, pte_t *pte)
 {
 	if ((error_code & X86_PF_WRITE) && !pte_write(*pte))
 		return 0;
@@ -959,6 +959,8 @@ static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
 	return 1;
 }
 
+static int kernel_access_ok(unsigned long error_code, unsigned long address, pgd_t *pgd);
+
 /*
  * Handle a spurious fault caused by a stale TLB entry.
  *
@@ -984,11 +986,6 @@ static noinline int
 spurious_kernel_fault(unsigned long error_code, unsigned long address)
 {
 	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int ret;
 
 	/*
 	 * Only writes to RO or instruction fetches from NX may cause
@@ -1004,6 +1001,50 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 		return 0;
 
 	pgd = init_mm.pgd + pgd_index(address);
+	return kernel_access_ok(error_code, address, pgd);
+}
+NOKPROBE_SYMBOL(spurious_kernel_fault);
+
+/*
+ * For kernel addresses, pte_present and pmd_present are sufficient for
+ * is_address_accessible. For user addresses these functions will return true
+ * even though the pte is not actually accessible by hardware (i.e _PAGE_PRESENT
+ * is not set). This happens in cases where the pages are physically present in
+ * memory, but they are not made accessible to hardware as they need software
+ * handling first:
+ *
+ * - ptes/pmds with _PAGE_PROTNONE need autonuma balancing (see pte_protnone(),
+ *   change_prot_numa(), and do_numa_page()).
+ *
+ * - pmds with _PAGE_PSE & !_PAGE_PRESENT are undergoing splitting (see
+ *   split_huge_page()).
+ *
+ * Here, we care about whether the hardware can actually access the page right
+ * now.
+ *
+ * These issues aren't currently present for PUD but we also have a custom
+ * PUD_PRESENT for a layer of future-proofing.
+ */
+#define PUD_PRESENT(pud) (pud_flags(pud) & _PAGE_PRESENT)
+#define PMD_PRESENT(pmd) (pmd_flags(pmd) & _PAGE_PRESENT)
+#define PTE_PRESENT(pte) (pte_flags(pte) & _PAGE_PRESENT)
+
+/*
+ * Check if an access by the kernel would cause a page fault. The access is
+ * described by a page fault error code (whether it was a write/instruction
+ * fetch) and address. This doesn't check for types of faults that are not
+ * expected to affect the kernel, e.g. PKU. The address can be user or kernel
+ * space, if user then we assume the access would happen via the uaccess API.
+ */
+static noinstr int
+kernel_access_ok(unsigned long error_code, unsigned long address, pgd_t *pgd)
+{
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int ret;
+
 	if (!pgd_present(*pgd))
 		return 0;
 
@@ -1012,27 +1053,27 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 		return 0;
 
 	if (p4d_leaf(*p4d))
-		return spurious_kernel_fault_check(error_code, (pte_t *) p4d);
+		return kernel_protection_ok(error_code, (pte_t *) p4d);
 
 	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
+	if (!PUD_PRESENT(*pud))
 		return 0;
 
 	if (pud_leaf(*pud))
-		return spurious_kernel_fault_check(error_code, (pte_t *) pud);
+		return kernel_protection_ok(error_code, (pte_t *) pud);
 
 	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
+	if (!PMD_PRESENT(*pmd))
 		return 0;
 
 	if (pmd_leaf(*pmd))
-		return spurious_kernel_fault_check(error_code, (pte_t *) pmd);
+		return kernel_protection_ok(error_code, (pte_t *) pmd);
 
 	pte = pte_offset_kernel(pmd, address);
-	if (!pte_present(*pte))
+	if (!PTE_PRESENT(*pte))
 		return 0;
 
-	ret = spurious_kernel_fault_check(error_code, pte);
+	ret = kernel_protection_ok(error_code, pte);
 	if (!ret)
 		return 0;
 
@@ -1040,12 +1081,11 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 	 * Make sure we have permissions in PMD.
 	 * If not, then there's a bug in the page tables:
 	 */
-	ret = spurious_kernel_fault_check(error_code, (pte_t *) pmd);
+	ret = kernel_protection_ok(error_code, (pte_t *) pmd);
 	WARN_ONCE(!ret, "PMD has incorrect permission bits\n");
 
 	return ret;
 }
-NOKPROBE_SYMBOL(spurious_kernel_fault);
 
 int show_unhandled_signals = 1;
 
@@ -1490,6 +1530,29 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 	}
 }
 
+static __always_inline void warn_if_bad_asi_pf(
+	unsigned long error_code, unsigned long address)
+{
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+	struct asi *target;
+
+	/*
+	 * It's a bug to access sensitive data from the "critical section", i.e.
+	 * on the path between asi_enter and asi_relax, where untrusted code
+	 * gets run. #PF in this state sees asi_intr_nest_depth() as 1 because
+	 * #PF increments it. We can't think of a better way to determine if
+	 * this has happened than to check the ASI pagetables, hence we can't
+	 * really have this check in non-debug builds unfortunately.
+	 */
+	VM_WARN_ONCE(
+		(target = asi_get_target(current)) != NULL &&
+		asi_intr_nest_depth() == 1 &&
+		!kernel_access_ok(error_code, address, asi_pgd(target)),
+		"ASI-sensitive data access from critical section, addr=%px error_code=%lx class=%s",
+		(void *) address, error_code, asi_class_name(target->class_id));
+#endif
+}
+
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
 	irqentry_state_t state;
@@ -1497,6 +1560,31 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 
 	address = cpu_feature_enabled(X86_FEATURE_FRED) ? fred_event_data(regs) : read_cr2();
 
+	if (static_asi_enabled() && !user_mode(regs)) {
+		pgd_t *pgd;
+
+		/* Can be a NOP even for ASI faults, because of NMIs */
+		asi_exit();
+
+		/*
+		 * handle_page_fault() might oops if we run it for a kernel
+		 * address in kernel mode. This might be the case if we got here
+		 * due to an ASI fault. We avoid this case by checking whether
+		 * the address is now, after asi_exit(), accessible by hardware.
+		 * If it is - there's nothing to do. Note that this is a bit of
+		 * a shotgun; we can also bail early from user-address faults
+		 * here that weren't actually caused by ASI. So we might wanna
+		 * move this logic later in the handler. In particular, we might
+		 * be losing some stats here. However for now this keeps ASI
+		 * page faults nice and fast.
+		 */
+		pgd = (pgd_t *)__va(read_cr3_pa()) + pgd_index(address);
+		if (!user_mode(regs) && kernel_access_ok(error_code, address, pgd)) {
+			warn_if_bad_asi_pf(error_code, address);
+			return;
+		}
+	}
+
 	prefetchw(&current->mm->mmap_lock);
 
 	/*

-- 
2.47.1.613.gc27f4b7a9f-goog


