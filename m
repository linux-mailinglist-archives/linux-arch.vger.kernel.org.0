Return-Path: <linux-arch+bounces-15590-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62316CE7162
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41ADB3050CDC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A345E320A3E;
	Mon, 29 Dec 2025 14:38:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332E3203AA
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019103; cv=none; b=owmeqlmuFd/nWPQ+Xwxv2LZx3EDW/fKq7fYRMfpflhIe7GPzEDzYxJqaX8xRoQkyPhe63QRVbTHQvd3g0rguotlHXW7xje3B2k9Hbx6fiuJTj3jVF4NNY/9xyDi1nAkM0jX64wcXAw6QR06i9NU8Y7Oft44AN0qdEk2eXjlJ2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019103; c=relaxed/simple;
	bh=QELGmcYo0okd7XeZ+8OIMQ2Ox7GoXMWa9Ttw3qK5W4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGHIhADrCOtWqS0XYugmCDK9kRPnBnRM0DAZ8WhiPMeIMQyz+YjxvBobuxdfWbNzrqHKRxbncMmCs1+Z6Coj/qdxdb9yrIZl7djDc+NYqqO9Z+n1F2+sv57Qr3tYy7pkLDBqhbGg6RtbUYct00PD+rAeoRljxIR+URlj3IxWeKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a12ed4d205so79825715ad.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767019098; x=1767623898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2pBV4vyT2c4GBUcrUp/G3rP2JcNWZOiRH8LtGLdyis=;
        b=Ba2SxHoOSIkzAFV9I9zfIQ8+RVMMr6Uhf9E/nNVfiMUt+u+bRsdkcZYyB4ZnDCcgoI
         ogUdhogWRDvrb53ZnRBPY/ozJkPfGqCwZ9iP7n0OEJ4xYPv/a4OmU9y7HSrqJw4g/cuG
         ibRavUAhYkC2/GJcbUg/8SgQ7N64E+7gMwh+67iVrlHYqx03EOailHCJhUG9Tft//VjK
         AVDh7zdX/2cIp1vQCmCkAedjgjIIRbpiihPErrpUbPVYDXVj8WingNWC2ZAkZATB/GS/
         S2NpwjdK3P2MTo5uPOzL0ckD7A8/OytL4pNf/dt2QYa6zW4clE/CX1RmYwi0nChOTGnK
         ciuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsQ7sHFqZdyNXE0iUEuYxc7Dc4nHHXrWPGnuV7GUcSNKsZiVQMLJDAyVZpPw3wpZRzW2LTjy/+O1tF@vger.kernel.org
X-Gm-Message-State: AOJu0YzO5cX1WILsN+fLviz30V+WeTwICshBnm3DB0qe2hBePnylNXLR
	t6x4VfwmjpePiGZy/3mylUGXZ9huEO4OiQwy8qZVXSKDlvBQamLXeCgL
X-Gm-Gg: AY/fxX7AmKPnzdNe9Glc5/+dUG25LV0OxApqobrM9kq4h4Gt5iPap0pTwr/594v2xPt
	N3YqlQVjST9Wbyd1kbIyC5JZrTqMlY3iNVKxhaWcNElqBh/VUNdGacLYnqL8t4e9+3GW5IrytD/
	x2XUbHkH+lvEBE6bFYcvkFPhf3dvaezBky9ggjrjVKuR4wbQV+dzMbvXbq+NKMLG1eIFhO/j3Xl
	NNawpafRgf7rXw45gC8er18f8tlpZZ26Gkn4Brh4JxYT8CTQOmU/m694LNtYGZs7mVYA6UzF9rf
	bGZBShrIKmRzUV4jB48A5C3T8+uNLUXs+juU+GV8ic8tlsPLPREcaH6ii0nnx9p9I+kw6BV4pz2
	hNM5K8S5ewbsG+WoxGivlemuu+aJ2cctulN6xx9uyjLhKzx9kht4rExoWovIaJfAxzRl59ZossK
	P9njWg6ARbupgWjHANSkMt
X-Google-Smtp-Source: AGHT+IGdJt3lkU5juysv6cnzuaDtBicBqS5Uo+6zRrWiZ1emfZCDgGtYUFWFKyKinXKOayvqccQJSQ==
X-Received: by 2002:a17:902:ea11:b0:290:91d2:9304 with SMTP id d9443c01a7336-2a2f22052f9mr332042505ad.4.1767019098192;
        Mon, 29 Dec 2025 06:38:18 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([45.8.220.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7736fsm279669625ad.92.2025.12.29.06.38.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:38:17 -0800 (PST)
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
Date: Mon, 29 Dec 2025 22:36:57 +0800
Message-ID: <20251229143657.76968-4-lance.yang@linux.dev>
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


