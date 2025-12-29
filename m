Return-Path: <linux-arch+bounces-15587-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A22CE711D
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4CEF300C8E6
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C06432B9A1;
	Mon, 29 Dec 2025 14:31:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9732B992
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018685; cv=none; b=bFs5A/6Pfj49EVenLDMIrdDqsvwxa479laK7Wr+K7BIdIWjh/j9FK48dA3TdgdINgoI/NZoVGnmoiI1GmtfcwKxFVohwGtaIpF7VWwY6YTC6IT9tsrV+Nvwci8cPZWrhLfb90H5atqLOKReCxhbskVZAwKkOSJGjDdoa7+Gkp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018685; c=relaxed/simple;
	bh=QELGmcYo0okd7XeZ+8OIMQ2Ox7GoXMWa9Ttw3qK5W4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rp+3yqy0UiYpYKC6jz8UiYCQBPKi691kHmm4Qncd4FburZNJAyTzeqa9DITsIFNCXqREEK2c3dNrWGyGiWpZApzxvKRYrTX0XEkJ1jsNyIxjkHAwF6UF7O6aLrHVgzWjqfWPgNyH0L27ngjwTZYRsjN8TtglOVVIsa9MVrz10h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso6871918b3a.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767018683; x=1767623483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2pBV4vyT2c4GBUcrUp/G3rP2JcNWZOiRH8LtGLdyis=;
        b=USD7haghEA+wzpwYOCkZHnwT8xywNCcF8hg1+SWOIsi79+A62t/eCDAVSYDg4p8p8c
         WkAv66dGQJMg7J/m6al6O95tIcubrSzrkPJapfQu5f7PkuQsWguyyDR5q1Hh2DsFZlLH
         yzXsgot1Wgdy/2LOMBNQI2VQPv2l0206WzMz4mweeyTrIEWxUexuc33S5akX/H2a3KtB
         djFwT6tUEVzCEFpZZ2ZeNuYOFtH1fezdqGZ8L85XzDebyY4dbt7NXl5R2f97/UwFuXcj
         M+Wcl0TMDQDgc88GbZ2+hSyy5rRpwQbA/1KE89jgChrwnKDQo54dLv5lr4ORTJxh58Ss
         MsbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0/l1ry7rytolqR6c1TF2t+iIkZSEz3RcblaIO+4kX9m2t6X4JCD4MHmMzTvh3P6oQCHPrCACMlIZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYSK7C+BwpdQrko968igpyQKfmyQg/OHXQMTnP65/b4tPWiNT
	F4r6iqT4KNicevblqkx8QNTQY+rT8DbYHkLxX6zTu2cpfiOi7XCNrJvZ
X-Gm-Gg: AY/fxX4pJSL+Zj/8qeluFDByMX7XpEH9SSmZOwib8v39gWG12GBx49saLR5SrY8q0Pf
	GpRxNF/hwFDeJGr/bs6Kr7qS6g3FWYu7gHErADD/lJntuGQxCZnHZDXt67sQ/gwS11TfCbQB23I
	Lew6D6wtBq1wB+vUkWUrO6kKZw+wDlHKiqFOFvs5avOW4ZXyU61k7cX1HGWIBX/VUE+q7KGcjh8
	VCNoDBAzqXhtrJD5JKZJQ7BRHldY/osUYIeMqUqeTn7w0vnxqlQlLHrbeIKU1h6DhaRgIobFpxN
	aOB8Xmk6HhG2mQ7Wcb3eO43kwdpEVqs61sybJt81tEGizf5CpyA0uDbuiOYv/rhQkCb4b9llnTp
	7um0bf2SVrNHd8zOYDn9vRyqYYF5t1ICG7vxVNrvr6sUDlmg6FjHdhQNP39osW33McKApXknVwk
	NxkN6MB4GUrA6CfzyteLWE
X-Google-Smtp-Source: AGHT+IFiw887UMmrpccqqPDuA4Sml65dVXg15rA20Xbw/FfFGKW61CmBXpyhkJbsrlAp7EarY75hqQ==
X-Received: by 2002:a05:6a00:8c11:b0:7fb:c6ce:a873 with SMTP id d2e1a72fcca58-7ff64fc5fbdmr25731812b3a.5.1767018682758;
        Mon, 29 Dec 2025 06:31:22 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm29705159b3a.32.2025.12.29.06.31.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:31:22 -0800 (PST)
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
Subject: [PATCH RESEND v1 3/3] mm: embed TLB flush IPI check in tlb_remove_table_sync_one()
Date: Mon, 29 Dec 2025 22:30:33 +0800
Message-ID: <20251229143038.73315-4-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229143038.73315-1-lance.yang@linux.dev>
References: <20251229143038.73315-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Embed the tlb_table_flush_implies_ipi_broadcast() check directly inside
tlb_remove_table_sync_one() instead of requiring every caller to check
it explicitly. This relies on callers to do the right thing: flush with
freed_tables=true or unshared_tables=true beforehand.

All existing callers satisfy this requirement:

1. mm/khugepaged.c:1188 (collapse_huge_page):

   pmdp_collapse_flush(vma, address, pmd)
   -> flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE)
      -> flush_tlb_mm_range(mm, ..., freed_tables = true)
         -> flush_tlb_multi(mm_cpumask(mm), info)

   So freed_tables=true before calling tlb_remove_table_sync_one().

2. include/asm-generic/tlb.h:861 (tlb_flush_unshared_tables):

   tlb_flush_mmu_tlbonly(tlb)
   -> tlb_flush(tlb)
      -> flush_tlb_mm_range(mm, ..., unshared_tables = true)
         -> flush_tlb_multi(mm_cpumask(mm), info)

   unshared_tables=true (equivalent to freed_tables for sending IPIs).

3. mm/mmu_gather.c:341 (__tlb_remove_table_one):

   When we can't allocate a batch page in tlb_remove_table(), we do:

   tlb_table_invalidate(tlb)
   -> tlb_flush_mmu_tlbonly(tlb)
      -> flush_tlb_mm_range(mm, ..., freed_tables = true)
         -> flush_tlb_multi(mm_cpumask(mm), info)

   Then:
   tlb_remove_table_one(table)
   -> __tlb_remove_table_one(table) // if !CONFIG_PT_RECLAIM
      -> tlb_remove_table_sync_one()

   freed_tables=true, and this should work too.

   Why is tlb->freed_tables guaranteed? Because callers like
   pte_free_tlb() (via free_pte_range) set freed_tables=true before
   calling __pte_free_tlb(), which then calls tlb_remove_table().
   We cannot free page tables without freed_tables=true.

   Note that tlb_remove_table_sync_one() was a NOP on bare metal x86
   (CONFIG_MMU_GATHER_RCU_TABLE_FREE=n) before commit a37259732a7d
   ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional").

4-5. mm/khugepaged.c:1683,1819 (pmdp_get_lockless_sync macro):

   Same as #1. These also use pmdp_collapse_flush() beforehand.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/mmu_gather.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 7468ec388455..7b588643cbae 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -276,6 +276,10 @@ static void tlb_remove_table_smp_sync(void *arg)
 
 void tlb_remove_table_sync_one(void)
 {
+	/* Skip the IPI if the TLB flush already synchronized with other CPUs. */
+	if (tlb_table_flush_implies_ipi_broadcast())
+		return;
+
 	/*
 	 * This isn't an RCU grace period and hence the page-tables cannot be
 	 * assumed to be actually RCU-freed.
-- 
2.49.0


