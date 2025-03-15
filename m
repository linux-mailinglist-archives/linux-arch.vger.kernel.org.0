Return-Path: <linux-arch+bounces-10886-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B46EA62B7F
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 12:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71E819C05B1
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF01F9A95;
	Sat, 15 Mar 2025 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diX0xfqF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4813F1F7098;
	Sat, 15 Mar 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742036378; cv=none; b=bnzgyr2L/cD4eH7N5nBcihPMXev+0LksNQF+I4BohNL66GCFPFkDkaF/YyOQpfL2JFe5vUBW7sedBUK7w6C7bp9QCnN/DCtualZpcf6WmANBRgPOeB2L+380TC6gy4/QSjnnntu2+SjF85SuxTksUHzp/ZssK0fsujISToLeK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742036378; c=relaxed/simple;
	bh=A5i5/N269tmlctuJx50AMW6UOHChrJm88b2b4zSeyoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2uwLxFqj4KLq7lVTThC8d8xjFbagSmtSjSFYWH1n4qfdK/2lPUNSU6qrKqzj5HWBXefwzBGD5fsZYsrmSs3/AMTJueDmdhBfG46zpBqniRcI3ieDpEdCJ+G/8LC92bCrt+fh2xzudiKDARUtRGfQR0ujkdvKGfGghth2U4A5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diX0xfqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19449C4CEE9;
	Sat, 15 Mar 2025 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742036377;
	bh=A5i5/N269tmlctuJx50AMW6UOHChrJm88b2b4zSeyoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diX0xfqF9v6ZGZRle7yS797sxjadb3E94MlDDS4u2Ag47HK7jKFgrf0+lFKqJyd4Z
	 9zI1O0TL4ydGgnrIeulnAzEMTAwCyHN4aaYIjOJk4KG9iQ9AUEgXcaqj1ZPma2QWCj
	 7R4G/nVWt1vuxaxJKUIQRdYxGdOY+kQSZryHNxz+vVP+V61ore9HhuE0ButGW2mWzR
	 bZv7UuwIJNTuGwzwOmv42rKJQ/X2fJFY4DLlYwRmOt8Uuk/ln2ZGVjY/dlC/AIRZQf
	 xIBQPHVRG8UBgapcN+S6EKST97e/EqLy5aOB9pu3G9miFJF68PdnfRDwdShSTHnAR1
	 0xk0SMnqOCSoA==
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
Subject: [PATCH 4/6] powerpc: asm/io.h: remove split ioread64/iowrite64 helpers
Date: Sat, 15 Mar 2025 11:59:05 +0100
Message-Id: <20250315105907.1275012-5-arnd@kernel.org>
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

In previous kernels, there were conflicting definitions for what
ioread64_lo_hi() and similar functions were supposed to do on
architectures with native 64-bit MMIO. Based on the actual usage in
drivers, they are in fact expected to be a pair of 32-bit accesses on
all architectures, which makes the powerpc64 definition wrong.

Remove it and use the generic implementation instead.

Drivers that want to have split lo/hi or hi/lo accesses on 32-bit
architectures but can use 64-bit accesses where supported should instead
use ioread64()/iowrite64() after including the corresponding header file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/io.h | 48 -----------------------------------
 1 file changed, 48 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index fd92ac450169..d36c4ccaca08 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -738,35 +738,11 @@ static inline unsigned int ioread32be(const void __iomem *addr)
 #define ioread32be ioread32be
 
 #ifdef __powerpc64__
-static inline u64 ioread64_lo_hi(const void __iomem *addr)
-{
-	return readq(addr);
-}
-#define ioread64_lo_hi ioread64_lo_hi
-
-static inline u64 ioread64_hi_lo(const void __iomem *addr)
-{
-	return readq(addr);
-}
-#define ioread64_hi_lo ioread64_hi_lo
-
 static inline u64 ioread64be(const void __iomem *addr)
 {
 	return readq_be(addr);
 }
 #define ioread64be ioread64be
-
-static inline u64 ioread64be_lo_hi(const void __iomem *addr)
-{
-	return readq_be(addr);
-}
-#define ioread64be_lo_hi ioread64be_lo_hi
-
-static inline u64 ioread64be_hi_lo(const void __iomem *addr)
-{
-	return readq_be(addr);
-}
-#define ioread64be_hi_lo ioread64be_hi_lo
 #endif /* __powerpc64__ */
 
 static inline void iowrite16be(u16 val, void __iomem *addr)
@@ -782,35 +758,11 @@ static inline void iowrite32be(u32 val, void __iomem *addr)
 #define iowrite32be iowrite32be
 
 #ifdef __powerpc64__
-static inline void iowrite64_lo_hi(u64 val, void __iomem *addr)
-{
-	writeq(val, addr);
-}
-#define iowrite64_lo_hi iowrite64_lo_hi
-
-static inline void iowrite64_hi_lo(u64 val, void __iomem *addr)
-{
-	writeq(val, addr);
-}
-#define iowrite64_hi_lo iowrite64_hi_lo
-
 static inline void iowrite64be(u64 val, void __iomem *addr)
 {
 	writeq_be(val, addr);
 }
 #define iowrite64be iowrite64be
-
-static inline void iowrite64be_lo_hi(u64 val, void __iomem *addr)
-{
-	writeq_be(val, addr);
-}
-#define iowrite64be_lo_hi iowrite64be_lo_hi
-
-static inline void iowrite64be_hi_lo(u64 val, void __iomem *addr)
-{
-	writeq_be(val, addr);
-}
-#define iowrite64be_hi_lo iowrite64be_hi_lo
 #endif /* __powerpc64__ */
 
 struct pci_dev;
-- 
2.39.5


