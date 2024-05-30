Return-Path: <linux-arch+bounces-4620-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C68D5366
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2024 22:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CF12838E8
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2024 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4025A18628A;
	Thu, 30 May 2024 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wmWVCbnc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68720176226
	for <linux-arch@vger.kernel.org>; Thu, 30 May 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100205; cv=none; b=lMG0tqXnnC+4Xj1ddqKOejHpV/fvCAah9iYwXkRluohNnIhvsAaFuZJ5SsGlDCIKrFQgVxk4AnCZH3vHOLgd9qMlx7IBTgkU+FCyfJKcBNe0XKN92EBJ2vjr4MKSAxOpxMpqZT96aPADlqrmVj/bdR1WkkUsHEWRveQ2DeSW5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100205; c=relaxed/simple;
	bh=XUjFWGj6/WpAaFwycBfCrOCU9DlTes4t/F71EMkAvys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JVNEsoVfWnra92xCYbJxqU67jEV8oFSVSHTmi+NclYCen4IkUvpw/zodVCkjKIBgFRsB3mDoBxjuStEW/Fcbu5TJ9M1i700iV4KiiX1bxLn4cl+izQKo20qk5KEZjFaMF+mJsDwLLMpn45bqwt4pAV+rKKdz7qdNx9as/W0cvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wmWVCbnc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-629f8a92145so5093877b3.0
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2024 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717100194; x=1717704994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pHjSd+aIqRhv+ONO+ERZ6+Qj/zRJj03ekyM6mSPMSw=;
        b=wmWVCbncaCu6slFi8FMRu6CSf7OjTc3ooIJ6u4JTGz4uuB/5XYNqSY6kpiX8l+cv/a
         RS2YjRfGNDbTLe9RRtUCiqHDjyWFJFUOawr1MUergdAODIT43nGChItokZ8q50Jk6/Bc
         g37L5yJ+N/471zX6HSFi6EPPZZs+5rYS53yT0Uzo9kkSsDuoFEGRQVEDXSCceu4hUhpX
         qtmdfmxzzkXtIKxy4usn1YBEJ5T38MJlAUtAEB9OgYOrw2o9K3XwYhPfDs6DjcJhg/qy
         UHcWIB/w+OsfyMnFJxebDJ5OPdN02j1FqS9s9IbJPNejdtqzMo3m+4u0yKZ8QgDMaDQY
         ejcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717100194; x=1717704994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pHjSd+aIqRhv+ONO+ERZ6+Qj/zRJj03ekyM6mSPMSw=;
        b=mBPrBdI3jYqQQ6bUy+pLNSJOdKp7bn3LLIb4CdbBs4q0zEUD5BBC1ipzjNzxd8A/SE
         YJaKJ35GkYmW09CZ8hqCm6p+ByckXSI6FSL8bvtkL6i0GWcjrq9VARVt228FJDlhBeKT
         L6MiwM4wcyS9ncDoudf3fPZBBo5WSjLxdg95qzu+FjE5DtolU0AcCI+e/ov2Uz/dOMC4
         g0hcOPSKV5Vhds5g8WzxCf9GziAL/R0+VX9XBwgirddHksjyxDp/4MiwNFWFCmNGejxm
         3mxrdq8eTIrkDCVVWXJdsUb0uCHcRA5K/yU2BxUyrb0puJieY8Axh2C2cT/QjsSLV/eT
         Ry8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbCR4wKXDK+8nm9ULPhbTuga9CFuXCR3ApOUfbDSaO0m4c64Sv7hN88Ua6FPyV9pYBiRZrD6HvJxdm9i8Cm5uJJkXW6cvHvTf4FA==
X-Gm-Message-State: AOJu0YzdjCj0UOawxjv/n1w1pj8FZl7MXN5rj2EZVBX1YUGZyNbD8UfF
	0X0xzVsEABYxciXlTf0w/71p3haMVZCVmtIMqvOLzJKK0NE6bBFPXusdqLGhBnoBufRSn9/dhib
	ONnufabne5td9KAe8f4ug4w==
X-Google-Smtp-Source: AGHT+IGF2g6dxEX+gxT34hXKpp4EetOLAozp6L7SZwUKbjyW2NHWygGsIen9fVtJ1Yl28C4lRpzFPm38Ju/2eQQdZg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:fd2:b0:627:7563:95b1 with
 SMTP id 00721157ae682-62c6bce7d09mr9510237b3.5.1717100193783; Thu, 30 May
 2024 13:16:33 -0700 (PDT)
Date: Thu, 30 May 2024 20:16:07 +0000
In-Reply-To: <20240530201616.1316526-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240530201616.1316526-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240530201616.1316526-9-almasrymina@google.com>
Subject: [PATCH net-next v10 08/14] memory-provider: dmabuf devmem memory provider
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
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
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
index 35ad237fdf29e..7c28d6fac6242 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -100,6 +100,21 @@ static inline struct page *netmem_to_page(netmem_ref netmem)
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
index 1770c7be24afc..731f2d1e1ee10 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -477,4 +477,26 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
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
index edc3066e1ea56..87a7799460267 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -142,6 +142,8 @@ struct pp_memory_provider_params {
 	void *mp_priv;
 };
 
+extern const struct memory_provider_ops dmabuf_devmem_ops;
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index fe9865699abb1..e591449a3cf1b 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -163,6 +163,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	 * the driver may read this config while it's creating its * rx-queues.
 	 * WRITE_ONCE() here to match the READ_ONCE() in the driver.
 	 */
+	WRITE_ONCE(rxq->mp_params.mp_ops, &dmabuf_devmem_ops);
 	WRITE_ONCE(rxq->mp_params.mp_priv, binding);
 
 	err = netdev_rx_queue_restart(dev, rxq_idx);
@@ -298,4 +299,86 @@ int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	dma_buf_put(dmabuf);
 	return err;
 }
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
+	if (!pool->dma_map)
+		return -EOPNOTSUPP;
+
+	if (pool->dma_sync)
+		return -EOPNOTSUPP;
+
+	if (pool->p.order != 0)
+		return -E2BIG;
+
+	net_devmem_dmabuf_binding_get(binding);
+	return 0;
+}
+
+static netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool,
+						 gfp_t gfp)
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
+	dma_addr = net_devmem_get_dma_addr(niov);
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
+	.alloc_netmems		= mp_dmabuf_devmem_alloc_netmems,
+	.release_page		= mp_dmabuf_devmem_release_page,
+};
+EXPORT_SYMBOL(dmabuf_devmem_ops);
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index fa2a1f7ba0067..b625791a0fe77 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -13,6 +13,7 @@
 
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
+#include <net/netdev_rx_queue.h>
 
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -21,12 +22,15 @@
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
@@ -187,7 +191,9 @@ static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params,
 			  int cpuid)
 {
+	const struct memory_provider_ops *mp_ops = NULL;
 	unsigned int ring_qsize = 1024; /* Default */
+	void *mp_priv = NULL;
 	int err;
 
 	page_pool_struct_check();
@@ -270,6 +276,16 @@ static int page_pool_init(struct page_pool *pool,
 	if (pool->dma_map)
 		get_device(pool->p.dev);
 
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
@@ -469,28 +485,6 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
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
2.45.1.288.g0e0cd299f1-goog


