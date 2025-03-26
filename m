Return-Path: <linux-arch+bounces-11137-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65420A71A32
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 16:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B873C18889B8
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86081A705C;
	Wed, 26 Mar 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC2YE/oT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1751624C2;
	Wed, 26 Mar 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002555; cv=none; b=m7EREwo0hUB7g4LoWsO71NkeTHbEZZZwd/UxjBD1G9IxbaFrFQTD8849rucTnPaeoioPdTq9+GmjOAUU1J0BMeRYGiCebjlJ7qeJiXH5ZKvTbD7YvMxOvp8mjuvdFEilro1iTjdxRIHyt7ZFX+gZqCMsqms6MVZYEOOjvpHJBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002555; c=relaxed/simple;
	bh=qaYn04pl0bOmbX7Q3sOhRWu/QUj4q3xvvH/bXbpjwDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERrZYKMcYVa5RVeU8PgJi1rNOaqR4mwMcNFuN+mI7fJw3hRe3VTKmVHyBGmuvjnxu3nXnEDY3V6aItokbveZ97n17BWr+FMyDN5yvoYasRbIUhgtSFypR/ycnwe6d7SK0WzkDPdDhfNQ0avtfGc1hI8svLxg4G2Y9Yxp4CIs6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC2YE/oT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0DFC4CEE2;
	Wed, 26 Mar 2025 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743002555;
	bh=qaYn04pl0bOmbX7Q3sOhRWu/QUj4q3xvvH/bXbpjwDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lC2YE/oT3fyupPQ2QRcZzHgza1/sOCa5chbFYaMXFQg5pq7QL6oPsHPlqCbpCWn9F
	 q5Hp/gTd3oqCS4oz4rWf34knTycSCfoS41l9NOMpXEz2rRiTv7uZPoZhPYHyhh3qsz
	 OJW3W5qBp8L6ee7YrSb2dELYMDG2NMiKYT9vZPWUYA7D3+4Q2IHWKFNp+kRdFNE2TP
	 4r1sSODu8+5rkSTBYFzsb6yiS21pEvi3ouaEKhW/VjGeZS0DQro+gxJXjgvxIPd5/X
	 aqQDXgWY0UtzZmsMjtx0uBh6EXfjSlcUD26jMuRszxW3kxL4xXrcwUJLX/8nKYuNp4
	 u6z1n/jTSeFNQ==
Date: Wed, 26 Mar 2025 08:22:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	kernel test robot <oliver.sang@intel.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 2/2] memblock: don't release high memory to page
 allocator when HIGHMEM is off
Message-ID: <20250326152228.GA1105284@ax162>
References: <20250325114928.1791109-1-rppt@kernel.org>
 <20250325114928.1791109-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325114928.1791109-3-rppt@kernel.org>

On Tue, Mar 25, 2025 at 01:49:28PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Nathan Chancellor reports the following crash on a MIPS system with
> CONFIG_HIGHMEM=n:
...
> The crash happens because commit 6faea3422e3b ("arch, mm: streamline
> HIGHMEM freeing") too eagerly frees high memory to the page allocator even
> when HIGHMEM is disabled.
> 
> Make sure that when CONFIG_HIGHMEM=n the high memory is not released to the
> page allocator.
> 
> Link: https://lore.kernel.org/all/20250323190647.GA1009914@ax162
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Fixes: 6faea3422e3b ("arch, mm: streamline HIGHMEM freeing")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  mm/memblock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 64ae678cd1d1..d7ff8dfe5f88 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2166,6 +2166,9 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
>  	unsigned long start_pfn = PFN_UP(start);
>  	unsigned long end_pfn = PFN_DOWN(end);
>  
> +	if (!IS_ENABLED(CONFIG_HIGHMEM) && end_pfn > max_low_pfn)
> +		end_pfn = max_low_pfn;
> +
>  	if (start_pfn >= end_pfn)
>  		return 0;
>  
> -- 
> 2.47.2
> 

