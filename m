Return-Path: <linux-arch+bounces-762-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9588097CE
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 01:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E25F1C20C94
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 00:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192E11FB3;
	Fri,  8 Dec 2023 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04ViboTO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6751734
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 16:52:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d6b751dabcso15621857b3.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 16:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996779; x=1702601579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=igrDQ25kHpMvPF+Js5oOYPKq9BDscOjehO2W0ZO2Cow=;
        b=04ViboTOIUXyfwWbPzlEoZFF/dh03VXifu1JKxfqaSlKwEQiqXKJd4X8DHJrmkY2aL
         97OtIgxuK3IVGuc49JAKnJVUG/knMMvGrPdklyJPCHl03IC35fZ9Wp4QvjLKs6Q/ukkK
         7mMiLBwxGap9Pn5d/nedz+9YoYMlPvtgW6VmozGDNGBMMl1c/wW5m6DXQKIlVW2F+V4I
         K762D9kq+Wc0lPmU65Tt9pcEJXRpWJ181whoaXiw5AfB+NDam3uzB1a4nkznRdZ9PN/T
         OhhJKt1tQS2y8sqNIxWHXVWRUrv4JigxPx6ACvC4ccLeUpe3ndg7DksWqd0TcJDw43ey
         53FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996779; x=1702601579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igrDQ25kHpMvPF+Js5oOYPKq9BDscOjehO2W0ZO2Cow=;
        b=MfC8ap4jHsMF42GsB2AUy7SGws+2DSQlmtR0panuMHBu3xv/LBu5GZp1uWir2hYzEp
         TNB7MBrUuX9ggkh6orszkiTG+QLN+JZDWXEQNcgoW5UA3UhXIMwmAfdQ29jHXPXajRLa
         W1OylihFUWGxyP+vm1bhIGaQJM0G5ReqUt3WygaiLpmBIwlKcQuEC3dUG2jvRsOudUoc
         ZHq/6twnJv5THUmdIq1Ml59GP42zfJlJcPdHwwfTLa9YwD8p6TXx4aX/tryKVI+f7fj2
         RJDnkIG1LVBuTcit5QrcfBKS6QWZNFyxEbZYiJbsXxrZysSRmWlL0eoEIACtI/8s/pwD
         gE3g==
X-Gm-Message-State: AOJu0YybmiH6Q9j5zkxk9RCOLRRVwr4fgS6zbySGtm0CsMfdho0kAoUL
	/U3jM3Y3PAsf2seo/Vi0XQOXvbQReHdkwlKeYw==
X-Google-Smtp-Source: AGHT+IEMerd8kG6TBFoJlyaslab8zvjY5F48zAWx9TZDbWRCemESCUxSY0OIOYo+khnUBC/+wrmkFKlHBIMlI6PczA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:2893:b0:5d3:b449:e58e with
 SMTP id ee19-20020a05690c289300b005d3b449e58emr47985ywb.6.1701996778990; Thu,
 07 Dec 2023 16:52:58 -0800 (PST)
Date: Thu,  7 Dec 2023 16:52:33 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-3-almasrymina@google.com>
Subject: [net-next v1 02/16] net: page_pool: create hooks for custom page providers
From: Mina Almasry <almasrymina@google.com>
To: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

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

RFC v3 -> v1
- Removed unusued mem_provider. (Yunsheng).
- Replaced memory_provider & mp_priv with netdev_rx_queue (Jakub).

---
 include/net/page_pool/types.h | 12 ++++++++++
 net/core/page_pool.c          | 43 +++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ac286ea8ce2d..0e9fa79a5ef1 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -51,6 +51,7 @@ struct pp_alloc_cache {
  * @dev:	device, for DMA pre-mapping purposes
  * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
  * @napi:	NAPI which is the sole consumer of pages, otherwise NULL
+ * @queue:	struct netdev_rx_queue this page_pool is being created for.
  * @dma_dir:	DMA mapping direction
  * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
  * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
@@ -63,6 +64,7 @@ struct page_pool_params {
 		int		nid;
 		struct device	*dev;
 		struct napi_struct *napi;
+		struct netdev_rx_queue *queue;
 		enum dma_data_direction dma_dir;
 		unsigned int	max_len;
 		unsigned int	offset;
@@ -125,6 +127,13 @@ struct page_pool_stats {
 };
 #endif
 
+struct memory_provider_ops {
+	int (*init)(struct page_pool *pool);
+	void (*destroy)(struct page_pool *pool);
+	struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
+	bool (*release_page)(struct page_pool *pool, struct page *page);
+};
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
@@ -174,6 +183,9 @@ struct page_pool {
 	 */
 	struct ptr_ring ring;
 
+	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ca1b3b65c9b5..f5c84d2a4510 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -25,6 +25,8 @@
 
 #include "page_pool_priv.h"
 
+static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -174,6 +176,7 @@ static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	memcpy(&pool->p, &params->fast, sizeof(pool->p));
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
@@ -234,10 +237,25 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
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
 
 static void page_pool_uninit(struct page_pool *pool)
@@ -519,7 +537,10 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
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
@@ -576,10 +597,13 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
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
@@ -587,7 +611,10 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
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
@@ -857,6 +884,12 @@ static void __page_pool_destroy(struct page_pool *pool)
 
 	page_pool_unlist(pool);
 	page_pool_uninit(pool);
+
+	if (pool->mp_ops) {
+		pool->mp_ops->destroy(pool);
+		static_branch_dec(&page_pool_mem_providers);
+	}
+
 	kfree(pool);
 }
 
-- 
2.43.0.472.g3155946c3a-goog


