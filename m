Return-Path: <linux-arch+bounces-4309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88838C2D0A
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 01:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F21228537E
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E4117A93D;
	Fri, 10 May 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qr8xRX5j"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66417799B
	for <linux-arch@vger.kernel.org>; Fri, 10 May 2024 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715383301; cv=none; b=SG0x+7FlnzIzaK0euXLnNqMyhRruYMbNRyF2u4RJkzV6JOj2146Xjr7XeUtoU3TRpc1fJt1hd+Dz7L+ZnvbGHq/xUcRhneSttmdHSDgO5Nvx2iH2ItSR0H5APB1hfpiC9hQ+DjdLGNbFQZyXNb6Gn3nMkTdLKqXy+Vii8pXumwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715383301; c=relaxed/simple;
	bh=zhQgIGsliaRMPODuEh9alcn3ryAERVvmq6IESbhY/AI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DFVYfTBbx+X5zYQeIVRiNgD4tsM7DNDWgv9OEUq9z1Jf6EajJxkS/IPkU4PScU37KNL4fIghghE5w0f8rQtjc2b4BZa7wDxgV56bl3Q1BJmaBkAvExPcIY3WA62yb2rqnOG8eNoSBus5uNynPSKQcn5fELPD/vW0EhpdHoZFC9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qr8xRX5j; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61d21cf3d3bso43255267b3.3
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2024 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715383297; x=1715988097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF9DcpJoLgJZU1T6Q4IRPCuOLCY+nprTpvGu9aP6Tnw=;
        b=Qr8xRX5jjqIJuQBHE4mK+ciuYzRl18RHbd0KoG5f2/jetPvi4uD9Ypvl51D6VbjtD9
         xxSeFDT5ezAdc7zxdKO0w4Ld53SsJ/3+ZNbNewqOwLEKyi2ua1auYISAl2O5e13tVZrU
         RxvKXAANgfWaTeMUjolqHYR5nYD02YUImnoPI1cq3Tib0JUN8iTh1dBO9McZ4xbaKncV
         hc3AfaDO73dYSvnLEgZG608uLiIkmnxZk/J2pU+U/xlIZqp/x7Scn51MbjN5l21KaC4q
         NHcWqkKnOU+Xwt9Kt87P7K5961MZYumrSIQmuLcjT4oUJdr/c8YzNMcwsdeZFodkR8NO
         wJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715383297; x=1715988097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF9DcpJoLgJZU1T6Q4IRPCuOLCY+nprTpvGu9aP6Tnw=;
        b=XqbhpsnxtrB/SzhmVUXrY1uZeP3S6kicmvM6knxp2t9Fz+VMU0wuOIJDVITqIBMkCy
         74HJlhEUxNlrltVQBU3Sb6BEhXSgWnALQRS9p0YEpULXH53ZLuCVFlr0wHyYPHOfY9U7
         deQ4QiZFQtrQKXk1Sa3y/Bz4UigYa1DWXU7+Aj3Su4FtZNi1Et1dY5KYxPOOcuHq4BPh
         Sf214EHwexUJ35Zikof5DCDpEL2j8tNrz367RJcfO2fGA+Ee8ZICC1h6rppU/Vlz4V4b
         OqkSRlETXQYXdo530H5vW4jr/kosGVfv7L3aksBpeTCsoIQkWcuPwss6yroi1kKeBDDw
         0edA==
X-Forwarded-Encrypted: i=1; AJvYcCUqAAkQhl0b70ktl+5g+m+sjOOvW1pi0dLesQ/gQUOEdXpG0YRS+MWRjeyTploXGa48xbQW5z5JGdRlQJS10qZRxMMF5YVeaYb6Hg==
X-Gm-Message-State: AOJu0YyFUBGveuENLjqPr/b+y3B+uoEduvpJiKW4vyfdnbP49JRN4l2w
	/MFe1qnQUqm4guTBitELfirOpH+PXD7mVPtfi0n0HZ0Mvq0zi/nQZPualBNb+sPWWlgj+Hd9bL/
	dJcM4ojJzJnAiC6POlCZh6Q==
X-Google-Smtp-Source: AGHT+IHyy1zdjYt14WuzL8ym16Mq2uHGoZIET4EFDeRi6dpgQgb7i6+tMrcwUYVLihO97jB0eo61thDqNoYgijbY8A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:3428:1b4e:e75a:d31b])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:4508:b0:61b:e1cf:44f1 with
 SMTP id 00721157ae682-622b0169688mr8577047b3.9.1715383296884; Fri, 10 May
 2024 16:21:36 -0700 (PDT)
Date: Fri, 10 May 2024 16:21:13 -0700
In-Reply-To: <20240510232128.1105145-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510232128.1105145-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510232128.1105145-3-almasrymina@google.com>
Subject: [PATCH net-next v9 02/14] net: page_pool: create hooks for custom
 page providers
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Christoph Hellwig <hch@infradead.org>
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

- This is implemented by Jakub in his RFC:
https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com/T/

I take no credit for the idea or implementation; I only added minor
edits to make this workable with device memory TCP, and removed some
hacky test code. This is a critical dependency of device memory TCP
and thus I'm pulling it into this series to make it revewable and
mergeable.

- There is a pending discussion about the acceptance of the page_pool
  memory provider hooks:

https://lore.kernel.org/netdev/20240403002053.2376017-3-almasrymina@google.com/

I'm unsure if the discussion has been resolved yet. There seems to be
agreement that the io_uring use case without dmabuf is good but unsure
about the ops. The conversation will likely continue to this iteration.

Cc: Christoph Hellwig <hch@infradead.org>

RFC v3 -> v1
- Removed unusued mem_provider. (Yunsheng).
- Replaced memory_provider & mp_priv with netdev_rx_queue (Jakub).

---
 include/net/page_pool/types.h | 12 ++++++++++
 net/core/page_pool.c          | 43 +++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index a6ebed0022160..2bf15ca6bfd48 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -52,6 +52,7 @@ struct pp_alloc_cache {
  * @dev:	device, for DMA pre-mapping purposes
  * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
  * @napi:	NAPI which is the sole consumer of pages, otherwise NULL
+ * @queue:	struct netdev_rx_queue this page_pool is being created for.
  * @dma_dir:	DMA mapping direction
  * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
  * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
@@ -64,6 +65,7 @@ struct page_pool_params {
 		int		nid;
 		struct device	*dev;
 		struct napi_struct *napi;
+		struct netdev_rx_queue *queue;
 		enum dma_data_direction dma_dir;
 		unsigned int	max_len;
 		unsigned int	offset;
@@ -126,6 +128,13 @@ struct page_pool_stats {
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
 
@@ -176,6 +185,9 @@ struct page_pool {
 	 */
 	struct ptr_ring ring;
 
+	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 8bcc7014a61a0..ae403397df09d 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -26,6 +26,8 @@
 
 #include "page_pool_priv.h"
 
+static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -178,6 +180,7 @@ static int page_pool_init(struct page_pool *pool,
 			  int cpuid)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	memcpy(&pool->p, &params->fast, sizeof(pool->p));
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
@@ -249,10 +252,25 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
+	if (pool->mp_ops) {
+		err = pool->mp_ops->init(pool);
+		if (err) {
+			pr_warn("%s() mem-provider init failed %d\n", __func__,
+				err);
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
@@ -547,7 +565,10 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
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
@@ -605,10 +626,13 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
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
@@ -616,7 +640,10 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
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
@@ -919,6 +946,12 @@ static void __page_pool_destroy(struct page_pool *pool)
 
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
2.45.0.118.g7fe29c98d7-goog


