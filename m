Return-Path: <linux-arch+bounces-15588-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FB1CE712F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87AA53002885
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6031ED96;
	Mon, 29 Dec 2025 14:38:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151B31D379
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019082; cv=none; b=SJRQq67Hz0V3JNtiT75jJlCXkp4/Hr8DltfoeZqDJaj83R+eadsw2Udfa7HQAGN2aPzBRpibE1nhesM7Re5Y8sF2Z2VwiXxCzAOZFRuQFzYRvwf1+nZjlI1wVYVl2YIy/Ie1T2JOaWatrAUfVbVxMZXTEPnfy3zxQ09OYJskc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019082; c=relaxed/simple;
	bh=lC6GEfxIGK/35lvrPF2qw5D86rHWEQ6C/lNcw05H+jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euIMEKPMRNRhMyNxyCDx3tzMEEtpb9mtqzbTznlYkPTgtftdPTjAxNmI9MD7phNeYEynfOvOTQa0hoHdUI6eFrVkmxAUC3RlqFjq/aRtGMURDM6q9Kody+HKpqHz2dHCXq8z/w6lDO5OBHOdRs9L24nB6+/5OvzpqBhqOQHc4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a12ed4d205so79822935ad.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767019080; x=1767623880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foHDr6tTVVg2N+oq2ubI3TwM6NJy7Osy+6nFP/DCYQ8=;
        b=BbgfcGtIZM2NyOcqPK1x1k8PPh3DzR6Kbs1OOracathMb8I1JwmAzFWeOB+hacSJ1x
         JF2Z7PWS78DN1PrnnJwTstiMTjFw4xW9mi7FZKyl7fxEtl9yQx9lFYDjtMlqV5p2U2DS
         VsXJcYYgvBjr+KeHysOMtfe7ooz4uEMDkthY1bz3q1HnX81m2ncVT5olkqII2H4g8REJ
         cG7eMRHRRjBpmd55KXd8WkniRoSQemwG1CaRxNxi0tJNVMqhjC5PjuSg1LoJex094jWG
         fKZAIxGSQxlSjBDHtfgNzp5xmBeH6+UljZM0GA/hhNP9Mp0uez3KiSbohYJ0rgLN9eR7
         Zm9A==
X-Forwarded-Encrypted: i=1; AJvYcCWP3oC4OIN74pO26AW9/9UBWTK+EN85B6j7AXhAROdONKuP1AeUJ03HR0lwdBHo4oxS14w0tPJJ0lMP@vger.kernel.org
X-Gm-Message-State: AOJu0YxWobIZOyFOAGj/C30aB3n9tGMa5VaMZkEVF6vF+m3rLGwMV++M
	NtGpGQ+a8yLy1SXoKNAJN9I++xkgoMSbhGKDC0Nj84Lg5dXkP8eWQlJT
X-Gm-Gg: AY/fxX5HBilSn+iYhR8N45jgmuZSXYYku1STb534qCm8sjiK6ZjB/SWkgAoNqAk196r
	0gn4Qs2WODn/D1jlxt/RkjM/ft8UOl8XuMM51dtt592qEPyMgVAd8thpzjFkkgr4oxSemBaQVpI
	PUGrmscT55TNwh4Ozs54RvPx/lNOeYKoB26XIQGwSZR6Maz9ZP6AGrO+eVSJB0VtaH6gcJuoYqh
	WhZLvCZrpXRgazphBoNDl2zGMtSFRbTewgzMN3Gs031PuXVYhyJ7k8BkjTn9ySNqWnsuv2SBlpl
	CEUrkw+G5gA4tdqzqsD2KIs9fWS3dHL0ep64iMiuSkxYVHDNt7qyp5Z9LcBsL/z+B3NI275mRSv
	2l7OwfzztTy+wiN7m784iVcQ9eYCVmLDBp6apJrEGLoTzQcgptSGrzY2+ghiS/PjHNX5eLYdIL0
	aQV06swRdFaX0rD5JmJjKh3dWcHj2fBak=
X-Google-Smtp-Source: AGHT+IEV772w153pVl2WpyWEJno3SC8dcLG3m0A8YzC4kscVWxvA6UP//UDe0ihAoD40pu8neBRzLg==
X-Received: by 2002:a17:902:f607:b0:295:9e4e:4090 with SMTP id d9443c01a7336-2a2f2a3cea1mr322095945ad.52.1767019079997;
        Mon, 29 Dec 2025 06:37:59 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([45.8.220.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7736fsm279669625ad.92.2025.12.29.06.37.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:37:58 -0800 (PST)
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
Subject: [PATCH RESEND v1 1/3] mm/tlb: allow architectures to skip redundant TLB sync IPIs
Date: Mon, 29 Dec 2025 22:36:55 +0800
Message-ID: <20251229143657.76968-2-lance.yang@linux.dev>
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

When unsharing hugetlb PMD page tables, we currently send two IPIs: one
for TLB invalidation, and another to synchronize with concurrent GUP-fast
walkers.

However, if the TLB flush already reaches all CPUs, the second IPI is
redundant. GUP-fast runs with IRQs disabled, so when the TLB flush IPI
completes, any concurrent GUP-fast must have finished.

Add tlb_table_flush_implies_ipi_broadcast() to let architectures indicate
their TLB flush provides full synchronization, enabling the redundant IPI
to be skipped.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/asm-generic/tlb.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 4d679d2a206b..e8d99b5e831f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -261,6 +261,20 @@ static inline void tlb_remove_table_sync_one(void) { }
 
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
+/*
+ * Architectures can override if their TLB flush already broadcasts IPIs to all
+ * CPUs when freeing or unsharing page tables.
+ *
+ * Return true only when the flush guarantees:
+ * - IPIs reach all CPUs with potentially stale paging-structure cache entries
+ * - Synchronization with IRQ-disabled code like GUP-fast
+ */
+#ifndef tlb_table_flush_implies_ipi_broadcast
+static inline bool tlb_table_flush_implies_ipi_broadcast(void)
+{
+	return false;
+}
+#endif
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 /*
-- 
2.49.0


