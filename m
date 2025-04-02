Return-Path: <linux-arch+bounces-11241-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5616CA79822
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 00:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBD23AC692
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEDA1F5852;
	Wed,  2 Apr 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MN0rwul8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648D1F584E;
	Wed,  2 Apr 2025 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743632382; cv=none; b=avp8hMd7utYX3bBV9+6U0bJqSUlCRaBYXSbh4259GX6TMJaNdAJYkBAnR/jhu+Y6HZmwqzsq93x/HEcd4YWxTcTwMQg4sZMifSBj1vKn29EFPVnSOWQYlv38SfXpB7c9Ew/MFev3DKgHEkDpbfPkCcaXuJn4SK2l2V0A+eY1OiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743632382; c=relaxed/simple;
	bh=wPsvqq2TSbIuz1MPM2VtyP0iPPL9yl5M+hWPehgLpqo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jtyMZEPP/CazFlrh3XR27JkozDcZVwcxr0WnYuRQd4p1JbRufipzaa3QL4oLcwiwHt26YqQ4fX5jhgHwmzvlxG9xi/3J7VbRaPZVkDi/jdK+Hd7yalIky5nVA6G+Y9LV9fEPtxCPsFjghHs2G3ba2eJW+Tt8hh3pT/kTXeCytQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MN0rwul8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6891C4CEDD;
	Wed,  2 Apr 2025 22:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1743632381;
	bh=wPsvqq2TSbIuz1MPM2VtyP0iPPL9yl5M+hWPehgLpqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MN0rwul88GP900T3ka3+dXtLjh8IwNNA9RT3nEWRa8o9B1lbXW5PF6oFB+Y5PaxEc
	 cB0Ulv+iObS+6Y0OHvTHokSUx5zRS+Q/fbfSYkfG8SYFhRUS4XDMPm6+JWt6JQ+0u+
	 YcPFQ7Oql9WH35j4upaWbTtXV/UQjFcsL9gY5LxQ=
Date: Wed, 2 Apr 2025 15:19:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "David S. Miller"
 <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, Naresh
 Kamboju <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org, Linux
 Regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH v2 10/13] arch, mm: set high_memory in free_area_init()
Message-Id: <20250402151940.145c3bf65387b10735fe5c4f@linux-foundation.org>
In-Reply-To: <Z-2br1vk8lf9V40T@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
	<20250313135003.836600-11-rppt@kernel.org>
	<20250402140521-bf9b3743-094e-4097-a189-10cdf1db9255@linutronix.de>
	<Z-0xrWyff9-9bJRf@kernel.org>
	<20250402145330-3ff21a6b-fb03-4bc8-8178-51a535582c6f@linutronix.de>
	<20250402181842-f25872a1-00f7-4a8f-ae6d-3927899ee3a6@linutronix.de>
	<Z-2br1vk8lf9V40T@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 23:18:55 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> The proper fix is
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
> I've sent it along with the fix for x86 [1] (commit 7790c9c9265e
> ("memblock: don't release high memory to page allocator when HIGHMEM is
> off") in mm-unstable), but for some reason it didn't make it to the Linus
> tree :/
> 
> @Andrew, are you going to send it to Linus or you prefer if I take it via
> memblock tree? 
> 
> [1] https://lore.kernel.org/all/20250325114928.1791109-3-rppt@kernel.org/

That fix is now in mm-stable for a second round of merge window
material.  I'll send that off to Linus later today.


