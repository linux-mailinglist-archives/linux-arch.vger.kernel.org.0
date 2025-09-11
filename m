Return-Path: <linux-arch+bounces-13482-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53DCB52623
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6050A3A80F4
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981D1B21BF;
	Thu, 11 Sep 2025 01:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OgipKV8w"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751E19DF5F;
	Thu, 11 Sep 2025 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555648; cv=none; b=M6p7as0PL8aW3COk3CcyrNShacLhkxOCUY4K2TFYA/nslDSwjQi2dskfKSmPS+lEtDTvwi+ZmTALKKSZS8JEKR7HV+pCDjA3TvB/AgqGQ9tZkk/ZCEOPvDMumKthvLRv76ejoG/MVOjM/y8IT/g3bnvp9lC85QpGHPHo33zIBlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555648; c=relaxed/simple;
	bh=TJlub72lfADxZb9jAV2zWYMLuh8xPEWUExbL+sSdjGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXjxR+JVaGiD71uJkPdqHTbAfaM+CZgOiXrFZiq57OoC6hMfiVJw0bLjphA+nHx+M0GcyN4Fpv6vWswcbJLFi0rEzNRe65kBFgYF/HcyagEp1k3kMAmIfqIw4vE+wxfiRixAsoT+Ef0mmf981Z2znGeAbS0OsUn8i6h3N6yT8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OgipKV8w; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dT1BxFkTZrJNMl6lghh16C3xi92G77G7I1uWC3xO+sg=; b=OgipKV8wG4JxJCj9qZQxA7NEYX
	5I2cXfYahl18StSAYdWsh8CrSgwGi4OsGizfkRdhkufK2logxkuZwi7M4lwQDkAfbvZ2zDsxKW9y7
	6s0sSQpZQq378erekTPRaSw29jwr4vWQjCmwHX/ScmgdHSBVy3kOG7+PODtbntjpRw504RbiUxbnq
	k8LAoTbCPo30Qq/vsPn70XYn8J9Vu6DUONqeiH76MhxNm5uRIctZEV3pEmtLJ/2g1KsiK4ocCqa1q
	PLJmcY/cux0QO629+EplOa1MSs0P6Fc8nqT8bIHF3BCH6pzN5Z+25yneSypC4R7KnNeLeQNnax+D3
	t+v5QIGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwWVh-0000000AwcU-2Shg;
	Thu, 11 Sep 2025 01:54:05 +0000
Date: Thu, 11 Sep 2025 02:54:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	linux-alpha@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 4/6] alpha: get rid of the remnants of BAD_PAGE and friends
Message-ID: <20250911015405.GD2604499@ZenIV>
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

unused since 2.4 times...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/pgtable.h | 10 ----------
 arch/alpha/mm/init.c             | 27 ---------------------------
 2 files changed, 37 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index ae2bdbeec91c..84014e9be504 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -126,19 +126,9 @@ struct vm_area_struct;
 #define pgprot_noncached(prot)	(prot)
 
 /*
- * BAD_PAGETABLE is used when we need a bogus page-table, while
- * BAD_PAGE is used for a bogus page.
- *
  * ZERO_PAGE is a global shared page that is always zero:  used
  * for zero-mapped memory areas etc..
  */
-extern pte_t __bad_page(void);
-extern pmd_t * __bad_pagetable(void);
-
-extern unsigned long __zero_page(void);
-
-#define BAD_PAGETABLE	__bad_pagetable()
-#define BAD_PAGE	__bad_page()
 #define ZERO_PAGE(vaddr)	(virt_to_page(ZERO_PGE))
 
 /*
diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 2d491b8cdab9..4c5ab9cd8a0a 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -60,33 +60,6 @@ pgd_alloc(struct mm_struct *mm)
 }
 
 
-/*
- * BAD_PAGE is the page that is used for page faults when linux
- * is out-of-memory. Older versions of linux just did a
- * do_exit(), but using this instead means there is less risk
- * for a process dying in kernel mode, possibly leaving an inode
- * unused etc..
- *
- * BAD_PAGETABLE is the accompanying page-table: it is initialized
- * to point to BAD_PAGE entries.
- *
- * ZERO_PAGE is a special page that is used for zero-initialized
- * data and COW.
- */
-pmd_t *
-__bad_pagetable(void)
-{
-	memset(absolute_pointer(EMPTY_PGT), 0, PAGE_SIZE);
-	return (pmd_t *) EMPTY_PGT;
-}
-
-pte_t
-__bad_page(void)
-{
-	memset(absolute_pointer(EMPTY_PGE), 0, PAGE_SIZE);
-	return pte_mkdirty(mk_pte(virt_to_page(EMPTY_PGE), PAGE_SHARED));
-}
-
 static inline unsigned long
 load_PCB(struct pcb_struct *pcb)
 {
-- 
2.47.2


