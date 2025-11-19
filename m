Return-Path: <linux-arch+bounces-14889-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D26BDC6D22A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 08:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CCAC354963
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158C2C0298;
	Wed, 19 Nov 2025 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uyjpuiv9"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C04296BA5
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537575; cv=none; b=fNOJS8UeVbrkP6u0DWrrJECdHYnnJkXfkmiBS43Twph5afD+xZ3f70evORccpQOJnCb2qYbmjEwwBs5iU3iK6a4u8tGYCMTsM3ngK61n0VnMPEFYcFoJC+FXhmcUrZKHyx7uvqCj/FI+Nczw95MX7i/b7wC6xI4vteI7ZQaLmzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537575; c=relaxed/simple;
	bh=11+Gw4P/9LydQICXj98068sKmY8lDHK8bLvUtxVXDtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3s0BwyPeiXzM/eZN566HOPU1o2g+30c+7mqB1DbLVYmknStOfTdMpAXcVg3QTNDpszVOwbl/75HRB3OvtCTXSAWYCtAee4rEYxT+Tqr9ji4LFefO2BxBGQ39f4+ENiHS3MDEIRZqbGXq5L3czBqhpiKwGHPLRpxpzT+owQwBbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uyjpuiv9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763537570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqzAgJ4OlgcGBu7aVY4MnPgaTUGUmQkYyYjl0T7Jjfo=;
	b=uyjpuiv9TBbXB7w5nX9ezg2b/0arYsi+ngniUmEy5/UHQe7UIU+7bW+ZZH6JZOPtCOAwTM
	I2y6i4tBKl8QNLVOSZZcx0mBsB2R/e0ql3nUife45Tqxisf0T9zBpRBX7bZtz84Wv3to6z
	ik4dz5PKJGLLY8Z0cTmGxwsTW0EsQQg=
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
Subject: [PATCH v2 2/7] alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
Date: Wed, 19 Nov 2025 15:31:19 +0800
Message-ID: <54381c49729449b9c3a09e78a69bf14b4b107774.1763537007.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1763537007.git.zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
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


