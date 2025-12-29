Return-Path: <linux-arch+bounces-15569-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0BCE6101
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 07:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B52CB3005B9C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 06:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DBF27F01E;
	Mon, 29 Dec 2025 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX6iWUyw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD123A994;
	Mon, 29 Dec 2025 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766991556; cv=none; b=lvii82gKX/NLGxzYOKYigl9ky1xMwf9QgiFBfJLxleO9ZlGi2m/6YUnqVpGY+U2cEXcuh4Ax3JSQBFMPI73UDc79bMgCU9IIq3dBi2UvbcSnEtnc8bSoMSUXOLCp7eyv5sUPdnVKKT7+hnPZ/JNny9ckg5eXvGUX99N/G2SkxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766991556; c=relaxed/simple;
	bh=o0wgikOuKph/UYuKT9+K1YO24u8iftLUAb48sk35Re0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMW5jdMKx2PtezjixlI96oWH1GVbLofC8c7/wdOVA+qmCrWxSHfulGEyN3aTz7MColFjEk88w267a4EVCrYh0yi0WvBeJLPSs5qxcSQQPXHlb6HNm6jMyocGcG7RsVUhmTisaMJQij77MBkAP6QwRc8/k+nZvfifFQPS9MyAtlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX6iWUyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013C0C4CEF7;
	Mon, 29 Dec 2025 06:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766991556;
	bh=o0wgikOuKph/UYuKT9+K1YO24u8iftLUAb48sk35Re0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LX6iWUywtDOVwU3j9KaL9yXGKfNvvYoCb2qlBXzbFyPsnG2vGbJfpde+T2rxhLMi6
	 2QkUnuWKjSpsWFFAsUzRcNl579W7HN0vsLwnx0uIdqDYc9pemeno7sciMWkg6kcTI/
	 4/xSfoSw/2dLsoppKWxsEq5G+zDhlITLjIbe3xtQyDd3VX8EaYH8uBU7LN15p9UqQL
	 FVs9iNnIt/1eTm9Frc5o3vv9Yv1CER2nZ+JljzygBIBdOv7xURTNYUtEzZKhlQ+g8z
	 HHaOgTGPYzoj7al1VV0VjV+KDjSPLts8cDtlXEe/iJFkjLIODRbrq6dVEwqGplAjPU
	 8vCr0gtMZU5XA==
Date: Mon, 29 Dec 2025 08:59:05 +0200
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
Subject: Re: [PATCH 20/26] mm/sparse: Register information into meminspect
Message-ID: <aVImuURq0FXsfsrp@kernel.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-21-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-21-eugen.hristev@linaro.org>

Hi Eugen,

On Wed, Nov 19, 2025 at 05:44:21PM +0200, Eugen Hristev wrote:
> Annotate vital static information into meminspect:
>  - mem_section
> 
> Information on these variables is stored into inspection table.
> 
> Register dynamic information into meminspect:
>  - section
>  - mem_section_usage
> 
> This information is being allocated for each node, so call
> memblock_mark_inspect to mark the block accordingly.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>  mm/sparse.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 17c50a6415c2..80530e39c8b2 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -15,6 +15,7 @@
>  #include <linux/swapops.h>
>  #include <linux/bootmem_info.h>
>  #include <linux/vmstat.h>
> +#include <linux/meminspect.h>
>  #include "internal.h"
>  #include <asm/dma.h>
>  
> @@ -30,6 +31,7 @@ struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
>  	____cacheline_internodealigned_in_smp;
>  #endif
>  EXPORT_SYMBOL(mem_section);
> +MEMINSPECT_SIMPLE_ENTRY(mem_section);
>  
>  #ifdef NODE_NOT_IN_PAGE_FLAGS
>  /*
> @@ -253,6 +255,7 @@ static void __init memblocks_present(void)
>  		size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
>  		align = 1 << (INTERNODE_CACHE_SHIFT);
>  		mem_section = memblock_alloc_or_panic(size, align);
> +		memblock_mark_inspect(virt_to_phys(mem_section), size);

Why not meminspect_register_va()?

>  	}
>  #endif
>  
> @@ -343,6 +346,7 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
>  		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
>  		goto again;
>  	}
> +	memblock_mark_inspect(virt_to_phys(usage), size);
>  	return usage;
>  }
>  
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

