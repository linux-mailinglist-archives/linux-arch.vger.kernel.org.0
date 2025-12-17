Return-Path: <linux-arch+bounces-15476-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6009DCC7047
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 11:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B02E30625B6
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CABD33D6FF;
	Wed, 17 Dec 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MRO4qPIx"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEBE33D6DB
	for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964828; cv=none; b=FqF/4iqfHR+6CbMOw23sPt3fOYx/IItA/PdBjJIb+LsaJ3iUN1lxXxWAzwYLcwMJWk+i7lqOc2zYfKsHTUN/Zhukehh1nyQunPiqLdEFDsntRkghOeIHgXB71THHgpVkRrA2g3TaubuHaCLGSiLSLcOE78m4+6nQfpGijbfeU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964828; c=relaxed/simple;
	bh=2TdWibhf5ZP3VSAv96FB5mOfcfdZyF1zBRAuRMzN4h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftOqrlTxWtSrsPGXHJqyKya8G8ysycNOLQUtutNppz2by9EUz+YUNyxtQwdWaGwLcJSwl8RkXGPCSxl484iz2Kc8PaUfgNEMrsQwdYvdmCuOv9aV8T0FwzRtwppgh+aXr/6ktaw4zTgSlW7kgsbVrwu9d+1mQxczog9d9l3x8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MRO4qPIx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765964813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oN9R7byRGmHEs6T0OtpuwOuRpbJv46Zq9CpZBf5+XJg=;
	b=MRO4qPIxxsVdDqwXzC7u9PLqRjNXx7wnrDSDf1lYyiYd50PIXjJACLh+SJDhboDde2AFBp
	xudEn7lhZost3Ms/RAgSJ4rwmF9QHLUnd5iBfmp1YPdZeHPAwkC3Dg4lXkpK8Qt3kXk60G
	KOm9TW1XYyMer/EiQIPn82zf46FXx9c=
From: Qi Zheng <qi.zheng@linux.dev>
To: will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	dev.jain@arm.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ioworker0@gmail.com,
	linmag7@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 0/7] enable PT_RECLAIM on all 64-bit architectures
Date: Wed, 17 Dec 2025 17:45:41 +0800
Message-ID: <cover.1765963770.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Changes in v3:
 - modify the commit message in [PATCH v3 1/7] (suggested by David Hildenbrand)
 - make PT_RECLAIM depends on MMU_GATHER_RCU_TABLE_FREE instead of 64BIT
 - collect Acked-by
 - rebase onto the next-20251217

Changelog in v2:
 - fix compilation errors (reported by Magnus Lindholm and kernel test robot)
 - adjust some code style (suggested by Huacai Chen)
 - make PT_RECLAIM user-unselectable (suggested by David Hildenbrand)
 - rebase onto the next-20251119

Hi all,

This series aims to enable PT_RECLAIM on all 64-bit architectures.

On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of empty PTE
page table pages (such as 100GB+). To resolve this problem, we need to enable
PT_RECLAIM, which depends on MMU_GATHER_RCU_TABLE_FREE.

Therefore, this series first enables MMU_GATHER_RCU_TABLE_FREE on all 64-bit
architectures, and finally makes PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE.
This way, PT_RECLAIM can be enabled by default on all 64-bit architectures.

Of course, this will also be enabled on some 32-bit architectures that already
support MMU_GATHER_RCU_TABLE_FREE. That's fine, PT_RECLAIM works well on all
32-bit architectures as well. Although the benefit isn't significant, there's
still memory that can be reclaimed. Perhaps PT_RECLAIM can be enabled on all
32-bit architectures in the future.

Comments and suggestions are welcome!

Thanks,
Qi

Qi Zheng (7):
  mm: change mm/pt_reclaim.c to use asm/tlb.h instead of
    asm-generic/tlb.h
  alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
  LoongArch: mm: enable MMU_GATHER_RCU_TABLE_FREE
  mips: mm: enable MMU_GATHER_RCU_TABLE_FREE
  parisc: mm: enable MMU_GATHER_RCU_TABLE_FREE
  um: mm: enable MMU_GATHER_RCU_TABLE_FREE
  mm: make PT_RECLAIM depends on MMU_GATHER_RCU_TABLE_FREE

 arch/alpha/Kconfig                   | 1 +
 arch/alpha/include/asm/tlb.h         | 6 +++---
 arch/loongarch/Kconfig               | 1 +
 arch/loongarch/include/asm/pgalloc.h | 7 +++----
 arch/mips/Kconfig                    | 1 +
 arch/mips/include/asm/pgalloc.h      | 7 +++----
 arch/parisc/Kconfig                  | 1 +
 arch/parisc/include/asm/tlb.h        | 4 ++--
 arch/um/Kconfig                      | 1 +
 arch/x86/Kconfig                     | 1 -
 mm/Kconfig                           | 9 ++-------
 mm/pt_reclaim.c                      | 2 +-
 12 files changed, 19 insertions(+), 22 deletions(-)

-- 
2.20.1


