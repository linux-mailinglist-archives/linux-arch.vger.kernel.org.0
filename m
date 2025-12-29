Return-Path: <linux-arch+bounces-15593-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF8CE7231
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D14830111B6
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03F32A3E7;
	Mon, 29 Dec 2025 14:55:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D96329E72
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767020107; cv=none; b=tRxdfgT2KfakgtGAzkv1o2xyYS4r5X8Eh69/2U6CAegOP/lW1qBCST8SSJWqlweQDzVD6bJp3It5tImdWoe7CiG2o0CraqQ4tyVVVRvSMm8bmauTKyS9uWRBzhbJg+H5vlZIVAytkAF505fnY2fYH+Yzv1jKifH43NgN7eRpoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767020107; c=relaxed/simple;
	bh=QELGmcYo0okd7XeZ+8OIMQ2Ox7GoXMWa9Ttw3qK5W4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMZN0upJO6sH7wgvfw1h8WXC4TMA2BbjLij9iNOMmUekJTnwbNXYJIbs0Rwic7WmEon4gt0VwTuNotUbrXDL4V6ILcb7ChoAuboExKn5QsLODhjGNQO2fcPDwITYQZHAgro74ZJqued+WMdgl2scFXnsmw6RsWwYbctIgyiMyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c363eb612so9159502a91.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767020104; x=1767624904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2pBV4vyT2c4GBUcrUp/G3rP2JcNWZOiRH8LtGLdyis=;
        b=SCgUeUGuPlbZ5gsiqDBrQIycuzJ0hGcmA3di7aa2LUMeHGcn4K/CnDPDuyH+B5Yjuw
         Q05CAU2/SoGkRBnRRF9nQxmwCtDSixl/F+j5BZOBDMb1ZWhA/7LkA35Nn+iN1aO/xNEz
         auZSXH3KGfOVJegGmw7bfJfJjj3CY8EUz/xgrvObm+taIB862Y+h1cPXFWATZipCP+2X
         wEDZ/LTOjX22UhW7GVLUEYVZhjZgUUxSezLL7ZugtJfa0SME+v9zRJjOaee5OQWy0Cph
         Vdz+fLqbg/NVmh0U65ksCZrSX3t8kRKPEuRMX7rbdxp6f946HdBfzPdf9n02UfOLPKrm
         gyrg==
X-Forwarded-Encrypted: i=1; AJvYcCUM/nYwtK5Il31rSsU19QWx5TI7hP0hn66R15D2Jg8pMmqM12gKN5CSYU1ZlSIfZzCybmtWrpX6dU8r@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0fXuYweswOR50Of+G2la/wmITDtva14ghLKG6u/V09DVeErA
	LEsw7qSLxjfezjpQk9YqV24XKAjYeUjtS5SQG5lQ7ZpLtg5JIqVitAIM
X-Gm-Gg: AY/fxX7i9VVnQFSRzyMlBRpN/uj0FKj/Kx1lsADKiDLVN79s/csUA9L1zuwdSDcEfnE
	WWzD2+xeGoHFxuFXLWfjLRDAaDzKwiM3Ve+7GS0iqr2EkYTJdwtnMIIbYPzOYE7CdblrnZt2NTG
	BOn8t/nV2wNbkGPJmMuVaqptRmyMDaBqKAPB4adJ2avVLxcAJTWY/HTpH7Kl8JFaa9QImkOQcKT
	Ih84KqXeX1PhVxnxwgrAfpGr7mCr5Dr2wSs4KZw8HxnVO4/NcG9AotpZ2kMQN9pwCE+GK2rsv35
	Gx1I8UAzdxjPAGM2mgM+X3FoV9HAvODpgzQWfHTJtWLNsVgRO9TenI9B0iIGfpbScwkEZNSQvJE
	4tP60cqF2BbD9dhSA8DGt/LJNtwDKHMysr4flN1yCC+GEIYwwXjCWqBy1M71UiYlKjrr1Ai2NX4
	0eGqPQjLmXNS8O579/sL0z
X-Google-Smtp-Source: AGHT+IEf9Iv5nOPUSm+mp/HKv1O5w/lt7w1F73FenhI+IdA1+6z3gDDv4Fw3i4Tf4eeD+0sQQsI38w==
X-Received: by 2002:a17:90b:560c:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-34e921c3003mr21256159a91.22.1767020103739;
        Mon, 29 Dec 2025 06:55:03 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbcb6esm31557603a91.9.2025.12.29.06.54.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:55:03 -0800 (PST)
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
Subject: [PATCH v2 3/3] mm: embed TLB flush IPI check in tlb_remove_table_sync_one()
Date: Mon, 29 Dec 2025 22:52:45 +0800
Message-ID: <20251229145245.85452-4-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229145245.85452-1-lance.yang@linux.dev>
References: <20251229145245.85452-1-lance.yang@linux.dev>
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


