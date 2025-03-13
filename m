Return-Path: <linux-arch+bounces-10728-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99785A5F6A2
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA357AE16E
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E814267F44;
	Thu, 13 Mar 2025 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAvAkADl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1F267B0E;
	Thu, 13 Mar 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873903; cv=none; b=NwlBuVrpZFHWGCNqI7Udy3Zx5jIGoNirf0kt2anN/wqRCI+KF5MGJj14GBhLi4lcKNEc0YHZdxG/bWZQau4OnXM9RsMD/jNb++GH5TVOKAm/xoRM1BT0PYXe+iHsVsotm/w1SCUQrckldiTvjN2dTgynimRKfP5Ak6ZvHJQVfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873903; c=relaxed/simple;
	bh=uD5faVqJ7G6OTY8H5Svd8uEX7wWQ143lrl+QSf2xljc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STSVmcokgNB/fWv9+EGZH+3Y5X0zjKjvPtBgQ4+QEuM3txBgRKITuJpOecHvUv06d/EWegoWRqqjSWh8zyWGAKisczw4SvqHLQvIINHDF5tbb+qVhEat92MZiWT1zIGXRnjbjbl56ulc6FowtbfxuceQfLfv2x/YXMMsYuNhj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAvAkADl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A398C4CEEA;
	Thu, 13 Mar 2025 13:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873903;
	bh=uD5faVqJ7G6OTY8H5Svd8uEX7wWQ143lrl+QSf2xljc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAvAkADl38NVbSZKILqjquMXN3H24XBk/B6I41lcVbP00o/57lseGod9pdeTReVMs
	 cGwlYVhuGgyWlrhDCI2daJ1ZuH+VeJ81cIRRK9frKmoiVueFr/N/mjUPeYtEx8wJ8T
	 nBs3CkwbMReqveisUvVZBC22mbfZgYYmTbCh29QOQKxl3NVOzvvN3jvxoRqmAwnVch
	 0ZqbY3ubQTUgmI2m+/Okv6ac4OZYKAK3inE5/1A+FzyXOEE0bOdUpCjBHuKjnqgp9K
	 6yHOo0+C4guHPMqoX35CH+VdOKq/D8Ff1oyIUB7Oo0RhP3dSOBxqfGBVfIxIiCRB+o
	 mLZqPSEOGfNGg==
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
Subject: [PATCH v2 06/13] nios2: move pr_debug() about memory start and end to setup_arch()
Date: Thu, 13 Mar 2025 15:49:56 +0200
Message-ID: <20250313135003.836600-7-rppt@kernel.org>
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

This will help with pulling out memblock_free_all() to the generic
code and reducing code duplication in arch::mem_init().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/nios2/kernel/setup.c | 2 ++
 arch/nios2/mm/init.c      | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index da122a5fa43b..a4cffbfc1399 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -149,6 +149,8 @@ void __init setup_arch(char **cmdline_p)
 	memory_start = memblock_start_of_DRAM();
 	memory_end = memblock_end_of_DRAM();
 
+	pr_debug("%s: start=%lx, end=%lx\n", __func__, memory_start, memory_end);
+
 	setup_initial_init_mm(_stext, _etext, _edata, _end);
 	init_task.thread.kregs = &fake_regs;
 
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index a2278485de19..aa692ad30044 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -65,8 +65,6 @@ void __init mem_init(void)
 	unsigned long end_mem   = memory_end; /* this must not include
 						kernel stack at top */
 
-	pr_debug("mem_init: start=%lx, end=%lx\n", memory_start, memory_end);
-
 	end_mem &= PAGE_MASK;
 	high_memory = __va(end_mem);
 
-- 
2.47.2


