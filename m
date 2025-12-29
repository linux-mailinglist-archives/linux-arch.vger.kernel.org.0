Return-Path: <linux-arch+bounces-15600-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8323CE7A83
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 17:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7347300FA2E
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFCE32ED2C;
	Mon, 29 Dec 2025 16:43:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E26D1A7
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026590; cv=none; b=AulsExr2gOqUIFrle5H5e2lxD00cfe0+RxYgo3fwv4vrBd9qVsOrWIakcm+Gjc72oKyzrd4Fsxl4I4MnpJ7m275nDkH88MyOn95YKWf8TzK90KLJLZYpkicD7j7jzLUa9Z5Jo/skps3fYnDXfzG05kKUSx2Ak/I9Zu+NomIEaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026590; c=relaxed/simple;
	bh=zlr/111TrHo5MpMuGBuF231eLYaYQPaX7JKTu3tzgjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9gm9l59Knas3so4LBgT2mATV/w25ZrC6NBFuc4ZScZwVzf+EYUDUaYR9pBkf1dKesCKO+GVI5bvtVf6Dy2eb21Ymy3Pw5ZAY0VNBPbs96kqbUFuZh1ZOeJkeB/bGHiNXwcwQWU2/uQlBZzhdDmuVCmyULz6drSHxJCIRqWmsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45358572a11so5075362b6e.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 08:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767026585; x=1767631385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rSXDsPw9SWpPdwz0G6LJLeCgBG0923yYOTzxWibmOZo=;
        b=ess+RCEhFKufirUXb2UByD4tIY451jEmRBNMHSNfimmbPfO5cyNinJbkAYj9cz/IYu
         /VtG4blt6NFJe/FyOHuJ8dG3K4WuGqLzFH+Ia6euROPfFaRr4IAJKiSMHoHXTg9xh7fs
         e96jbdevv++wWs5JvoKYF91bKD/2pG4KVwoRyfaOcw2sUAtaKPS6wr8uyIAwvYKpT50L
         7fFr2oIG08Ltv73Fhg4UY0W3Jy5UfTlS313qCnHLtcw6W04HvRiTHcQoRH4+3X7nVBf7
         3gET8AFCIJ6GYcuqSdIpVvFLQuBJzIPTMs5H9v0U49YEqmCsrulBRbG3VMvMvcQSupTK
         VroA==
X-Forwarded-Encrypted: i=1; AJvYcCWld57reGZqMSjiZzoeTXVPlQm63siFe/++vMs/AP3YDeQzJXhekEYknSa3ECTAWhedOmCcw9DHNxvs@vger.kernel.org
X-Gm-Message-State: AOJu0YxlL/SGqePFj00Bocp1FPoEbluN/uXSPH0CzHC/rKlZ9vVIeTjf
	XBO6WFQ2cjOQSM5RP9kexJfm1rchr64U37szqvEocBB9XammA8gW3QmIyQqALUCifqg=
X-Gm-Gg: AY/fxX74bF5EcfU2mFziorukWg5ZteE/B4arlpxYiykAJ8IwG1PZKcdaVZz7h3K4xcW
	sAP//JmHqrvqTfkrCHqew7qjq/S+lH2CYab2araqYbdXuETnyU+7f2gZj9vYJb2Oj58zbi//k8l
	3YfMeV8nSbk5lJfGCdMcv6mFUkRCIwrv0dr4OVQKiAz7MmF6x866jDzvThSXa9nVU21DZU3O5Cz
	g23KoyC6OsZiuNdoCHa328nnkkC2QewPUjfSCKvAAa7/ClGoFS4xoYq65lzjm9uueXtnNpnzNsW
	mvMC0slAfKfpoDyDZylYtVoHTb76KUnKG43609AxWXhELE3+gruoSIgUQML1bFbmyNsNq9pljT+
	ELZWWj/XlOPmNsyy7h1MqSiYc278dsMYqz6Vtjfo30B/VGKdrGXH9tUiPfsRZf3Yo83kzV4ahKH
	NT5dVn3bDgLLbssfLsJU0q
X-Google-Smtp-Source: AGHT+IEP/l8Fja7SBvXa0ush+/T4hTB3LaeICnV93wQNMRXO4irWoD5nheCHiMMFR22YVQ8DnynhEA==
X-Received: by 2002:a05:7022:208:b0:119:e56b:c74d with SMTP id a92af1059eb24-121722b2bc9mr31073304c88.18.1767020515978;
        Mon, 29 Dec 2025 07:01:55 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([154.17.20.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c058sm118358235c88.11.2025.12.29.07.01.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 07:01:55 -0800 (PST)
From: Lance Yang <lance.yang@linux.dev>
To: lance.yang@linux.dev
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	arnd@arndb.de,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	david@kernel.org,
	dev.jain@arm.com,
	hpa@zytor.com,
	ioworker0@gmail.com,
	jannh@google.com,
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
Subject: [PATCH v2 0/3] skip redundant TLB sync IPIs
Date: Mon, 29 Dec 2025 23:01:47 +0800
Message-ID: <20251229150147.89896-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <17a56acb-4e2c-4b14-bdb7-f64b105a3b4f@linux.dev>
References: <17a56acb-4e2c-4b14-bdb7-f64b105a3b4f@linux.dev>
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


