Return-Path: <linux-arch+bounces-15567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F8ACE60D9
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 07:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0ECE300452A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9432623BCF7;
	Mon, 29 Dec 2025 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUntOqUx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC42253B0;
	Mon, 29 Dec 2025 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766991405; cv=none; b=Ew+ajhjNDyRPuZC/NKO4hNbPY8HFJV7N3l+XpRUJj5ONmXHPL4i3TGRjpbMiTkbWUBo/AdFrk7nkP7UjcxGNK8zseP7UC2Tb7u7z+JSMi+A3khG29JAKlpIe147vsz0aVq+oAW4WcLQJG+z5tzvO6Js5P+Dytdtzsijldp4B0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766991405; c=relaxed/simple;
	bh=2L8Mk5WlWQlOwro+lzGpqFESnl7Z8ZzqFs5ya2vJbDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puLkiYa8q/2Y8TP0MnFevoh7FAuUfMl4WZl/zDpFnk8TwLNLIUby4+m6/JJPXwY/2HZJiefThOL4m69d+DN7Y9h0BttSX5MQgWTTtPHMjZpmXS645mbX2LFV5rQHl+OkksD2T52DzJ/SdUM9SHjN0t49sRTTQceKMoYTcjtoI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUntOqUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BF0C4CEF7;
	Mon, 29 Dec 2025 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766991404;
	bh=2L8Mk5WlWQlOwro+lzGpqFESnl7Z8ZzqFs5ya2vJbDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUntOqUx88jhIghah0BtHV123Tman5cFwnDzVOOMvAYksaJNRnWq3CjmRgean4N04
	 iqBLRzsOdMTU3ApunWnlX+Bxep76Drrj3bbErnOEUHKj70mMeVRFGcbNvY3xbUz2aR
	 WAj1+AQac4O+dn36O7LVQJUH2awM38yGe/04UBJ3WJbWcANLHTDv1LS+mLBD8qIIq5
	 /IsjB1NXRI9IJzDgLplHWc7WmtEBGwCqwThO1YR7/smhHyy8w0NEidVyVyHCbhTFKB
	 ot1wOsmC7rNnr2/wlnCU8Nn7gUTB/bs0BUNZCqANofZZ2Jp49o7HJ6H/nXcX0sXTiN
	 DODwXttylU7BQ==
Date: Mon, 29 Dec 2025 08:56:34 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
	pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net,
	david@redhat.com, mhocko@suse.com, tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, jonechou@google.com,
	rostedt@goodmis.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
Subject: Re: [PATCH 18/26] mm/memblock: Add MEMBLOCK_INSPECT flag
Message-ID: <aVImIneFgOngYdSn@kernel.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-19-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-19-eugen.hristev@linaro.org>

Hi Eugen,

On Wed, Nov 19, 2025 at 05:44:19PM +0200, Eugen Hristev wrote:
> This memblock flag indicates that a specific block is registered
> into an inspection table.
> The block can be marked for inspection using memblock_mark_inspect()
> and cleared with memblock_clear_inspect()

Can you explain why memblock should treat memory registered for inspection
differently?

> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>  include/linux/memblock.h |  7 +++++++
>  mm/memblock.c            | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 221118b5a16e..c3e55a4475cf 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -51,6 +51,10 @@ extern unsigned long long max_possible_pfn;
>   * memory reservations yet, so we get scratch memory from the previous
>   * kernel that we know is good to use. It is the only memory that
>   * allocations may happen from in this phase.
> + * @MEMBLOCK_INSPECT: memory region is annotated in kernel memory inspection
> + * table. This means a dedicated entry will be created for this region which
> + * will contain the memory's address and size. This allows kernel inspectors
> + * to retrieve the memory.
>   */
>  enum memblock_flags {
>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> @@ -61,6 +65,7 @@ enum memblock_flags {
>  	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>  	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>  	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
> +	MEMBLOCK_INSPECT	= 0x80,	/* memory selected for kernel inspection */
>  };
>  
>  /**
> @@ -149,6 +154,8 @@ unsigned long memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1,
>  bool memblock_overlaps_region(struct memblock_type *type,
>  			      phys_addr_t base, phys_addr_t size);
>  bool memblock_validate_numa_coverage(unsigned long threshold_bytes);
> +int memblock_mark_inspect(phys_addr_t base, phys_addr_t size);
> +int memblock_clear_inspect(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e23e16618e9b..a5df5ab286e5 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -17,6 +17,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/memblock.h>
>  #include <linux/mutex.h>
> +#include <linux/meminspect.h>
>  
>  #ifdef CONFIG_KEXEC_HANDOVER
>  #include <linux/libfdt.h>
> @@ -1016,6 +1017,40 @@ static int __init_memblock memblock_setclr_flag(struct memblock_type *type,
>  	return 0;
>  }
>  
> +/**
> + * memblock_mark_inspect - Mark inspectable memory with flag MEMBLOCK_INSPECT.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_mark_inspect(phys_addr_t base, phys_addr_t size)
> +{
> +	int ret;
> +
> +	ret = memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_INSPECT);
> +	if (ret)
> +		return ret;
> +
> +	meminspect_lock_register_pa(base, size);
> +
> +	return 0;
> +}
> +
> +/**
> + * memblock_clear_inspect - Clear flag MEMBLOCK_INSPECT for a specified region.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_clear_inspect(phys_addr_t base, phys_addr_t size)
> +{
> +	meminspect_lock_unregister_pa(base, size);
> +
> +	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_INSPECT);
> +}
> +
>  /**
>   * memblock_mark_hotplug - Mark hotpluggable memory with flag MEMBLOCK_HOTPLUG.
>   * @base: the base phys addr of the region
> @@ -2704,6 +2739,7 @@ static const char * const flagname[] = {
>  	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
>  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
>  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
> +	[ilog2(MEMBLOCK_INSPECT)] = "INSPECT",
>  };
>  
>  static int memblock_debug_show(struct seq_file *m, void *private)
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

