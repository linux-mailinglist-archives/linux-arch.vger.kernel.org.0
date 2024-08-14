Return-Path: <linux-arch+bounces-6197-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF911951ED7
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 17:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4FB1C21CDE
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884921DA5E;
	Wed, 14 Aug 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vm4v2bc1"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247C1B5830;
	Wed, 14 Aug 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650277; cv=none; b=ujeC6DTsNe5f16aDaXTDBHWHPXvnmL5Q3O7A4PP4mSrXVzmSNm6oMYSUfYjKi5RxaQj22LdwyX32AtyW47wMjk9GxsRIu10KZUAS7E+a+PYyNcGr2534v/ZbSgQgoRI8ixPck1s3E0LSJfK+GKXQHd0LMNnl60doMYft22Uts3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650277; c=relaxed/simple;
	bh=tdadX9fO7MJt/rojFQaWHf4gVWAH38mayzTo//zSQD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC9Xg6lAvQjnPrMKqfGfYvHXuZTqMrVomA4sEENMogVnVS432rR3rALySSVYh+Kzhb1e5vW5tuuN7sm7mcycZqsG/7L2BSMLeZvWU+jEFMQN987vkUu8lnuwoFXSBt0gwfHtj4k3WzEu0kYkla3GH944Ie02X7X2tkv0xE9vvio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vm4v2bc1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ImVhDDZvGKdMvHRXKWtBY7b1k/mxkNbLUAPdKjzQZA4=; b=vm4v2bc1RJWujLJZeuHTO2tTsQ
	r9TLvhRGZHshO+cnttcm3iLy974IWx6T811ohmQwtnkXjc3sCZkSRvrTVT/gR9nkri6yeC707ghwJ
	Bh1bmjfmYR0tTcecAL4mF+rr6iy3ahkAozOJf1TqTanDkuXZmQXqfPxMOfu2lC3wBDD1Bl2AxnxTi
	tLvueUBRhx2Yljo6YI2vWB60Ha40L4FgOjsz7Ly3zHPmvRBwfRbjAJgWdFcwILeE/J2+nWDSyaOxr
	WowQrt9wNTEQv7Go8sxdc2Qep7gI0w3W6K+x60EZuFdRON7IxbDs6/aVGC1P2klBWA8+azfqVgUVj
	SOSl8zGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAs-00000000gHd-25s5;
	Wed, 14 Aug 2024 15:44:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 5/5] mm: Make mk_pte() definition unconditional
Date: Wed, 14 Aug 2024 16:44:25 +0100
Message-ID: <20240814154427.162475-6-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814154427.162475-1-willy@infradead.org>
References: <20240814154427.162475-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All architectures now use the common mk_pte() definition, so we
can remove the condition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8204ffd87d74..1d46422b79cc 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -41,12 +41,10 @@
 #define FIRST_USER_ADDRESS	0UL
 #endif
 
-#ifndef mk_pte
 static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
 	return pfn_pte(page_to_pfn(page), pgprot);
 }
-#endif
 
 /*
  * This defines the generic helper for accessing PMD page
-- 
2.43.0


