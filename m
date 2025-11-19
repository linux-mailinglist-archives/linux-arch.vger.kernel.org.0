Return-Path: <linux-arch+bounces-14907-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F13CC6E494
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 12:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E5FF52E443
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EEC354ACB;
	Wed, 19 Nov 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJbIHiQr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46273502BB;
	Wed, 19 Nov 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763552491; cv=none; b=MUw1CAF8IJ7FL/JlkWxZL/98OFywb7a56IDDyBDavXc2JOc0kvrGQJtY4IFil0mVE0pxZiZ6F54acPiA+C5RPWXovlR/zZXng93CjDCM0mCz8BM2T6Jke/Yin4rdY2vflaxlPnwFeDNd+yH8TGMDr1rseTXakB8Oc4TL2wAYeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763552491; c=relaxed/simple;
	bh=HXpQLGEYTPYES14JBHZvvFK44MSIkNFIzwcCwSjsouc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHn/k3j3xybYwLtJ+67HJOPuWd2JBKRGF2IBPX91PuXInLXmnRmZg6YvdV2io5YPslW1yAvMw8XnjeKOy0lyi/in4h7G809i8nmjIfI7by/0d3GEAEikh/NZLNyMUZghvwop2pXN3Wfqx+roRDeRQBpFmvnkhI4Y9o7R7h1GMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJbIHiQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F382FC116B1;
	Wed, 19 Nov 2025 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763552490;
	bh=HXpQLGEYTPYES14JBHZvvFK44MSIkNFIzwcCwSjsouc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dJbIHiQryWS5vtNu02vTmwBFqXplLmDlrRF3Oj/Hv8Rl3ZpPg4lfks4k8cE/XqwR9
	 V9MAm853Im7SAdK7OXzlQw1hc6tyKLDgzb0uKjIo0GCzMjAqscZ2owxQPDp1CdEz7a
	 7usbZ/LyHrmIBFSRl4TInJY6BMkNTTqpwNiRaRzl4++4YCRK4dWRMoJoh2WkvIkdYZ
	 xgI0cA9TTcO8KXj59OYrhJ5G/eM4nqANztmks5pHkQqHorWXCFHTgtIibsN3o8GESg
	 KcvLEYucw41mQLZuYbSRCwcgj/tdWLOnihNqvwOfKxarPLIBUMfK6lvxodlvk9eBbF
	 XeSn8dvhB6NSg==
Message-ID: <e539179f-668e-452d-a08e-6143392dae6a@kernel.org>
Date: Wed, 19 Nov 2025 12:41:22 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mm: change mm/pt_reclaim.c to use asm/tlb.h
 instead of asm-generic/tlb.h
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com, linmag7@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
 <e9d510106b5bf72a9b577b8c5ad161fd3c29c2b6.1763537007.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <e9d510106b5bf72a9b577b8c5ad161fd3c29c2b6.1763537007.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.25 08:31, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Generally, the asm/tlb.h will include asm-generic/tlb.h, so change
> mm/pt_reclaim.c to use asm/tlb.h instead of asm-generic/tlb.h. This can
> also fix compilation errors on some architecture when CONFIG_PT_RECLAIM
> is enabled (such as alpha).

"This is a preparation for enabling CONFIG_PT_RECLAIM on other 
architectures, such as alpha."

> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/pt_reclaim.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
> index 0d9cfbf4fe5d8..46771cfff8239 100644
> --- a/mm/pt_reclaim.c
> +++ b/mm/pt_reclaim.c
> @@ -2,7 +2,7 @@
>   #include <linux/hugetlb.h>
>   #include <linux/pgalloc.h>
>   
> -#include <asm-generic/tlb.h>
> +#include <asm/tlb.h>
>   
>   #include "internal.h"
>   

Right, we're using pte_free_tlb(), and the default lives in 
include/asm-generic/tlb.h.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

