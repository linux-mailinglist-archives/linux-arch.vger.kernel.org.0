Return-Path: <linux-arch+bounces-13480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 214D4B5261F
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE89188D12D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 01:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9221930A;
	Thu, 11 Sep 2025 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pVr4gye1"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128101B21BF;
	Thu, 11 Sep 2025 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555589; cv=none; b=U6s7vdXa1Cpfxq5CKMJVHUsdLALAObKDkGf41sXOxi30Q2mkNRe1l5JWlIg6XNolUu7TsWcWkRrUl719mvc+sZaVwxQgfqlACoj+IHG3EOV2kLuZfn5rqM2NTU3CX5/UwKdI8yaIYlyqgYgC4bmL5q+NFeXpl4qXdHBcy3b6Jqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555589; c=relaxed/simple;
	bh=BY9Ovd8/d4h6aiKK7e/q2JSokSpQ5NkMZRwrymHRszc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCt/7Se2eJU9Ri5Nkv/IwtQes8ASbXRe3d8Et8DIE2jupI4ef7SQkSFwK+XTNt5cccipFFuF5JxStPaNHut0KrZOogCblTE4x/TeQ0MY68xWd35bJSZP7eilR8RK8M8kWMBuoFK3Me/Zyuxg66bmnSEPWZppQ2bhS0lJBEbFrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pVr4gye1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0BRvY0YpC/pM2PkgVS+2GUuGcZCzqldYex/5/9b3gAY=; b=pVr4gye13PJ+QlZcd4AdKAvcTS
	VIHKiZXxAlUOxNfzw3BeBT94a0OVktOsYUcqN3MyD36LMyaJTUhKByJy02C8QPqCQA4e7tZuSZyCE
	+p2122BQJW8Fq8A7QU4KbmTEo92vGCFZ9E2kpecyANFPR2NND3qgVN0fv19lYL+klTAo/uGlwc5gu
	dU07KGr2HtNEI+Gv0y1h9vdB383vJO0ecK12g8vkM0cu3Ip4tlOWUMHL8W4MdrjIzZZuXMqhXpjqd
	4ND6q2aO0g2WSECghE0fP8ohA1v1SUT1WCOHwjKxg2Mf5wSjzu5nR829h09ITy6mxftKrHvAxOi51
	5Z9X/Qng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwWUk-0000000Aw9v-1QrW;
	Thu, 11 Sep 2025 01:53:06 +0000
Date: Thu, 11 Sep 2025 02:53:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	linux-alpha@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/6][alpha,m68k,openrisc] PAGE_PTR() had been last used
 outside of arch/* in 1.1.94
Message-ID: <20250911015306.GB2604499@ZenIV>
References: <20250911015124.GV31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911015124.GV31600@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

.. and in arch/* - circa 2.2.7.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/pgtable.h    | 13 -------------
 arch/m68k/include/asm/pgtable_mm.h  | 10 ----------
 arch/openrisc/include/asm/pgtable.h | 14 --------------
 3 files changed, 37 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 44e7aedac6e8..ae2bdbeec91c 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -141,19 +141,6 @@ extern unsigned long __zero_page(void);
 #define BAD_PAGE	__bad_page()
 #define ZERO_PAGE(vaddr)	(virt_to_page(ZERO_PGE))
 
-/* number of bits that fit into a memory pointer */
-#define BITS_PER_PTR			(8*sizeof(unsigned long))
-
-/* to align the pointer to a pointer address */
-#define PTR_MASK			(~(sizeof(void*)-1))
-
-/* sizeof(void*)==1<<SIZEOF_PTR_LOG2 */
-#define SIZEOF_PTR_LOG2			3
-
-/* to find an entry in a page-table */
-#define PAGE_PTR(address)		\
-  ((unsigned long)(address)>>(PAGE_SHIFT-SIZEOF_PTR_LOG2)&PTR_MASK&~PAGE_MASK)
-
 /*
  * On certain platforms whose physical address space can overlap KSEG,
  * namely EV6 and above, we must re-twiddle the physaddr to restore the
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index 62f2ff4e6799..bba64a9c49ac 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -119,16 +119,6 @@ extern void *empty_zero_page;
  */
 #define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
 
-/* number of bits that fit into a memory pointer */
-#define BITS_PER_PTR			(8*sizeof(unsigned long))
-
-/* to align the pointer to a pointer address */
-#define PTR_MASK			(~(sizeof(void*)-1))
-
-/* sizeof(void*)==1<<SIZEOF_PTR_LOG2 */
-/* 64-bit machines, beware!  SRB. */
-#define SIZEOF_PTR_LOG2			       2
-
 extern void kernel_set_cachemode(void *addr, unsigned long size, int cmode);
 
 /*
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index d33702831505..138f46fc838b 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -183,20 +183,6 @@ extern void paging_init(void);
 extern unsigned long empty_zero_page[2048];
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
 
-/* number of bits that fit into a memory pointer */
-#define BITS_PER_PTR			(8*sizeof(unsigned long))
-
-/* to align the pointer to a pointer address */
-#define PTR_MASK			(~(sizeof(void *)-1))
-
-/* sizeof(void*)==1<<SIZEOF_PTR_LOG2 */
-/* 64-bit machines, beware!  SRB. */
-#define SIZEOF_PTR_LOG2			2
-
-/* to find an entry in a page-table */
-#define PAGE_PTR(address) \
-((unsigned long)(address)>>(PAGE_SHIFT-SIZEOF_PTR_LOG2)&PTR_MASK&~PAGE_MASK)
-
 /* to set the page-dir */
 #define SET_PAGE_DIR(tsk, pgdir)
 
-- 
2.47.2


