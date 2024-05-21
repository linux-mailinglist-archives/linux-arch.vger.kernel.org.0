Return-Path: <linux-arch+bounces-4477-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F018CA8DB
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B401C2124C
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A54776E;
	Tue, 21 May 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIQ5nB50"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE0179BD;
	Tue, 21 May 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276222; cv=none; b=eVEISVIrDh6et4+3H/EBsBQe4Oca+90ds0gVCLF5LzWSkx6bjPBaUb7h6Hs1LhxcS6u4FyzyEZib6GsWImi0KAlIzQpV2ifWGKyZdYIUcaf6ImOsoTyEsz5a3Ry8CYkvko3kWwmY2bzG6Rt6aM+Q/G25SUkfZzsQY2FPtiplBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276222; c=relaxed/simple;
	bh=g5ad6h6fsS1VZMljbHFZQxtWXnD0wuSkOgJPO8o+IWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGPa4/xQLZO2WToK3OYFwkBNG+KIoLFWMAPNc6ItfFHv9ft4ybS3rLZG2lSEyj/uUzTRIsSN3R8SmxeIwKtUgtqw1ilSyzHbVaNgswVIdw1P0DnoH9R6IWq6XL5KQPILARDpBM71XeQf1APIxDor8m9mgt+ALO7LbeIndp8Wcmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIQ5nB50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6168C2BD11;
	Tue, 21 May 2024 07:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716276222;
	bh=g5ad6h6fsS1VZMljbHFZQxtWXnD0wuSkOgJPO8o+IWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIQ5nB50A9fzy5aGKXStqGdhlcNXWJDoGm3vdmlYmeIA0Exsw9AAftpoIq0V5PD7P
	 ojLOwe2a0aIn3HYTZAuur0MT4qKOMLOcd6jotkYJ0sQSqEYpAqlDmyr+SvVgkd5VhH
	 rm/o95/zodJ0qYY9z3yHKKhiWK3ASNm4xAF+A1AlLnqSdMK+6s43pbz4z5SvtTkcu0
	 h8T3JC1arzq5w1Mdp03m4Tm+hSzqdcmo78juAHHutycjkQPjPjIQVhXQA+XzfoVfax
	 b+eNncCUyc5BnkclrrbRVUmS6V6egan9JUCPSrp9exOdPg5hKAsKFbcqZbvrwBLfX4
	 s74zLa4/EuRKg==
Date: Tue, 21 May 2024 10:21:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, arnd@arndb.de,
	anshuman.khandual@arm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [Patch v2] mm/memblock: discard .text/.data if
 CONFIG_ARCH_KEEP_MEMBLOCK not set
Message-ID: <ZkxLkK7vgzzaEvyw@kernel.org>
References: <20240510020422.8038-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510020422.8038-1-richard.weiyang@gmail.com>

Hi,

On Fri, May 10, 2024 at 02:04:22AM +0000, Wei Yang wrote:
> When CONFIG_ARCH_KEEP_MEMBLOCK not set, we expect to discard related
> code and data. But it doesn't until CONFIG_MEMORY_HOTPLUG not set
> neither.
> 
> This patch puts memblock's .text/.data into its own section, so that it
> only depends on CONFIG_ARCH_KEEP_MEMBLOCK to discard related code and
> data.
> 
> After this, from the log message in mem_init_print_info(), init size
> increase from 2420K to 2432K on arch x86.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> 
> ---
> v2: fix orphan section for powerpc
> ---
>  arch/powerpc/kernel/vmlinux.lds.S |  1 +
>  include/asm-generic/vmlinux.lds.h | 14 +++++++++++++-
>  include/linux/memblock.h          |  8 ++++----
>  3 files changed, 18 insertions(+), 5 deletions(-)
>  
> +#define __init_memblock        __section(".mbinit.text") __cold notrace \
> +						  __latent_entropy
> +#define __initdata_memblock    __section(".mbinit.data")
> +

The new .mbinit.* sections should be added to scripts/mod/modpost.c
alongside .meminit.* sections and then I expect modpost to report a bunch
of section mismatches because many memblock functions are called on memory
hotplug even on architectures that don't select ARCH_KEEP_MEMBLOCK.

>  #ifndef CONFIG_ARCH_KEEP_MEMBLOCK
> -#define __init_memblock __meminit
> -#define __initdata_memblock __meminitdata
>  void memblock_discard(void);
>  #else
> -#define __init_memblock
> -#define __initdata_memblock
>  static inline void memblock_discard(void) {}
>  #endif
>  
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.

