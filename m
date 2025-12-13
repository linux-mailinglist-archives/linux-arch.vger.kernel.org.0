Return-Path: <linux-arch+bounces-15393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B33CBA704
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D03A3009FC3
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765D7481B1;
	Sat, 13 Dec 2025 08:01:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE61F12F8
	for <linux-arch@vger.kernel.org>; Sat, 13 Dec 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765612895; cv=none; b=t7QW2P++N+GGIBHMCBPpWjLfHCjMiGJ7CeovT7sC2uzdIzOiQSEEmuOxfNaHKgfHziD20GiXvE9SS07/DdJnxJALZqAFhCwqTB19GyG7Gu1/ywczgTjuSeY3IoDaRM8WPTX16TEfebn3sxBjca7wuvriQOh5H4w+z1sZvbaDtAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765612895; c=relaxed/simple;
	bh=jXDGWyRXrmBErkv9sVlwDZo5kqTeYEl2XPZA8Y4KEZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZ78zEbH7xajD0RLD1uHf8xxKbWVG2aGNkm9nuler/CLro3VLlQ5ysrA8x9ajy8S0dAhzWgbMhwFemoNYpNwz3WcMjnRj+00chXIFjZ6IOdtNgfXDkvNYbK6fjIkOzhAFyMvodYeXTGure+6tqMWX0sdjr4jYWzVOkpR9ZLbnlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so797933a12.0
        for <linux-arch@vger.kernel.org>; Sat, 13 Dec 2025 00:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765612893; x=1766217693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6zyZqpXGOD7PQXCX/qi8XAI4ssAYS91zNYfhBfwbL38=;
        b=kUkJ4ToMSde7BABR592WP6bcV5H6U1XYvwi/zlAhQZglos7XSQJvXi8nnMLgVeMlqv
         cg8An1kV6x2gKAoP5GEjRBYkzEe3STTpllrEwHApzLhZTRBWktfuF0QMR7D29REX+hDz
         C1/0Sai+p9ZCUGj2M0duoyoftui/79UQXgWMBzQelczWRX+uUKVHgFl1srcn8x4/P6Xq
         0bgUG0Dol5+9E4kK8LpoUe71jKMR6f2Ce4/1noWyipSHSKCJ+okek5Re2DX8wQNcyHd/
         1UuEICRQoU5AO+g/8ISs1G/bc29STrt6ju2VNhFqliVK4lDpjLq1sjnZOU7+9UNzNIVD
         /t4A==
X-Forwarded-Encrypted: i=1; AJvYcCV8WIrugMb6hq3OQf9KAMc2ECT+Tms2omnfw89usxadNOV26mmJJVbRtVRvqhnTOUa2XU/LhwFpnJSt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5wIJHpL8FkhekUOV/X75niiicAuvLX0kQrt76Cj29BAGvrxG
	meo4CNUrJO2s/nHHkjYQ94vTtXYE0gQOT2+dwx6MwtXygCkFExlfVXT9
X-Gm-Gg: AY/fxX6UzsJ0AY/wt4E+P6mi/cokLYqcLVSFXM5yQmMUfoHJeqTJrGLFeUuKP9lDkCu
	8nbrSfUDL4n2ki2DV/Y1dvMolfpIKiY7m3/vfmUP7RV94sri5UkZX2Z8r1Of1203IvuCegRAu71
	HKOpWagULfT1fDkaOKbmqWvpI6uQW7e3sybJEjlc1W3evmC0Lpy/KFNyxxGpfgQd2iCdFhpnTeN
	2wnWL/Ud9Siq87kGqyhezeevptefB23hmRtr2wDFm0ViIlB4hzLbY30Ytc3/VuAElISXyiGNwz7
	PqKOCTM4MrTTjxmuWF5K+aS88YQ71BoZ5Fhq+O/hrtz7ZjXOq9yElG0scfZld3l+2ZrGJe0M2rP
	8GQFeHbSyqbIN2gJpa8Sf63W2tu+2A6yiIT7K9nQjSNdVYfzeTlHaovLJE1KvTktX3PnXQyxId2
	njXV+lIJdYUAiV38jrmJCdCb6WH/hcs2xUjY+M
X-Google-Smtp-Source: AGHT+IEvzQW8UzoOcTZBNcUeKF5AlG/hKLmPQTyZebSEYXQtt07g7PJxjlFHqOPOoSkuSiaptW4vAg==
X-Received: by 2002:a17:903:2ec3:b0:295:4d97:84f9 with SMTP id d9443c01a7336-29f24eea3b8mr45731115ad.26.1765612893191;
        Sat, 13 Dec 2025 00:01:33 -0800 (PST)
Received: from localhost.localdomain ([45.142.165.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f05287fa3sm53149155ad.5.2025.12.13.00.01.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Dec 2025 00:01:32 -0800 (PST)
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
Subject: [PATCH RFC 3/3] mm/khugepaged: skip redundant IPI in collapse_huge_page()
Date: Sat, 13 Dec 2025 16:00:25 +0800
Message-ID: <20251213080038.10917-4-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251213080038.10917-1-lance.yang@linux.dev>
References: <20251213080038.10917-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Similar to the hugetlb PMD unsharing optimization, skip the second IPI
in collapse_huge_page() when the TLB flush already provides necessary
synchronization.

Before commit a37259732a7d ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE
unconditional"), bare metal x86 didn't enable MMU_GATHER_RCU_TABLE_FREE.
In that configuration, tlb_remove_table_sync_one() was a NOP. GUP-fast
synchronization relied on IRQ disabling, which blocks TLB flush IPIs.

When Rik made MMU_GATHER_RCU_TABLE_FREE unconditional to support AMD's
INVLPGB, all x86 systems started sending the second IPI. However, on
native x86 this is redundant:

  - pmdp_collapse_flush() calls flush_tlb_range(), sending IPIs to all
    CPUs to invalidate TLB entries

  - GUP-fast runs with IRQs disabled, so when the flush IPI completes,
    any concurrent GUP-fast must have finished

  - tlb_remove_table_sync_one() provides no additional synchronization

On x86, skip the second IPI when running native (without paravirt) and
without INVLPGB. For paravirt with non-native flush_tlb_multi and for
INVLPGB, conservatively keep both IPIs.

Use tlb_table_flush_implies_ipi_broadcast(), consistent with the hugetlb
optimization.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 97d1b2824386..06ea793a8190 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1178,7 +1178,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	_pmd = pmdp_collapse_flush(vma, address, pmd);
 	spin_unlock(pmd_ptl);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_remove_table_sync_one();
+	/*
+	 * Skip the second IPI if the TLB flush above already synchronized
+	 * with concurrent GUP-fast via broadcast IPIs.
+	 */
+	if (!tlb_table_flush_implies_ipi_broadcast())
+		tlb_remove_table_sync_one();
 
 	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
 	if (pte) {
-- 
2.49.0


