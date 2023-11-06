Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26E37E18AE
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 03:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjKFCo3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 21:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjKFCo1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 21:44:27 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A285613E
        for <linux-arch@vger.kernel.org>; Sun,  5 Nov 2023 18:44:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afa86b8d66so56328577b3.3
        for <linux-arch@vger.kernel.org>; Sun, 05 Nov 2023 18:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238663; x=1699843463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2aWBuORvTMxiaxkeVBpZ19MJEVfIpSc8yfaq5OEMLWc=;
        b=3fASEIAw+83aeyOPu29o+h9e9Py/WA3mB46W/RzTuxb5g5o9BZanbIUVaUumEMHy9o
         frqRfDo8Q3gjyTIYmA2v6GzWsPC14qQfKTlRvE5jCLdJ/j0YveO/NOyVQplB165lZeuZ
         NuYK0pfyrwTi7QtGrHXTwbaYcTTp00wu4oYFTcz8fq16lOuATHbTnvXy0I8UT13P6i7x
         IB3SL0mL29a99hli8I05b/sp0F7kvL+sF2aVoOYtW1aspfbOeXjoEMcfYvo6EOmnQETH
         Sb6BLKvGdH+EXSFm6oTa2iGlPUs4US/OiwD3HXkCLJ/mNaB7aB7wmd9kVDZD0COMIkyl
         d5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238663; x=1699843463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aWBuORvTMxiaxkeVBpZ19MJEVfIpSc8yfaq5OEMLWc=;
        b=exDinCItUA+2pHzla/4mEghMCvSwjyefnQfdLzHogFkzug+8rmtm0m85OpLNujy+ml
         WnRab9MD+FDDn0lLAlXlV/JapcWDFf/fs15WL71a9746zx94N6PG+rfHcZNtKo7uzJb6
         eZzNrgo91X6VLn3zVbgBjtf4ZGmqDPxXKiv8fBQxQInhMnIJSvpt4UtPmC28OfYLxhHe
         5YqhWa8tsEMDz1AtF7bIxUq4pIACqB1+l0qf0hCAKaJ+QfQVi+7s6Fe9ZqBsiNHKZbOy
         oz1FW0rTItTiLn6oWcfPf2cq6e20Rw1J+N4EGgbdZRv6AQY0TXXMGyK4Q8WwpS1Dl1yv
         Nbjw==
X-Gm-Message-State: AOJu0Yy47QNnk/vFQ2qOIDiwny7mUeDc5uKV4NnXHuyIxeFezTz2fM9K
        WREg3JT5H7bG7MB+BmKwFHw2373BHLA8QCuJxg==
X-Google-Smtp-Source: AGHT+IEw+DPriD5kGCKLp7L9RvV3A2PIEZmUjmOXZu2L4QcO1pjeWSWUha8L2tTFId6zhwFVRynJBYuZ216EpkRCrw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:688b:0:b0:da0:46e5:a7ef with SMTP
 id d133-20020a25688b000000b00da046e5a7efmr496838ybc.3.1699238662743; Sun, 05
 Nov 2023 18:44:22 -0800 (PST)
Date:   Sun,  5 Nov 2023 18:44:01 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-3-almasrymina@google.com>
Subject: [RFC PATCH v3 02/12] net: page_pool: create hooks for custom page providers
From:   Mina Almasry <almasrymina@google.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Cc:     Mina Almasry <almasrymina@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

The page providers which try to reuse the same pages will
need to hold onto the ref, even if page gets released from
the pool - as in releasing the page from the pp just transfers
the "ownership" reference from pp to the provider, and provider
will wait for other references to be gone before feeding this
page back into the pool.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>


---

This is implemented by Jakub in his RFC:
https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com/T/

I take no credit for the idea or implementation; I only added minor
edits to make this workable with device memory TCP, and removed some
hacky test code. This is a critical dependency of device memory TCP
and thus I'm pulling it into this series to make it revewable and
mergable.

---
 include/net/page_pool/types.h | 18 +++++++++++++
 net/core/page_pool.c          | 51 +++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 6fc5134095ed..d4bea053bb7e 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -60,6 +60,8 @@ struct page_pool_params {
 	int		nid;
 	struct device	*dev;
 	struct napi_struct *napi;
+	u8		memory_provider;
+	void            *mp_priv;
 	enum dma_data_direction dma_dir;
 	unsigned int	max_len;
 	unsigned int	offset;
@@ -118,6 +120,19 @@ struct page_pool_stats {
 };
 #endif
 
+struct mem_provider;
+
+enum pp_memory_provider_type {
+	__PP_MP_NONE, /* Use system allocator directly */
+};
+
+struct pp_memory_provider_ops {
+	int (*init)(struct page_pool *pool);
+	void (*destroy)(struct page_pool *pool);
+	struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
+	bool (*release_page)(struct page_pool *pool, struct page *page);
+};
+
 struct page_pool {
 	struct page_pool_params p;
 
@@ -165,6 +180,9 @@ struct page_pool {
 	 */
 	struct ptr_ring ring;
 
+	const struct pp_memory_provider_ops *mp_ops;
+	void *mp_priv;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 578b6f2eeb46..7ea1f4682479 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -23,6 +23,8 @@
 
 #include <trace/events/page_pool.h>
 
+static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -172,6 +174,7 @@ static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	memcpy(&pool->p, params, sizeof(pool->p));
 
@@ -225,10 +228,34 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
+	switch (pool->p.memory_provider) {
+	case __PP_MP_NONE:
+		break;
+	default:
+		err = -EINVAL;
+		goto free_ptr_ring;
+	}
+
+	pool->mp_priv = pool->p.mp_priv;
+	if (pool->mp_ops) {
+		err = pool->mp_ops->init(pool);
+		if (err) {
+			pr_warn("%s() mem-provider init failed %d\n",
+				__func__, err);
+			goto free_ptr_ring;
+		}
+
+		static_branch_inc(&page_pool_mem_providers);
+	}
+
 	if (pool->p.flags & PP_FLAG_DMA_MAP)
 		get_device(pool->p.dev);
 
 	return 0;
+
+free_ptr_ring:
+	ptr_ring_cleanup(&pool->ring, NULL);
+	return err;
 }
 
 /**
@@ -490,7 +517,10 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 		return page;
 
 	/* Slow-path: cache empty, do real allocation */
-	page = __page_pool_alloc_pages_slow(pool, gfp);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		page = pool->mp_ops->alloc_pages(pool, gfp);
+	else
+		page = __page_pool_alloc_pages_slow(pool, gfp);
 	return page;
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
@@ -542,10 +572,13 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
 void page_pool_return_page(struct page_pool *pool, struct page *page)
 {
 	int count;
+	bool put;
 
-	__page_pool_release_page_dma(pool, page);
-
-	page_pool_clear_pp_info(page);
+	put = true;
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		put = pool->mp_ops->release_page(pool, page);
+	else
+		__page_pool_release_page_dma(pool, page);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
@@ -553,7 +586,10 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
 	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
 	trace_page_pool_state_release(pool, page, count);
 
-	put_page(page);
+	if (put) {
+		page_pool_clear_pp_info(page);
+		put_page(page);
+	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
 	 * __page_cache_release() call).
@@ -821,6 +857,11 @@ static void __page_pool_destroy(struct page_pool *pool)
 	if (pool->disconnect)
 		pool->disconnect(pool);
 
+	if (pool->mp_ops) {
+		pool->mp_ops->destroy(pool);
+		static_branch_dec(&page_pool_mem_providers);
+	}
+
 	ptr_ring_cleanup(&pool->ring, NULL);
 
 	if (pool->p.flags & PP_FLAG_DMA_MAP)
-- 
2.42.0.869.gea05f2083d-goog

