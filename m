Return-Path: <linux-arch+bounces-10667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A4A5B8F0
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 07:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C6817219E
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB51EEA23;
	Tue, 11 Mar 2025 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmTErZmr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC81E7C2F;
	Tue, 11 Mar 2025 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672666; cv=none; b=kdC0VLOm6T49XH4TMxoYAZchwl4zN0HmEjOP7RIQpp6pYsPfwxrHL/Jg9bAuQnIJ8yMXHE1WMOQMJ9kAtjdbbbdQqCjbROSB77m3Vy0FQIha5amzSf1XI2JnuKFbTGuGk1JnmQ6aCXO4VzL5CjE4L+WiXZCb5VtvNustkejzcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672666; c=relaxed/simple;
	bh=BYwU/E93/QHnTs75zXL/K5KaaL59dt5dqcEKsspSbzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6dpsoZ0VxKAuWORjIO9mpfXc0gdRGAi9S5JNsG2g3jXhohwF4Yp/vrR7td22L8hutpf9LHTrZtfYLGSlJleL96yUhPuljyeLLe+21NbjtX2F4mZDN88MIfNhfHUygaU3mdaWrvYoGLiSJzqpOtq18t4E2gbHcxIWhViUxQeAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmTErZmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78FCC4CEE9;
	Tue, 11 Mar 2025 05:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741672666;
	bh=BYwU/E93/QHnTs75zXL/K5KaaL59dt5dqcEKsspSbzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmTErZmrStaJuWPq1Y2KiGUlkJyWnCTthhB4B91JAVbdcH9I2nMKyf/7Fd4sug/pB
	 N7nEu2kNBk1O0Ul+w/IBo19oXH5glyY2bbtD6tCtn0BJHbkHTd1iWoNnx2w3T9m+7H
	 IxxQVA4Y4Lv0jGi6PXT0q9QqF5s7ZqRI2g89QBdwAFMPmOQwhOa9TxU3xtlxsqpRqF
	 lYy7nKRBTlEc1vamVRBquPAmfL9PiTgEWIBb6xcf97y28M06V5hY0PpqPM3HaTZw4K
	 HfU+XsvU0VemNSiwuoybyIXmF+A+kWMDABoLN29HvFjqUrPbxMBmNFc1zs7FVelcPG
	 fJ1v7DiVKuKeg==
Date: Tue, 11 Mar 2025 07:57:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 05/13] MIPS: make setup_zero_pages() use memblock
Message-ID: <Z8_Qw9Soe5bzWJ44@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-6-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306185124.3147510-6-rppt@kernel.org>

On Thu, Mar 06, 2025 at 08:51:15PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Allocating the zero pages from memblock is simpler because the memory is
> already reserved.
> 
> This will also help with pulling out memblock_free_all() to the generic
> code and reducing code duplication in arch::mem_init().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/mips/include/asm/mmzone.h |  2 --
>  arch/mips/mm/init.c            | 16 +++++-----------
>  2 files changed, 5 insertions(+), 13 deletions(-)
 
Andrew can you please pick this as a fixup?

From 148713d17cbdf7a3ad08f18ba203185b70c0e7c2 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 11 Mar 2025 07:51:27 +0200
Subject: [PATCH] MIPS: use memblock_alloc_or_panic() in setup_zero_page()

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/mips/mm/init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 6ea27bbd387e..a673d3d68254 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -68,9 +68,7 @@ static void __init setup_zero_pages(void)
 	else
 		order = 0;
 
-	empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, PAGE_SIZE);
-	if (!empty_zero_page)
-		panic("Oh boy, that early out of memory?");
+	empty_zero_page = (unsigned long)memblock_alloc_or_panic(PAGE_SIZE << order, PAGE_SIZE);
 
 	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
 }
-- 
2.47.2

-- 
Sincerely yours,
Mike.

