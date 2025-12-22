Return-Path: <linux-arch+bounces-15529-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E122CCD49DA
	for <lists+linux-arch@lfdr.de>; Mon, 22 Dec 2025 04:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B174E30062D1
	for <lists+linux-arch@lfdr.de>; Mon, 22 Dec 2025 03:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D5225C6F9;
	Mon, 22 Dec 2025 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYuQYPXz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A61F1513
	for <linux-arch@vger.kernel.org>; Mon, 22 Dec 2025 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373584; cv=none; b=ZrTpKD90AK2E2yLzmPGI1DiCxHtex1DFx1iONDZt5H8O43LZ7Y1a4IXHNPXJ7bOi/jcutukufMeykRX7aUeVi3zyHUHPe1IruzSGv2XTlS04STSirE9uRB2Yr0Qzu9lrNs462haVCSV+W/GQQ+QOLMQi17k3u6Fn4hxKyCupG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373584; c=relaxed/simple;
	bh=a/h2fhy/nEGLig6vrhMsbxqGANvv2FNEEAhbM8MlUU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+TyXmpk8sOaqqk0yd7NXGouiIwq+WKkvuflW9s5IfMt4Ut32U3UreWPyZzmbHc0OSep/ZGo2KkJ3JX535TE6stWDOBWznU4bRdGL4q3Kh1ftvsjk8F1CSQ0STlNejmlosaCGTij8aq3Vs+00OgmhELZQkmx0IwlshFvHJ75xPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYuQYPXz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7ba55660769so2753549b3a.1
        for <linux-arch@vger.kernel.org>; Sun, 21 Dec 2025 19:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766373582; x=1766978382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GmlPOC1P0AM0GDfDwLCyARMYoCDX/JlrqGabW/rzIU=;
        b=FYuQYPXzGh+OUVxe0EHaEasD/c/aTl7oUAAgZJEZj0dagPAKHz4gXKnwMUHkE2czl9
         OIR1DWtKXXFFON+Tm8/tDtMHOyLma7+QTX7acNkA0Bx1hoPuLEaZJRUX7eibpY+4MbE4
         Ioqg6A5KQGM2+fKUt8kr3TfLO/Q/TivmoN/fkYGodMAu/W5yUPW+TXdicOzy9qWrSJ8R
         ILzV9rBT9/5OHYeFtGT1A6yZfWEyj4UugQuh20fsOk6aEnDdHhmy5+VfdmR6byRdzGmr
         c51WwPGbFDOZwXDi/v7Ak6D63NhLiWOX68lFj4oV1dxVLH/gGJCRnBg8ty+eH0V34yZ2
         WcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766373582; x=1766978382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GmlPOC1P0AM0GDfDwLCyARMYoCDX/JlrqGabW/rzIU=;
        b=BeEwoEHf37F/xkOuqVJQr7zxsRFvlS+vXN93VFSXymCWvm2qavy8qdgJxY4qs/gCzf
         DRC5LlGeq+kJbQMv5YjEoLSgWFWja0zJEkkihrJsjLmrUh/uHalfL5I+a/sCD/YerzyA
         MvpthJYbvzuUr2wTu+oOAdBUVMQuf2wNG3O94hI1HDB4V/LOrrqIoFRLh8ub7TR1xMZA
         ykYp8cJUy4uDbLwPd9E2+UMrcTHXFeoWfj2cy8qaZzc7zFkYYAXd1sDXGbrmm1Rm6kNT
         Dd++J+3J/RvYEYU3CIFUYD0k6eYotGGxgkr4AFqX24F+T+BZetNyRFsnYbnJ+YJsQwuE
         oIGg==
X-Forwarded-Encrypted: i=1; AJvYcCWq5lTurwFkuASUuCNxsCMJRDvTFlLM40Z4B9j6jGjo2J9PQNiHj2isFqJxYe4nSxGvbw83D+SjLtdc@vger.kernel.org
X-Gm-Message-State: AOJu0YygZTGVfi3BHE/yOTRt8kbe6LHjBBDrdJ7aIwa5+2YdLb47vQAF
	nPdhafjnKXcv5/80LiNEHTnsjz/P2aUTc5mLz+H8GZlz33J03rOq/lfW
X-Gm-Gg: AY/fxX5nmB9wbAga3ILCSpVkeD5gBLoJaM3SxoN+naHKEjsSu0T8QlSSdmgpDYnFl5Y
	AGX/N/KgtXpyPpqe4HJx3j9tzleFb576Tcfr5mek/1cNfJwZc8W0B8HPr/yocPDXAC/qWAz9l0G
	aCYHCJ5y+CCfQaWFBz1lQ5Mt/SBReMHD08bfmAolxTcIk1HbJNZjFQLS/X7UAYJCzpCS4hGQ3G+
	bpabzCI+TWaOb1jjXFHUJwKmo77jQE/Srrt8QRi3NmLk/62Y2057YMBFc1aOebjseyKeejQEd76
	QZv+FweuC1IZteancUABh3GkS7sT7vsE9U7bAJB6zrOUC557gLoNWN1Mw0YRnCl9jpXuGrFJWu8
	aUjhMUn1Z3tTepC2sIp82/P4IPr+Dz5NFG1HZAzgv7MHQ48VRjH+hPZKrO99IvWsUav651NE5On
	RwYR1Tt+JxNZwfhkmm0X4=
X-Google-Smtp-Source: AGHT+IGhp8ZTBsTDENWrru9arl6O4MqGzyl9sqpGRfkDR76L/XfuVadL6vRq18Zl3e3t0t/ZUDjAYg==
X-Received: by 2002:a05:6300:2109:b0:366:14b0:4b0e with SMTP id adf61e73a8af0-376aabf93ddmr9390466637.74.1766373581676;
        Sun, 21 Dec 2025 19:19:41 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d2bbsm82226215ad.55.2025.12.21.19.19.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Dec 2025 19:19:41 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: david@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	arnd@arndb.de,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dev.jain@arm.com,
	hpa@zytor.com,
	ioworker0@gmail.com,
	jannh@google.com,
	lance.yang@linux.dev,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mingo@redhat.com,
	npache@redhat.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	riel@surriel.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	ziy@nvidia.com
Subject: Re: [PATCH RFC 2/3] x86/mm: implement redundant IPI elimination for
Date: Mon, 22 Dec 2025 11:19:19 +0800
Message-ID: <20251222031919.41964-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <c36501bc-2690-4ed2-b85e-13e64c41baaf@kernel.org>
References: <c36501bc-2690-4ed2-b85e-13e64c41baaf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>


On Thu, 18 Dec 2025 14:08:07 +0100, David Hildenbrand (Red Hat) wrote:
> On 12/13/25 09:00, Lance Yang wrote:
> > From: Lance Yang <lance.yang@linux.dev>
> > 
> > Pass both freed_tables and unshared_tables to flush_tlb_mm_range() to
> > ensure lazy-TLB CPUs receive IPIs and flush their paging-structure caches:
> > 
> > 	flush_tlb_mm_range(..., freed_tables || unshared_tables);
> > 
> > Implement tlb_table_flush_implies_ipi_broadcast() for x86: on native x86
> > without paravirt or INVLPGB, the TLB flush IPI already provides necessary
> > synchronization, allowing the second IPI to be skipped. For paravirt with
> > non-native flush_tlb_multi and for INVLPGB, conservatively keep both IPIs.
> > 
> > Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> > Signed-off-by: Lance Yang <lance.yang@linux.dev>
> > ---
> >   arch/x86/include/asm/tlb.h | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
> > index 866ea78ba156..96602b7b7210 100644
> > --- a/arch/x86/include/asm/tlb.h
> > +++ b/arch/x86/include/asm/tlb.h
> > @@ -5,10 +5,24 @@
> >   #define tlb_flush tlb_flush
> >   static inline void tlb_flush(struct mmu_gather *tlb);
> >   
> > +#define tlb_table_flush_implies_ipi_broadcast tlb_table_flush_implies_ipi_broadcast
> > +static inline bool tlb_table_flush_implies_ipi_broadcast(void);
> > +
> >   #include <asm-generic/tlb.h>
> >   #include <linux/kernel.h>
> >   #include <vdso/bits.h>
> >   #include <vdso/page.h>
> > +#include <asm/paravirt.h>
> > +
> > +static inline bool tlb_table_flush_implies_ipi_broadcast(void)
> > +{
> > +#ifdef CONFIG_PARAVIRT
> > +	/* Paravirt may use hypercalls that don't send real IPIs. */
> > +	if (pv_ops.mmu.flush_tlb_multi != native_flush_tlb_multi)
> > +		return false;
> > +#endif
> > +	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
> 
> Right, here I was wondering whether we should have a new pv_ops callback 
> to indicate that instead.
> 
> pv_ops.mmu.tlb_table_flush_implies_ipi_broadcast()
> 
> Or a simple boolean property that pv init code properly sets.

Cool!

> 
> Something for x86 folks to give suggestions for. :)

I prefer to use a boolean property instead of comparing function pointers.
Something like this:

----8<----
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index cfcb60468b01..90e9da33f2c7 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -243,4 +243,5 @@ void hyperv_setup_mmu_ops(void)

 	pr_info("Using hypercall for remote TLB flush\n");
 	pv_ops.mmu.flush_tlb_multi = hyperv_flush_tlb_multi;
+	pv_ops.mmu.tlb_flush_implies_ipi_broadcast = false;
 }
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 3502939415ad..f9756df6f3f6 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -133,6 +133,19 @@ struct pv_mmu_ops {
 	void (*flush_tlb_multi)(const struct cpumask *cpus,
 				const struct flush_tlb_info *info);

+	/*
+	 * Indicates whether TLB flush IPIs provide sufficient synchronization
+	 * for GUP-fast when freeing or unsharing page tables.
+	 *
+	 * Set to true only when the TLB flush guarantees:
+	 * - IPIs reach all CPUs with potentially stale paging-structure caches
+	 * - Synchronization with IRQ-disabled code like GUP-fast
+	 *
+	 * Paravirt implementations that use hypercalls (which may not send
+	 * real IPIs) should set this to false.
+	 */
+	bool tlb_flush_implies_ipi_broadcast;
+
 	/* Hook for intercepting the destruction of an mm_struct. */
 	void (*exit_mmap)(struct mm_struct *mm);
 	void (*notify_page_enc_status_changed)(unsigned long pfn, int npages, bool enc);
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 96602b7b7210..9d20ad4786cc 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -18,7 +18,7 @@ static inline bool tlb_table_flush_implies_ipi_broadcast(void)
 {
 #ifdef CONFIG_PARAVIRT
 	/* Paravirt may use hypercalls that don't send real IPIs. */
-	if (pv_ops.mmu.flush_tlb_multi != native_flush_tlb_multi)
+	if (!pv_ops.mmu.tlb_flush_implies_ipi_broadcast)
 		return false;
 #endif
 	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index df78ddee0abb..aaea83100105 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -843,6 +843,7 @@ static void __init kvm_guest_init(void)
 #ifdef CONFIG_SMP
 	if (pv_tlb_flush_supported()) {
 		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
+		pv_ops.mmu.tlb_flush_implies_ipi_broadcast = false;
 		pr_info("KVM setup pv remote TLB flush\n");
 	}

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ab3e172dcc69..625fe93e138a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -173,6 +173,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
+	.mmu.tlb_flush_implies_ipi_broadcast = true,

 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 7a35c3393df4..06eb80cfb4da 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2185,6 +2185,7 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
 		.flush_tlb_kernel = xen_flush_tlb,
 		.flush_tlb_one_user = xen_flush_tlb_one_user,
 		.flush_tlb_multi = xen_flush_tlb_multi,
+		.tlb_flush_implies_ipi_broadcast = false,

 		.pgd_alloc = xen_pgd_alloc,
 		.pgd_free = xen_pgd_free,
---

Native x86 sets it to true, paravirt guests (Xen/KVM/Hyper-V) set it to
false. Making the intent explicit :)

Hopefully x86 folks can give me some suggestions!
 
Thanks,
Lance

