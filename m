Return-Path: <linux-arch+bounces-2900-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55641875D55
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 05:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5AEB21FDA
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 04:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1562E84A;
	Fri,  8 Mar 2024 04:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="WHOLKf9i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AD32C92
	for <linux-arch@vger.kernel.org>; Fri,  8 Mar 2024 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709873876; cv=none; b=NdzZnrSBesPCkZ+Ye1oJKuvBEPuzlY6Rbg0hpQEnFOZfQ7y7TvK7IjK0SY3BVKkR36IDIxVmgYgmYT2coay6PLqFLcszTu7pZiuKKjAWcyHs/XFm22EEsaK3YiV71+0Vh4jtCVNxPTFNqvg0Acw+CYdjjgJcDYXtcEor06E9AOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709873876; c=relaxed/simple;
	bh=YHgLhGo9u/GaA4wjmsG1D7h2kk3KAbiuEeepwyKoTyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYv9KJlkRgspkfFQJ1/DiAFZaXcnLqLK4vuq1dNvmdqNgzMjtXUdUU4TbGbEbRbQA5634EDxxLkWQ4vkjcgPNCjqGmZE8LJTo9YwKqE1zePxe35DJ5fG08GYUSRO6Xe3KyEmyrUFcvd9g4DuQ6qp2BKIDtUBBAT/QsmucX3nw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=WHOLKf9i; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a1bc321852so436215eaf.2
        for <linux-arch@vger.kernel.org>; Thu, 07 Mar 2024 20:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709873872; x=1710478672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hd5eSIOo7us1LbsNzpdstrnvo/0BBPJxonyWDnWYOdI=;
        b=WHOLKf9iGdgVvKTjQmxXbGWwIT9aW9o9hEq9U+lj49TYZ42wh7OW8mGicrRGPFBWec
         GQXHXEEy7tPbKwC1FHg8zUZWXZfzhZPY7eTptlAxCYMCrZISnWijtPow38TPk+467WQI
         C+SLrK5dNJPHk+1cx98faF71o72UvdNKhUddExLhLHqSlNl82akiFzavl0puT4+AmRFJ
         Ec9bN9cNgCHYY85wXTpFf//96AeQfDdV8fpasYXN1atMrFSxm0GJhpfw8m5MlTIrmThy
         aDpFbpiasRW10nZIRqfeXavPvZw0dJn5/4Gc7DZtaG5mAlYsF39ActGfINqVsFI27Zds
         3LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709873872; x=1710478672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd5eSIOo7us1LbsNzpdstrnvo/0BBPJxonyWDnWYOdI=;
        b=pJJ6ind2dR/6iildqQw7RC1aI02ZCKHILHUjDiaxpmVY1Ap2ZZkUpIqff2Sl4HiVoB
         SUL1h6v0ysVuejtIU6lpKrX3PKb7HmbXrRTL9N97MxFaPPt+dF1hzR8mTIyN5cGPhkn6
         d6/pWATb8avRKUhoGbEp870LTm2Vzor3e/gkFOISaufQfg0qQUl/dH521y3Jz+fkbf6Z
         d3IQ7WL9AE9q6Oh+6p+ShE/8sx8uni2auytv7n4Ik7/8rc7CLqFl3C13pM/ygGNe3R9f
         03evwWDkFZxkRsI4Jt6xR7O43tP8FC6RE9/A7ZK4aaiGcgoccrGFb43Q7NKzP0BC2/09
         8Nag==
X-Forwarded-Encrypted: i=1; AJvYcCW7IQsbSqVynIqpCro7eD3o8JiEQV/8UiV4akL3Tqjn3mCaX5DyphOHlwv59VuDn4j2poh6POi4waKlAU+AIIR9modPzDMCyyZxxA==
X-Gm-Message-State: AOJu0YyXMOOPTtM25Mfh+s8ODqr4D876RpGQAzmEFQYqt+Si3BF87KaV
	7ThhMzI/Wk6C4hPwCTZuSb5lax0HqA9jPv1wCTmRVpSp9T1kbpA7JhGkSv/91co=
X-Google-Smtp-Source: AGHT+IGD+SMzrtIqxos2BUylU1ihI6jHOpxBRUaDnHcmTxvqFG6hCKlO2aW2yjsKNPG+MnRLXz5+kA==
X-Received: by 2002:a05:6358:70b:b0:176:40d5:2bd5 with SMTP id e11-20020a056358070b00b0017640d52bd5mr10614876rwj.6.1709873871879;
        Thu, 07 Mar 2024 20:57:51 -0800 (PST)
Received: from [192.168.1.24] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id k76-20020a633d4f000000b005dc8702f0a9sm13477127pga.1.2024.03.07.20.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 20:57:51 -0800 (PST)
Message-ID: <15625bac-dfec-4c4e-a828-d11424f7aced@davidwei.uk>
Date: Thu, 7 Mar 2024 20:57:49 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240305020153.2787423-3-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-04 18:01, Mina Almasry wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> The page providers which try to reuse the same pages will
> need to hold onto the ref, even if page gets released from
> the pool - as in releasing the page from the pp just transfers
> the "ownership" reference from pp to the provider, and provider
> will wait for other references to be gone before feeding this
> page back into the pool.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> This is implemented by Jakub in his RFC:
> https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com/T/
> 
> I take no credit for the idea or implementation; I only added minor
> edits to make this workable with device memory TCP, and removed some
> hacky test code. This is a critical dependency of device memory TCP
> and thus I'm pulling it into this series to make it revewable and
> mergeable.
> 
> RFC v3 -> v1
> - Removed unusued mem_provider. (Yunsheng).
> - Replaced memory_provider & mp_priv with netdev_rx_queue (Jakub).
> 
> ---
>  include/net/page_pool/types.h | 12 ++++++++++
>  net/core/page_pool.c          | 43 +++++++++++++++++++++++++++++++----
>  2 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 5e43a08d3231..ffe5f31fb0da 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -52,6 +52,7 @@ struct pp_alloc_cache {
>   * @dev:	device, for DMA pre-mapping purposes
>   * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
>   * @napi:	NAPI which is the sole consumer of pages, otherwise NULL
> + * @queue:	struct netdev_rx_queue this page_pool is being created for.
>   * @dma_dir:	DMA mapping direction
>   * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
>   * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
> @@ -64,6 +65,7 @@ struct page_pool_params {
>  		int		nid;
>  		struct device	*dev;
>  		struct napi_struct *napi;
> +		struct netdev_rx_queue *queue;
>  		enum dma_data_direction dma_dir;
>  		unsigned int	max_len;
>  		unsigned int	offset;
> @@ -126,6 +128,13 @@ struct page_pool_stats {
>  };
>  #endif
>  
> +struct memory_provider_ops {
> +	int (*init)(struct page_pool *pool);
> +	void (*destroy)(struct page_pool *pool);
> +	struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
> +	bool (*release_page)(struct page_pool *pool, struct page *page);
> +};

Separate question as I try to adapt bnxt to this and your queue
configuration API.

How does GVE handle the need to allocate kernel pages for headers and
dmabuf for payloads?

Reading the code, struct gve_rx_ring is the main per-ring object with a
page pool. gve_queue_page_lists are filled with page pool netmem
allocations from the page pool in gve_alloc_queue_page_list(). Are these
strictly used for payloads only?

I found a struct gve_header_buf in both gve_rx_ring and struct
gve_per_rx_queue_mem_dpo. This is allocated in gve_rx_queue_mem_alloc()
using dma_alloc_coherent(). Is this where GVE stores headers?

IOW, GVE only uses page pool to allocate memory for QPLs, and QPLs are
used by the device for split payloads. Is my understanding correct?

> +
>  struct page_pool {
>  	struct page_pool_params_fast p;
>  
> @@ -176,6 +185,9 @@ struct page_pool {
>  	 */
>  	struct ptr_ring ring;
>  
> +	void *mp_priv;
> +	const struct memory_provider_ops *mp_ops;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>  	/* recycle stats are per-cpu to avoid locking */
>  	struct page_pool_recycle_stats __percpu *recycle_stats;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index d706fe5548df..8776fcad064a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -25,6 +25,8 @@
>  
>  #include "page_pool_priv.h"
>  
> +static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
> +
>  #define DEFER_TIME (msecs_to_jiffies(1000))
>  #define DEFER_WARN_INTERVAL (60 * HZ)
>  
> @@ -177,6 +179,7 @@ static int page_pool_init(struct page_pool *pool,
>  			  int cpuid)
>  {
>  	unsigned int ring_qsize = 1024; /* Default */
> +	int err;
>  
>  	memcpy(&pool->p, &params->fast, sizeof(pool->p));
>  	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
> @@ -248,10 +251,25 @@ static int page_pool_init(struct page_pool *pool,
>  	/* Driver calling page_pool_create() also call page_pool_destroy() */
>  	refcount_set(&pool->user_cnt, 1);
>  
> +	if (pool->mp_ops) {
> +		err = pool->mp_ops->init(pool);
> +		if (err) {
> +			pr_warn("%s() mem-provider init failed %d\n",
> +				__func__, err);
> +			goto free_ptr_ring;
> +		}
> +
> +		static_branch_inc(&page_pool_mem_providers);
> +	}
> +
>  	if (pool->p.flags & PP_FLAG_DMA_MAP)
>  		get_device(pool->p.dev);
>  
>  	return 0;
> +
> +free_ptr_ring:
> +	ptr_ring_cleanup(&pool->ring, NULL);
> +	return err;
>  }
>  
>  static void page_pool_uninit(struct page_pool *pool)
> @@ -546,7 +564,10 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
>  		return page;
>  
>  	/* Slow-path: cache empty, do real allocation */
> -	page = __page_pool_alloc_pages_slow(pool, gfp);
> +	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
> +		page = pool->mp_ops->alloc_pages(pool, gfp);
> +	else
> +		page = __page_pool_alloc_pages_slow(pool, gfp);
>  	return page;
>  }
>  EXPORT_SYMBOL(page_pool_alloc_pages);
> @@ -603,10 +624,13 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
>  void page_pool_return_page(struct page_pool *pool, struct page *page)
>  {
>  	int count;
> +	bool put;
>  
> -	__page_pool_release_page_dma(pool, page);
> -
> -	page_pool_clear_pp_info(page);
> +	put = true;
> +	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
> +		put = pool->mp_ops->release_page(pool, page);
> +	else
> +		__page_pool_release_page_dma(pool, page);
>  
>  	/* This may be the last page returned, releasing the pool, so
>  	 * it is not safe to reference pool afterwards.
> @@ -614,7 +638,10 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
>  	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
>  	trace_page_pool_state_release(pool, page, count);
>  
> -	put_page(page);
> +	if (put) {
> +		page_pool_clear_pp_info(page);
> +		put_page(page);
> +	}
>  	/* An optimization would be to call __free_pages(page, pool->p.order)
>  	 * knowing page is not part of page-cache (thus avoiding a
>  	 * __page_cache_release() call).
> @@ -884,6 +911,12 @@ static void __page_pool_destroy(struct page_pool *pool)
>  
>  	page_pool_unlist(pool);
>  	page_pool_uninit(pool);
> +
> +	if (pool->mp_ops) {
> +		pool->mp_ops->destroy(pool);
> +		static_branch_dec(&page_pool_mem_providers);
> +	}
> +
>  	kfree(pool);
>  }
>  

