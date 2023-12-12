Return-Path: <linux-arch+bounces-910-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C4A80E577
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 09:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569FB1C208E9
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 08:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBFC182DB;
	Tue, 12 Dec 2023 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yjDyLlX+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF858D2
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 00:07:56 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso7050091e87.3
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 00:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702368475; x=1702973275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KEK+GLviJvtTbzYzmtDV4AEm8T+lMdwOyDcx0NSd3/o=;
        b=yjDyLlX+WKvy4KTLqbEPOCBw4F+IfDEZIpxf47iaC+QwGIVN2mrumhoyWdfOJrZ4ln
         elyQuYvRjFjTkc6oFXoVx6liygAGXgNq2KJsItw/ovqcLu0yKy56kIVV7YzDoowB1pRi
         ks/5kNP3Pq4YwfnuN81N/o7hZ2oHD+mjhjXXeHtoNCrudwV9wg5+35c5/sB/6TI3b9Sj
         4RESd8RD116cSDinYlkJ2MSyEmBrXvxm3GeUBqTMhncOnEV2ldV3DjKpqwGuotby8Jlb
         krIJQANQDL1ceXf/yKAp7b2enwvIJlKKajnuMCFKYnGeVzM3m0o7sGrSs98s6tchC2Fo
         oaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702368475; x=1702973275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEK+GLviJvtTbzYzmtDV4AEm8T+lMdwOyDcx0NSd3/o=;
        b=v4pWGvHEQ8sUOaOTVCfQAKIYur9BhUx/k6P9/PTWsj/7YJQ+dG2cI4i4GcvJoK0Vid
         tsP/OQOSFVxkoQ43ue/kmz341+2TQ1mlYzCDWCevHVgbR01Xhq5I2ETCiR8wcPK3SW2f
         tn1jaQa3QNJj8x9OLGj/NtSUSScPeiimBUXudWox0kztU/cwQmFgwmPvQYKp7mtSwnmM
         gCID+9cqyDDXfW4TM3XOuEYiJiXuDwlVa43BGjabduC7L2K7cfR4sNnLWh0eaksS46Ko
         luAVCEC9j+QHUupI11qDqJk9+Q4Xe01ynBPWLIjREkBPvn5D/IPyVO9xLBaTTRzIAdQ0
         vfdg==
X-Gm-Message-State: AOJu0Yyj3i5e1UFligKGK7fZ2CHGv+VwDGJim5GtTR0O2I1dFve9noMu
	qkkV5NDqEobd0aEUaQTdZ06+s31CsWYLXS6j5i1dgw==
X-Google-Smtp-Source: AGHT+IEyDnIHVqAdsBAK/Xj7zNRHMZz0/zXmDbcUqKkjG+kJeiX3tGS1DN1FlCnS9R/LXR3IKWLy3yX4hnlm0fdZnR8=
X-Received: by 2002:a05:6512:a8c:b0:50c:6b:f164 with SMTP id
 m12-20020a0565120a8c00b0050c006bf164mr3620875lfu.27.1702368474939; Tue, 12
 Dec 2023 00:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com> <20231208005250.2910004-3-almasrymina@google.com>
In-Reply-To: <20231208005250.2910004-3-almasrymina@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Dec 2023 10:07:18 +0200
Message-ID: <CAC_iWjKikzwpjR0hBjYuRxgYjyqp_EYrrxoveB_2DgCxk6vWYw@mail.gmail.com>
Subject: Re: [net-next v1 02/16] net: page_pool: create hooks for custom page providers
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mina,

Apologies for not participating in the party earlier.

On Fri, 8 Dec 2023 at 02:52, Mina Almasry <almasrymina@google.com> wrote:
>
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
> mergable.
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
> index ac286ea8ce2d..0e9fa79a5ef1 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -51,6 +51,7 @@ struct pp_alloc_cache {
>   * @dev:       device, for DMA pre-mapping purposes
>   * @netdev:    netdev this pool will serve (leave as NULL if none or multiple)
>   * @napi:      NAPI which is the sole consumer of pages, otherwise NULL
> + * @queue:     struct netdev_rx_queue this page_pool is being created for.
>   * @dma_dir:   DMA mapping direction
>   * @max_len:   max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
>   * @offset:    DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
> @@ -63,6 +64,7 @@ struct page_pool_params {
>                 int             nid;
>                 struct device   *dev;
>                 struct napi_struct *napi;
> +               struct netdev_rx_queue *queue;
>                 enum dma_data_direction dma_dir;
>                 unsigned int    max_len;
>                 unsigned int    offset;
> @@ -125,6 +127,13 @@ struct page_pool_stats {
>  };
>  #endif
>
> +struct memory_provider_ops {
> +       int (*init)(struct page_pool *pool);
> +       void (*destroy)(struct page_pool *pool);
> +       struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
> +       bool (*release_page)(struct page_pool *pool, struct page *page);
> +};
> +
>  struct page_pool {
>         struct page_pool_params_fast p;
>
> @@ -174,6 +183,9 @@ struct page_pool {
>          */
>         struct ptr_ring ring;
>
> +       void *mp_priv;
> +       const struct memory_provider_ops *mp_ops;
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>         /* recycle stats are per-cpu to avoid locking */
>         struct page_pool_recycle_stats __percpu *recycle_stats;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index ca1b3b65c9b5..f5c84d2a4510 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -25,6 +25,8 @@
>
>  #include "page_pool_priv.h"
>
> +static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);

We could add the existing page pool mechanisms as another 'provider',
but I assume this is coded like this for performance reasons (IOW skip
the expensive ptr call for the default case?)

> +
>  #define DEFER_TIME (msecs_to_jiffies(1000))
>  #define DEFER_WARN_INTERVAL (60 * HZ)
>
> @@ -174,6 +176,7 @@ static int page_pool_init(struct page_pool *pool,
>                           const struct page_pool_params *params)
>  {
>         unsigned int ring_qsize = 1024; /* Default */
> +       int err;
>
>         memcpy(&pool->p, &params->fast, sizeof(pool->p));
>         memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
> @@ -234,10 +237,25 @@ static int page_pool_init(struct page_pool *pool,
>         /* Driver calling page_pool_create() also call page_pool_destroy() */
>         refcount_set(&pool->user_cnt, 1);
>
> +       if (pool->mp_ops) {
> +               err = pool->mp_ops->init(pool);
> +               if (err) {
> +                       pr_warn("%s() mem-provider init failed %d\n",
> +                               __func__, err);
> +                       goto free_ptr_ring;
> +               }
> +
> +               static_branch_inc(&page_pool_mem_providers);
> +       }
> +
>         if (pool->p.flags & PP_FLAG_DMA_MAP)
>                 get_device(pool->p.dev);
>
>         return 0;
> +
> +free_ptr_ring:
> +       ptr_ring_cleanup(&pool->ring, NULL);
> +       return err;
>  }
>
>  static void page_pool_uninit(struct page_pool *pool)
> @@ -519,7 +537,10 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
>                 return page;
>
>         /* Slow-path: cache empty, do real allocation */
> -       page = __page_pool_alloc_pages_slow(pool, gfp);
> +       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)

Why do we need && pool->mp_ops? On the init function, we only bump
page_pool_mem_providers if the ops are there

> +               page = pool->mp_ops->alloc_pages(pool, gfp);
> +       else
> +               page = __page_pool_alloc_pages_slow(pool, gfp);
>         return page;
>  }
>  EXPORT_SYMBOL(page_pool_alloc_pages);
> @@ -576,10 +597,13 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
>  void page_pool_return_page(struct page_pool *pool, struct page *page)
>  {
>         int count;
> +       bool put;
>
> -       __page_pool_release_page_dma(pool, page);
> -
> -       page_pool_clear_pp_info(page);
> +       put = true;
> +       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)

ditto

> +               put = pool->mp_ops->release_page(pool, page);
> +       else
> +               __page_pool_release_page_dma(pool, page);
>
>         /* This may be the last page returned, releasing the pool, so
>          * it is not safe to reference pool afterwards.
> @@ -587,7 +611,10 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
>         count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
>         trace_page_pool_state_release(pool, page, count);
>
> -       put_page(page);
> +       if (put) {
> +               page_pool_clear_pp_info(page);
> +               put_page(page);
> +       }
>         /* An optimization would be to call __free_pages(page, pool->p.order)
>          * knowing page is not part of page-cache (thus avoiding a
>          * __page_cache_release() call).
> @@ -857,6 +884,12 @@ static void __page_pool_destroy(struct page_pool *pool)
>
>         page_pool_unlist(pool);
>         page_pool_uninit(pool);
> +
> +       if (pool->mp_ops) {

Same here. Using a mix of pool->mp_ops and page_pool_mem_providers
will work, but since we always check the ptr on init, can't we simply
rely on page_pool_mem_providers for the rest of the code?

Thanks
/Ilias
> +               pool->mp_ops->destroy(pool);
> +               static_branch_dec(&page_pool_mem_providers);
> +       }
> +
>         kfree(pool);
>  }
>
> --
> 2.43.0.472.g3155946c3a-goog
>

