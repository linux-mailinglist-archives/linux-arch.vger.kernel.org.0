Return-Path: <linux-arch+bounces-15596-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD61CE74A5
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8FFE3012BD8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDECC32E6A5;
	Mon, 29 Dec 2025 16:04:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758A32E6A8
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024276; cv=none; b=Nb0VPF7Ls4vL8DgCD5X1e63Wbu9Mw6w0mhBxsNrfLw6D9gnEJVvM2k3Fk+mgj2/SHxXMP9LHrfVOIFuqXPRUBnWlzGq2Oe02AQ/JnvBJisVHsqZ1YVzYxOhc4mopf9XHQ6EnKu5zQlwF34Qr6NR3+/MMCHFjtZz9tH2TXm9MvMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024276; c=relaxed/simple;
	bh=iglCtSg7yLjM4+ieaBuaOj/sKVkNeZTBv2wFT1JQJiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCHTd6rk6icQjv1ZmsqTupOwMAmq1GO4XtWu68FvvrN/H52AXJp/0x9NBOT4q1syfK9hlnsxuy4WyWC8iLZVc16Q+DVxZ69PIuikXKip7TzzYVCkYD+NQCHpMkmMPz0UP4Vlo1Jq9RTqLaFYskOflM/2fnNhGIGnwDBc0th2V1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ba3ffd54dbso1306535285a.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 08:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767024274; x=1767629074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYC2KycL3rfVSFqLvotaH1KEwy8YCG3oD0jwMS4kfPg=;
        b=HPYB4vlTkBOZ4RUEWa97GDq+03/c5n1foGBFFsbh8QaN3m5wds/p55mi7tAhPfA5Jh
         yFjCl6DWUdZ+NbG2kIfzVKS7DNlczT/uaVFkR7N02t/QZa7+HvICs+9SbgFlDd0auDVk
         9HZ1lMbY9q+FT06qQtac3CtrLxcriyGN0dam7VsRK8i+TZkC+6UWLeNVxYstI91/mSHu
         h9CBt0V+v+SJn3uKMwwOwygIVIFWyjA6gfHabcehT4L1ejBhrDmIK49AcxVI/lL4JF8v
         6ryox7sed6BsASdgr88ArqzAQXJ1Z36SpawoXITftCNQoM/8MND5BXLWStOihJHxI3Yr
         CAng==
X-Forwarded-Encrypted: i=1; AJvYcCVunuM+7XPLeiI7YrZTsWL+8TDIawHi5uhJZWmdwPOHYqkw8gBo7cqUraTt0pm49HiKl0SMWNUnjtot@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRYF7HruIKlQN11uHUYFZAKFbVb2PEk6Vcasbk8bZSNnwSrAo
	/P9lZMyE2rUbk2Btio1whf4tJtOQWJgZsrzW14gDfQoZ3Qdzz07Jsug3ZidRRPLJi0A=
X-Gm-Gg: AY/fxX6iB6feEIu0kL4a89KvjGKCOefSoR++9afgrnf3UQW2PFL7iojlzTlxiG7kj41
	YTHWYJkuW4M6PI9qp3sC5ZyY5K8jgFiAUh5w/57SbYT27BxkG+BPjmmyVA3rabZvxkkzZsKqOMo
	LBF0svkYC+97GQN+AeJQjeCQVi7Y/L8WpvyyjJzb1EuMePMMJjq2oiq+CCGFvib/o/cTHtNCtN7
	azmVnQEULPAJGMkPhspqdUGNYhsqBgwcSJbnUlEgHfUxkLwh9ohzP2EEXU5t++R2Umt8dItwmuA
	5ijxrARhOtDOm0+EkQGdSZhKeycOOJUlBWjfiQUbXF8E/QAibj5EEvzb7SEwDKuvJzI07otkKio
	lDtp7k357YCHVzHzXx+klZjDshdN7u/VPFpKrPGKIlQ4bR4md+hAAQqK4gTpVxnVpDBnYYedI0r
	xuREECZVyAFL33LZ1d66FheDpoV0nUMDI=
X-Google-Smtp-Source: AGHT+IFhUxr5n8VZRZbKH7W82fTkxc2RP8kajse/6MgRobffbByIorFltc6WUeCvU41oKdSH/PT+mQ==
X-Received: by 2002:a17:902:cf08:b0:2a2:ecb6:55ac with SMTP id d9443c01a7336-2a2f220cbf6mr353927325ad.7.1767019032156;
        Mon, 29 Dec 2025 06:37:12 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([45.8.220.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7736fsm279669625ad.92.2025.12.29.06.37.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:37:11 -0800 (PST)
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
Subject: [PATCH RESEND v1 0/3] skip redundant TLB sync IPIs
Date: Mon, 29 Dec 2025 22:36:54 +0800
Message-ID: <20251229143657.76968-1-lance.yang@linux.dev>
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


