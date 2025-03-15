Return-Path: <linux-arch+bounces-10888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EE2A62B95
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 12:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8EB3BF984
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADD1FA856;
	Sat, 15 Mar 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNNhAbIc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692F1F8AE5;
	Sat, 15 Mar 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742036388; cv=none; b=SwlXx3MUiAn+2OaPXAVGuDtT8r7i4VPHCgoSa7rCJvb6hxaLfu21Isv5Bo1u88/yfkNyVcJZv2cH8m5wdiN3pN/vPxGBF3VvDAfvCXXv8yWgp6LU8Y796GlzanOQcDTSeS2bLiMY6VJH9KmxlAtGzLb/7RLA5UP9MUgdEZ8qV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742036388; c=relaxed/simple;
	bh=D1ohrsimuAws13B6dSJm4c6y+zLXLpUyAoEhItGWqLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6DBSVg5kDh5wyZOdGvTIitcz3DXyNxAvR7yQZnu2/wqGaG70vqbnlwRATvsGeugJNyQxkGb14HACFSiOmheLlxo06fLBacLYGFAMuw3lzYZ731iQU/I+VeEUeVUEIpeCYpJ4gPZjETr5e5usUIFrNgeCbaCoFukjr/nlbXAPtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNNhAbIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D88DC4CEEB;
	Sat, 15 Mar 2025 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742036388;
	bh=D1ohrsimuAws13B6dSJm4c6y+zLXLpUyAoEhItGWqLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNNhAbIcf8rr4eGgVdyHX/E4D7k+KscqVldr3+lldQwAq/jdglR4SphehjOkkIAfo
	 9MTwIzw6Z7O68YzXNinfAPSEpQJZ9wzcMof+k1SPnJ/7hFw6HtRWFJi1uTRy96dElT
	 Yrn3toSD3j2xehdk6dinEZuvTCExMzPnp+nP9BfsYnK13ARddI0p7dvolMIAOxtoRp
	 c3qisYBppYDADHR7fvA8+qJpI2/iweFvf6USys3kpwbK40VECL1kXsmdz6LVpJecQ5
	 JJy8sF2gcnadf9t6j3+n8Bo9nIq6Lmmec6msUk1Pt+0xre7BMklDXjYqi4id+5RyP6
	 qG4v1Q27bB3Og==
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
Subject: [PATCH 6/6] m68k/nommu: stop using GENERIC_IOMAP
Date: Sat, 15 Mar 2025 11:59:07 +0100
Message-Id: <20250315105907.1275012-7-arnd@kernel.org>
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

There is no need to go through the GENERIC_IOMAP wrapper for PIO on
nommu platforms, since these always come from PCI I/O space that is
itself memory mapped.

Instead, the generic ioport_map() can just return the MMIO location
of the ports directly by applying the PCI_IO_PA offset, while
ioread32/iowrite32 trivially turn into readl/writel as they do
on most other architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/Kconfig             | 2 +-
 arch/m68k/include/asm/io_no.h | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index b2ed0308c0ea..b50c275fa94d 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -18,7 +18,7 @@ config M68K
 	select DMA_DIRECT_REMAP if M68K_NONCOHERENT_DMA && !COLDFIRE
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
-	select GENERIC_IOMAP if HAS_IOPORT
+	select GENERIC_IOMAP if HAS_IOPORT && MMU
 	select GENERIC_IRQ_SHOW
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
index 2c96e8480173..516371d5587a 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -123,10 +123,6 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define PCI_IO_SIZE	0x00010000		/* 64k */
 #define PCI_IO_MASK	(PCI_IO_SIZE - 1)
 
-#define HAVE_ARCH_PIO_SIZE
-#define PIO_OFFSET	0
-#define PIO_MASK	0xffff
-#define PIO_RESERVED	0x10000
 #define PCI_IOBASE	((void __iomem *) PCI_IO_PA)
 #define PCI_SPACE_LIMIT	PCI_IO_MASK
 #endif /* CONFIG_PCI */
-- 
2.39.5


