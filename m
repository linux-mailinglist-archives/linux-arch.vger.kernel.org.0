Return-Path: <linux-arch+bounces-15589-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E4CE7132
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A76B23002490
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE86320A02;
	Mon, 29 Dec 2025 14:38:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30E3164B1
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019093; cv=none; b=E0U0MqCxNmbiUZiBI/2frlDLyGLetkkMp4bgxL4a+MYF1KrtTU3da228NpdJ8bqxHVxYE76fWRdMVOAEKGWjd+Z4vJaKIJqw6LVEjLTnpdMs+alIrMOpv+mlhwsHgoWRn/ZzCQfihTAX4fJeB+e1D9EjhcEzYCcTKTPcWETv9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019093; c=relaxed/simple;
	bh=m4iHj+AwFx2PCF5x5k1miVOJkb/O+RupWNG1Z8Fowrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuF+MyYy95o9MAvCw3ElsYfUdTnBkCfPzCs5yad4/B9CYehvg3slGQ5IKkJB+HrwC9flEFJ6UUCbXfdMd6hdsW/ZUGjw9byjgT7rCRQPugfwko57YFsiPL0Ee6YX/Vid/aQiLPe6HXf4anPENMH6hX3yvhKrIAHe6ztXAHa/6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a09d981507so67154975ad.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767019089; x=1767623889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZldRDJqtH1ig79a3NbAjYulmXt3x4GlRPqkLpWEwBdc=;
        b=O8UjQCEJJ1+bU6OruFr9GkwCJiLCoBAIuZSfHXzPs/t8a8pzt28DS/ZbrpUfOVeI8q
         YtCgN1tyM7bs1638TU9mJo3/qutaS/NOLtbWVuDyxlK5KkSO3DrVPZnAjSY+snBUFasu
         xEDf9WreFXFCU8Ey8J5KWDsrRmqP955+lZJa1pT/MV75Qhc08WG4I+9WJLMVPp47iNKY
         mZZUESgMEGN347YUeYW23ieZBv+buOj/neqwnfJMAdSQbFJi3osI8SU5qYcF1aD1mNFS
         PUQxE2m2xJSqyu2jEfLlz8VIuk2q9mOLXd6pWUHePTgwRwFZXM4K+EFO8crWiRGgBezc
         brMw==
X-Forwarded-Encrypted: i=1; AJvYcCVML2A9vL2+nJArc7+13B9RJHaMNTEzKvmCUg5+HbFKkmlBroxeeuOijvegjP033QRgC74CkvoPdBZV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdunl7oZCwYGrbwjnQfSbczhBQThVDZhnAhT3O3ZgaOYOuxXLC
	zWYpVqpQMBX3AFFYdzl8+7omTuP/vSBVNqF1QVk3yQfJkGpQNj84JLDR
X-Gm-Gg: AY/fxX6DBjh00Vng6LeM0jN0lRp2+zVr5BpTXmOPA/wQyd9FO0ttzYjW7J3phMUZz7J
	0oiAPeIz3Kb4vaJ9WS3SvbOozf4Esj4rWOdyrieZx4mtt/KZR0oXt7WZ0P/ObSWWYP6XXcrqJOp
	TTxWPPFUpiSaLlVwnTVlgwIWa1fIZ55dM409IfyGKe0rN1A2ddZte+e63yYiMn6tsYSqqWIOPVu
	3jkXsQGSpVgxTCGLygR6NUpJ0HknBJAcE/MgRkCyVDHWGeWA2JjgnyG77FnKmxomDyeBuKQZ3MI
	DG+TLudcR9w2zjStrZ45iQ8NNupZLw3MLGELAcq7fcOp32q5Dcx+dq1YGNCshZpboXf2SjzdSX5
	SBe0zAAfdSM2ujE+QFiXuozypIrcA2DacoBGl1ZPbBlcDvuA97Olzv9h0outM+gIendKS/nq1qh
	Z7Iqfq9okY4ZBu+l7Rmm0Z
X-Google-Smtp-Source: AGHT+IGbzQsFnxYP9S+gBanduwTJYp5i/avcPenp0gxUy3BJDakAIqFIQWIEeOZwEbX1DJzlvouniA==
X-Received: by 2002:a17:902:cf0d:b0:298:45e5:54a4 with SMTP id d9443c01a7336-2a2f0caa6fdmr287168855ad.1.1767019089301;
        Mon, 29 Dec 2025 06:38:09 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([45.8.220.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7736fsm279669625ad.92.2025.12.29.06.38.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:38:08 -0800 (PST)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH RESEND v1 2/3] x86/mm: implement redundant IPI elimination for page table operations
Date: Mon, 29 Dec 2025 22:36:56 +0800
Message-ID: <20251229143657.76968-3-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229143657.76968-1-lance.yang@linux.dev>
References: <20251229143657.76968-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Add a callback function flush_tlb_multi_implies_ipi_broadcast to pv_mmu_ops
to explicitly track whether flush_tlb_multi IPIs provide sufficient
synchronization for GUP-fast when freeing or unsharing page tables.

Pass both freed_tables and unshared_tables to flush_tlb_mm_range() to
ensure lazy-TLB CPUs receive IPIs and flush their paging-structure caches:
	flush_tlb_mm_range(..., freed_tables || unshared_tables);

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 arch/x86/include/asm/paravirt_types.h |  6 ++++++
 arch/x86/include/asm/tlb.h            | 19 ++++++++++++++++++-
 arch/x86/kernel/paravirt.c            | 10 ++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 3502939415ad..a5bd0983da1f 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -133,6 +133,12 @@ struct pv_mmu_ops {
 	void (*flush_tlb_multi)(const struct cpumask *cpus,
 				const struct flush_tlb_info *info);
 
+	/*
+	 * Indicates whether flush_tlb_multi IPIs provide sufficient
+	 * synchronization for GUP-fast when freeing or unsharing page tables.
+	 */
+	bool (*flush_tlb_multi_implies_ipi_broadcast)(void);
+
 	/* Hook for intercepting the destruction of an mm_struct. */
 	void (*exit_mmap)(struct mm_struct *mm);
 	void (*notify_page_enc_status_changed)(unsigned long pfn, int npages, bool enc);
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 866ea78ba156..3a7cdfdcea8e 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -5,10 +5,26 @@
 #define tlb_flush tlb_flush
 static inline void tlb_flush(struct mmu_gather *tlb);
 
+#define tlb_table_flush_implies_ipi_broadcast tlb_table_flush_implies_ipi_broadcast
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
+	if (pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast)
+		return pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast();
+
+	return false;
+#else
+	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
+#endif
+}
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
@@ -20,7 +36,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 		end = tlb->end;
 	}
 
-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
+	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
+			   tlb->freed_tables || tlb->unshared_tables);
 }
 
 static inline void invlpg(unsigned long addr)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ab3e172dcc69..4eaa44800b39 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,6 +60,15 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
+static bool native_flush_tlb_multi_implies_ipi_broadcast(void)
+{
+	/* Paravirt may use hypercalls that don't send real IPIs. */
+	if (pv_ops.mmu.flush_tlb_multi != native_flush_tlb_multi)
+		return false;
+
+	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
+}
+
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
@@ -173,6 +182,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
+	.mmu.flush_tlb_multi_implies_ipi_broadcast = native_flush_tlb_multi_implies_ipi_broadcast,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
-- 
2.49.0


