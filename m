Return-Path: <linux-arch+bounces-14031-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D42BCDDC4
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 17:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED7D934FDF3
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9698826D4D8;
	Fri, 10 Oct 2025 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccSQzqIO"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263D2F90D3
	for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111295; cv=none; b=H1b13u7P31o0swyiWUvjKEqr3Je13hTVTRVtE9PjjWWgKValmS8DKzPH6pJZdaOr78Y9nsU3vjXLfmDg2eB3eias4CQREsKYmh0hp73T+tQeyYefyg+Eg6/pl4RUAbQCWJB8Qhg1Y7HpCu4e9ZOABqrZvSEGulMBhpyJFCoiebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111295; c=relaxed/simple;
	bh=VTyfa05lwmhXcbBavbgICIhnfR0mj66QOmvmyK/xxEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJEeuoo1e57ICX2t2UmcHVqs3xJRDWTZOpt/UrLTkYHZ6ZCYdTDPXTd+F2PKtz3VFABpXxNCWCRoZHOWPHORLEqv3p60L1KMaF16tQThCAo/h9rsoR+fJuMXFvl/JTQj7E0m1zEcOU4PPHDbJniqevDqni4boFFxgnaIqKrNsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccSQzqIO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760111293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cbj4zp7uSZx/T4/nBfgioKWu9VmcYJpiOH4O825NldU=;
	b=ccSQzqIO1678FWk4MIbVKKQF3DpBHjDrB7ukZAaCQ0S0olR2KRb3m6ot6eZuCPtF0LsBi9
	Tyt8M4nh1cTeChUQLbgffAH7DaxNXxO6MyPCu7MX2e7J90NVdUI9eslfh1JSKmfhBlpO56
	QTYbN8jhd2lmwUOcsO6q6xSdMcl+OYo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-vBNA1yILN1WPT3ArJUl3tA-1; Fri,
 10 Oct 2025 11:48:07 -0400
X-MC-Unique: vBNA1yILN1WPT3ArJUl3tA-1
X-Mimecast-MFC-AGG-ID: vBNA1yILN1WPT3ArJUl3tA_1760111281
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 509861800452;
	Fri, 10 Oct 2025 15:48:01 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.224.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98E831800576;
	Fri, 10 Oct 2025 15:47:46 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>,
	Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [RFC PATCH v6 28/29] x86/mm, mm/vmalloc: Defer kernel TLB flush IPIs under CONFIG_COALESCE_TLBI=y
Date: Fri, 10 Oct 2025 17:38:38 +0200
Message-ID: <20251010153839.151763-29-vschneid@redhat.com>
In-Reply-To: <20251010153839.151763-1-vschneid@redhat.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Previous commits have added an unconditional TLB flush right after
switching to the kernel CR3 on NOHZ_FULL CPUs, and a software signal to
determine whether a CPU has its kernel CR3 loaded.

Using these two components, we can now safely defer kernel TLB flush IPIs
targeting NOHZ_FULL CPUs executing in userspace (i.e. with the user CR3
loaded).

Note that the COALESCE_TLBI config option is introduced in a later commit,
when the whole feature is implemented.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/include/asm/tlbflush.h |  3 +++
 arch/x86/mm/tlb.c               | 34 ++++++++++++++++++++++++++-------
 mm/vmalloc.c                    | 34 ++++++++++++++++++++++++++++-----
 3 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index e39ae95b85072..6d533afd70952 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -321,6 +321,9 @@ extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
				unsigned long end, unsigned int stride_shift,
				bool freed_tables);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+#ifdef CONFIG_COALESCE_TLBI
+extern void flush_tlb_kernel_range_deferrable(unsigned long start, unsigned long end);
+#endif

 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 39f80111e6f17..aa3a83d5eccc2 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -12,6 +12,7 @@
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
 #include <linux/mmu_context.h>
+#include <linux/sched/isolation.h>

 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -1509,23 +1510,24 @@ static void do_kernel_range_flush(void *info)
		flush_tlb_one_kernel(addr);
 }

-static void kernel_tlb_flush_all(struct flush_tlb_info *info)
+static void kernel_tlb_flush_all(smp_cond_func_t cond, struct flush_tlb_info *info)
 {
	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
		invlpgb_flush_all();
	else
-		on_each_cpu(do_flush_tlb_all, NULL, 1);
+		on_each_cpu_cond(cond, do_flush_tlb_all, NULL, 1);
 }

-static void kernel_tlb_flush_range(struct flush_tlb_info *info)
+static void kernel_tlb_flush_range(smp_cond_func_t cond, struct flush_tlb_info *info)
 {
	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
		invlpgb_kernel_range_flush(info);
	else
-		on_each_cpu(do_kernel_range_flush, info, 1);
+		on_each_cpu_cond(cond, do_kernel_range_flush, info, 1);
 }

-void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+static inline void
+__flush_tlb_kernel_range(smp_cond_func_t cond, unsigned long start, unsigned long end)
 {
	struct flush_tlb_info *info;

@@ -1535,13 +1537,31 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
				  TLB_GENERATION_INVALID);

	if (info->end == TLB_FLUSH_ALL)
-		kernel_tlb_flush_all(info);
+		kernel_tlb_flush_all(cond, info);
	else
-		kernel_tlb_flush_range(info);
+		kernel_tlb_flush_range(cond, info);

	put_flush_tlb_info();
 }

+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	__flush_tlb_kernel_range(NULL, start, end);
+}
+
+#ifdef CONFIG_COALESCE_TLBI
+static bool flush_tlb_kernel_cond(int cpu, void *info)
+{
+	return housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) ||
+	       per_cpu(kernel_cr3_loaded, cpu);
+}
+
+void flush_tlb_kernel_range_deferrable(unsigned long start, unsigned long end)
+{
+	__flush_tlb_kernel_range(flush_tlb_kernel_cond, start, end);
+}
+#endif
+
 /*
  * This can be used from process context to figure out what the value of
  * CR3 is without needing to do a (slow) __read_cr3().
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5edd536ba9d2a..c42f413a7a693 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -494,6 +494,30 @@ void vunmap_range_noflush(unsigned long start, unsigned long end)
	__vunmap_range_noflush(start, end);
 }

+#ifdef CONFIG_COALESCE_TLBI
+/*
+ * !!! BIG FAT WARNING !!!
+ *
+ * The CPU is free to cache any part of the paging hierarchy it wants at any
+ * time. It's also free to set accessed and dirty bits at any time, even for
+ * instructions that may never execute architecturally.
+ *
+ * This means that deferring a TLB flush affecting freed page-table-pages (IOW,
+ * keeping them in a CPU's paging hierarchy cache) is a recipe for disaster.
+ *
+ * This isn't a problem for deferral of TLB flushes in vmalloc, because
+ * page-table-pages used for vmap() mappings are never freed - see how
+ * __vunmap_range_noflush() walks the whole mapping but only clears the leaf PTEs.
+ * If this ever changes, TLB flush deferral will cause misery.
+ */
+void __weak flush_tlb_kernel_range_deferrable(unsigned long start, unsigned long end)
+{
+	flush_tlb_kernel_range(start, end);
+}
+#else
+#define flush_tlb_kernel_range_deferrable(start, end) flush_tlb_kernel_range(start, end)
+#endif
+
 /**
  * vunmap_range - unmap kernel virtual addresses
  * @addr: start of the VM area to unmap
@@ -507,7 +531,7 @@ void vunmap_range(unsigned long addr, unsigned long end)
 {
	flush_cache_vunmap(addr, end);
	vunmap_range_noflush(addr, end);
-	flush_tlb_kernel_range(addr, end);
+	flush_tlb_kernel_range_deferrable(addr, end);
 }

 static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
@@ -2333,7 +2357,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,

	nr_purge_nodes = cpumask_weight(&purge_nodes);
	if (nr_purge_nodes > 0) {
-		flush_tlb_kernel_range(start, end);
+		flush_tlb_kernel_range_deferrable(start, end);

		/* One extra worker is per a lazy_max_pages() full set minus one. */
		nr_purge_helpers = atomic_long_read(&vmap_lazy_nr) / lazy_max_pages();
@@ -2436,7 +2460,7 @@ static void free_unmap_vmap_area(struct vmap_area *va)
	flush_cache_vunmap(va->va_start, va->va_end);
	vunmap_range_noflush(va->va_start, va->va_end);
	if (debug_pagealloc_enabled_static())
-		flush_tlb_kernel_range(va->va_start, va->va_end);
+		flush_tlb_kernel_range_deferrable(va->va_start, va->va_end);

	free_vmap_area_noflush(va);
 }
@@ -2884,7 +2908,7 @@ static void vb_free(unsigned long addr, unsigned long size)
	vunmap_range_noflush(addr, addr + size);

	if (debug_pagealloc_enabled_static())
-		flush_tlb_kernel_range(addr, addr + size);
+		flush_tlb_kernel_range_deferrable(addr, addr + size);

	spin_lock(&vb->lock);

@@ -2949,7 +2973,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
	free_purged_blocks(&purge_list);

	if (!__purge_vmap_area_lazy(start, end, false) && flush)
-		flush_tlb_kernel_range(start, end);
+		flush_tlb_kernel_range_deferrable(start, end);
	mutex_unlock(&vmap_purge_lock);
 }

--
2.51.0


