Return-Path: <linux-arch+bounces-15477-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46986CC7263
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 11:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33892304D886
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715B533DEE3;
	Wed, 17 Dec 2025 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jh2KGANA"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8A33D6DA
	for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964829; cv=none; b=m9TAPdJSnZO4gsZnstN4VuTa28Gaw68kQjCSZ7obUcBwkpSTxDtSe+gxUBP5BT8avVlkFiVB3cvkUuwhr78m1F512U4c/6V9XrUrk7X5zYq6lqcNormSE8XpmFgPvhYE0L0uvllgyzWNdd05aBwnrFRmd5bmmkv4wu63VnVeh4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964829; c=relaxed/simple;
	bh=11+Gw4P/9LydQICXj98068sKmY8lDHK8bLvUtxVXDtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gL5Ffe/v/TzCjRUDC1DpTnMS8ICsDrU0vp3BQYfOoL2Z4QakXvBJQio3IrviMwjelUf4mJ53N6WsFKYWfqxRDe/xadWSJIF2Y3wg+FVRlPmi9OL9duTGUmhHQvj9c4OvARxuzDkpySfGgd8SC/ckOCS378PtxiFCXxgCg4pHDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jh2KGANA; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765964822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqzAgJ4OlgcGBu7aVY4MnPgaTUGUmQkYyYjl0T7Jjfo=;
	b=jh2KGANAcZFZ/Soyhd/A84RQMbBaBHVyKCxUF5JCM+7cx9Rnhf/tMQ9P6HVN/+QKFGILZp
	BLjt6g/DwkO9AsGY0t54potwgCcFvvmS0tsSHhK+hfb0CuuOfNRuGIBOXhCfCHIj04JF9d
	IqY0V30iUlnAoa7IdoieTfgaHfQtGcM=
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 2/7] alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
Date: Wed, 17 Dec 2025 17:45:43 +0800
Message-ID: <3018b189364a57a76fc70dcb477aa5f0da045b05.1765963770.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1765963770.git.zhengqi.arch@bytedance.com>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
empty PTE page table pages (such as 100GB+). To resolve this problem,
first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
PT_RECLAIM feature, which resolves this problem.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/Kconfig           | 1 +
 arch/alpha/include/asm/tlb.h | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 80367f2cf821c..6c7dbf0adad62 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -38,6 +38,7 @@ config ALPHA
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
 	select MMU_GATHER_NO_RANGE
+	select MMU_GATHER_RCU_TABLE_FREE
 	select SPARSEMEM_EXTREME if SPARSEMEM
 	select ZONE_DMA
 	help
diff --git a/arch/alpha/include/asm/tlb.h b/arch/alpha/include/asm/tlb.h
index 4f79e331af5ea..ad586b898fd6b 100644
--- a/arch/alpha/include/asm/tlb.h
+++ b/arch/alpha/include/asm/tlb.h
@@ -4,7 +4,7 @@
 
 #include <asm-generic/tlb.h>
 
-#define __pte_free_tlb(tlb, pte, address)		pte_free((tlb)->mm, pte)
-#define __pmd_free_tlb(tlb, pmd, address)		pmd_free((tlb)->mm, pmd)
- 
+#define __pte_free_tlb(tlb, pte, address)	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
+#define __pmd_free_tlb(tlb, pmd, address)	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
+
 #endif
-- 
2.20.1


