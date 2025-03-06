Return-Path: <linux-arch+bounces-10561-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE83A5589B
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 22:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0FF3A74F1
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 21:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154A207DF3;
	Thu,  6 Mar 2025 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fCD2eitP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003022063EB;
	Thu,  6 Mar 2025 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296006; cv=none; b=EuxXbGLJ9FgpP3J0IRXVfcGo7Nnp++oqL2NIDA2Uh70rm9x4W5N4EteKgygGcSsag4p8UmgVKDepFPZu/JpM/lk4kZQrJ7uqtRTVpBPLthcDsx3VskZTb75jMkIR6b0HshB1uOpj5pl/DgNYlIBMNX+39/xvprf/z0zylDhfDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296006; c=relaxed/simple;
	bh=cZDw6Poc4BDrQ+UyFQkoa8sDIiciZub+M7TYHo89aq4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MokhWgxpVZ9lNICHfLGEAvGyP7SpKn7Dsc9kWXlFukm3zs766/ex/scBvNXAy0VkUP3e/L1O6sXwW6MYJ+Wb4SdDFJLTMPJfDxV7qh09bv93JdkpTgaTQviYZzOrSPjmCkhUlQcnT2TgFUZM6AHVJ6VexRPdHosYHI6gJ3AnOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fCD2eitP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9335C4CEE0;
	Thu,  6 Mar 2025 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741296005;
	bh=cZDw6Poc4BDrQ+UyFQkoa8sDIiciZub+M7TYHo89aq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCD2eitPTHFzv+QGanXjZD4bENnmRFCyuGnOvEmFo3oZUyxfGbz0e9/waUKJcay/B
	 ulqAAqZ8fT7ST4z1YZd+B5XSm85iLoKo7BN7tD3KTLECZ4zAMHYgvB+TmrABW752ri
	 sqVT0tKHdBGtciAetPrknw/7LiV2aVP98DL5X7zA=
Date: Thu, 6 Mar 2025 13:20:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson
 <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain
 <bcain@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>,
 Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge
 Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Johannes Berg
 <johannes@sipsolutions.net>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily
 Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 00/13] arch, mm: reduce code duplication in mem_init()
Message-Id: <20250306132003.0066f109dae75f74711f9432@linux-foundation.org>
In-Reply-To: <20250306185124.3147510-1-rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Mar 2025 20:51:10 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> Every architecture has implementation of mem_init() function and some
> even more than one. All these release free memory to the buddy
> allocator, most of them set high_memory to the end of directly
> addressable memory and many of them set max_mapnr for FLATMEM case.
> 
> These patches pull the commonalities into the generic code and refactor
> some of the mem_init() implementations so that many of them can be just
> dropped.

Thanks, I added this series to mm.git.

