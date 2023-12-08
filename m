Return-Path: <linux-arch+bounces-795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4471809F5C
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 10:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DE91F21808
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C44125D1;
	Fri,  8 Dec 2023 09:30:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F351716;
	Fri,  8 Dec 2023 01:30:39 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Smm472DZRz1Q6XR;
	Fri,  8 Dec 2023 17:26:47 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Dec
 2023 17:30:36 +0800
Subject: Re: [net-next v1 09/16] page_pool: device memory support
To: Mina Almasry <almasrymina@google.com>, Shailend Chand
	<shailend@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst
	<jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Ahern
	<dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-10-almasrymina@google.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <32211cbf-3a4e-8a86-6214-4304ddb18a98@huawei.com>
Date: Fri, 8 Dec 2023 17:30:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231208005250.2910004-10-almasrymina@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/12/8 8:52, Mina Almasry wrote:
> Overload the LSB of struct page* to indicate that it's a page_pool_iov.
> 
> Refactor mm calls on struct page* into helpers, and add page_pool_iov
> handling on those helpers. Modify callers of these mm APIs with calls to
> these helpers instead.
> 
> In areas where struct page* is dereferenced, add a check for special
> handling of page_pool_iov.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v1:
> - Disable fragmentation support for iov properly.
> - fix napi_pp_put_page() path (Yunsheng).
> 
> ---
>  include/net/page_pool/helpers.h | 78 ++++++++++++++++++++++++++++++++-
>  net/core/page_pool.c            | 67 ++++++++++++++++++++--------
>  net/core/skbuff.c               | 28 +++++++-----
>  3 files changed, 141 insertions(+), 32 deletions(-)
> 
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 00197f14aa87..2d4e0a2c5620 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -154,6 +154,64 @@ static inline struct page_pool_iov *page_to_page_pool_iov(struct page *page)
>  	return NULL;
>  }
>  
> +static inline int page_pool_page_ref_count(struct page *page)
> +{
> +	if (page_is_page_pool_iov(page))

As mentioned before, it seems we need to have the above checking every
time we need to do some per-page handling in page_pool core, is there
a plan in your mind how to remove those kind of checking in the future?

Even though a static_branch check is added in page_is_page_pool_iov(), it
does not make much sense that a core has tow different 'struct' for its
most basic data.

IMHO, the ppiov for dmabuf is forced fitting into page_pool without much
design consideration at this point.

> +		return page_pool_iov_refcount(page_to_page_pool_iov(page));
> +
> +	return page_ref_count(page);
> +}
> +

...

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b157efea5dea..07f802f1adf1 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -896,19 +896,23 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
>  	bool allow_direct = false;
>  	struct page_pool *pp;
>  
> -	page = compound_head(page);
> -
> -	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
> -	 * in order to preserve any existing bits, such as bit 0 for the
> -	 * head page of compound page and bit 1 for pfmemalloc page, so
> -	 * mask those bits for freeing side when doing below checking,
> -	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
> -	 * to avoid recycling the pfmemalloc page.
> -	 */
> -	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
> -		return false;
> +	if (!page_is_page_pool_iov(page)) {

For now, the above may work for the the rx part as it seems that you are
only enabling rx for dmabuf for now.

What is the plan to enable tx for dmabuf? If it is also intergrated into
page_pool? There was a attempt to enable page_pool for tx, Eric seemed to
have some comment about this:
https://lkml.kernel.org/netdev/2cf4b672-d7dc-db3d-ce90-15b4e91c4005@huawei.com/T/#mb6ab62dc22f38ec621d516259c56dd66353e24a2

If tx is not intergrated into page_pool, do we need to create a new layer for
the tx dmabuf?

> +		page = compound_head(page);
> +
> +		/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
> +		 * in order to preserve any existing bits, such as bit 0 for the
> +		 * head page of compound page and bit 1 for pfmemalloc page, so
> +		 * mask those bits for freeing side when doing below checking,
> +		 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
> +		 * to avoid recycling the pfmemalloc page.
> +		 */
> +		if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
> +			return false;
>  
> -	pp = page->pp;
> +		pp = page->pp;
> +	} else {
> +		pp = page_to_page_pool_iov(page)->pp;
> +	}
>  
>  	/* Allow direct recycle if we have reasons to believe that we are
>  	 * in the same context as the consumer would run, so there's
> 

