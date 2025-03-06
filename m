Return-Path: <linux-arch+bounces-10542-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825BA55571
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A50F1893E51
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C326BD9F;
	Thu,  6 Mar 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mc3+5VBd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57B25A2B5;
	Thu,  6 Mar 2025 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287119; cv=none; b=HvYipX0bHgp5B3vbhFSCDq/HQeTku/on61R5RXR5/K/M0sfq8eF5FS3RSDoMEgmEnj6Q2QU14o+aDJeCegBfPX0Jo16Llsl1PihHJXNjQCV+XA3xst1TOiPdXLA5Q/2gnMSRNH4sm/KVt2AMTzZ47Gx9pxapr++XpO0qULrDLQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287119; c=relaxed/simple;
	bh=xXhNVtoRAjb56OLfL+MIUyuiC6fNrGdmFypg4AHZHss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+bzeTojJ5hxBflEG58SB5sN1p2KfZqmjAfprLouO4TW3yjQx3tdVLuowD60B8DB1uGIfxkBVYT63Z+aiOOjvNxO1GaaBoZLzhihqfKu2WUh8XzGxIXrCVGXjk2ZY/t2/M1HlzS34jyfKT0Cgc6h8zlV7YSHF/LHmJbGkDIPFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mc3+5VBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A344CC4AF09;
	Thu,  6 Mar 2025 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287118;
	bh=xXhNVtoRAjb56OLfL+MIUyuiC6fNrGdmFypg4AHZHss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mc3+5VBdIIu92zQEQScIdHtZDhsV8+TCREp8qojNXCswdu86fU2tpoEml4nZd+poR
	 eQ0aLJbVQzCZz9QzHALQCbJDJmU+0IljCo21Q5bN5Bm7RSinZHmM9kZn2YJ+28Da5R
	 F3c4gmZD4pIuuzDv9PqqG1EoltUBB5A6ciiMy22TEZs/vmhrtV3uwpgLjhtCkg5Rdv
	 BvwfrE5ADeSFTJF2WiyoCmebxERnGD71/MtMVpgpA/CV54VKWpKBskx5rbT/nROo1f
	 YwI/WFO7c+f3jMkR6/CwCcPcELWSYBwm/v51JOMhWtqAnUyjyq8a8lee+Mg1IXoDLQ
	 F1y1chgJwbe0w==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
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
Subject: [PATCH 01/13] arm: mem_init: use memblock_phys_free() to free DMA memory on SA1111
Date: Thu,  6 Mar 2025 20:51:11 +0200
Message-ID: <20250306185124.3147510-2-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306185124.3147510-1-rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
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


