Return-Path: <linux-arch+bounces-3369-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198868960FA
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 02:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43FE28AF70
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 00:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2CA47F73;
	Wed,  3 Apr 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xotEaH53"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979144384
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103686; cv=none; b=M/Fdi1fmrQX9FjHN43/hJGors1Dq+36l5vpjfQDnzhx75EVFkXTUca5yxQB6KL0Y1rVyMsQScrxT7yYF2CBe5ALsChusNlNVNlgCfiBTgMddOnnKZ5WNFIutUDkwMyq04MdD+9LIfUhGbmvfZEQz/6URQHyo8UQW5VHzT8azNwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103686; c=relaxed/simple;
	bh=iAZIdAeyk5KwfVZtSv+YxVpZp+Xhv/VXPbGJraPxX48=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TGV47Gc8rP57OkWAd7VhSprxJ22riXCyCuFATqkvmWgucvRRNohuIw8uSBNINMJn7YAji4I9vXHEw8SlZaLTSzVRNdEj7XBkQbk8QQ5Hy+p3OgcWn4lvt+NU+cxoz7jlm8GsKin2RNh1SZnBIy+ZgDS+fcyT/zaCtasVKy68EXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xotEaH53; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-614245201b6so84546587b3.2
        for <linux-arch@vger.kernel.org>; Tue, 02 Apr 2024 17:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712103681; x=1712708481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KDnK9042R37xuDgfAU4H+c5h2ZT59o2lkrQnd2iy6g=;
        b=xotEaH53QTfWxRznRvO0S/CN8+H3wU7nXkN7Er+siZofxgvYbUpNV3UjrTOoNN9zPt
         J4nNG0HWlqAiMbikZ+tCJg8/a4bFoFuK4FeolEskqAkgljB+NV3hxaDLZZ/SxK0V0PwC
         6sDHC5vtP1lE78NhH5/JNyHAVTQCmZqDhyhLW/SQOIsG3pVTRdVMx+mlLihGJAkKYX+Z
         S0BdSp1Z2xEvuls9BR0We98XFT5bAbf8j21Q7i5YWlbj6DltuiDPEgHtLVWHKtTHyvqO
         35eyF4AnZUenvrRmdEjiSLGh/fIaoVxNjkiP9LQlfrStXZ6xMj/51Zy9hBiC1IQuJgWU
         rlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712103681; x=1712708481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KDnK9042R37xuDgfAU4H+c5h2ZT59o2lkrQnd2iy6g=;
        b=doT8Nvg+eCPInUbeNu5yRSZv03y9kbicddezXbj1EF5f1F4xQ7aVUoT4hmDkDDbx6A
         c6a5FfyqJMo4GdYi2eH7mnWg/x51ZHxPhVorQkOlQHLVnSQm0lw6xDlmpq8bo7yFChxv
         XHz3cbreLkFHregfqIRRDv4M6YMZkkpVZPmJ8ggpWDTXXNlcNc9zVFvKhne6bOB7Xf5n
         Up9XRJT8PXhasaYzisD9d91Ie2j2wWTAmietv85M11JeR/mdqgZEiIniTmoKzh2/95eH
         4PGTgaDPZpfRBCI46OuJZrEC2gLhPq93b3c0NfRUyDJ3viH27cHN7RelC/Vl9oorl4Qk
         ZNCA==
X-Forwarded-Encrypted: i=1; AJvYcCXK+EVlp88Hil5RsDUcCca0aLAaI8+uo2XltsBHTGOeFFqocL9SCz+nogwzdyswSFN2IJrHc/Fld2eRPUj0rWiNJmcvhbhjjeBBOw==
X-Gm-Message-State: AOJu0Yxj30RNVUcGvq08zOdrgEZB+aTxPagtzlL9zyxqto0CACDpR2Or
	j8G0AWqvqHKWuzEfa21E0vhxeqh0K7oyUKaUw1NyeT7uEJRiXNGWbd2BgrmzmHDP7GFnXDZKaBE
	T+GMBVRgeytJ2ybOy3XYNCA==
X-Google-Smtp-Source: AGHT+IHN8yJOVsi5NXIjvSglg6U+7Y+83OiCU0kqsPUb0GPHWCkldQNi8HaY3qs+17XWK31NaciRG6QIpTDdXKPAFg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:ec7:b0:615:5090:7722 with
 SMTP id cs7-20020a05690c0ec700b0061550907722mr279427ywb.6.1712103680766; Tue,
 02 Apr 2024 17:21:20 -0700 (PDT)
Date: Tue,  2 Apr 2024 17:20:45 -0700
In-Reply-To: <20240403002053.2376017-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403002053.2376017-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403002053.2376017-9-almasrymina@google.com>
Subject: [RFC PATCH net-next v8 08/14] memory-provider: dmabuf devmem memory provider
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
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Florian Westphal <fw@strlen.de>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Aleksander Lobakin <aleksander.lobakin@intel.com>, Michael Lass <bevan@bi-co.net>, 
	Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement a memory provider that allocates dmabuf devmem in the form of
net_iov.

The provider receives a reference to the struct netdev_dmabuf_binding
via the pool->mp_priv pointer. The driver needs to set this pointer for
the provider in the net_iov.

The provider obtains a reference on the netdev_dmabuf_binding which
guarantees the binding and the underlying mapping remains alive until
the provider is destroyed.

Usage of PP_FLAG_DMA_MAP is required for this memory provide such that
the page_pool can provide the driver with the dma-addrs of the devmem.

Support for PP_FLAG_DMA_SYNC_DEV is omitted for simplicity & p.order !=
0.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v8:
- Use skb_frag_size instead of frag->bv_len to fix patch-by-patch build
  error

v6:
- refactor new memory provider functions into net/core/devmem.c (Pavel)

v2:
- Disable devmem for p.order != 0

v1:
- static_branch check in page_is_page_pool_iov() (Willem & Paolo).
- PP_DEVMEM -> PP_IOV (David).
- Require PP_FLAG_DMA_MAP (Jakub).

---
 include/net/netmem.h            | 15 ++++++
 include/net/page_pool/helpers.h | 22 +++++++++
 include/net/page_pool/types.h   |  2 +
 net/core/devmem.c               | 83 +++++++++++++++++++++++++++++++++
 net/core/page_pool.c            | 38 +++++++--------
 5 files changed, 138 insertions(+), 22 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 74eeaa34883e..34aa1c80c1ca 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -126,6 +126,21 @@ static inline struct page *netmem_to_page(netmem_ref netmem)
 	return (__force struct page *)netmem;
 }
 
+static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return (struct net_iov *)((__force unsigned long)netmem &
+					  ~NET_IOV);
+
+	DEBUG_NET_WARN_ON_ONCE(true);
+	return NULL;
+}
+
+static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
+{
+	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
+}
+
 static inline netmem_ref page_to_netmem(struct page *page)
 {
 	return (__force netmem_ref)page;
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index c6a55eddefae..eb736506c3ce 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -453,4 +453,26 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+static inline void page_pool_set_pp_info(struct page_pool *pool,
+					 netmem_ref netmem)
+{
+	netmem_set_pp(netmem, pool);
+	netmem_or_pp_magic(netmem, PP_SIGNATURE);
+
+	/* Ensuring all pages have been split into one fragment initially:
+	 * page_pool_set_pp_info() is only called once for every page when it
+	 * is allocated from the page allocator and page_pool_fragment_page()
+	 * is dirtying the same cache line as the page->pp_magic above, so
+	 * the overhead is negligible.
+	 */
+	page_pool_fragment_netmem(netmem, 1);
+	if (pool->has_init_callback)
+		pool->slow.init_callback(netmem, pool->slow.init_arg);
+}
+
+static inline void page_pool_clear_pp_info(netmem_ref netmem)
+{
+	netmem_clear_pp_magic(netmem);
+	netmem_set_pp(netmem, NULL);
+}
 #endif /* _NET_PAGE_POOL_HELPERS_H */
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index f04af1613f59..5b58c9e185a4 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -141,6 +141,8 @@ struct pp_memory_provider_params {
 	void *mp_priv;
 };
 
+extern const struct memory_provider_ops dmabuf_devmem_ops;
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index c25ede5f6fb9..01337de7d6a4 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -204,6 +204,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	 * the driver may read this config while it's creating its * rx-queues.
 	 * WRITE_ONCE() here to match the READ_ONCE() in the driver.
 	 */
+	WRITE_ONCE(rxq->mp_params.mp_ops, &dmabuf_devmem_ops);
 	WRITE_ONCE(rxq->mp_params.mp_priv, binding);
 
 	err = net_devmem_restart_rx_queue(dev, rxq_idx);
@@ -340,3 +341,85 @@ int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	return err;
 }
 #endif
+
+/*** "Dmabuf devmem memory provider" ***/
+
+static int mp_dmabuf_devmem_init(struct page_pool *pool)
+{
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+
+	if (!binding)
+		return -EINVAL;
+
+	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
+		return -EOPNOTSUPP;
+
+	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		return -EOPNOTSUPP;
+
+	if (pool->p.order != 0)
+		return -E2BIG;
+
+	net_devmem_dmabuf_binding_get(binding);
+	return 0;
+}
+
+static netmem_ref mp_dmabuf_devmem_alloc_pages(struct page_pool *pool,
+					       gfp_t gfp)
+{
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+	netmem_ref netmem;
+	struct net_iov *niov;
+	dma_addr_t dma_addr;
+
+	niov = net_devmem_alloc_dmabuf(binding);
+	if (!niov)
+		return 0;
+
+	dma_addr = net_iov_dma_addr(niov);
+
+	netmem = net_iov_to_netmem(niov);
+
+	page_pool_set_pp_info(pool, netmem);
+
+	if (page_pool_set_dma_addr_netmem(netmem, dma_addr))
+		goto err_free;
+
+	pool->pages_state_hold_cnt++;
+	trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt);
+	return netmem;
+
+err_free:
+	net_devmem_free_dmabuf(niov);
+	return 0;
+}
+
+static void mp_dmabuf_devmem_destroy(struct page_pool *pool)
+{
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+
+	net_devmem_dmabuf_binding_put(binding);
+}
+
+static bool mp_dmabuf_devmem_release_page(struct page_pool *pool,
+					  netmem_ref netmem)
+{
+	WARN_ON_ONCE(!netmem_is_net_iov(netmem));
+	WARN_ON_ONCE(atomic_long_read(netmem_get_pp_ref_count_ref(netmem)) !=
+		     1);
+
+	page_pool_clear_pp_info(netmem);
+
+	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
+
+	/* We don't want the page pool put_page()ing our net_iovs. */
+	return false;
+}
+
+const struct memory_provider_ops dmabuf_devmem_ops = {
+	.init			= mp_dmabuf_devmem_init,
+	.destroy		= mp_dmabuf_devmem_destroy,
+	.alloc_pages		= mp_dmabuf_devmem_alloc_pages,
+	.release_page		= mp_dmabuf_devmem_release_page,
+};
+EXPORT_SYMBOL(dmabuf_devmem_ops);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index c7bffd08218b..a0544b680e8a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -12,6 +12,7 @@
 
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
+#include <net/netdev_rx_queue.h>
 
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -20,12 +21,15 @@
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/genalloc.h>
+#include <net/devmem.h>
 
 #include <trace/events/page_pool.h>
 
 #include "page_pool_priv.h"
 
 DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+EXPORT_SYMBOL(page_pool_mem_providers);
 
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
@@ -178,7 +182,9 @@ static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params,
 			  int cpuid)
 {
+	const struct memory_provider_ops *mp_ops = NULL;
 	unsigned int ring_qsize = 1024; /* Default */
+	void *mp_priv = NULL;
 	int err;
 
 	memcpy(&pool->p, &params->fast, sizeof(pool->p));
@@ -251,6 +257,16 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
+	if (pool->p.queue) {
+		mp_ops = READ_ONCE(pool->p.queue->mp_params.mp_ops);
+		mp_priv = READ_ONCE(pool->p.queue->mp_params.mp_priv);
+	}
+
+	if (mp_ops && mp_priv) {
+		pool->mp_ops = mp_ops;
+		pool->mp_priv = mp_priv;
+	}
+
 	if (pool->mp_ops) {
 		err = pool->mp_ops->init(pool);
 		if (err) {
@@ -444,28 +460,6 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	return false;
 }
 
-static void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
-{
-	netmem_set_pp(netmem, pool);
-	netmem_or_pp_magic(netmem, PP_SIGNATURE);
-
-	/* Ensuring all pages have been split into one fragment initially:
-	 * page_pool_set_pp_info() is only called once for every page when it
-	 * is allocated from the page allocator and page_pool_fragment_page()
-	 * is dirtying the same cache line as the page->pp_magic above, so
-	 * the overhead is negligible.
-	 */
-	page_pool_fragment_netmem(netmem, 1);
-	if (pool->has_init_callback)
-		pool->slow.init_callback(netmem, pool->slow.init_arg);
-}
-
-static void page_pool_clear_pp_info(netmem_ref netmem)
-{
-	netmem_clear_pp_magic(netmem);
-	netmem_set_pp(netmem, NULL);
-}
-
 static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 						 gfp_t gfp)
 {
-- 
2.44.0.478.gd926399ef9-goog


