Return-Path: <linux-arch+bounces-12002-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC9ABCA67
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 23:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E931890227
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 21:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0857A21CC49;
	Mon, 19 May 2025 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="C1tywkqN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745D21C9E7;
	Mon, 19 May 2025 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691713; cv=none; b=PtJMJRX3UZnwMimQse0lzUFArdQNiIiUb4WrdplHMZbZh99lPzXda9YpD3WEbWKvKw14PQmRSlw8JjcvO0z5YbA1MsAzxX/zK85AspcCGQzWP5cNoCakDjUSoEbDdFLNVxKMDGnJ1pm0cYtRfTXXwDdQj57QWa48Tb99bKOjkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691713; c=relaxed/simple;
	bh=dlKAmhW9zKgVRMeo0heLwBPiru8W62725BeAQY5f1+Y=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DKdzdBXJ6dr+emk/W1ddQaF2sqWSTLr4pPNpDpdaNVrDlj8yH5cQryygVzPlhkJTHglYwq+bPuqenq6Zi1qNfLr1bPYvnRJzgTu2A8iAmkCVJX4YBYQYNi9A+4imQd5azEbOYAMhuTG55KbId3we2mW96prXDNAtM4bzPFQ94xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=C1tywkqN; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1747691713; x=1779227713;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZTBWHR+TKfiCZBw1vt8bZJYOmNBojFPZ6w32Ws9zvXo=;
  b=C1tywkqNYcAu7wEq4u2sp6anECvhWQV9pt1Tn33SIrto04xb9jmfTiUO
   VaEqKh7JQUuJOJWhhO5CIWQzWJ66MR2GfzD0lSP+KT4Tb5qDkbllSTgWa
   64m8EfyN8B/hJ07pF3sEme2zcu8JyRLcfKavWh8qSVIryFmxGsZSRBCfs
   3kdF8xlX8Jm4+/fdw2BGvCMoZuC1mcOnL3CDMnTGynqPBZwVHtqG7lISa
   hLwpVEcC+QavIA253HjyQjz8BKbJtXaLukAnG8Dhc7XqYRzN+kTn5HitY
   01u0UeRFbsv9xtzmz3yWJ2YxNXg9BnvoQHIwSKO4f4tOZ0Rmi7qIpOunh
   w==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="491768678"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:55:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:27353]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.141:2525] with esmtp (Farcaster)
 id be5f95f2-05c5-4170-ba78-00aac800df84; Mon, 19 May 2025 21:55:07 +0000 (UTC)
X-Farcaster-Flow-ID: be5f95f2-05c5-4170-ba78-00aac800df84
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:55:06 +0000
Received: from email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 19 May 2025 21:55:06 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com (Postfix) with ESMTP id 17CACA025F;
	Mon, 19 May 2025 21:55:06 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id A24E86609; Mon, 19 May 2025 23:55:05 +0200 (CEST)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Mike Rapoport <rppt@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Alexandre Ghiti
	<alexghiti@rivosinc.com>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/cma: make detection of highmem_start more robust
In-Reply-To: <20250519171805.1288393-1-rppt@kernel.org>
References: <20250519171805.1288393-1-rppt@kernel.org>
Date: Mon, 19 May 2025 23:55:05 +0200
Message-ID: <mafs0plg4tgee.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike,

On Mon, May 19 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Pratyush Yadav reports the following crash:
>
>     ------------[ cut here ]------------
>     kernel BUG at arch/x86/mm/physaddr.c:23!
>     ception 0x06 IP 10:ffffffff812ebbf8 error 0 cr2 0xffff88903ffff000
>     CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc6+ #231 PREEMPT(undef)
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
>     RIP: 0010:__phys_addr+0x58/0x60
>     Code: 01 48 89 c2 48 d3 ea 48 85 d2 75 05 e9 91 52 cf 00 0f 0b 48 3d ff ff ff 1f 77 0f 48 8b 05 20 54 55 01 48 01 d0 e9 78 52 cf 00 <0f> 0b 90 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
>     RSP: 0000:ffffffff82803dd8 EFLAGS: 00010006 ORIG_RAX: 0000000000000000
>     RAX: 000000007fffffff RBX: 00000000ffffffff RCX: 0000000000000000
>     RDX: 000000007fffffff RSI: 0000000280000000 RDI: ffffffffffffffff
>     RBP: ffffffff82803e68 R08: 0000000000000000 R09: 0000000000000000
>     R10: ffffffff83153180 R11: ffffffff82803e48 R12: ffffffff83c9aed0
>     R13: 0000000000000000 R14: 0000001040000000 R15: 0000000000000000
>     FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffff88903ffff000 CR3: 0000000002838000 CR4: 00000000000000b0
>     Call Trace:
>      <TASK>
>      ? __cma_declare_contiguous_nid+0x6e/0x340
>      ? cma_declare_contiguous_nid+0x33/0x70
>      ? dma_contiguous_reserve_area+0x2f/0x70
>      ? setup_arch+0x6f1/0x870
>      ? start_kernel+0x52/0x4b0
>      ? x86_64_start_reservations+0x29/0x30
>      ? x86_64_start_kernel+0x7c/0x80
>      ? common_startup_64+0x13e/0x141
>
>   The reason is that __cma_declare_contiguous_nid() does:
>
>           highmem_start = __pa(high_memory - 1) + 1;
>
>   If dma_contiguous_reserve_area() (or any other CMA declaration) is
>   called before free_area_init(), high_memory is uninitialized. Without
>   CONFIG_DEBUG_VIRTUAL, it will likely work but use the wrong value for
>   highmem_start.
>
> The issue occurs because commit e120d1bc12da ("arch, mm: set high_memory in
> free_area_init()") moved initialization of high_memory after the call to
> dma_contiguous_reserve() -> __cma_declare_contiguous_nid() on several
> architectures.
>
> In the case CONFIG_HIGHMEM is enabled, some architectures that actually
> support HIGHMEM (arm, powerpc and x86) have initialization of high_memory
> before a possible call to __cma_declare_contiguous_nid() and some
> initialized high_memory late anyway (arc, csky, microblase, mips, sparc,
> xtensa) even before the commit e120d1bc12da so they are fine with using
> uninitialized value of high_memory.

I don't know if they are fine or they haven't realized this is a bug
yet. Either way, this patch fixes the crash for me on x86_64, restores
how it should behave, and doesn't seem to make anything worse, so:

Tested-by: Pratyush Yadav <ptyadav@amazon.de>

Thanks for fixing this!

>
> And in the case CONFIG_HIGHMEM is disabled high_memory essentially becomes
> the first address after memory end, so instead of relying on high_memory to
> calculate highmem_start use memblock_end_of_DRAM() and eliminate the
> dependency of CMA area creation on high_memory in majority of
> configurations.
>
> Reported-by: Pratyush Yadav <ptyadav@amazon.de>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/cma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index 15632939f20a..c04be488b099 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -608,7 +608,10 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
>  	 * complain. Find the boundary by adding one to the last valid
>  	 * address.
>  	 */
> -	highmem_start = __pa(high_memory - 1) + 1;
> +	if (IS_ENABLED(CONFIG_HIGHMEM))
> +		highmem_start = __pa(high_memory - 1) + 1;
> +	else
> +		highmem_start = memblock_end_of_DRAM();
>  	pr_debug("%s(size %pa, base %pa, limit %pa alignment %pa)\n",
>  		__func__, &size, &base, &limit, &alignment);

-- 
Regards,
Pratyush Yadav



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


