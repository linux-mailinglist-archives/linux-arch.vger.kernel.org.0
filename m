Return-Path: <linux-arch+bounces-4614-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1590A8D530C
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2024 22:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEA92819F4
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2024 20:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03861158D7F;
	Thu, 30 May 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7QPoA+v"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EE158A1E
	for <linux-arch@vger.kernel.org>; Thu, 30 May 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100186; cv=none; b=hJ7ckUBLaxSGN8xtlIPLOZ46LBKUtnlGgqHqicd93IphxpB23yDffV6fdX4oapu5X6vFkHePA/EFXzAekQnpMkRRXZi7qUsOzk8ilUtqNu0frwEL9v+8WqEdzGeLOPmuh5fm3DoBWEOkJYvo71TJeTUH/RO0AlfRpBjsjW9gz0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100186; c=relaxed/simple;
	bh=aBnYje6A82XaEKFyLV9gCbV9fgLuPXwNN+l/HwJvBXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5ph64jAIUpt/4fxz3LxjhIjHwl5AfmDLPp41CgnO8j+DOacOrOJQZSZF1N/irrrrkEH0N7HTKlizevjS2TtS96OqDF783/368k/k0oOoAO1VOSXxKgFJ4NOns/7pS5YNI5pplyDXScYAWzWW6JIfSy6Qb+uoBcIs0wz7ibYwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7QPoA+v; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-629f8a92145so5090547b3.0
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2024 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717100183; x=1717704983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EPevCT7/2IjjDXAWaiob99tAoIzY7exVAkr0lb7mAI=;
        b=A7QPoA+vWRgks12DbQcyyuCzLN3AdkvhIKcn2khvdMl+oNMIDXkWEet9lYrpi1Q/Jz
         bF3n1YnPASjfwoevU+4b/rzxB2yPMEW3pPXakBHexyiYswIcYMhsVQN8VkAn5MN1ngfG
         hecKLjyzCt6Vw8rgbgUqDwOkrvPmqd0nTi+GuU+tHApc0VgjhNfJxiJqIjW8cixs8caM
         bepHo1p4BLiSYqWXYC0QqFge2ApRXt3+99xoPRArxDlw36vWrcuPFVG4DYfV8wpY7Zlx
         2iF3tUlX24Ju1paSp38Mwuh2zrjsWDY1IU34GX9ahBtcxAle+xJqrExJKFzM5DNMsFgE
         ZWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717100183; x=1717704983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EPevCT7/2IjjDXAWaiob99tAoIzY7exVAkr0lb7mAI=;
        b=OyNWl7bXV+gTs/vZxAhR8A2U6iMD9ZFVqNFp2+P5hwT0LT/1CEsmmv25zaMM9bpH3o
         Hwbb2HMVb0hO/eFaJTe6yWmLO9x9fsMYKbGlyBziwXuTzPNVd+AXB0xRWgVm59NG/wQl
         oonMRf9u1cpJOrhRgsa9xtgIR0jajHkfyVA5+paEFKbmYiUzFPrmutOHv446c1WMeDUK
         RMNvs1gyvVZlE87lCT9M6DTva/6IQt9U2bb3hHcckMSo3kFLAzU/RpH83jMmaQegWPhf
         LE4JTkkPT79uK1lJclNaElcTTUfk+ix/xIFp0W57rZJIrmevFRKBZHKBXOmt8oywxBlM
         Nvwg==
X-Forwarded-Encrypted: i=1; AJvYcCXMW7E6dgu18DA9bdaS4cxji1H1jLMqXSzUGzsDqPEkgHZV3b8Tw+bcdOO+qNQodxAPx1N652CO68uVRkCNiFhvuVPExz4QUh49Cw==
X-Gm-Message-State: AOJu0YyS1UHs5Km0uweWoxixUIV+PpAiU9wTevwWXFcjjfsDohaykpz/
	QwQDBJt2z2vbMYX/tFJGlzO7XmqnJRnsGI9R2a72azgzybyryMebfbNLsfWDCW61SqNz3cUlSxs
	zZiTdQDBGdpcXxqRo9mX0FQ==
X-Google-Smtp-Source: AGHT+IEzZ69JqoW6GJOeqts3Sq7g6h07tqQC0w1VVoiY60y4YSnBAwIT5aGEAkdPhLJOkoxRCW8vNj1B6RaErZFLlg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:e:b0:62a:415b:a137 with SMTP
 id 00721157ae682-62c6bc22eecmr8577877b3.1.1717100182928; Thu, 30 May 2024
 13:16:22 -0700 (PDT)
Date: Thu, 30 May 2024 20:16:01 +0000
In-Reply-To: <20240530201616.1316526-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240530201616.1316526-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240530201616.1316526-3-almasrymina@google.com>
Subject: [PATCH net-next v10 02/14] net: page_pool: create hooks for custom
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
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
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

I'm unsure if the discussion has been resolved yet. Sending the series
anyway to get reviews/feedback on the (unrelated) rest of the series.

Cc: Christoph Hellwig <hch@infradead.org>

v10:
- Renamed alloc_pages -> alloc_netmems. alloc_pages is now
  a preprocessor macro, and reusing the string results in a build error.

RFC v3 -> v1
- Removed unusued mem_provider. (Yunsheng).
- Replaced memory_provider & mp_priv with netdev_rx_queue (Jakub).

---
 include/net/page_pool/types.h | 12 ++++++++++
 net/core/page_pool.c          | 43 +++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index b088d131aeb0d..b038b838f042f 100644
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
@@ -64,6 +65,7 @@ struct page_pool_params {
 		int		nid;
 		struct device	*dev;
 		struct napi_struct *napi;
+		struct netdev_rx_queue *queue;
 		enum dma_data_direction dma_dir;
 		unsigned int	max_len;
 		unsigned int	offset;
@@ -127,6 +129,13 @@ struct page_pool_stats {
 };
 #endif
 
+struct memory_provider_ops {
+	int (*init)(struct page_pool *pool);
+	void (*destroy)(struct page_pool *pool);
+	struct page *(*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
+	bool (*release_page)(struct page_pool *pool, struct page *page);
+};
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
@@ -193,6 +202,9 @@ struct page_pool {
 	 */
 	struct ptr_ring ring;
 
+	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f4444b4e39e63..251c9356c9202 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -26,6 +26,8 @@
 
 #include "page_pool_priv.h"
 
+static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -186,6 +188,7 @@ static int page_pool_init(struct page_pool *pool,
 			  int cpuid)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	page_pool_struct_check();
 
@@ -267,7 +270,22 @@ static int page_pool_init(struct page_pool *pool,
 	if (pool->dma_map)
 		get_device(pool->p.dev);
 
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
 	return 0;
+
+free_ptr_ring:
+	ptr_ring_cleanup(&pool->ring, NULL);
+	return err;
 }
 
 static void page_pool_uninit(struct page_pool *pool)
@@ -569,7 +587,10 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 		return page;
 
 	/* Slow-path: cache empty, do real allocation */
-	page = __page_pool_alloc_pages_slow(pool, gfp);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		page = pool->mp_ops->alloc_netmems(pool, gfp);
+	else
+		page = __page_pool_alloc_pages_slow(pool, gfp);
 	return page;
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
@@ -627,10 +648,13 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
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
@@ -638,7 +662,10 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
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
@@ -937,6 +964,12 @@ static void __page_pool_destroy(struct page_pool *pool)
 
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
2.45.1.288.g0e0cd299f1-goog


