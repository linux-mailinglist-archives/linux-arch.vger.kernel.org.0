Return-Path: <linux-arch+bounces-9691-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91412A09A72
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 19:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E113A7CDD
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42847225791;
	Fri, 10 Jan 2025 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7V6d91L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B921507F
	for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534499; cv=none; b=sxrmp7f2FVfpDff5WfWv/hf4eREM8Ir4tPiT9nhKrdnJQVWF40jvnCe4xSvHnB3TM+08U4uzH30vI+C5lR4FDUvwjiVFkZ+zOBmGy8xnpacxqruFY+woJrxb7MOYTkJYEqZhT76ddrxw4NjJCFI7OhQecfRIxcr1DbcOevJKSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534499; c=relaxed/simple;
	bh=1374Do4Rx2F5pY+EGpqwdcNLe6jMXYdydvm0BHDKH7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CUqFe61fVhlbtv17Hdplglvr6PZQZfa6pRoSTs2xo+30RFM1ZE+CKMVeqHFjV052QJs02NE63SfsOP/lr/LnpwSN+Z12isvzj2LmopctGWb+fa7Pss7wWjp46vWMydeugpJfp2kOWAA6Na+8yZy6kTHw8/EVvqVKLllE/+BYi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M7V6d91L; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385d6ee042eso1539532f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 10:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534477; x=1737139277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pY19vAYDyHEycAFKYfxYiz+ttrD3KEZuAB5DIP4OiZk=;
        b=M7V6d91Lx4FnIcYROEe46v49we10lUAoEPRi2eKJXhdYdaPswzoGst6Q38EheJqOBJ
         vbhyipVXnKIQY48E9TAoKjnfeCxyF7x9IyESZv/y7l7kuHj9LRRvsRXEoJn7kMefY3/o
         eboiiowzu2FkiN2ZlouPNVngswdDY4sNhdkqWPxlGl7sJ5qc/NDjb4SnR2SMT/vFKVDp
         U1wr/kHdv5WYjD+eKYLvYil4gB5A6hO32vDCYH5qdeddVijuj25SHhCXgOUxdX2+pHkV
         EnIYmA1MG5eJ+06TpGvr66vz+vD/9gBaopm+BTIB83edaphDB+mbKT+mLQDHgZy7eN91
         mecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534477; x=1737139277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pY19vAYDyHEycAFKYfxYiz+ttrD3KEZuAB5DIP4OiZk=;
        b=ER0nbPoQiHhV9xRuDTPG3+4hwblc7il9TdCh6HuTU/TOowPfziySKpxqj6Rm4gwBzm
         HlaGcXLMpmACaXq459AAWiO70Xv5fk127Ssfye2SvCUsLCXsAaBJxa7QCvhvynenAncS
         D/iF6TQfe61mNd2KE+0gawc3AvVakj/1uYrKQve7xNXtwYAYp6r46BTaxc2eThmfYHjD
         dU3akKSNuKThOculqyG2nIbRiqW2sJ2fpELQTBxz80g8WyRF02lWj8wZueJcEE4gFfw/
         HG3o9SBaDT5aRyMwUQ8P3ilGMr3gwC66eV5YKAPvZ6KArq3WhFdOApAuLYVm5g5cVkFU
         uoaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNEy97fvhYeb9kfa+RZ6Koh9FoNFNNMJuIgTKPGV9V6H9bB5VmbZ6029hiVBtOKpe2w8jFhiLBG4A9@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzbU10c4S5l6J+1WT/BNaBeuah0zs1l9Xhu3VtbFA554sBGso
	iWjs/xllXTyOyouDXEXkk7wIHkDESTsXceXXUD2ECUwmWmLrf0RaS1Af3f5t1eeglAh1ZAZcFR1
	tJzCqjPGKRA==
X-Google-Smtp-Source: AGHT+IH1S1jc9i/BllMTXkt6dmv+P02SGjsqDnUUQ50M5C80r6DIU0GdLO3snheexKkp2plBsUVSQfJITnAXdg==
X-Received: from wmbfk13.prod.google.com ([2002:a05:600c:ccd:b0:434:f9da:44af])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:154a:b0:385:eeb9:a5bb with SMTP id ffacd0b85a97d-38a872de3femr10883177f8f.17.1736534477376;
 Fri, 10 Jan 2025 10:41:17 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:40 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-14-8419288bc805@google.com>
Subject: [PATCH RFC v2 14/29] mm: asi: Map non-user buddy allocations as nonsensitive
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
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This is just simplest possible page_alloc patch I could come up with to
demonstrate ASI working in a "denylist" mode: we map the direct map into
the restricted address space, except pages allocated with GFP_USER.

Pages must be asi_unmap()'d before they can be re-allocated. This
requires a TLB flush, which can't generally be done from the free path
(requires IRQs on), so pages that need unmapping are freed via a
workqueue.

This solution is not ideal:

 - If the async queue gets long, we'll run out of allocatable memory.
 - We don't batch the TLB flushing or worker wakeups at all.
 - We drop FPI flags and skip the pcplists.

Internally at Google we've so far found with extra complexity we're able
to make this solution work for the workloads we've tested so far. It
seems likely this won't keep working forever. So instead for the [PATCH]
version I hope to come up with an implementation that instead just makes
the allocator more deeply aware of sensitivity, most likely this will
look a bit like an extra "dimension" like movability etc. This was
discussed at LSF/MM/BPF [1], I plan to research this right after RFCv2.
However, once that research is done we might want to consider merging a
sub-optimal solution to unblock iteration and development.

[1] https://youtu.be/WD9-ey8LeiI

The main thing in here that is "real" and may warrant discussion is
__GFP_SENSITIVE (or at least, some sort of allocator switch to determine
sensitivity, in an "allowlist" model we would probably have the
opposite, and in future iterations we might want additional options for
different "types" of sensitivity). I think we need this as an extension
to the allocation API; the main alternative would be to infer from
context of the allocation whether the data should be treated as
sensitive; however I think we will have contexts where both sensitive
and nonsensitive data needs to be allocatable.

If there are concerns about __GFP flags specifically, rather than just
the general problem of expanding the allocator API, we could always just
provide an API like __alloc_pages_sensitive or something, implemented
with ALLOC_ flags internally.

Checkpatch-args: --ignore=SPACING,MACRO_ARG_UNUSED,COMPLEX_MACRO
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/asi.c              |  33 +++++++++-
 include/linux/gfp.h            |   5 ++
 include/linux/gfp_types.h      |  15 ++++-
 include/linux/page-flags.h     |  11 ++++
 include/trace/events/mmflags.h |  12 +++-
 mm/mm_init.c                   |   1 +
 mm/page_alloc.c                | 134 ++++++++++++++++++++++++++++++++++++++++-
 tools/perf/builtin-kmem.c      |   1 +
 8 files changed, 205 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 17391ec8b22e3c0903cd5ca29cbb03fcc4cbacce..b951f2100b8bdea5738ded16166255deb29faf57 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -5,6 +5,8 @@
 #include <linux/spinlock.h>
 
 #include <linux/init.h>
+#include <linux/pgtable.h>
+
 #include <asm/asi.h>
 #include <asm/cmdline.h>
 #include <asm/cpufeature.h>
@@ -104,10 +106,17 @@ const char *asi_class_name(enum asi_class_id class_id)
  *    allocator from interrupts and the page allocator ultimately calls this
  *    code.
  *  - They support customizing the allocation flags.
+ *  - They avoid infinite recursion when the page allocator calls back to
+ *    asi_map
  *
  * On the other hand, they do not use the normal page allocation infrastructure,
  * that means that PTE pages do not have the PageTable type nor the PagePgtable
  * flag and we don't increment the meminfo stat (NR_PAGETABLE) as they do.
+ *
+ * As an optimisation we attempt to map the pagetables in
+ * ASI_GLOBAL_NONSENSITIVE, but this can fail, and for simplicity we don't do
+ * anything about that. This means it's invalid to access ASI pagetables from a
+ * critical section.
  */
 static_assert(!IS_ENABLED(CONFIG_PARAVIRT));
 #define DEFINE_ASI_PGTBL_ALLOC(base, level)				\
@@ -116,8 +125,11 @@ static level##_t * asi_##level##_alloc(struct asi *asi,			\
 				       gfp_t flags)			\
 {									\
 	if (unlikely(base##_none(*base))) {				\
-		ulong pgtbl = get_zeroed_page(flags);			\
+		/* Stop asi_map calls causing recursive allocation */	\
+		gfp_t pgtbl_gfp = flags | __GFP_SENSITIVE;		\
+		ulong pgtbl = get_zeroed_page(pgtbl_gfp);		\
 		phys_addr_t pgtbl_pa;					\
+		int err;						\
 									\
 		if (!pgtbl)						\
 			return NULL;					\
@@ -131,6 +143,16 @@ static level##_t * asi_##level##_alloc(struct asi *asi,			\
 		}							\
 									\
 		mm_inc_nr_##level##s(asi->mm);				\
+									\
+		err = asi_map_gfp(ASI_GLOBAL_NONSENSITIVE,		\
+				  (void *)pgtbl, PAGE_SIZE, flags);	\
+		if (err)						\
+			/* Should be rare. Spooky. */			\
+			pr_warn_ratelimited("Created sensitive ASI %s (%pK, maps %luK).\n",\
+				#level, (void *)pgtbl, addr);		\
+		else							\
+			__SetPageGlobalNonSensitive(virt_to_page(pgtbl));\
+									\
 	}								\
 out:									\
 	VM_BUG_ON(base##_leaf(*base));					\
@@ -586,6 +608,9 @@ static bool follow_physaddr(
  * reason for this is that we don't want to unexpectedly undo mappings that
  * weren't created by the present caller.
  *
+ * This must not be called from the critical section, as ASI's pagetables are
+ * not guaranteed to be mapped in the restricted address space.
+ *
  * If the source mapping is a large page and the range being mapped spans the
  * entire large page, then it will be mapped as a large page in the ASI page
  * tables too. If the range does not span the entire huge page, then it will be
@@ -606,6 +631,9 @@ int __must_check asi_map_gfp(struct asi *asi, void *addr, unsigned long len, gfp
 	if (!static_asi_enabled())
 		return 0;
 
+	/* ASI pagetables might be sensitive. */
+	WARN_ON_ONCE(asi_in_critical_section());
+
 	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
 	VM_BUG_ON(!IS_ALIGNED(len, PAGE_SIZE));
 	/* RFC: fault_in_kernel_space should be renamed. */
@@ -706,6 +734,9 @@ void asi_unmap(struct asi *asi, void *addr, size_t len)
 	if (!static_asi_enabled() || !len)
 		return;
 
+	/* ASI pagetables might be sensitive. */
+	WARN_ON_ONCE(asi_in_critical_section());
+
 	VM_BUG_ON(start & ~PAGE_MASK);
 	VM_BUG_ON(len & ~PAGE_MASK);
 	VM_BUG_ON(!fault_in_kernel_space(start)); /* Misnamed, ignore "fault_" */
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index a951de920e208991b37fb2d878d9a0e9c550548c..dd3678b5b08016ceaee2d8e1932bf4aefbc7efb0 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -396,6 +396,11 @@ extern void page_frag_free(void *addr);
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
 
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+void page_alloc_init_asi(void);
+#else
+static inline void page_alloc_init_asi(void) { }
+#endif
 void page_alloc_init_cpuhp(void);
 int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f9053c701e24bdcf1dfe6afbf1278a2d..5147dbd53eafdccc32cfd506569b04d5c082d1b2 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -58,6 +58,7 @@ enum {
 #ifdef CONFIG_SLAB_OBJ_EXT
 	___GFP_NO_OBJ_EXT_BIT,
 #endif
+	___GFP_SENSITIVE_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -103,6 +104,11 @@ enum {
 #else
 #define ___GFP_NO_OBJ_EXT       0
 #endif
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+#define ___GFP_SENSITIVE	BIT(___GFP_SENSITIVE_BIT)
+#else
+#define ___GFP_SENSITIVE 0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -299,6 +305,12 @@ enum {
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
+/*
+ * Allocate sensitive memory, i.e. do not map it into ASI's restricted address
+ * space.
+ */
+#define __GFP_SENSITIVE	((__force gfp_t)___GFP_SENSITIVE)
+
 /* Room for N __GFP_FOO bits */
 #define __GFP_BITS_SHIFT ___GFP_LAST_BIT
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -380,7 +392,8 @@ enum {
 #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
 #define GFP_NOIO	(__GFP_RECLAIM)
 #define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
-#define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
+#define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | \
+			 __GFP_HARDWALL | __GFP_SENSITIVE)
 #define GFP_DMA		__GFP_DMA
 #define GFP_DMA32	__GFP_DMA32
 #define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 7ee9a0edc6d21708fc93dfa8913dc1ae9478dee3..761b082f1885976b860196d8e69044276e8fa9ca 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -125,6 +125,9 @@ enum pageflags {
 #endif
 #ifdef CONFIG_ARCH_USES_PG_ARCH_3
 	PG_arch_3,
+#endif
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+	PG_global_nonsensitive,
 #endif
 	__NR_PAGEFLAGS,
 
@@ -632,6 +635,14 @@ FOLIO_TEST_CLEAR_FLAG_FALSE(young)
 FOLIO_FLAG_FALSE(idle)
 #endif
 
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+__PAGEFLAG(GlobalNonSensitive, global_nonsensitive, PF_ANY);
+#define __PG_GLOBAL_NONSENSITIVE (1UL << PG_global_nonsensitive)
+#else
+__PAGEFLAG_FALSE(GlobalNonSensitive, global_nonsensitive);
+#define __PG_GLOBAL_NONSENSITIVE 0
+#endif
+
 /*
  * PageReported() is used to track reported free pages within the Buddy
  * allocator. We can use the non-atomic version of the test and set
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa21971862b6f200263c74cedff3882..a511a76b4310e949fd5b40b01253cf7d262f0177 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -50,7 +50,8 @@
 	gfpflag_string(__GFP_RECLAIM),		\
 	gfpflag_string(__GFP_DIRECT_RECLAIM),	\
 	gfpflag_string(__GFP_KSWAPD_RECLAIM),	\
-	gfpflag_string(__GFP_ZEROTAGS)
+	gfpflag_string(__GFP_ZEROTAGS),		\
+	gfpflag_string(__GFP_SENSITIVE)
 
 #ifdef CONFIG_KASAN_HW_TAGS
 #define __def_gfpflag_names_kasan ,			\
@@ -95,6 +96,12 @@
 #define IF_HAVE_PG_ARCH_3(_name)
 #endif
 
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+#define IF_HAVE_ASI(_name) ,{1UL << PG_##_name, __stringify(_name)}
+#else
+#define IF_HAVE_ASI(_name)
+#endif
+
 #define DEF_PAGEFLAG_NAME(_name) { 1UL <<  PG_##_name, __stringify(_name) }
 
 #define __def_pageflag_names						\
@@ -122,7 +129,8 @@ IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
 IF_HAVE_PG_IDLE(young)							\
 IF_HAVE_PG_ARCH_2(arch_2)						\
-IF_HAVE_PG_ARCH_3(arch_3)
+IF_HAVE_PG_ARCH_3(arch_3)						\
+IF_HAVE_ASI(global_nonsensitive)
 
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607aaf1943214c7f79f2a52e17eefac2ad79..30b84c0dd8b764e91fb64b116805ebb46526dd7e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2639,6 +2639,7 @@ void __init mm_core_init(void)
 	BUILD_BUG_ON(MAX_ZONELISTS > 2);
 	build_all_zonelists(NULL);
 	page_alloc_init_cpuhp();
+	page_alloc_init_asi();
 
 	/*
 	 * page_ext requires contiguous pages,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b6958333054d06ed910f8fef863d83a7312eca9e..3e98fdfbadddb1f7d71e9e050b63255b2008d167 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1041,6 +1041,8 @@ static void kernel_init_pages(struct page *page, int numpages)
 	kasan_enable_current();
 }
 
+static bool asi_async_free_enqueue(struct page *page, unsigned int order);
+
 __always_inline bool free_pages_prepare(struct page *page,
 			unsigned int order)
 {
@@ -1049,6 +1051,11 @@ __always_inline bool free_pages_prepare(struct page *page,
 	bool init = want_init_on_free();
 	bool compound = PageCompound(page);
 	struct folio *folio = page_folio(page);
+	/*
+	 * __PG_GLOBAL_NONSENSITIVE needs to be kept around for the ASI async
+	 * free logic.
+	 */
+	unsigned long flags_mask = ~PAGE_FLAGS_CHECK_AT_PREP | __PG_GLOBAL_NONSENSITIVE;
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -1107,7 +1114,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 					continue;
 				}
 			}
-			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+			(page + i)->flags &= flags_mask;
 		}
 	}
 	if (PageMappingFlags(page)) {
@@ -1123,7 +1130,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 	}
 
 	page_cpupid_reset_last(page);
-	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page->flags &= flags_mask;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
 	pgalloc_tag_sub(page, 1 << order);
@@ -1164,7 +1171,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 
 	debug_pagealloc_unmap_pages(page, 1 << order);
 
-	return true;
+	return !asi_async_free_enqueue(page, order);
 }
 
 /*
@@ -4528,6 +4535,118 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	return true;
 }
 
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+
+struct asi_async_free_cpu_state {
+	struct work_struct work;
+	struct list_head to_free;
+};
+static DEFINE_PER_CPU(struct asi_async_free_cpu_state, asi_async_free_cpu_state);
+
+static void asi_async_free_work_fn(struct work_struct *work)
+{
+	struct asi_async_free_cpu_state *cpu_state =
+		container_of(work, struct asi_async_free_cpu_state, work);
+	struct page *page, *tmp;
+	struct list_head to_free = LIST_HEAD_INIT(to_free);
+
+	local_irq_disable();
+	list_splice_init(&cpu_state->to_free, &to_free);
+	local_irq_enable(); /* IRQs must be on for asi_unmap. */
+
+	/* Use _safe because __free_the_page uses .lru */
+	list_for_each_entry_safe(page, tmp, &to_free, lru) {
+		unsigned long order = page_private(page);
+
+		asi_unmap(ASI_GLOBAL_NONSENSITIVE, page_to_virt(page),
+			  PAGE_SIZE << order);
+		for (int i = 0; i < (1 << order); i++)
+			__ClearPageGlobalNonSensitive(page + i);
+
+		free_one_page(page_zone(page), page, page_to_pfn(page), order, FPI_NONE);
+		cond_resched();
+	}
+}
+
+/* Returns true if the page was queued for asynchronous freeing. */
+static bool asi_async_free_enqueue(struct page *page, unsigned int order)
+{
+	struct asi_async_free_cpu_state *cpu_state;
+	unsigned long flags;
+
+	if (!PageGlobalNonSensitive(page))
+		return false;
+
+	local_irq_save(flags);
+	cpu_state = this_cpu_ptr(&asi_async_free_cpu_state);
+	set_page_private(page, order);
+	list_add(&page->lru, &cpu_state->to_free);
+	if (mm_percpu_wq)
+		queue_work_on(smp_processor_id(), mm_percpu_wq, &cpu_state->work);
+	local_irq_restore(flags);
+
+	return true;
+}
+
+void __init page_alloc_init_asi(void)
+{
+	int cpu;
+
+	if (!static_asi_enabled())
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct asi_async_free_cpu_state *cpu_state
+			= &per_cpu(asi_async_free_cpu_state, cpu);
+
+		INIT_WORK(&cpu_state->work, asi_async_free_work_fn);
+		INIT_LIST_HEAD(&cpu_state->to_free);
+	}
+}
+
+static int asi_map_alloced_pages(struct page *page, uint order, gfp_t gfp_mask)
+{
+
+	if (!static_asi_enabled())
+		return 0;
+
+	if (!(gfp_mask & __GFP_SENSITIVE)) {
+		int err = asi_map_gfp(
+			ASI_GLOBAL_NONSENSITIVE, page_to_virt(page),
+			PAGE_SIZE * (1 << order), gfp_mask);
+		uint i;
+
+		if (err)
+			return err;
+
+		for (i = 0; i < (1 << order); i++)
+			__SetPageGlobalNonSensitive(page + i);
+	}
+
+	return 0;
+}
+
+#else /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+
+static inline
+int asi_map_alloced_pages(struct page *pages, uint order, gfp_t gfp_mask)
+{
+	return 0;
+}
+
+static inline
+bool asi_unmap_freed_pages(struct page *page, unsigned int order)
+{
+	return true;
+}
+
+static bool asi_async_free_enqueue(struct page *page, unsigned int order)
+{
+	return false;
+}
+
+#endif
+
 /*
  * __alloc_pages_bulk - Allocate a number of order-0 pages to a list or array
  * @gfp: GFP flags for the allocation
@@ -4727,6 +4846,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
 		return NULL;
 
+	/* Clear out old (maybe sensitive) data before reallocating as nonsensitive. */
+	if (!static_asi_enabled() && !(gfp & __GFP_SENSITIVE))
+		gfp |= __GFP_ZERO;
+
 	gfp &= gfp_allowed_mask;
 	/*
 	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
@@ -4773,6 +4896,11 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
 	kmsan_alloc_page(page, order, alloc_gfp);
 
+	if (page && unlikely(asi_map_alloced_pages(page, order, gfp))) {
+		__free_pages(page, order);
+		page = NULL;
+	}
+
 	return page;
 }
 EXPORT_SYMBOL(__alloc_pages_noprof);
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index a756147e2eec7a3820e1953db346fafa8fe687ba..99f4c6632155d2573f1370af131c15c3d8baa655 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -682,6 +682,7 @@ static const struct {
 	{ "__GFP_RECLAIM",		"R" },
 	{ "__GFP_DIRECT_RECLAIM",	"DR" },
 	{ "__GFP_KSWAPD_RECLAIM",	"KR" },
+	{ "__GFP_SENSITIVE",		"S" },
 };
 
 static size_t max_gfp_len;

-- 
2.47.1.613.gc27f4b7a9f-goog


