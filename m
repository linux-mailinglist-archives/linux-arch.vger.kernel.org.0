Return-Path: <linux-arch+bounces-15598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF2CCE78CA
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 17:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF6B23001BE4
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 16:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A12334C0A;
	Mon, 29 Dec 2025 16:34:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8231334C28
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026094; cv=none; b=Ase+9mT82vCMSjskNSFOuh88fUEWSj0InCDY2pYYVudJStGAnBbuvfVoxeRkL0oRoZH80G0AUKPRmywyo0u15aPmQZtGZtLQoD1KZxa+L3Wx/y9pa2QDVwVidsgk58Xj9LYtuzv5dhSoISAU5GnQOpSGuB8pa9J1Q9auZ1eYnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026094; c=relaxed/simple;
	bh=zlr/111TrHo5MpMuGBuF231eLYaYQPaX7JKTu3tzgjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZrGG5tGGUJ++2rd/UJ3UzD/oVebra8ZjV/6WPa0Ekkm2Rf6M7cVRvoceSqhHcKSgpbkRhSR6887sVi3pZyR0+f1AoXKjDKIbpeimK2KwwcsitdN978wIVNfZ85rNjbIhIMhj9q5Dfq1NUT6k76i0Fd1U94Y2SRNG/N4/eFayZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c52fa75cd3so10310560a34.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 08:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767026091; x=1767630891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSXDsPw9SWpPdwz0G6LJLeCgBG0923yYOTzxWibmOZo=;
        b=CXoxv+CsPJqGrOpnyMe7U8q8mOIvbognsNEtjwSWZut3PY6KHmwpAj+9wb6jt43Tsr
         dIAa4eWjfLae1xQtzbkUbPBdHSd5mP4IMz/yDV9P6ItwKWuzsKqbbYBzHI2BSYNR5kHY
         K98US2kNWgmAdDqsI2PXYnf9LtAKshmb9kobBZTGElhZbMgTnO9+BmcFZ/24XaQc1SBQ
         pwRb5aFyB7xpx+HrEkBeF6WzmOs1nSdJ5WNyjgnHN6C+hZXLmbVdhlfSZeiksWp3mL4x
         9a8k2Ozbt+Q+Ihx1EJDE8KMIf4H7j+yyLKiwmmJeH1BGyf5sYF6ISB/3hIMZp1Bgi2b5
         DBbw==
X-Forwarded-Encrypted: i=1; AJvYcCWCwc8B+TX0O+cwW3fyuDfXxzfc0us5/M1eUmeZKnUZSzX2dPQNeJ1/kbZDKEiLZmJX23sWLCSyE64K@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JgkykvXAYUmH4Nd752G6P+1w6MbeDuGAJN8snkHtG4v201MR
	V1tsCCL0mKNq3MF0SZXgmghAmx0XJ1ZKd3913VO9f9q9DquMGRF6h70KyicX9CNdX+o=
X-Gm-Gg: AY/fxX5Lbo8cWpBKQadQX8gX8ou2R1AItc5dfKLMNheIrdKts1ArwdGdSVVVku/ffih
	cHX5A2Zn8eHrdMgCCvJRGq+cy069LWKhqXtt9rpqugr7aFpLobDD3JhFqmEXE2Xw9i2ZgF/ms2+
	GA5qqKUKyWttTQkRP3iH22dMOtIRG2PS3VPL9vCnsDEogED02hNjU12OOaZbv1xCatM5MhwpVyr
	tDbi9cs+utZUl+nyWg7B68mPRnWQMFbuggeNBxELczLDGZMHl6TbA8H3piB+KK8sBGWhYgmDMkb
	d3njoXXuJofBLc8Jsx+VLP/wwU2Nvcj0PDo0FKykKXm0TOgj0aeCv0qn/z2tijTUjljLwsUhqf4
	pEYban6xVrOmjolhR4aqQKhORCjGL3hbxeaRc8hhh94+a4de/Gl34I7U0VdJd3X8l8PMYsiPW5b
	H9f2PvualrmG1hRqKwqMNC
X-Google-Smtp-Source: AGHT+IELTW1f0I8nau1FRdD8kDyAYgeeHou3baqoPeRrgIvEnjXylw0MJkmOP3DRvYb3odQ78YmLmw==
X-Received: by 2002:a17:90b:1e51:b0:341:8ac7:24d3 with SMTP id 98e67ed59e1d1-34e921f6c8cmr23662117a91.34.1767019978519;
        Mon, 29 Dec 2025 06:52:58 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbcb6esm31557603a91.9.2025.12.29.06.52.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:52:58 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] skip redundant TLB sync IPIs
Date: Mon, 29 Dec 2025 22:52:42 +0800
Message-ID: <20251229145245.85452-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Hi all,

When unsharing hugetlb PMD page tables or collapsing pages in khugepaged,
we send two IPIs: one for TLB invalidation, and another to synchronize
with concurrent GUP-fast walkers. However, if the TLB flush already
reaches all CPUs, the second IPI is redundant. GUP-fast runs with IRQs
disabled, so when the TLB flush IPI completes, any concurrent GUP-fast
must have finished.

This series introduces a way for architectures to indicate their TLB flush
already provides full synchronization, allowing the redundant IPI to be
skipped. For now, the optimization is implemented for x86 first and applied
to all page table operations that free or unshare tables.

David Hildenbrand did the initial implementation. I built on his work and
relied on off-list discussions to push it further - thanks a lot David!

v1 -> v2:
- Fix cover letter encoding to resolve send-email issues. Apologies for
  any email flood caused by the failed send attempts :(

RFC -> v1:
- Use a callback function in pv_mmu_ops instead of comparing function
  pointers (per David)
- Embed the check directly in tlb_remove_table_sync_one() instead of
  requiring every caller to check explicitly (per David)
- Move tlb_table_flush_implies_ipi_broadcast() outside of
  CONFIG_MMU_GATHER_RCU_TABLE_FREE to fix build error on architectures
  that don't enable this config.
  https://lore.kernel.org/oe-kbuild-all/202512142156.cShiu6PU-lkp@intel.com/
- https://lore.kernel.org/linux-mm/20251213080038.10917-1-lance.yang@linux.dev/


Lance Yang (3):
  mm/tlb: allow architectures to skip redundant TLB sync IPIs
  x86/mm: implement redundant IPI elimination for page table operations
  mm: embed TLB flush IPI check in tlb_remove_table_sync_one()

 arch/x86/include/asm/paravirt_types.h |  6 ++++++
 arch/x86/include/asm/tlb.h            | 19 ++++++++++++++++++-
 arch/x86/kernel/paravirt.c            | 10 ++++++++++
 include/asm-generic/tlb.h             | 14 ++++++++++++++
 mm/mmu_gather.c                       |  4 ++++
 5 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.49.0


