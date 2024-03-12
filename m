Return-Path: <linux-arch+bounces-2933-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2F4878F13
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 08:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE17B213B2
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AC46995A;
	Tue, 12 Mar 2024 07:31:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0166C69944;
	Tue, 12 Mar 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710228715; cv=none; b=npWPN8fC/e4NVRFhNidgnr2zTNojRwR2PoEKWdtSHtnQGdDyNLmnqo8d9iWDGBhFDt95fXQnoJCXX/UZXCoeUEoVQlgcUraHnXyCw+VjJ01VRM57n6RiUFLg4qL2clQBhVIRmlAx9c4sP+RJasugQDbRCYSsjBWMcNXTIPZHc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710228715; c=relaxed/simple;
	bh=C/YtlJq6MD68YVbA5nvbcQYlt9pBdSBOZia86ZjMxUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1Pu8I4M9Zi61P1Rix2vhyIaZoqpqUP4Z/6FGKs9ivrCDprmfmVESd8iFuDMzyooDFfoZ0xZQNijkSlvBAi5NnJkaKOArfGic1/QxMH1FhcoRr50gbryg+9xZz9ne0dZVhqg8EoqVRPLjqEnu1CUU92HHFsAsok34AzTRa45pBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E6C433C7;
	Tue, 12 Mar 2024 07:31:50 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	kernel test robot <lkp@intel.com>,
	Barry Song <21cnbao@gmail.com>
Subject: [PATCH] LoongArch: Remove superfluous flush_dcache_page() definition
Date: Tue, 12 Mar 2024 15:31:31 +0800
Message-ID: <20240312073131.2278318-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LoongArch doesn't have cache aliases, so flush_dcache_page() is a no-op.
There is a generic implementation for this case in include/asm-generic/
cacheflush.h. So remove the superfluous flush_dcache_page() definition,
which also silences such build warnings:

   In file included from crypto/scompress.c:12:
   include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
   include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
      76 |                 struct page *page;
         |                              ^~~~
   crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
     174 |                         struct page *dst_page = sg_page(req->dst);
         |

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp@intel.com/
Suggested-by: Barry Song <21cnbao@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/cacheflush.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
index 80bd74106985..f8754d08a31a 100644
--- a/arch/loongarch/include/asm/cacheflush.h
+++ b/arch/loongarch/include/asm/cacheflush.h
@@ -37,8 +37,6 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
 #define flush_icache_range	local_flush_icache_range
 #define flush_icache_user_range	local_flush_icache_range
 
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-
 #define flush_cache_all()				do { } while (0)
 #define flush_cache_mm(mm)				do { } while (0)
 #define flush_cache_dup_mm(mm)				do { } while (0)
@@ -47,7 +45,6 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
 #define flush_cache_vmap(start, end)			do { } while (0)
 #define flush_cache_vunmap(start, end)			do { } while (0)
 #define flush_icache_user_page(vma, page, addr, len)	do { } while (0)
-#define flush_dcache_page(page)				do { } while (0)
 #define flush_dcache_mmap_lock(mapping)			do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)		do { } while (0)
 
-- 
2.43.0


