Return-Path: <linux-arch+bounces-4868-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415A9060DA
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 03:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABA5B20B7B
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 01:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A3ADDB1;
	Thu, 13 Jun 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTS1EFkq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BA12CDAF
	for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2024 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242585; cv=none; b=hheVRUaJLigbAjkaDN4GtVlQ0iS8jDn95jCmmUS6iDSqu93zgXyVCraFYhx6pxWeGE8GuPrE+zeTP8qwRxXf3HsvwHJI+g2vXYw9zi9FCN//fzFm4+V8WlprmPr7pQpoS/1AVzmebeWHkPhB1t/3MODxNlbLuh1U9ZAGxQh13nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242585; c=relaxed/simple;
	bh=D0t1JNajx/OujguVhRUh1iVBIzs2yeMSzq0dHxVh1po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f/n1Pa1zGMFVk4eQTaO10rZfojC5HChZwmnDTY9DJD3Q9HiNeWU+Xt+Dm00qNo8RRR2FWM03g2ElPKFgNF6c7BdXrWa8bHvr6tiDXNuSeOjgoDoe7cwn+797PmrpRXlyCLFkFR3TPEbz+mIq5GcCf+EsY157cQBN0p8Gk0c/bWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTS1EFkq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfec7058deeso936993276.2
        for <linux-arch@vger.kernel.org>; Wed, 12 Jun 2024 18:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718242574; x=1718847374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oda02cHUoPG13Gw2z7WixLzp1h2c8OCsBPSqQJZIrds=;
        b=kTS1EFkqlBSiew/P8HUM9BvXpb60svc13Gefa02Rpk+53jk7/CY/A6ggS5kDJ9/r0m
         jRytJfvkP+uxl1iuEABDhPQyZr38fxdr8bT8ksYKtJd+MRCtu0xbK7KQEhQ1pJz2dWOm
         CoIzr6rUhCsnjIYM1T+a7PE6iJpWSWJG8YcA1squTAHd/26zNczUmPbGYRCHpxS1OHAK
         mMMUONh17EXx2dxj1Q/WMzqngj0UaAB73FfRF4trTYWUS8PyzyfLP9Y7d0ERWyogIIFt
         dD2OxsmaXuSX6yVLrAw7w/om7NPcQnOmlC2CVTBwB0dVRIVgJ5b6ASTz7tWZg33B04Ha
         Vd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242574; x=1718847374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oda02cHUoPG13Gw2z7WixLzp1h2c8OCsBPSqQJZIrds=;
        b=Pc0va5whY8UeaUQKjuLfcOe7cRI2GAX3lWVAB6bMpVpNVYvWyGkEtw7xUAjzoudPMV
         flc6+Sl1iW1bw3Wt9hDDe8WkXxAnaLAlSpJzJK6gZPPq+oLIOfDsmlOSE+s8YmHcrlvw
         6IA4MU3bg/uzJymWwAsNU3UnO9Xxx+a3NUMPDkD0nTqhCO5hZihkG7ezKmQVnfSHoYUv
         zAcUgMtbOZU8Mrbvwa/uUw5SyYCFTbVZZn0MVxM/rQ1ZT5HD46CwQz44TuMqAe975o07
         7UIry6QdOPIdiEBqyZchrZ4domDFQtbPama5tiXLLAs+Td2R7Y7RxHpuUmib5hchZ12u
         SEDg==
X-Forwarded-Encrypted: i=1; AJvYcCVDcR6sTA8Iiai3VOgr0ImsH9NG9eHdoO6tu3uukv55jWNHC203xjemZEpCwcX3RWybkBmUTCa6f4aMlvq807FC1MEFwEFZtbRloQ==
X-Gm-Message-State: AOJu0YwnfrFFv5AbAPlBezogXZIWpalyKeWhH+FlIlbRrmKBe4m4RwBO
	SMa+loNtYQxV0Un9ktq1aMd1K5/LVkrxU8evFqWMPgxk1BH+GvG62xkSFVAmjUc3moQyBbLDhuK
	nI4hU7tbWlBQuM1sDy8Hz9g==
X-Google-Smtp-Source: AGHT+IEIihVTHjJ/VCKxtkGTafjXkjND8dBC56LjR6vRzY/uWRIicj8bQ0O5ZjYGMPmd+MZUIue5r5vyWf7e8mmpQA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:2b12:b0:df7:9ac4:f1b2 with
 SMTP id 3f1490d57ef6-dfe6656e2b7mr1005091276.5.1718242573944; Wed, 12 Jun
 2024 18:36:13 -0700 (PDT)
Date: Thu, 13 Jun 2024 01:35:44 +0000
In-Reply-To: <20240613013557.1169171-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613013557.1169171-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613013557.1169171-8-almasrymina@google.com>
Subject: [PATCH net-next v12 07/13] memory-provider: dmabuf devmem memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
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

---

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
 include/net/mp_dmabuf_devmem.h  | 44 ++++++++++++++++++++
 include/net/netmem.h            | 15 +++++++
 include/net/page_pool/helpers.h | 22 ++++++++++
 include/net/page_pool/types.h   |  2 +
 net/core/devmem.c               | 74 +++++++++++++++++++++++++++++++++
 net/core/page_pool.c            | 70 +++++++++++++++++++------------
 6 files changed, 201 insertions(+), 26 deletions(-)
 create mode 100644 include/net/mp_dmabuf_devmem.h

diff --git a/include/net/mp_dmabuf_devmem.h b/include/net/mp_dmabuf_devmem.h
new file mode 100644
index 0000000000000..300a2356eed00
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
index 0693117f8d74f..2179a55f21448 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -52,6 +52,7 @@ struct pp_alloc_cache {
  * @nid:	NUMA node id to allocate from pages from
  * @dev:	device, for DMA pre-mapping purposes
  * @napi:	NAPI which is the sole consumer of pages, otherwise NULL
+ * @queue:	struct netdev_rx_queue this page_pool is being created for.
  * @dma_dir:	DMA mapping direction
  * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
  * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
@@ -66,6 +67,7 @@ struct page_pool_params {
 		int		nid;
 		struct device	*dev;
 		struct napi_struct *napi;
+		struct netdev_rx_queue *queue;
 		enum dma_data_direction dma_dir;
 		unsigned int	max_len;
 		unsigned int	offset;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index f4fd9b9dbb675..d3843eade5fc2 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -17,6 +17,7 @@
 #include <linux/genalloc.h>
 #include <linux/dma-buf.h>
 #include <net/devmem.h>
+#include <net/mp_dmabuf_devmem.h>
 #include <net/netdev_queues.h>
 
 /* Device memory support */
@@ -296,4 +297,77 @@ int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	dma_buf_put(dmabuf);
 	return err;
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
+void mp_dmabuf_devmem_destroy(struct page_pool *pool)
+{
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+
+	net_devmem_dmabuf_binding_put(binding);
+}
+
+bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
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
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1152e3547795a..22e3c58648d42 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -13,6 +13,7 @@
 
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
+#include <net/netdev_rx_queue.h>
 
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -21,12 +22,16 @@
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/genalloc.h>
+#include <net/devmem.h>
+#include <net/mp_dmabuf_devmem.h>
 
 #include <trace/events/page_pool.h>
 
 #include "page_pool_priv.h"
 
 DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+EXPORT_SYMBOL(page_pool_mem_providers);
 
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
@@ -188,6 +193,7 @@ static int page_pool_init(struct page_pool *pool,
 			  int cpuid)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	page_pool_struct_check();
 
@@ -269,7 +275,25 @@ static int page_pool_init(struct page_pool *pool,
 	if (pool->dma_map)
 		get_device(pool->p.dev);
 
+	if (pool->p.queue)
+		pool->mp_priv = READ_ONCE(pool->p.queue->mp_params.mp_priv);
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
+	return err;
 }
 
 static void page_pool_uninit(struct page_pool *pool)
@@ -453,28 +477,6 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
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
@@ -570,7 +572,10 @@ netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
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
@@ -634,8 +639,13 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
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
@@ -643,8 +653,10 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
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
@@ -963,6 +975,12 @@ static void __page_pool_destroy(struct page_pool *pool)
 
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
 
-- 
2.45.2.505.gda0bf45e8d-goog


