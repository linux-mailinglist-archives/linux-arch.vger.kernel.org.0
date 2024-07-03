Return-Path: <linux-arch+bounces-5242-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DED92699E
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 22:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8C41F24D30
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 20:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED021187560;
	Wed,  3 Jul 2024 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f5M/j25j"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F574964E;
	Wed,  3 Jul 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038816; cv=none; b=J03Z78AxQvrRgmBy+rVXo6x9aL5QY9mRCaUFvpmwd3xdMh5H+tcD4JVlpQ8iyJTIRyp+DTiei0MaNLaPwRHoIieDTNqYYcKFKwFGgSxMLQGk8i8aQB88PYitQkdC/j5B0nf15iwpVmGVFYImwUbcsqRMLEcQaXZhZK2dpoCSIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038816; c=relaxed/simple;
	bh=tuQHLlAouSdPultBMPgeE6K1xRkwyTQxSL/YLzuM72w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9wpA+AcTHG1cHcB9mTyRbZLiFbId92GFwCnJPk8LVjVGWdBlIAvYfQfNk+yFSfTENHZFImtbrfOPTSmLolNyR55ioKCTxj7DPid24BlUHVTPRqT+L53eUaWyL4lB+9CXGNgvUjOqcJBwQbiODfR2kYgeRo+vW4rvD6ymcslltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f5M/j25j; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XS+zrxZS8FCD/qmlRLlhjAGXk4ayWalj57MX2RYOszQ=; t=1720038811; x=1721248411; 
	b=f5M/j25jmYqonaR6dqoHobJOIyUTZugCv6As4wMCbEDdj+ynjjiMqPkMcky824V/IFATkEXSn7e
	QL27fPs697/wC1waixG5UPg52FkTTBkB0aeSAr1yPuf2vQXOz2eIfOTZGoWWdjM2J72hwjM60JgRk
	fxuOSd5uajVQTAFfjkNB40LalWsLoS/hIRdH40o8OdH0tlHkNN8F1CKh/IIt9x3uO8eNCe4TCt23D
	ziZZ4gAOYLXQvvltesDrUrze4XmF63zzNY4gFRaWdmJ/g6JAXkqLZTZe8nlwEkq+opyMNdKRWKi23
	UPur0XKAWbmHGBlN1mFEUk1TbwjIyaxquk0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sP6fP-0000000ANj1-1WMW;
	Wed, 03 Jul 2024 22:33:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic/iomap.h: don't check for readq/writeq
Date: Wed,  3 Jul 2024 22:33:26 +0200
Message-ID: <20240703223325.6832892b5f70.Ib536e07baa98b5bf760424eaf984d79284343f05@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At least on ARCH=um, the generic implementations of
readq/writeq from asm-generic/io.h are used, but it
may also use GENERIC_IOMAP. In this case, io.h will
include iomap.h before readq/writeq are defined and
as a result, iomap.h never declares iowrite64_lo_hi
and friends, causing compiler/warnings errors when
they're then implemented in iomap.c, also making it
impossible to actually use them.

Fix this by simply defining all the 64-bit versions
always and always only on 64-bit platforms, without
regard to readq/writeq.

Normally, 64-bit platforms will have them anyway,
and if they neither have it nor use asm-generic/io.h
then iomap.c will simply not have the functions (the
ifdef remains there) and the link will fail (rather
than compilation).

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 include/asm-generic/iomap.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 196087a8126e..e3c0d4a85800 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -34,9 +34,6 @@ extern unsigned int ioread32be(const void __iomem *);
 #ifdef CONFIG_64BIT
 extern u64 ioread64(const void __iomem *);
 extern u64 ioread64be(const void __iomem *);
-#endif
-
-#ifdef readq
 #define ioread64_lo_hi ioread64_lo_hi
 #define ioread64_hi_lo ioread64_hi_lo
 #define ioread64be_lo_hi ioread64be_lo_hi
@@ -55,9 +52,6 @@ extern void iowrite32be(u32, void __iomem *);
 #ifdef CONFIG_64BIT
 extern void iowrite64(u64, void __iomem *);
 extern void iowrite64be(u64, void __iomem *);
-#endif
-
-#ifdef writeq
 #define iowrite64_lo_hi iowrite64_lo_hi
 #define iowrite64_hi_lo iowrite64_hi_lo
 #define iowrite64be_lo_hi iowrite64be_lo_hi
-- 
2.45.2


