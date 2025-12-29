Return-Path: <linux-arch+bounces-15597-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAEBCE74C0
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 17:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97DBC300D654
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D832E6BE;
	Mon, 29 Dec 2025 16:06:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71369329365
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024396; cv=none; b=BjdKwKb1cJsvGIoJ7u+ybTg+VUDnGTvsXIACZD1tH36tVdboSXC8sQjaO1SDYM1sA59HMTaXtCfqdX4om20ral/Kt1NBPiAfkZEQMPMZNypsHuu8uBeIbEhZY7d5MRal77zvFbg8YwlO2/Kdfd6dcAlG7SzSItW6CBEOta1+E08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024396; c=relaxed/simple;
	bh=n7zOUW6Ej9XQxpCqpcebXYRtyBmuik8QvZ4x35PJmsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ItX54KBJ5Z5rmjaOXU1JNWux8ZaPVMrLK4Mt4znUUn9pqySZ1wyQZ4gi/QlCLR4/qMypCUQVkAUZtcg1SmV/243H3cKs9PqxTMuoFOu99mHd0ELWt/b6zF8HDvFYJUPdWYeRCvXnRjYdd2GU/jwn+6B/9LhPae66pLKJtY/PBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-65cff0c342eso6338076eaf.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 08:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767024393; x=1767629193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI/SttekhGDiQM1tlGP5eL+usMVrVsg1suNc61YphTc=;
        b=mS2o9RDn462zoDXbhBWCr1thW1TtHS7Y4GXS3UZ828OFGEFXGSW3OHK83hERHeIA2M
         FjiRnyIxNX3gX951l6XvREl3p3uDSC0kmoqTfb8fcZg5s7EDctaZ61xMznYu01ZghG2e
         EtgDu3nrbpYP37ohI0Q32CIP/OsNbJk5aehZNFYjN0B8NNJfUjg9yO5cZgPneOeswIcd
         DRlVw2XOLkBBTxZW3vUVjmgWbOO5kXgtQnur4B9dYieHgsbt7RtJWmSj+4GB5GGjpyu+
         9mML+jDV9Qp+y722fbJVMG3nN5x/HQougC8i20PahyACxQVQekSQEsAGDqE8J8RUuQUQ
         +6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQI+LuaF+JVf28mqynBIy8y69oF/Jz0965viBesPLqcsREDPGKFEV5CwV0AHmT8J2a7xcHSvny7aDi@vger.kernel.org
X-Gm-Message-State: AOJu0YzDcVSFhOInAO/3pDZSgqoLdb5P86UzrCd7SPfBYTUKudiyOoLK
	a02tGC8g4ICzLz9mUun6/C8z0BKvpVWz2I9iexAKtmTH61pyHW2qFBnx8zIMGGjOzFQ=
X-Gm-Gg: AY/fxX6ScvFuIvLXZRlRLvfjVK3tSgZ/t6eJpRY78zwZfoEOhRuf+o8sWdmQYESDRcY
	6W03EC18g62d4zddaS0JO5eHHOVjuwiiu7we4kWHWi559TUvf0fbO1GWHOnt9Qyh0WUO+PgUH9G
	oi5LgGEOwiSGRQ4JFDwFvlIW5fIuhJTjlXH3OQZapOWxxHB53PFAwHh0rbtQmKVz0Ig8X0OHWG+
	UM6oF/t8mA8pFDvIgXVO9N26EoWtUg4irDIokKWMW1mmGOxwdt2mj2h3t4TwJnFTxip6RS9xiM4
	QNUP7ugC0rkfrQ5m2nYNfiLnACizep/FBGflZSkbEVCdViHLHa7Ohr+38jEGU8PiOYj6rrw1fSN
	/BaQnIqve/XH5AYTKVbtiofIKhpBHZ/DsjmxwJMrhhLuuABHnpYRks3idVfZS7sO9AcgMUeaDkd
	ElzoAEU7HATSHAN+P3Pl1u
X-Google-Smtp-Source: AGHT+IF8h2vXgJODZ7JZMxunWbJsYMMr6g5hSF24Ns6SSSKowIEhxB0xTevh9xlGxdP/5/5wrf4fPA==
X-Received: by 2002:a05:6a00:f99:b0:7e8:43f5:bd55 with SMTP id d2e1a72fcca58-7ff67759f24mr24454290b3a.65.1767018650539;
        Mon, 29 Dec 2025 06:30:50 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm29705159b3a.32.2025.12.29.06.30.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:30:49 -0800 (PST)
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
Date: Mon, 29 Dec 2025 22:30:30 +0800
Message-ID: <20251229143038.73315-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
relied on off-list discussions to push it further — thanks a lot David!

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


