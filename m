Return-Path: <linux-arch+bounces-15679-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 435C2CFC31B
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 07:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8753C30042B0
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 06:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB6A26E6F4;
	Wed,  7 Jan 2026 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm3LVa0u"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D17225A38;
	Wed,  7 Jan 2026 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767767975; cv=none; b=uCMirg0EwySoICoiFScl1OnBEddB22XID7K/v5vQ6gwSumAwOc9TO1Ilp+4IOe/K5mlrXcc+JUISdXAdFXvgt8bJ0XLnfqP4l91pIKzMysqpemoSsaHrRJKbFh3xD7zrGnaDy6VFzqKsnhGXp+2agnp6bujOTCxzSvgtWTPXpKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767767975; c=relaxed/simple;
	bh=r4bEK9BemNQRBh64Y6NaLRszQJcBw/t/jTWMXTw/H/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzg9BMJET5jxPnhSzck7wppKF2zu4ZQoMsPDuPIvLfIsfPXjQzI+NVM2JXhIM0L8wgQrF4ei51GNYX/U4jLxoJlYzhYqNvsona4TaJV5a33KntDT6aiwDoYJaKjBIn4wtAbzQ1h03QSxmXw2gI6zyy4lf5HLBvMiejPPNtTwK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm3LVa0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDB3C4CEF7;
	Wed,  7 Jan 2026 06:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767767975;
	bh=r4bEK9BemNQRBh64Y6NaLRszQJcBw/t/jTWMXTw/H/c=;
	h=From:To:Cc:Subject:Date:From;
	b=nm3LVa0uxqUMX+/bH+uyM4Fc8+MpY8DLnc21LCeiWEHrY38jUfBbujI0jGMGQ7Lt3
	 lTovokU+kR30/S6Fqu46y5IEDkdkCLE7kBxjpAOUjBVbJBqY8oG2GiImtoWXcdHvFn
	 D6IrAwrP+t48kcm1zwUTeXrdgQY/AMThcSq2wNA05n6or4E7Q01Eos/jgVzavlVJ9l
	 OKYjfN9zxBvC35R91Qolhhapf2VS8UsksCNq4IC+Wo2B/vzPRti9kZ/70xGslfZm4k
	 4OMYaRA7JEQng5zWEpKLLl9kRGPS/1PcM1ljWEQ99c6hVAaAi5sJbyY2DpWQrs1r5D
	 o92EjFQopQjlg==
From: alexs@kernel.org
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-kernel@vger.kernel.org,
	Alex Shi <alexs@kernel.org>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/pgtable: remove unddefined __HAVE_ARCH_P4D_ALLOC_ONE/__HAVE_ARCH_P4D_FREE
Date: Wed,  7 Jan 2026 14:39:10 +0800
Message-ID: <20260107063911.15299-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

No any archs has ever define __HAVE_ARCH_P4D_ALLOC_ONE/__HAVE_ARCH_P4D_FREE
So let's remove them.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/asm-generic/pgalloc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 5fb31e0fe15f..11bafe764599 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -246,13 +246,11 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 }
 #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
 
-#ifndef __HAVE_ARCH_P4D_ALLOC_ONE
 static inline p4d_t *p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long addr)
 {
 	return __p4d_alloc_one_noprof(mm, addr);
 }
 #define p4d_alloc_one(...)	alloc_hooks(p4d_alloc_one_noprof(__VA_ARGS__))
-#endif
 
 static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
@@ -262,13 +260,11 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	pagetable_dtor_free(ptdesc);
 }
 
-#ifndef __HAVE_ARCH_P4D_FREE
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
 	if (!mm_p4d_folded(mm))
 		__p4d_free(mm, p4d);
 }
-#endif
 
 #endif /* CONFIG_PGTABLE_LEVELS > 4 */
 
-- 
2.43.0


