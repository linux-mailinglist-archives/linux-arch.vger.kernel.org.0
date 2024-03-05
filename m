Return-Path: <linux-arch+bounces-2790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F2D8712B8
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 03:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C18C1B23FFF
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 02:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9518639;
	Tue,  5 Mar 2024 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmeKkjC/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD0E182BD
	for <linux-arch@vger.kernel.org>; Tue,  5 Mar 2024 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604126; cv=none; b=WgmnRTNFmyUIh5eQAqiwQYKLq4hXiple5+z7lLLlYXv7/DwB79M+8CT+spVg3NtL5jTF1mE1B0Grn4rLaCSKOlLUeprfrnV9PHrW7s+NKOsJUPGBAO7yNM9sUOa9ANT4G4dOvPrpu6q3O9KG/EiHWxjkiLJ07nMeSUGSQy7xXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604126; c=relaxed/simple;
	bh=kPcvF1yAIkU4SC9auITlzhMeVIQD4E0gxQqihz8N8Fk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SlDL7wqo9dsAUseYiu5IazhWOIb8QMYPL7QQOoTRYyjeIUHBEhGhXkRMyO8k1RiYN9MlrYyDrEUKxO+nVVd93ZWegpQJTcHMbVJePuqrjpr45tyzGxebq0xupEhD47mk2vxsgiwYi5USA81AqCsTpUqPj5vloj07dImlG7ouOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmeKkjC/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608d6ffc64eso73699747b3.0
        for <linux-arch@vger.kernel.org>; Mon, 04 Mar 2024 18:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709604122; x=1710208922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOWmAeQMGWMC5aJa64Dg0AHzjb+8gPpNDHS7ziT/3ac=;
        b=gmeKkjC/zxBnWVkZCwsSw7pqWMZgdwGOi3VEVTPYLgq7YA5GF0ar4Qx5H7PKSMJC/6
         7HzA+z1BVI9oNpIB0wFEYO+D5jMVHBMUinGnOdtcfm+unNf65u01qPIY7LRi7+YMTb60
         m6K62SlyfuOdYF69cdEqwaJKVnbqgivhEFe1ErC5tcy99gy8jE+/Hg+EWw0JI7DrQdA9
         PGbgK9+YSaiX9ooaBRYf0y3aqrIMo4cv2b8XUMPcCwXfgmQmLskoPekvP1o9I7JvldCY
         bl/H5AG2Ol4gk6joZU5Up2XRc3N+nNBaO2igwxyqPjmIztLt0RrFWAiAl0BmUR6P13ia
         ONKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604122; x=1710208922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOWmAeQMGWMC5aJa64Dg0AHzjb+8gPpNDHS7ziT/3ac=;
        b=pXi263Q0tTzqHwpkYv0GYxOfpQsVo3TZ93RACtSn19xKcI7rKUchFsjlWednZj7GQV
         ng9bj4kcn/4zdS0sjiZLs2IneaJiZNr3uAeFWMCM+1uq/Wk5UT8/WxQ+soPVstTiuomt
         rZh2Jj0UhRslwpTLYxpnC8Jz4l7fjm+5Y2nuo26qcFdqE2/AGR3mWNJMbbqcE8Ynfyig
         wpJp79PTuCnJhBHqRCLw7vvQrZj5nVgOH9u+rWTEM4IWJFDjHgBEDAbpeI5yKm1xth4w
         b8yitGaVxs+jI7q/EK8duf8m/ctsOGIFg8HF1PmYwvAyt+UvTZkV8J7kh5nEvpS6e73d
         v6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+jGMXdh9FvT7Vc2ZfmXNuOkVzSMWS5y4MF81/Ww2EenPPxTcVK2zIzNQM/uYPrDDPUGlWQ/nl0Z3exmHZA++5IZWjpexlGwaJ9g==
X-Gm-Message-State: AOJu0YyJ19+mLvpQMD/lAvpIdxgg1378t9vUm/ZLr6Eg858h7sCMQdFf
	LlHin/jPN8xyC/i7SV6CtVcxwviKgqetxs/9cdCh9k8UpRU/rRTvy8K2i2ycrTTMwK784z+M7vF
	N2dtueIRvot19Nqq/Na4QXg==
X-Google-Smtp-Source: AGHT+IG6KeWQw0XbqPbYmQM0P/6OwcAsrFu5mozN13W1clztdP6zot9Fisjb9bkCfEQNwnMXpfHNCZGrzpwJASvg9w==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b614:914c:63cd:3830])
 (user=almasrymina job=sendgmr) by 2002:a81:4c93:0:b0:609:3a33:bacc with SMTP
 id z141-20020a814c93000000b006093a33baccmr264479ywa.5.1709604121833; Mon, 04
 Mar 2024 18:02:01 -0800 (PST)
Date: Mon,  4 Mar 2024 18:01:37 -0800
In-Reply-To: <20240305020153.2787423-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305020153.2787423-3-almasrymina@google.com>
Subject: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for custom
 page providers
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
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
mergeable.

RFC v3 -> v1
- Removed unusued mem_provider. (Yunsheng).
- Replaced memory_provider & mp_priv with netdev_rx_queue (Jakub).

---
 include/net/page_pool/types.h | 12 ++++++++++
 net/core/page_pool.c          | 43 +++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 5e43a08d3231..ffe5f31fb0da 100644
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
index d706fe5548df..8776fcad064a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -25,6 +25,8 @@
 
 #include "page_pool_priv.h"
 
+static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -177,6 +179,7 @@ static int page_pool_init(struct page_pool *pool,
 			  int cpuid)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	memcpy(&pool->p, &params->fast, sizeof(pool->p));
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
@@ -248,10 +251,25 @@ static int page_pool_init(struct page_pool *pool,
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
@@ -546,7 +564,10 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
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
@@ -603,10 +624,13 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
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
@@ -614,7 +638,10 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
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
@@ -884,6 +911,12 @@ static void __page_pool_destroy(struct page_pool *pool)
 
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
2.44.0.rc1.240.g4c46232300-goog


