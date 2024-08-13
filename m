Return-Path: <linux-arch+bounces-6186-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61918950EB0
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 23:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71281F22E2F
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 21:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6B21AD41F;
	Tue, 13 Aug 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4JjaAi3s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A481ABECD
	for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2024 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583620; cv=none; b=t0S5XCEgluW4b27HkNrUrWqkhP+mubvgDAFql/wtTRB+VQocax4GFOV+5U3ZIIqFFr+jWfYNtkL5LC4ykATzP5rp83A+KPQGiINbmA1h2xfNU3DjAQmKCGezSah3af/o7iFWVabQC4gBanoIxvJC43wr/pJWbiJSNlGlIjKkCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583620; c=relaxed/simple;
	bh=Lv1HZB33igd8WiltldIm1xuXDpwjeGzaqOAyUFtGoCA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N5a62Xxdd5jl47BjMc7BOlWwgKF+FY5yDKZJXD8PAEbjAaWGH9YJdxKN+j5XYtOXX3Hav699RimmnxPSsesfNWewda3dtQ/BZxQ+lnDKe6g0MgYnFitu0fuPOsvUwGG/LlScPeXyEu9U/Ud8c5MHj6n4S9svqbzp5QAjCACHhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4JjaAi3s; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so9659379276.0
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2024 14:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723583611; x=1724188411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0mCJL3RbqwHfQUta3bwCmTM+iKiOkWhDVwTWUwq4Rzo=;
        b=4JjaAi3srlBxP4j+WwYDNdcYxD3bfaAugf0SPFfLSnMO19+e9eeFUTEKwZ8EOujDAE
         HaLh9jlwjEqrCgAbo6DlFEtlEQZRDAJh4H0bYSgNh7sqdyNY/CpC1b6vzylOfqHU4aJn
         wpRRZ1rdj17KDuA77matJj7RrwLYUoL9DbFqbntzp3c58Oh6yqthgudXelmrjn+0jECD
         l0tc3UHgM2ChzppAFZEIHc2oUgSQhm8cLtJ8etHBIo3HbmKuIrhRODzo4UnBV+3ZD2Qc
         sz2rLVRjt+o8CQQWnD1PbZyFZIRYPKCBKCyapPPqm8DBa5ODkkSYCBicD2WXRxYkOsn5
         fnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723583611; x=1724188411;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mCJL3RbqwHfQUta3bwCmTM+iKiOkWhDVwTWUwq4Rzo=;
        b=wkKT7iCmpYWka8yuU0E7zaPwE5ycq92nShbbXKLVSK9YcGaR/7HhloJVAT7o51d4HM
         f9nT4+5dVn9C4Ce2kPWIqwtQU9FFqAOCgPell9bZj7mdHEY0IhK/Q0LjKUPnlOe6BPGQ
         QG3PCuWMxvtYZVfDyES8rhwQyqOhtOUp5Dg3mzjmboSjAQcruarA88UtF7bQIuC9V1bM
         3G8Xaqrc5/GwuGJO0on4thu+M9LrkdTiVYE692mmgFwBpWGI6gaQzHNBmn3fqHhTo1+i
         JrgHSHSwzWiC/M9hqvQPpNe+NLxAd3A6ZjYe/cNAcjzYh59G3//kSU3ColuntFBMboa3
         yZAg==
X-Forwarded-Encrypted: i=1; AJvYcCUiBCp9bVaca6kdYkzFc47k/j0al+6wTgDy+E+0VU0MtMQS7lQxt1OO2cI+7hlAzHB9VbqQCcmsdCIV4aHMva1a3cmEV9SRgR5V/A==
X-Gm-Message-State: AOJu0YwkSQlGFPuA4ee8bc/pXn3IqzeNh9Yal+qztK9okwo87sBPY87x
	Yo8gJx0rkow25Dj2CKUPATWKi2FeatppaAgk9nn6eXh9Gx3Bw4RqPcdnJb7Cg2pekOsEPzIjv7H
	21yB6d8dTsP4iKzjO7MsITA==
X-Google-Smtp-Source: AGHT+IHiPxP8A/E9YoxlvJaoAgVERYeMi+Yj3z6jWzuLSwobvImcgZOij9ODCa+RgPWAnZFn/TNmmHdAlQb76hlXGA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:c750:0:b0:e0b:ea2e:7b00 with SMTP
 id 3f1490d57ef6-e1155a90debmr11089276.5.1723583610828; Tue, 13 Aug 2024
 14:13:30 -0700 (PDT)
Date: Tue, 13 Aug 2024 21:13:08 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813211317.3381180-7-almasrymina@google.com>
Subject: [PATCH net-next v19 06/13] memory-provider: dmabuf devmem memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
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
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
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
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

---

v19:
- Add PP_FLAG_ALLOW_UNREADABLE_NETMEM flag. It serves 2 purposes, (a)
  it guards drivers that don't support unreadable netmem (net_iov
  backed) from accidentally getting exposed to it, and (b) drivers that
  wish to create header pools can unset it for that pool to force
  readable netmem.
- Add page_pool_check_memory_provider, which verifies that the driver
  has created a page_pool with the expected configuration. This is used
  to report to the user if the mp configuration succeeded, and also
  verify that the driver is doing the right thing.
- Don't reset niov->dma_addr on allocation/free.

v17:
- Use ASSERT_RTNL (Jakub)

v16:
- Add DEBUG_NET_WARN_ON_ONCE(!rtnl_is_locked()), to catch cases if
  page_pool_init without rtnl_locking when the queue is provided. In
  this case, the queue configuration may be changed while we're initing
  the page_pool, which could be a race.

v13:
- Return on warning (Pavel).
- Fixed pool->recycle_stats not being freed on error (Pavel).
- Applied reviewed-by from Pavel.

v11:
- Rebase to not use the ops. (Christoph)

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
 include/net/mp_dmabuf_devmem.h |  44 ++++++++++++++
 include/net/page_pool/types.h  |  16 ++++-
 net/core/devmem.c              |  70 ++++++++++++++++++++++
 net/core/page_pool.c           | 103 ++++++++++++++++++++++++---------
 net/core/page_pool_priv.h      |   6 ++
 net/core/page_pool_user.c      |  26 +++++++++
 6 files changed, 237 insertions(+), 28 deletions(-)
 create mode 100644 include/net/mp_dmabuf_devmem.h

diff --git a/include/net/mp_dmabuf_devmem.h b/include/net/mp_dmabuf_devmem.h
new file mode 100644
index 000000000000..300a2356eed0
--- /dev/null
+++ b/include/net/mp_dmabuf_devmem.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Dmabuf device memory provider.
+ *
+ * Authors:	Mina Almasry <almasrymina@google.com>
+ *
+ */
+#ifndef _NET_MP_DMABUF_DEVMEM_H
+#define _NET_MP_DMABUF_DEVMEM_H
+
+#include <net/netmem.h>
+
+#if defined(CONFIG_DMA_SHARED_BUFFER) && defined(CONFIG_GENERIC_ALLOCATOR)
+int mp_dmabuf_devmem_init(struct page_pool *pool);
+
+netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp);
+
+void mp_dmabuf_devmem_destroy(struct page_pool *pool);
+
+bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem);
+#else
+static inline int mp_dmabuf_devmem_init(struct page_pool *pool)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool,
+							gfp_t gfp)
+{
+	return 0;
+}
+
+static inline void mp_dmabuf_devmem_destroy(struct page_pool *pool)
+{
+}
+
+static inline bool mp_dmabuf_devmem_release_page(struct page_pool *pool,
+						 netmem_ref netmem)
+{
+	return false;
+}
+#endif
+
+#endif /* _NET_MP_DMABUF_DEVMEM_H */
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 4afd6dd56351..e221521cd7f3 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -20,8 +20,17 @@
 					* device driver responsibility
 					*/
 #define PP_FLAG_SYSTEM_POOL	BIT(2) /* Global system page_pool */
+#define PP_FLAG_ALLOW_UNREADABLE_NETMEM	BIT(3) /* Allow unreadable (net_iov
+						* backed) netmem in this
+						* page_pool. Drivers setting
+						* this must be able to support
+						* unreadable netmem, where
+						* netmem_address() would return
+						* NULL. This flag should not be
+						* set for header page_pools.
+						*/
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
-				 PP_FLAG_SYSTEM_POOL)
+				 PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNREADABLE_NETMEM)
 
 /*
  * Fast allocation side cache array/stack
@@ -52,12 +61,14 @@ struct pp_alloc_cache {
  * @nid:	NUMA node id to allocate from pages from
  * @dev:	device, for DMA pre-mapping purposes
  * @napi:	NAPI which is the sole consumer of pages, otherwise NULL
+ * @queue:	struct netdev_rx_queue this page_pool is being created for.
  * @dma_dir:	DMA mapping direction
  * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
  * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
  * @slow:	params with slowpath access only (initialization and Netlink)
  * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
- * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL
+ * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL,
+ *		PP_FLAG_ALLOW_UNREADABLE_NETMEM.
  */
 struct page_pool_params {
 	struct_group_tagged(page_pool_params_fast, fast,
@@ -66,6 +77,7 @@ struct page_pool_params {
 		int		nid;
 		struct device	*dev;
 		struct napi_struct *napi;
+		struct netdev_rx_queue *queue;
 		enum dma_data_direction dma_dir;
 		unsigned int	max_len;
 		unsigned int	offset;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 301f4250ca82..2f2a7f4dee4c 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -17,6 +17,7 @@
 #include <linux/genalloc.h>
 #include <linux/dma-buf.h>
 #include <net/devmem.h>
+#include <net/mp_dmabuf_devmem.h>
 #include <net/netdev_queues.h>
 
 #include "page_pool_priv.h"
@@ -153,6 +154,10 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	if (err)
 		goto err_xa_erase;
 
+	err = page_pool_check_memory_provider(dev, rxq, binding);
+	if (err)
+		goto err_xa_erase;
+
 	return 0;
 
 err_xa_erase:
@@ -305,4 +310,69 @@ void dev_dmabuf_uninstall(struct net_device *dev)
 				xa_erase(&binding->bound_rxqs, xa_idx);
 	}
 }
+
+/*** "Dmabuf devmem memory provider" ***/
+
+int mp_dmabuf_devmem_init(struct page_pool *pool)
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
+netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp)
+{
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+	netmem_ref netmem;
+	struct net_iov *niov;
+
+	niov = net_devmem_alloc_dmabuf(binding);
+	if (!niov)
+		return 0;
+
+	netmem = net_iov_to_netmem(niov);
+
+	page_pool_set_pp_info(pool, netmem);
+
+	pool->pages_state_hold_cnt++;
+	trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt);
+	return netmem;
+}
+
+void mp_dmabuf_devmem_destroy(struct page_pool *pool)
+{
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+
+	net_devmem_dmabuf_binding_put(binding);
+}
+
+bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
+{
+	if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
+		return false;
+
+	if (WARN_ON_ONCE(atomic_long_read(netmem_get_pp_ref_count_ref(netmem)) !=
+		     1))
+		return false;
+
+	page_pool_clear_pp_info(netmem);
+
+	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
+
+	/* We don't want the page pool put_page()ing our net_iovs. */
+	return false;
+}
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 13277f05aebd..25be3327561b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -13,6 +13,7 @@
 
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
+#include <net/netdev_rx_queue.h>
 
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -21,6 +22,9 @@
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/genalloc.h>
+#include <net/devmem.h>
+#include <net/mp_dmabuf_devmem.h>
 
 #include <trace/events/page_pool.h>
 
@@ -28,6 +32,7 @@
 #include "netmem_priv.h"
 
 DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+EXPORT_SYMBOL(page_pool_mem_providers);
 
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
@@ -190,6 +195,7 @@ static int page_pool_init(struct page_pool *pool,
 			  int cpuid)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	page_pool_struct_check();
 
@@ -271,7 +277,36 @@ static int page_pool_init(struct page_pool *pool,
 	if (pool->dma_map)
 		get_device(pool->p.dev);
 
+	if (pool->p.queue &&
+	    pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
+		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
+		 * configuration doesn't change while we're initializing the
+		 * page_pool.
+		 */
+		ASSERT_RTNL();
+		pool->mp_priv = pool->p.queue->mp_params.mp_priv;
+	}
+
+	if (pool->mp_priv) {
+		err = mp_dmabuf_devmem_init(pool);
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
+#ifdef CONFIG_PAGE_POOL_STATS
+	if (!pool->system)
+		free_percpu(pool->recycle_stats);
+#endif
+	return err;
 }
 
 static void page_pool_uninit(struct page_pool *pool)
@@ -455,28 +490,6 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
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
@@ -572,7 +585,10 @@ netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
 		return netmem;
 
 	/* Slow-path: cache empty, do real allocation */
-	netmem = __page_pool_alloc_pages_slow(pool, gfp);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
+		netmem = mp_dmabuf_devmem_alloc_netmems(pool, gfp);
+	else
+		netmem = __page_pool_alloc_pages_slow(pool, gfp);
 	return netmem;
 }
 EXPORT_SYMBOL(page_pool_alloc_netmem);
@@ -608,6 +624,28 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 	return inflight;
 }
 
+void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
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
+void page_pool_clear_pp_info(netmem_ref netmem)
+{
+	netmem_clear_pp_magic(netmem);
+	netmem_set_pp(netmem, NULL);
+}
+
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 							 netmem_ref netmem)
 {
@@ -636,8 +674,13 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 {
 	int count;
+	bool put;
 
-	__page_pool_release_page_dma(pool, netmem);
+	put = true;
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
+		put = mp_dmabuf_devmem_release_page(pool, netmem);
+	else
+		__page_pool_release_page_dma(pool, netmem);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
@@ -645,8 +688,10 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
 	trace_page_pool_state_release(pool, netmem, count);
 
-	page_pool_clear_pp_info(netmem);
-	put_page(netmem_to_page(netmem));
+	if (put) {
+		page_pool_clear_pp_info(netmem);
+		put_page(netmem_to_page(netmem));
+	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
 	 * __page_cache_release() call).
@@ -965,6 +1010,12 @@ static void __page_pool_destroy(struct page_pool *pool)
 
 	page_pool_unlist(pool);
 	page_pool_uninit(pool);
+
+	if (pool->mp_priv) {
+		mp_dmabuf_devmem_destroy(pool);
+		static_branch_dec(&page_pool_mem_providers);
+	}
+
 	kfree(pool);
 }
 
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 581501b5cd8c..fcd9c1a227bc 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -33,4 +33,10 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
 }
 
+void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
+void page_pool_clear_pp_info(netmem_ref netmem);
+int page_pool_check_memory_provider(struct net_device *dev,
+				    struct netdev_rx_queue *rxq,
+				    struct net_devmem_dmabuf_binding *binding);
+
 #endif
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 3a3277ba167b..cbc54ee4f670 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -344,6 +344,32 @@ void page_pool_unlist(struct page_pool *pool)
 	mutex_unlock(&page_pools_lock);
 }
 
+int page_pool_check_memory_provider(struct net_device *dev,
+				    struct netdev_rx_queue *rxq,
+				    struct net_devmem_dmabuf_binding *binding)
+{
+	struct netdev_rx_queue *binding_rxq;
+	struct page_pool *pool;
+	struct hlist_node *n;
+	unsigned long xa_idx;
+
+	mutex_lock(&page_pools_lock);
+	hlist_for_each_entry_safe(pool, n, &dev->page_pools, user.list) {
+		if (pool->mp_priv != binding)
+			continue;
+
+		xa_for_each(&binding->bound_rxqs, xa_idx, binding_rxq) {
+			if (rxq != binding_rxq)
+				continue;
+
+			mutex_unlock(&page_pools_lock);
+			return 0;
+		}
+	}
+	mutex_unlock(&page_pools_lock);
+	return -ENODATA;
+}
+
 static void page_pool_unreg_netdev_wipe(struct net_device *netdev)
 {
 	struct page_pool *pool;
-- 
2.46.0.76.ge559c4bf1a-goog


