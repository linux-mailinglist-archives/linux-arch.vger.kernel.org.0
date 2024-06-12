Return-Path: <linux-arch+bounces-4848-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C7B90580B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 18:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB41C23E13
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24DC1822F8;
	Wed, 12 Jun 2024 16:00:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17AB1822ED;
	Wed, 12 Jun 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208051; cv=none; b=Hsk+8cke07v3Ad+Ydo3K7/XzJiJGjr6qLbFbxxmwhUB97tRKR9rvI4IgnQoc32MI5YtDux4s3I+k4EgVnern8Nu0YNOaSeseZxaRW+hh4vHYS6lq8z+RgL1Wak9t3C657jTcfe9EeQNPK21Ox6/qQPfg7YHu3Jp+HGl4W+q+gcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208051; c=relaxed/simple;
	bh=n0QsiZQsAJTKkyb6hHoKbMV6PFtIrWGSkhstBzpufGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lL7+vsATBvZmRSvKgbMDs/NFokDVOhIHiez+k0CAlwTzTS4zMK5WUf6hswjPUNrsN1GRHbKKfw9ahanUMU5rAOEDkul4dSExG44Zuy5yeld00Dawi3mSf8y3cyGPOwQ92iOyn13eAASiwga44l0zGu4WERaYnpgty6cuyUqVseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AB8C1042;
	Wed, 12 Jun 2024 09:01:13 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.42.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C61793F73B;
	Wed, 12 Jun 2024 09:00:47 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Price <steven.price@arm.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fixmap: Remove unused set_fixmap_offset_io()
Date: Wed, 12 Jun 2024 17:00:38 +0100
Message-Id: <20240612160038.522924-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro set_fixmap_offset_io() was added in commit f774b7d10e21
("arm64: fixmap: fix missing sub-page offset for earlyprintk") but then
commit 8ef0ed95ee04 ("arm64: remove arch specific earlyprintk") removed
the file causing the only user to be removed when the two commits were
merged. Since this has never been used again since the v3.15 release
remove it.

Signed-off-by: Steven Price <steven.price@arm.com>
---
This came up because for Arm CCA there is a need to override
set_fixmap_io() [1] and rather than also update set_fixmap_offset_io() I
thought it would be better to just drop the unused macro.

[1] https://lore.kernel.org/lkml/20240605093006.145492-6-steven.price@arm.com/
---
 include/asm-generic/fixmap.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 8cc7b09c1bc7..29cab7947980 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -97,8 +97,5 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 #define set_fixmap_io(idx, phys) \
 	__set_fixmap(idx, phys, FIXMAP_PAGE_IO)
 
-#define set_fixmap_offset_io(idx, phys) \
-	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_IO)
-
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_GENERIC_FIXMAP_H */
-- 
2.34.1


