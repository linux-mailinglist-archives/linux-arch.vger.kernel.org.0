Return-Path: <linux-arch+bounces-15642-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B4CEFCDE
	for <lists+linux-arch@lfdr.de>; Sat, 03 Jan 2026 09:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28E1A300F58F
	for <lists+linux-arch@lfdr.de>; Sat,  3 Jan 2026 08:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B214524E4D4;
	Sat,  3 Jan 2026 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iEJvQZUc"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E22C0F6C
	for <linux-arch@vger.kernel.org>; Sat,  3 Jan 2026 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767429573; cv=none; b=AHUKf8hnloXshcKd0jRC8e5suXVnENsQrMBlQsALdgjBrt+aD/vwye3nzVe8K+IOb5Aw6i2JJcQ5BLJF4EIcLBS1R2CNAZqLC88uFVQaCWHeSKfTlASeQCBEO4mZIgqPtLQn77JbCZLtUfSYOGXerxazSuQ1f294sr2dcDk42sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767429573; c=relaxed/simple;
	bh=c0ZvbNjJoB78BqiQET8V9ZuyapXbik4XmK+eS22Qsvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzmicFMWMdP4DnxFFa1PabE+6fpF9b8H91kaRy+v/8Nt7Hvb+2onWSxJog2EhEZgHAunpjd1f2QIrlHHaQMO4/Fyhb9OOhXZLGqVyVxAw3z8bbHCE1gS9hXIR/hVy7y2C25Ei+WL48LhYk0ZxSWyZVo3hMHdNmICX/wLeZUHlDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iEJvQZUc; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc3c20a9-69a2-41eb-9f22-8df262717348@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767429558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OjfT8QygV/9IkypXdM6tQtyzkm4OsqeUOl80eRwm6A=;
	b=iEJvQZUcy26Jx3TS6d3XXtQYn84JrNobUoTRlR6pCcevu4gIgJIFSBZjboXngtDewNWvfm
	q6p9kLkt1xS5lXfjlJQQ2GcFLg9mnUTkyK54pe5uONlgnCmGX11O21bt8AGqeP5g3JpRlH
	UPrWXG4RvDBbm24m2wekcLwZ/mgJ1s0=
Date: Sat, 3 Jan 2026 16:39:06 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] skip redundant TLB sync IPIs
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
References: <20251229145245.85452-1-lance.yang@linux.dev>
 <f81b98e5-87c0-4c21-9a75-ad5f9b6af6aa@intel.com>
 <1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org>
 <cea71c01-68e7-4f7f-9931-017109d95ef0@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <cea71c01-68e7-4f7f-9931-017109d95ef0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/3 00:41, Dave Hansen wrote:
> On 12/31/25 04:33, David Hildenbrand (Red Hat) wrote:
>> On 12/31/25 05:26, Dave Hansen wrote:
>>> On 12/29/25 06:52, Lance Yang wrote:
>>> ...
>>>> This series introduces a way for architectures to indicate their TLB
>>>> flush
>>>> already provides full synchronization, allowing the redundant IPI to be
>>>> skipped. For now, the optimization is implemented for x86 first and
>>>> applied
>>>> to all page table operations that free or unshare tables.
>>>
>>> I really don't like all the complexity here. Even on x86, there are
>>> three or more ways of deriving this. Having the pv_ops check the value
>>> of another pv op is also a bit unsettling.
>>
>> Right. What I actually meant is that we simply have a property "bool
>> flush_tlb_multi_implies_ipi_broadcast" that we set only to true from the
>> initialization code.
>>
>> Without comparing the pv_ops.
>>
>> That should reduce the complexity quite a bit IMHO.
> 
> Yeah, that sounds promising.

Thanks a lot for taking the time to review!

Yeah, I simplified things to just a bool property set during init
(no pv_ops comparison at runtime) as follows:

---8<---
diff --git a/arch/x86/include/asm/paravirt.h 
b/arch/x86/include/asm/paravirt.h
index 13f9cd31c8f8..a926d459e6f5 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -698,6 +698,7 @@ static __always_inline unsigned long 
arch_local_irq_save(void)

  extern void default_banner(void);
  void native_pv_lock_init(void) __init;
+void setup_pv_tlb_flush_ipi_broadcast(void) __init;

  #else  /* __ASSEMBLER__ */

@@ -727,6 +728,10 @@ void native_pv_lock_init(void) __init;
  static inline void native_pv_lock_init(void)
  {
  }
+
+static inline void setup_pv_tlb_flush_ipi_broadcast(void)
+{
+}
  #endif
  #endif /* !CONFIG_PARAVIRT */

diff --git a/arch/x86/include/asm/paravirt_types.h 
b/arch/x86/include/asm/paravirt_types.h
index 3502939415ad..7c010d8bee60 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -133,6 +133,12 @@ struct pv_mmu_ops {
  	void (*flush_tlb_multi)(const struct cpumask *cpus,
  				const struct flush_tlb_info *info);

+	/*
+	 * Indicates whether flush_tlb_multi IPIs provide sufficient
+	 * synchronization for GUP-fast when freeing or unsharing page tables.
+	 */
+	bool flush_tlb_multi_implies_ipi_broadcast;
+
  	/* Hook for intercepting the destruction of an mm_struct. */
  	void (*exit_mmap)(struct mm_struct *mm);
  	void (*notify_page_enc_status_changed)(unsigned long pfn, int npages, 
bool enc);
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 866ea78ba156..f570c7b2d03e 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -5,10 +5,23 @@
  #define tlb_flush tlb_flush
  static inline void tlb_flush(struct mmu_gather *tlb);

+#define tlb_table_flush_implies_ipi_broadcast 
tlb_table_flush_implies_ipi_broadcast
+static inline bool tlb_table_flush_implies_ipi_broadcast(void);
+
  #include <asm-generic/tlb.h>
  #include <linux/kernel.h>
  #include <vdso/bits.h>
  #include <vdso/page.h>
+#include <asm/paravirt.h>
+
+static inline bool tlb_table_flush_implies_ipi_broadcast(void)
+{
+#ifdef CONFIG_PARAVIRT
+	return pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast;
+#else
+	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
+#endif
+}

  static inline void tlb_flush(struct mmu_gather *tlb)
  {
@@ -20,7 +33,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
  		end = tlb->end;
  	}

-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
+	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
+			   tlb->freed_tables || tlb->unshared_tables);
  }

  static inline void invlpg(unsigned long addr)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ab3e172dcc69..0a49c2d79693 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,6 +60,23 @@ void __init native_pv_lock_init(void)
  		static_branch_enable(&virt_spin_lock_key);
  }

+void __init setup_pv_tlb_flush_ipi_broadcast(void)
+{
+	/*
+	 * For native TLB flush, if we don't have INVLPGB, we use IPI-based
+	 * flushing which sends real IPIs to all CPUs. This provides sufficient
+	 * synchronization for GUP-fast.
+	 *
+	 * For paravirt (e.g., KVM, Xen, HyperV), hypercalls may not send real
+	 * IPIs, so we keep the default value of false. Only set to true when
+	 * using native flush_tlb_multi without INVLPGB.
+	 */
+	if (pv_ops.mmu.flush_tlb_multi == native_flush_tlb_multi &&
+	    !cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast = true;
+}
+
+
  struct static_key paravirt_steal_enabled;
  struct static_key paravirt_steal_rq_enabled;

@@ -173,6 +190,7 @@ struct paravirt_patch_template pv_ops = {
  	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
  	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
  	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
+	.mmu.flush_tlb_multi_implies_ipi_broadcast = false,

  	.mmu.exit_mmap		= paravirt_nop,
  	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 74aa904be6dc..3f673e686b12 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -51,6 +51,7 @@
  #include <asm/olpc_ofw.h>
  #include <asm/pci-direct.h>
  #include <asm/prom.h>
+#include <asm/paravirt.h>
  #include <asm/proto.h>
  #include <asm/realmode.h>
  #include <asm/thermal.h>
@@ -1257,6 +1258,7 @@ void __init setup_arch(char **cmdline_p)
  	io_apic_init_mappings();

  	x86_init.hyper.guest_late_init();
+	setup_pv_tlb_flush_ipi_broadcast();

  	e820__reserve_resources();
  	e820__register_nosave_regions(max_pfn);
---

> 
>> But maybe you have an even better way on how to indicate support, in a
>> very simple way.
> 
> Rather than having some kind of explicit support enumeration, the other
> idea I had would be to actually track the state about what needs to get
> flushed somewhere. For instance, even CPUs with enabled INVLPGB support
> still use IPIs sometimes. That makes the
> tlb_table_flush_implies_ipi_broadcast() check a bit imperfect as is
> because it will for the extra sync IPI even when INVLPGB isn't being
> used for an mm.
> 
> First, we already save some semblance of support for doing different
> flushes when freeing page tables mmu_gather->freed_tables. But, the call
> sites in question here are for a single flush and don't use mmu_gathers.
> 
> The other pretty straightforward thing to do would be to add something
> to mm->context that indicates that page tables need to be freed but
> there might still be wild gup walkers out there that need an IPI. It
> would get set when the page tables are modified and cleared at all the
> sites where an IPIs are sent.

Thanks for the suggestion! The mm->context tracking idea makes a lot
of sense - it would handle those mixed INVLPGB/IPI cases much better :)

Maybe we could do that as a follow-up. I'd like to keep things simple
for now, so we just add a bool property to skip redundant TLB sync IPIs
on systems without INVLPGB support.

Then we could add the mm->context (or something similar) tracking later
to handle things more precisely.

Anyway, I'm open to going straight to the mm->context approach as well
and happy to do that instead :D

Thanks,
Lance

> 
> 
>>> That said, complexity can be worth it with sufficient demonstrated
>>> gains. But:
>>>
>>>> When unsharing hugetlb PMD page tables or collapsing pages in
>>>> khugepaged,
>>>> we send two IPIs: one for TLB invalidation, and another to synchronize
>>>> with concurrent GUP-fast walkers.
>>>
>>> Those aren't exactly hot paths. khugepaged is fundamentally rate
>>> limited. I don't think unsharing hugetlb PMD page tables just is all
>>> that common either.
>>
>> Given that the added IPIs during unsharing broke Oracle DBs rather badly
>> [1], I think this is actually a case worth optimizing.
> ...
>> [1] https://lkml.kernel.org/r/20251223214037.580860-1-david@kernel.org
> 
> Gah, that's good context, thanks.
> 
> Are there any tests out there that might catch these this case better?
> It might be something good to have 0day watch for.


