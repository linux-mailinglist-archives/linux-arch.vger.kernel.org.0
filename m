Return-Path: <linux-arch+bounces-10723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F07DA5F667
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFAB3BAF46
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D20D267F54;
	Thu, 13 Mar 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM8kjhfl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044D41760;
	Thu, 13 Mar 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873836; cv=none; b=sZCpO0tllpA7ZjbMpBP1L6RN3dD7VPYQk8hW5ABm6Y8s0r613jiRHOgs9H4SYdbFGb4olnnFa45U9FY3Mm7/+i5/72iA0FLFowne1nccqkPcOLbMCBM118EhyZX4jeTdLnAhE0mUOSjTq4uW0wSaRwBSfTFLRtA2sq6LQUBXUGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873836; c=relaxed/simple;
	bh=xXhNVtoRAjb56OLfL+MIUyuiC6fNrGdmFypg4AHZHss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0tRbEm6Sw0aH8UNYdtC4Y2EmyQL4DZd7EPFH/JzoaKhXzkjRtFKmLAXVIzJjfFa9/9YQenuRug0O39q0JJstCK9oVVIgCn+reHTrruzyqpEULueCQDXwmMn+Ci5i9M/9FY8EBC/h53FVU/M4xIpL8pvVaT/zpo4mP5u2/hPHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vM8kjhfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EA7C4CEEB;
	Thu, 13 Mar 2025 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873836;
	bh=xXhNVtoRAjb56OLfL+MIUyuiC6fNrGdmFypg4AHZHss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vM8kjhflpGv3ifczYRBjucOLjPNbTjYEFQMj1aEp0KsLhRKStFJlWIGjAEJLt2da+
	 HjtiQkCtGzrOP1Lfase8Tm5L6D5Mn8i2K2X8xlpqdSbVd+khSOen+r9N4+2Ckwctvl
	 vd45q3fsT5VFequdtDMR6RGd84DUAVt5h+T7EQZSGqGj3wc9JcT8Kf80HGB1m/4qV/
	 YmMUDr49NOXjSCqI/uf+x2MqyPp4kBxltU4mmCjCvwKgvY2LEte6vnTXfX463yflwU
	 D9m/XyUzL5ubJawlpBJuZyq0tgbiYauzm+IdYU+m35MKZ0/I3YkEYIrUzw4+S42UjY
	 9rlNZpu0kjehA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v2 01/13] arm: mem_init: use memblock_phys_free() to free DMA memory on SA1111
Date: Thu, 13 Mar 2025 15:49:51 +0200
Message-ID: <20250313135003.836600-2-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313135003.836600-1-rppt@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

This will help to pull out memblock_free_all() to generic code.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm/mm/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 5345d218899a..9aec1cb2386f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -277,14 +277,14 @@ void __init mem_init(void)
 
 	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
 
-	/* this will put all unused low memory onto the freelists */
-	memblock_free_all();
-
 #ifdef CONFIG_SA1111
 	/* now that our DMA memory is actually so designated, we can free it */
-	free_reserved_area(__va(PHYS_OFFSET), swapper_pg_dir, -1, NULL);
+	memblock_phys_free(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
 #endif
 
+	/* this will put all unused low memory onto the freelists */
+	memblock_free_all();
+
 	free_highpages();
 
 	/*
-- 
2.47.2


