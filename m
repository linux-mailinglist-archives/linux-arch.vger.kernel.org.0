Return-Path: <linux-arch+bounces-10883-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03CAA62B65
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DC0189E460
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 10:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142381F7098;
	Sat, 15 Mar 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4hScGqi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37301DFED;
	Sat, 15 Mar 2025 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742036363; cv=none; b=IbwxCvCeGmFC7SncOhsRCbLx/g9wEduSqQkVSpZ2b+8wXA+xZN3dvckhRs/HrYOaFCNrzrLieP7QeCUkf9H2qXdkZ1x4KhpTW9lBBJtBSv+V5yAwYzn7fietBrWQaY2BpyzfQEQVvav16pfiFTggxPBz60PszjVr6ReV+YFVmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742036363; c=relaxed/simple;
	bh=XXA0f10ge76JURf0KA9hKmmXZONM5AkZ6ZqHtAnEIXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foDw6bFkweIKWVT2M9FDOJeXLDuDPk/mi03dkxgLd+tm+q+RWGEpBg0Qsjg7MHB7feS2yJyTYOKzngQ+EUyWnHdG/H89gao6bqkY/w4vG/IdcH1W4GP9k9ctq8ZFBbXbjKwHtcT8Too1bEFPKSuYg6j6JO45kTcx9hF7OKmF2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4hScGqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EACC4CEED;
	Sat, 15 Mar 2025 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742036362;
	bh=XXA0f10ge76JURf0KA9hKmmXZONM5AkZ6ZqHtAnEIXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4hScGqiOZR2G7+YZ+XeHtUATN3Mm6OjWKl7pPELBMWcUOaE7swU5/tXQXCtYrXgJ
	 SPn6NIohA89E6WxLd4/4EO0PHl9zWKf0cYcPnPtM9euQEITLvQJY/l3Z6HMkfQ21kY
	 peVZIewC2M2sq5nTydsNySsFoSWFAEU9A8haa53ye/om1SVbnSU9xmf1KmvRvkOXHc
	 /lctotQq0rUR//VHF5ceYPM7gWypeEy7pueirktZ8wIvWBfKkm+w6ebJIp6scRyM7+
	 AX/jfDmcpNQctPeQnPz5wN6oLaWuHKAAe4zqT7h6pZKObc96WoBAOr4+Q2Xof5tAPo
	 AJ4N2+LBEjFYQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Julian Vetter <julian@outer-limits.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org
Subject: [PATCH 1/6] alpha: stop using asm-generic/iomap.h
Date: Sat, 15 Mar 2025 11:59:02 +0100
Message-Id: <20250315105907.1275012-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250315105907.1275012-1-arnd@kernel.org>
References: <20250315105907.1275012-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Alpha has custom definitions for ioread64()/iowrite64(), which now
don't exist in the lib/iomap.c variant. This is an endless source
of build failures, since alpha tries to share a couple of function
declarations.

Change alpha to have its own prototypes that match the definitions
in arch/alpha/kerne/io.c instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/io.h | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 65fe1e54c6da..fa3e4c246cda 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -10,10 +10,6 @@
 #include <asm/machvec.h>
 #include <asm/hwrpb.h>
 
-/* The generic header contains only prototypes.  Including it ensures that
-   the implementation we have here matches that interface.  */
-#include <asm-generic/iomap.h>
-
 /*
  * Virtual -> physical identity mapping starts at this offset
  */
@@ -276,13 +272,24 @@ extern void		__raw_writeq(u64 b, volatile void __iomem *addr);
 #define __raw_writel __raw_writel
 #define __raw_writeq __raw_writeq
 
-/*
- * Mapping from port numbers to __iomem space is pretty easy.
- */
+extern unsigned int ioread8(const void __iomem *);
+extern unsigned int ioread16(const void __iomem *);
+extern unsigned int ioread32(const void __iomem *);
+extern u64 ioread64(const void __iomem *);
+
+extern void iowrite8(u8, void __iomem *);
+extern void iowrite16(u16, void __iomem *);
+extern void iowrite32(u32, void __iomem *);
+extern void iowrite64(u64, void __iomem *);
+
+extern void ioread8_rep(const void __iomem *port, void *buf, unsigned long count);
+extern void ioread16_rep(const void __iomem *port, void *buf, unsigned long count);
+extern void ioread32_rep(const void __iomem *port, void *buf, unsigned long count);
+
+extern void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count);
+extern void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count);
+extern void iowrite32_rep(void __iomem *port, const void *buf, unsigned long count);
 
-/* These two have to be extern inline because of the extern prototype from
-   <asm-generic/iomap.h>.  It is not legal to mix "extern" and "static" for
-   the same declaration.  */
 extern inline void __iomem *ioport_map(unsigned long port, unsigned int size)
 {
 	return IO_CONCAT(__IO_PREFIX,ioportmap) (port);
@@ -629,10 +636,6 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
 #define RTC_PORT(x)	(0x70 + (x))
 #define RTC_ALWAYS_BCD	0
 
-/*
- * These get provided from <asm-generic/iomap.h> since alpha does not
- * select GENERIC_IOMAP.
- */
 #define ioread64 ioread64
 #define iowrite64 iowrite64
 #define ioread8_rep ioread8_rep
-- 
2.39.5


