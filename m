Return-Path: <linux-arch+bounces-10726-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88342A5F687
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA1D19C076F
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F423267B91;
	Thu, 13 Mar 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUZeqivF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090941FBCBF;
	Thu, 13 Mar 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873877; cv=none; b=e/6mp0eegzB651kIVCEUOtg3DZ1Xg2uAme1mFiyYBNU/rs0BTZRa97usiJ4ND72rmTyqaGTwTYci9HxQLmd9VGo8ExOpaaJAaSJ+UFMAHMlsgzSMF/8vpsOhADqTko//SVTGbrO/lV8W8UpT8RZgJMH1p4wEQGlg+IlS497occ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873877; c=relaxed/simple;
	bh=nkBe6+9DINra8ChNyXeYcesTu6mPwjeTN1yq3Y1szbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGgnYoSbSJB5TEYGnZjSWguhUPFh9DnCAiWuSsHb9fpRLnCXdicmi1fM3Ix9yfL6eUvFj6qdJiyDev1Lue0OnkumqJgpyqv7FhBK4FoAXByAp6whj7FTp6Tfnc7fkhfSzIsXyWrCgdUdLZfyNvHJrI4+Z7f9UNMTZ7UqH3K89Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUZeqivF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA2EC4CEF2;
	Thu, 13 Mar 2025 13:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873876;
	bh=nkBe6+9DINra8ChNyXeYcesTu6mPwjeTN1yq3Y1szbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUZeqivFJ9EYP9Zy5Yb5dJalUE7Sb9X9atTVUnHZ/8j5kxTnIcryI91Lg+eLahCch
	 +4/sfT0f6PJUfGIy2IFanNG6A/SLgSjazaFTA527QDMKz4pRayRywROhwmKdm3JxlH
	 Uaj0ch2Iv70h6kezQtFA/9UBiPtXqykcVjOMdYtmACBIyWki5ZD6vyT7Dwybtv0ic7
	 n9LWmVF+6qTkSWN3/DV0+azu4ZrNZg6SffekFyWnjGKFnrFNUttXXpQq00r7GYSixQ
	 2oLgogEMVsNX2bHppECFrGmjyvZM4fH0hNySDtDwvQnL1mRuqs8UADBKrepv0pyUKk
	 bQ1hkzIwD6VDQ==
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
Subject: [PATCH v2 04/13] MIPS: consolidate mem_init() for NUMA machines
Date: Thu, 13 Mar 2025 15:49:54 +0200
Message-ID: <20250313135003.836600-5-rppt@kernel.org>
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

Both MIPS systems that support numa (loongsoon3 and sgi-ip27) have
identical mem_init() for NUMA case.

Move that into arch/mips/mm/init.c and drop duplicate per-machine
definitions.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/mips/loongson64/numa.c      | 7 -------
 arch/mips/mm/init.c              | 7 +++++++
 arch/mips/sgi-ip27/ip27-memory.c | 9 ---------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index 8388400d052f..95d5f553ce19 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -164,13 +164,6 @@ void __init paging_init(void)
 	free_area_init(zones_size);
 }
 
-void __init mem_init(void)
-{
-	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
-	memblock_free_all();
-	setup_zero_pages();	/* This comes from node 0 */
-}
-
 /* All PCI device belongs to logical Node-0 */
 int pcibus_to_node(struct pci_bus *bus)
 {
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4583d1a2a73e..3db6082c611e 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -482,6 +482,13 @@ void __init mem_init(void)
 				0x80000000 - 4, KCORE_TEXT);
 #endif
 }
+#else  /* CONFIG_NUMA */
+void __init mem_init(void)
+{
+	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
+	memblock_free_all();
+	setup_zero_pages();	/* This comes from node 0 */
+}
 #endif /* !CONFIG_NUMA */
 
 void free_init_pages(const char *what, unsigned long begin, unsigned long end)
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 1963313f55d8..2b3e46e2e607 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -406,8 +406,6 @@ void __init prom_meminit(void)
 	}
 }
 
-extern void setup_zero_pages(void);
-
 void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = {0, };
@@ -416,10 +414,3 @@ void __init paging_init(void)
 	zones_size[ZONE_NORMAL] = max_low_pfn;
 	free_area_init(zones_size);
 }
-
-void __init mem_init(void)
-{
-	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
-	memblock_free_all();
-	setup_zero_pages();	/* This comes from node 0 */
-}
-- 
2.47.2


