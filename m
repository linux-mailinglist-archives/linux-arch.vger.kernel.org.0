Return-Path: <linux-arch+bounces-1994-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780A7847204
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 15:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316D02889A2
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F6120DFA;
	Fri,  2 Feb 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpRI3mL6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E701798F;
	Fri,  2 Feb 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884529; cv=none; b=aMTKuz0eruMTwNU09ZZnCJ6biCLRFwl0IBllUbLzu3jrBrcDyXX/aPokq1fGUawWp9IF0KFN8gbiVnU2syDquOR3XOreOzxVh8yq3mLSWxcg9fNzyCmRofDcyVN0CKpp5ERsFjSSWUUBbFfmoIJub+o+BrnsNKWt4Gvl58cGzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884529; c=relaxed/simple;
	bh=wriapjeWuh2ey1LerCDuOBHA5fjmti3BBGSuCxUGacE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aPKOo9B4RC27ncRebT2GjZDpzLFUqjlX/au/1f1ZCb8s47vyKQEsbZqReaNM9vI0WtRBB0bXxbSoi7G84quK7Raasrc/B+wkx3mvNMANVLVMfWeSqZI9VQDi+ra9+RleHdQ5qoQAQEK73vABoagmh3mx6Ow+aRw+PP3vFmNm5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpRI3mL6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706884528; x=1738420528;
  h=from:to:cc:subject:date:message-id;
  bh=wriapjeWuh2ey1LerCDuOBHA5fjmti3BBGSuCxUGacE=;
  b=GpRI3mL618VYgPf6Axyxb/1UXZJJrEpk5NG49LBqgYybDS8MwCFuqnYT
   rXtU1cKU4UzPV99FdUtAWucK5wfZSa7iBrt+bQtD+dMWpgGSfVNd4Gfgc
   cdggaIzol+gfCguKIdK1x1AOgXrqjlL6w1cvz1g39KXJBCrNvMeqPGND8
   t8BTYyUHDeTRQRcSyA7EURMJSl3VkS7e1FLtEko9seJiwWHKPEgSvpDAf
   pse4s8DFOyCDPy3TQ0eU8CWUPzSOqH1lw+GlBUL3im2kaok1IdyTIGOzD
   fdTbxFbKo/vXE77UU8uWu1zS+CjhHtkkHwQaDTTRqi5ZeIUyCUohWPsVc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11265575"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="11265575"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 06:35:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4707751"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 06:35:23 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: arnd@arndb.de,
	linus.walleij@linaro.org,
	guoren@kernel.org,
	bcain@quicinc.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH] mm: Remove broken pfn_to_virt() on arch csky/hexagon/openrisc
Date: Fri,  2 Feb 2024 22:05:50 +0800
Message-Id: <20240202140550.9886-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Remove the broken pfn_to_virt() on architectures csky/hexagon/openrisc.

The pfn_to_virt() on those architectures takes PFN instead of PA as the
input to macro __va(), with PAGE_SHIFT applying to the converted VA, which
is not right, especially when there's a non-zero offset in __va(). [1]

The broken pfn_to_virt() was noticed when checking how page_to_virt() is
unfolded on x86. It turns out that the one in linux/mm.h instead of in
asm-generic/page.h is compiled for x86. However, page_to_virt() in
asm-generic/page.h is found out expanding to pfn_to_virt() with a bug
described above. The pfn_to_virt() is found out not right as well on
architectures csky/hexagon/openrisc.

Since there's no single caller on csky/hexagon/openrisc to pfn_to_virt()
and there are functions doing similar things as pfn_to_virt() --
- pfn_to_kaddr() in asm/page.h for csky,
- page_to_virt() in asm/page.h for hexagon, and
- page_to_virt() in linux/mm.h for openrisc,
just delete the pfn_to_virt() on those architectures.

The pfn_to_virt() in asm-generic/page.h is not touched in this patch as
it's referenced by page_to_virt() in that header while the whole header is
going to be removed as a whole due to no one including it.

Link:https://lore.kernel.org/all/20240131055159.2506-1-yan.y.zhao@intel.com [1]
Cc: Linus Walleij <linus.walleij@linaro.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/csky/include/asm/page.h     | 5 -----
 arch/hexagon/include/asm/page.h  | 6 ------
 arch/openrisc/include/asm/page.h | 5 -----
 3 files changed, 16 deletions(-)

diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 4a0502e324a6..866855e1ab43 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -82,11 +82,6 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 	return __pa(kaddr) >> PAGE_SHIFT;
 }
 
-static inline void * pfn_to_virt(unsigned long pfn)
-{
-	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
-}
-
 #define MAP_NR(x)	PFN_DOWN((unsigned long)(x) - PAGE_OFFSET - \
 				 PHYS_OFFSET_OFFSET)
 #define virt_to_page(x)	(mem_map + MAP_NR(x))
diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 10f1bc07423c..32394b7e752e 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -133,12 +133,6 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 	return __pa(kaddr) >> PAGE_SHIFT;
 }
 
-static inline void *pfn_to_virt(unsigned long pfn)
-{
-	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
-}
-
-
 #define page_to_virt(page)	__va(page_to_phys(page))
 
 #include <asm/mem-layout.h>
diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index 44fc1fd56717..de33ba10ee67 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -77,11 +77,6 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 	return __pa(kaddr) >> PAGE_SHIFT;
 }
 
-static inline void * pfn_to_virt(unsigned long pfn)
-{
-	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
-}
-
 #define virt_to_page(addr) \
 	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
 

base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.17.1


