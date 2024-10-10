Return-Path: <linux-arch+bounces-7992-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D7999177
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CFB1F21584
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C91F4FC2;
	Thu, 10 Oct 2024 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="TnwSfC3B"
X-Original-To: linux-arch@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220E51DF72A;
	Thu, 10 Oct 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585360; cv=none; b=dOvroi/js4/s+5vBC9/wTT+IQCyUi1WsTbwwb+ao9Ik4yeOJ41B7qDSW7LsKTRs+yNfP1EtZr+sLCi1rQ5TkCY8qc6Tp5e70lNBB9kQFrYMzwGGNSk7bnrhZwhIBkE68G2XuMHNfHNZoEDxyNzEfMqeBcNf6K/IlSvno66gPzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585360; c=relaxed/simple;
	bh=eO8i66PrBt/aJfIHr67M2yWYkbNNStHt47cJJCQ8lLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6USq3tZmLh/VI+USVzGN9SvsoTWtGP+h3G0LYMhZDvt2yzVRAZFzQ8JlkKQR++CFWIJXCyCnPTDrSdR+NxSu2L9rdbTP3hTw21/XnuTHbCvhz0jsbx4dQuMQSsZj28G+JCkK7awC0/Ow8CokDHL8PmrtjWYUdRbz1akGYr8VKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=TnwSfC3B; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1728585350; bh=eO8i66PrBt/aJfIHr67M2yWYkbNNStHt47cJJCQ8lLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TnwSfC3B0BzzbrbBXfYCTvLzIQE1VFcC2vDoODjZOiRbhCpvxs+nfBrgLRAmHbBcp
	 5nDkTl4JQCQ0Wy/pLIF9/vFfww5UJ7PllGdlDfCRY4FgF60cuMAONiSY28SXpZ/fah
	 ofsTg0sJAj3lUJpCxa6onaZfbwwGyEE3F+sIl/MzmrdHNasu+qZYD2CQrQKKnIrTre
	 jEGUntoI51WphR4XjRXlRX68PsX4ZEqW4Lig8ApC7stf8X5g23ZhKSrvK2T2Yg2D5A
	 bDv/1YoYnX+4WK7gSe7xgNsbMfMhOH2hPirF455+QlQzq1JgcpZmps0ommzymfrvIp
	 q2yGRxotng1Sc5OlnXZIYfIyoPLe78QPg5yomWhS/7EpKy8gm5XCv2fZL2X1/G4BTR
	 HL2kBhQM874WRNw9Pe4sCOauh/y6zMseb5uFaaTGvb5Bwf1+uMfTKAYUXYiqB6xWHZ
	 FMRiB8gbs1uwwHzedLTctQNTtkBO6P4IZltp+SoRTwdUBuk2Am+I+Y/c5xNGGQwcTo
	 dfQXGkuiHFMt18pGbziRX9AoIhYRkcXuQB6IdBahXiHe06KoZakmU5fKhn5ggdgeZF
	 sIwBjRHZR9oCPZjKzUyfzG6lTzteD6iFNQ1wWMF1seN66YAyRB45H5n//oQ2UNHpBx
	 anTYx1ofeL2gjEtOuPaxF2ZM=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id DF155167DD7;
	Thu, 10 Oct 2024 20:35:47 +0200 (CEST)
Message-ID: <936057f4-e461-4977-85e7-6100127c9574@ijzerbout.nl>
Date: Thu, 10 Oct 2024 20:35:44 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Hellwig <hch@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dinh Nguyen
 <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Song Liu <song@kernel.org>, Stafford Horne <shorne@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241009180816.83591-8-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 09-10-2024 om 20:08 schreef Mike Rapoport:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Using large pages to map text areas reduces iTLB pressure and improves
> performance.
>
> Extend execmem_alloc() with an ability to use huge pages with ROX
> permissions as a cache for smaller allocations.
>
> To populate the cache, a writable large page is allocated from vmalloc with
> VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> ROX.
>
> Portions of that large page are handed out to execmem_alloc() callers
> without any changes to the permissions.
>
> When the memory is freed with execmem_free() it is invalidated again so
> that it won't contain stale instructions.
>
> The cache is enabled when an architecture sets EXECMEM_ROX_CACHE flag in
> definition of an execmem_range.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   include/linux/execmem.h |   2 +
>   mm/execmem.c            | 317 +++++++++++++++++++++++++++++++++++++++-
>   mm/internal.h           |   1 +
>   mm/vmalloc.c            |   5 +
>   4 files changed, 320 insertions(+), 5 deletions(-)
> [...]
> +static void execmem_cache_clean(struct work_struct *work)
> +{
> +	struct maple_tree *free_areas = &execmem_cache.free_areas;
> +	struct mutex *mutex = &execmem_cache.mutex;
> +	MA_STATE(mas, free_areas, 0, ULONG_MAX);
> +	void *area;
> +
> +	mutex_lock(mutex);
> +	mas_for_each(&mas, area, ULONG_MAX) {
> +		size_t size;
> +
No need to check for !area, because it is already guaranteed by the 
while loop condition (mas_for_each)
> +		if (!area)
> +			continue;
> +
> +		size = mas_range_len(&mas);
> +
> +		if (IS_ALIGNED(size, PMD_SIZE) &&
> +		    IS_ALIGNED(mas.index, PMD_SIZE)) {
> +			struct vm_struct *vm = find_vm_area(area);
> +
> +			execmem_set_direct_map_valid(vm, true);
> +			mas_store_gfp(&mas, NULL, GFP_KERNEL);
> +			vfree(area);
> +		}
> +	}
> +	mutex_unlock(mutex);
> +}
>

