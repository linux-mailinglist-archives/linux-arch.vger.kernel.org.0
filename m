Return-Path: <linux-arch+bounces-15568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 355ABCE60F7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 07:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E1B930062C7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 06:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7065E2C326B;
	Mon, 29 Dec 2025 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHt4chWY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375EE23A994;
	Mon, 29 Dec 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766991506; cv=none; b=RLKhz0dR9Kl61BAx5Z4ekbKcT2fy6ldB1q3YdyEHCnH0Rv2bEz9N0TUEy4SeXDPSACMs8zxrsdiBHKcAzgwAaLz3P/GFRmsos6OL8iRXqmwnS/5sT1sSNgFfnLPOxgnc0h6dGj7QbNVRqbYVMwndUV2HlLASuG3BhCbZaMArokM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766991506; c=relaxed/simple;
	bh=V2y2PsL6+tNWebVwd0+KwFFsHyM19wzJl+pDNwf+sLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9gpcNCKHTch+hwLmSD3v04rU6L1iDFfbey6PHWp0hP7v0W8QVavHtQUdkYaTju4hLcDfEPB+AlBgT6O+sbZcHCilFCczzRjlzbfQpQ5JycDlE+Bw+pfYzWBhCVf4TBsU/9rzyWMgIzJ+KLncgr0Oh/mrRLt52IErNfATvblF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHt4chWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CE1C4CEF7;
	Mon, 29 Dec 2025 06:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766991505;
	bh=V2y2PsL6+tNWebVwd0+KwFFsHyM19wzJl+pDNwf+sLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHt4chWYSuLuDbLrlpROYCd7Q5YXDLbWsfAff8CsrYD04k+l/DTp/2dZtSHvQWqno
	 Uv5A0PAEYWXIBVNK12KAE+tDmuz8dJWgD2fSfp8E+h5lbShxW7rzd0p1nBC55JzQr6
	 H1J0nH3v1nzqVtEKjuZo/DRD8Z1dBI7bank52DAHxQsGMaiJjkeirY+zSVUQDHe8f5
	 I5TbcjUhTz054W0VQeJG+KxBrB+7o4bbom0NsfxtyhwDUA6+N4J9T7lR2nuobKBKWt
	 5JZKi+hSeF+id57btnngVjqW5FuY5oi2sSB2Ro1A/cKqN/uxnV1tLUBaDqFrQ/Yod7
	 j0PAqpdFf/nHw==
Date: Mon, 29 Dec 2025 08:58:14 +0200
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
Subject: Re: [PATCH 19/26] mm/numa: Register information into meminspect
Message-ID: <aVImhhgEsHInebeh@kernel.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-20-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-20-eugen.hristev@linaro.org>

Hi Eugen,

On Wed, Nov 19, 2025 at 05:44:20PM +0200, Eugen Hristev wrote:
> Register dynamic information into meminspect:
>  - dynamic node data for each node
> 
> This information is being allocated for each node, as physical address,
> so call memblock_mark_inspect that will mark the block accordingly.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>  mm/numa.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/numa.c b/mm/numa.c
> index 7d5e06fe5bd4..379065dd633e 100644
> --- a/mm/numa.c
> +++ b/mm/numa.c
> @@ -4,6 +4,7 @@
>  #include <linux/printk.h>
>  #include <linux/numa.h>
>  #include <linux/numa_memblks.h>
> +#include <linux/meminspect.h>
>  
>  struct pglist_data *node_data[MAX_NUMNODES];
>  EXPORT_SYMBOL(node_data);
> @@ -20,6 +21,7 @@ void __init alloc_node_data(int nid)
>  	if (!nd_pa)
>  		panic("Cannot allocate %zu bytes for node %d data\n",
>  		      nd_size, nid);
> +	memblock_mark_inspect(nd_pa, nd_size);

Won't plain meminspect_register_pa() work here?

>  	/* report and initialize */
>  	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

