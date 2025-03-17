Return-Path: <linux-arch+bounces-10910-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FAA65328
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 15:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B563E3B481B
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A56245039;
	Mon, 17 Mar 2025 14:22:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E896D23FC6B;
	Mon, 17 Mar 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221320; cv=none; b=MHlYq51KElW4OMCrdYNa2FbFazrUbLFgwsT3v6U7vbRTaNeaLzs2/H2LvWoVl1w6FIGs3qMel7r7NVODzY2lA6F20RFDW3re8damSaenetdHcJB6tTjE1hboBcnoehAErCP9kWg51910xisSWcgIOeOkNGCM/CJG0y7P+7hEw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221320; c=relaxed/simple;
	bh=w65cv4CUNKlw6sVPxiOLyDXr602rMyWtTDqQ4n3B7mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeF7oeXNVaw/pbiRYso4K279cdh/Nd6HNraxTS//Y6BIbz5miEbC/K3SeJTI3U2noiU3gnAWe4N3cPZFoKFNW+PbyZ9YAGEbh+fAgAB4S3m34y+Q6Sn/fghg5wNjOLZ90mPGZ5lY6j7lbxvs534SPDxxyVYwKwD/Lb2DxfLsjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24CC326BE;
	Mon, 17 Mar 2025 07:22:07 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F102B3F63F;
	Mon, 17 Mar 2025 07:21:53 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 06/11] mm: Skip ptlock_init() for kernel PMDs
Date: Mon, 17 Mar 2025 14:16:55 +0000
Message-ID: <20250317141700.3701581-7-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250317141700.3701581-1-kevin.brodsky@arm.com>
References: <20250317141700.3701581-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split page table locks are not used for pgtables associated to
init_mm, at any level. pte_alloc_kernel() does not call
ptlock_init() as a result. There is however no separate alloc/free
functions for kernel PMDs, and pmd_ptlock_init() is called
unconditionally. When ALLOC_SPLIT_PTLOCKS is true (e.g. 32-bit
architectures or if CONFIG_PREEMPT_RT is selected), this results in
unnecessary dynamic memory allocation every time a kernel PMD is
allocated.

Now that pagetable_pmd_ctor() is passed the associated mm, we can
easily remove this overhead by skipping pmd_ptlock_init() if the
pgtable is associated to init_mm. No special-casing is needed on the
dtor path, as ptlock_free() is already called unconditionally for
all levels. (ptlock_free() is a no-op unless a ptlock was allocated
for the given PTP.)

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ee31ffd7ead2..4759da9cd633 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3125,7 +3125,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
 				      struct ptdesc *ptdesc)
 {
-	if (!pmd_ptlock_init(ptdesc))
+	if (mm != &init_mm && !pmd_ptlock_init(ptdesc))
 		return false;
 	ptdesc_pmd_pts_init(ptdesc);
 	__pagetable_ctor(ptdesc);
-- 
2.47.0


