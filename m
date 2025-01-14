Return-Path: <linux-arch+bounces-9776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D051A10F5D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 19:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C08A16A374
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35722652D;
	Tue, 14 Jan 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNZqEs2Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CE226188
	for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877829; cv=none; b=pPvD3EGlF96x+v1HSZHYsIPl81st9LlZITOGx70qFz/QSa0n3LQ7ln0asC5lrDTA3ZKHJyrxCO/fhpzYd0cAPXv6uCsw9HuVk9VSKgdaouvd6zWsGf5736e/JfpyxULYG4nqqaRVQ8GXy4WpD1SHyUvj3wt3YGJUa71d82RmDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877829; c=relaxed/simple;
	bh=BjhL1mvVgbiyUP5EFcXboLt0cmy2uCP8vakiLKoCaCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRMw9KuyACVKmNiwxP03n7jUGEtXAtEQbY5Cke3allMJplkfn63LZt+9VChomUsfUJJkl41LqUipgnl5ZPO+L2d1MQ3P3jCjyH2fpO6HAJzBSFeXYpNqO661JPboVOV/rrfCBHHO6CSJlSgbDSTa5a5iBUaFqaxPntD88VOTjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNZqEs2Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736877825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le8UIdWvg/w/MVcf7PTpfkO3a8bfCjcr6cLgmw3M858=;
	b=DNZqEs2YY90KWegLtUNMKTwGRPETPz7uCY9w/Jl4tAw8gybvD7b4bi/cWIqw/SuBJbNp7i
	yVj1xOiIOjCmvBJAvMr3WjQO/v0r9DOwvBiK8rQUtX2Sy+QytQV4Nst4RLwqpYrvj7rvxO
	Uv0Gq9b9D4k9p6dc95qGs2pBbe0XxHM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-RjogcdnCPlS1FV6yZ4Sprw-1; Tue,
 14 Jan 2025 13:03:43 -0500
X-MC-Unique: RjogcdnCPlS1FV6yZ4Sprw-1
X-Mimecast-MFC-AGG-ID: RjogcdnCPlS1FV6yZ4Sprw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C8EC19560B3;
	Tue, 14 Jan 2025 18:03:39 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.55])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2905C195608A;
	Tue, 14 Jan 2025 18:03:16 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Cc: Peter Zijlstra <peterz@infradead.org>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rong Xu <xur@google.com>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v4 26/30] x86,tlb: Make __flush_tlb_global() noinstr-compliant
Date: Tue, 14 Jan 2025 18:51:39 +0100
Message-ID: <20250114175143.81438-27-vschneid@redhat.com>
In-Reply-To: <20250114175143.81438-1-vschneid@redhat.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Peter Zijlstra <peterz@infradead.org>

Later patches will require issuing a __flush_tlb_all() from noinstr code.
This requires making both __flush_tlb_local() and __flush_tlb_global()
noinstr-compliant.

For __flush_tlb_global(), both native_flush_tlb_global() and xen_flush_tlb()
need to be made noinstr.

Forgo using __native_flush_tlb_global() / native_write_cr4() and have the
ASM directly inlined in the native function. For the Xen stuff,
__always_inline a handful of helpers.

Not-signed-off-by: Peter Zijlstra <peterz@infradead.org>
[Changelog faff]
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/include/asm/invpcid.h       | 13 ++++++-------
 arch/x86/include/asm/paravirt.h      |  2 +-
 arch/x86/include/asm/xen/hypercall.h | 11 +++++++++--
 arch/x86/mm/tlb.c                    | 15 +++++++++++----
 arch/x86/xen/mmu_pv.c                | 10 +++++-----
 arch/x86/xen/xen-ops.h               | 12 ++++++++----
 6 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/invpcid.h b/arch/x86/include/asm/invpcid.h
index 734482afbf81d..ff26136fcd9c6 100644
--- a/arch/x86/include/asm/invpcid.h
+++ b/arch/x86/include/asm/invpcid.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_INVPCID
 #define _ASM_X86_INVPCID
 
-static inline void __invpcid(unsigned long pcid, unsigned long addr,
+static __always_inline void __invpcid(unsigned long pcid, unsigned long addr,
 			     unsigned long type)
 {
 	struct { u64 d[2]; } desc = { { pcid, addr } };
@@ -13,7 +13,7 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
 	 * mappings, we don't want the compiler to reorder any subsequent
 	 * memory accesses before the TLB flush.
 	 */
-	asm volatile("invpcid %[desc], %[type]"
+	asm_inline volatile("invpcid %[desc], %[type]"
 		     :: [desc] "m" (desc), [type] "r" (type) : "memory");
 }
 
@@ -23,26 +23,25 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
 #define INVPCID_TYPE_ALL_NON_GLOBAL	3
 
 /* Flush all mappings for a given pcid and addr, not including globals. */
-static inline void invpcid_flush_one(unsigned long pcid,
-				     unsigned long addr)
+static __always_inline void invpcid_flush_one(unsigned long pcid, unsigned long addr)
 {
 	__invpcid(pcid, addr, INVPCID_TYPE_INDIV_ADDR);
 }
 
 /* Flush all mappings for a given PCID, not including globals. */
-static inline void invpcid_flush_single_context(unsigned long pcid)
+static __always_inline void invpcid_flush_single_context(unsigned long pcid)
 {
 	__invpcid(pcid, 0, INVPCID_TYPE_SINGLE_CTXT);
 }
 
 /* Flush all mappings, including globals, for all PCIDs. */
-static inline void invpcid_flush_all(void)
+static __always_inline void invpcid_flush_all(void)
 {
 	__invpcid(0, 0, INVPCID_TYPE_ALL_INCL_GLOBAL);
 }
 
 /* Flush all mappings for all PCIDs except globals. */
-static inline void invpcid_flush_all_nonglobals(void)
+static __always_inline void invpcid_flush_all_nonglobals(void)
 {
 	__invpcid(0, 0, INVPCID_TYPE_ALL_NON_GLOBAL);
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d4eb9e1d61b8e..b3daee3d46677 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -75,7 +75,7 @@ static inline void __flush_tlb_local(void)
 	PVOP_VCALL0(mmu.flush_tlb_user);
 }
 
-static inline void __flush_tlb_global(void)
+static __always_inline void __flush_tlb_global(void)
 {
 	PVOP_VCALL0(mmu.flush_tlb_kernel);
 }
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 97771b9d33af3..291e9f8006f62 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -365,8 +365,8 @@ MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
 	trace_xen_mc_entry(mcl, 4);
 }
 
-static inline void
-MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
+static __always_inline void
+__MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
 		int *success_count, domid_t domid)
 {
 	mcl->op = __HYPERVISOR_mmuext_op;
@@ -374,6 +374,13 @@ MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
 	mcl->args[1] = count;
 	mcl->args[2] = (unsigned long)success_count;
 	mcl->args[3] = domid;
+}
+
+static inline void
+MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
+		int *success_count, domid_t domid)
+{
+	__MULTI_mmuext_op(mcl, op, count, success_count, domid);
 
 	trace_xen_mc_entry(mcl, 4);
 }
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index a2becb85bea79..2d2ab3e221f0c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1169,9 +1169,10 @@ void flush_tlb_one_user(unsigned long addr)
 /*
  * Flush everything
  */
-STATIC_NOPV void native_flush_tlb_global(void)
+STATIC_NOPV noinstr void native_flush_tlb_global(void)
 {
 	unsigned long flags;
+	unsigned long cr4;
 
 	if (static_cpu_has(X86_FEATURE_INVPCID)) {
 		/*
@@ -1190,9 +1191,15 @@ STATIC_NOPV void native_flush_tlb_global(void)
 	 * be called from deep inside debugging code.)
 	 */
 	raw_local_irq_save(flags);
-
-	__native_tlb_flush_global(this_cpu_read(cpu_tlbstate.cr4));
-
+	cr4 = this_cpu_read(cpu_tlbstate.cr4);
+	asm volatile("mov %0,%%cr4": : "r" (cr4 ^ X86_CR4_PGE) : "memory");
+	asm volatile("mov %0,%%cr4": : "r" (cr4) : "memory");
+	/*
+	 * In lieu of not having the pinning crap, hard fail if CR4 doesn't
+	 * match the expected value. This ensures that anybody doing dodgy gets
+	 * the fallthrough check.
+	 */
+	BUG_ON(cr4 != this_cpu_read(cpu_tlbstate.cr4));
 	raw_local_irq_restore(flags);
 }
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 55a4996d0c04f..4eb265eb867af 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1231,22 +1231,22 @@ static noinstr void xen_write_cr2(unsigned long cr2)
 	this_cpu_read(xen_vcpu)->arch.cr2 = cr2;
 }
 
-static noinline void xen_flush_tlb(void)
+static noinline noinstr void xen_flush_tlb(void)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	preempt_disable();
+	preempt_disable_notrace();
 
 	mcs = xen_mc_entry(sizeof(*op));
 
 	op = mcs.args;
 	op->cmd = MMUEXT_TLB_FLUSH_LOCAL;
-	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+	__MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
 
-	xen_mc_issue(XEN_LAZY_MMU);
+	__xen_mc_issue(XEN_LAZY_MMU);
 
-	preempt_enable();
+	preempt_enable_notrace();
 }
 
 static void xen_flush_tlb_one_user(unsigned long addr)
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 63c13a2ccf556..effb1a54afbd1 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -235,15 +235,19 @@ static inline struct multicall_space xen_mc_entry(size_t args)
 void xen_mc_flush(void);
 
 /* Issue a multicall if we're not in a lazy mode */
-static inline void xen_mc_issue(unsigned mode)
+static __always_inline void __xen_mc_issue(unsigned mode)
 {
-	trace_xen_mc_issue(mode);
-
 	if ((xen_get_lazy_mode() & mode) == 0)
 		xen_mc_flush();
 
 	/* restore flags saved in xen_mc_batch */
-	local_irq_restore(this_cpu_read(xen_mc_irq_flags));
+	raw_local_irq_restore(this_cpu_read(xen_mc_irq_flags));
+}
+
+static inline void xen_mc_issue(unsigned mode)
+{
+	trace_xen_mc_issue(mode);
+	__xen_mc_issue(mode);
 }
 
 /* Set up a callback to be called when the current batch is flushed */
-- 
2.43.0


