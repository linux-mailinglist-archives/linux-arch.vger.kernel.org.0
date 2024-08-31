Return-Path: <linux-arch+bounces-6875-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E46966DEC
	for <lists+linux-arch@lfdr.de>; Sat, 31 Aug 2024 02:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883E21C22177
	for <lists+linux-arch@lfdr.de>; Sat, 31 Aug 2024 00:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B859147;
	Sat, 31 Aug 2024 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTeLM8hb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82661C6B5
	for <linux-arch@vger.kernel.org>; Sat, 31 Aug 2024 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725065021; cv=none; b=lYP2IWw5Sz+t574cWwJO+o24H2RYViRYJpSAnk8JgbgJf3boJq21eVsLIavzNNrRWQu8nwNik9TgB6vOf2g2bCYKOAWDhkmGBH/JyuiJTslXWveBVadGus7L//BYb5+BOchSXIZhhY5SZSpqymTc5HZ0PPN2DZYGVNQaxoA377I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725065021; c=relaxed/simple;
	bh=TnJR9L31j0Ycu2xcXIOjfiZEto+UN4G99/F4sro1ff0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l6OFDNEbri0spRRsuTrFu4kTHCK6GXQc9vjmtM126FIDi3qbrJlVqBPlfcVNf9iYmhwq/KuJ+SMM7ZDh4Aj5XkL+9bUSaNk97DIxBqGDBnqTsB4ngzEh7ZSnl//uBAiz6GAEWe/XRFMDkSo5EKofU4/7IBbYEStPsuxuMUDFyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gTeLM8hb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b47ff8a5c4so41685317b3.2
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 17:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725065014; x=1725669814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/2HPzByvp+lsMkxWlnfJdAXTlusPWy7rR74MFYEt/4=;
        b=gTeLM8hbhvi2M7g7xpVonm3bcC7xhtivNgpZVusMEvoFbF7vFJyTGgyrL5z6C+SYUu
         ZHvFRqycY017US5nPYGP3Ok8eQ9mz5//3PZoMPdZlrONym6c/wxkBw7+YT0Hlj+TrIl+
         SpoBLKjKf8j39QEv8QftDQ570yGHDTvGyFBeTtUE2GcBJVSVwbrZv7iehRX9TqaiSQ5j
         Hox+R+Ap8nL0KHyWQQBOtYIlsrYnjsa8are/eW9xLKtaJxD8lo+5rLyvD2H9b4zjyd7P
         V+P/itK/yHf6WPHuCPA4K4vrxlajc8DMFxfSSxBC85LqMcOeWm3FG5OLPpR5YSzHWMEy
         si3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725065014; x=1725669814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/2HPzByvp+lsMkxWlnfJdAXTlusPWy7rR74MFYEt/4=;
        b=J7luyU+cNTHhgTQihcTUnsPIlNSgEDesCq9o4teKTSEBnpQviGgujdmrVa5ZPkbtPZ
         pYLMAxDnVzCepDKXVzjlKStWDiRcju1VPBsIw10pt5z3LZdFrgumwy+qPFguYiU78we4
         exLP/urWF5Vqtu6wRlnCN2Ep8p8Xm1/iaUbjA8ia3vxLk9ymA/WpZKHUN3cSolpKj1Dq
         vEuG9TsYnUvJPt6LDdNDQIAzMe0wTzQZ8/t4llsZlwCMOScUnHth2+TJgoYNAqU0ak8r
         ail9wGOUJQ8y/XPrVFiWMkAg9/1qNv/uZz2jlio8XjPyY91lx+QSt/nHXj0chiXFxvjQ
         LJMg==
X-Forwarded-Encrypted: i=1; AJvYcCVCdVERF8G+VcbX9lvABWAyUUI7X6Fzh0Xpcena6v4OC26UMjt/gmVaRBkBgQwVBqiUNtUq8WnS4Fml@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDUl6/+eXH15UwKudKvWCgFWwIcp1d/30KWBg5I4icHXELz/2
	zMerVCjDufTJeWeVknvoBIQumlBpj5HntgfBkCHVenRwINUz0hvMAdVQFbZGmQJjdO0kALpaXn2
	lsIUuUh9ITbM3kGDmtjYYrQ==
X-Google-Smtp-Source: AGHT+IEUqZOioEmkEUMIUoru97PZZXAKyxqhEdvroRaDD+A/kRHFQLkCWUCRunV3At8QW+AUwLo8RsIuPjvHnS0ZPQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:3744:b0:64b:5cc7:bcb7 with
 SMTP id 00721157ae682-6d40d890122mr97297b3.1.1725065013549; Fri, 30 Aug 2024
 17:43:33 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:43:06 +0000
In-Reply-To: <20240831004313.3713467-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831004313.3713467-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831004313.3713467-7-almasrymina@google.com>
Subject: [PATCH net-next v24 06/13] memory-provider: dmabuf devmem memory provider
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
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
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

v23:
- Sort includes (Jakub)
- Add missing linux/mm.h include found after sorting.

v21:
- Provide empty definitions of functions moved to page_pool_priv.h, so
  that the build still succeeds when CONFIG_PAGE_POOL is not set.

v20:
- Moved queue pp_params field from fast path entries to slow path
  entries.
- Moved page_pool_check_memory_provider() call to inside
  netdev_rx_queue_restart (Pavel).
- Removed binding arg to page_pool_check_memory_provider() (Pavel).
- Removed unnecessary includes from page_pool.c
- Removed EXPORT_SYMBOL(page_pool_mem_providers) (Jakub)
- Check pool->slow.queue instead of walking binding xarray (Pavel
  & Jakub).

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
 include/net/mp_dmabuf_devmem.h |  44 +++++++++++++++
 include/net/netmem.h           |   1 +
 include/net/page_pool/types.h  |  16 +++++-
 net/core/devmem.c              |  66 ++++++++++++++++++++++
 net/core/netdev_rx_queue.c     |   7 +++
 net/core/page_pool.c           | 100 ++++++++++++++++++++++++---------
 net/core/page_pool_priv.h      |  20 +++++++
 net/core/page_pool_user.c      |  27 ++++++++-
 8 files changed, 252 insertions(+), 29 deletions(-)
 create mode 100644 include/net/mp_dmabuf_devmem.h

diff --git a/include/net/mp_dmabuf_devmem.h b/include/net/mp_dmabuf_devmem.h
new file mode 100644
index 000000000000..6d1cf2a77f6b
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
+#if defined(CONFIG_NET_DEVMEM)
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
index ac6c7945117b..61400d4b0d66 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -8,6 +8,7 @@
 #ifndef _NET_NETMEM_H
 #define _NET_NETMEM_H
 
+#include <linux/mm.h>
 #include <net/devmem.h>
 #include <net/net_debug.h>
 
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 4afd6dd56351..1b4698710f25 100644
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
@@ -57,7 +66,9 @@ struct pp_alloc_cache {
  * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
  * @slow:	params with slowpath access only (initialization and Netlink)
  * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
- * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL
+ * @queue:	struct netdev_rx_queue this page_pool is being created for.
+ * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL,
+ *		PP_FLAG_ALLOW_UNREADABLE_NETMEM.
  */
 struct page_pool_params {
 	struct_group_tagged(page_pool_params_fast, fast,
@@ -72,6 +83,7 @@ struct page_pool_params {
 	);
 	struct_group_tagged(page_pool_params_slow, slow,
 		struct net_device *netdev;
+		struct netdev_rx_queue *queue;
 		unsigned int	flags;
 /* private: used by test code only */
 		void (*init_callback)(netmem_ref netmem, void *arg);
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 727e5ee39f30..c8c112360caa 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -13,6 +13,7 @@
 #include <linux/netdevice.h>
 #include <linux/types.h>
 #include <net/devmem.h>
+#include <net/mp_dmabuf_devmem.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
@@ -320,3 +321,68 @@ void dev_dmabuf_uninstall(struct net_device *dev)
 			}
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
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index da11720a5983..e217a5838c87 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -4,8 +4,11 @@
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 
+#include "page_pool_priv.h"
+
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 {
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	void *new_mem, *old_mem;
 	int err;
 
@@ -31,6 +34,10 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	if (err)
 		goto err_free_old_mem;
 
+	err = page_pool_check_memory_provider(dev, rxq);
+	if (err)
+		goto err_free_new_queue_mem;
+
 	err = dev->queue_mgmt_ops->ndo_queue_stop(dev, old_mem, rxq_idx);
 	if (err)
 		goto err_free_new_queue_mem;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 52659db2d765..6e24950f2be4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -11,6 +11,8 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 
+#include <net/mp_dmabuf_devmem.h>
+#include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 
@@ -190,6 +192,7 @@ static int page_pool_init(struct page_pool *pool,
 			  int cpuid)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	page_pool_struct_check();
 
@@ -271,7 +274,36 @@ static int page_pool_init(struct page_pool *pool,
 	if (pool->dma_map)
 		get_device(pool->p.dev);
 
+	if (pool->slow.queue &&
+	    pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
+		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
+		 * configuration doesn't change while we're initializing the
+		 * page_pool.
+		 */
+		ASSERT_RTNL();
+		pool->mp_priv = pool->slow.queue->mp_params.mp_priv;
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
@@ -455,28 +487,6 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
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
@@ -572,7 +582,10 @@ netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
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
@@ -608,6 +621,28 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
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
@@ -636,8 +671,13 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
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
@@ -645,8 +685,10 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
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
@@ -965,6 +1007,12 @@ static void __page_pool_destroy(struct page_pool *pool)
 
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
index 2142caeddb7c..f90171dc477c 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -35,4 +35,24 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
 }
 
+#if defined(CONFIG_PAGE_POOL)
+void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
+void page_pool_clear_pp_info(netmem_ref netmem);
+int page_pool_check_memory_provider(struct net_device *dev,
+				    struct netdev_rx_queue *rxq);
+#else
+static inline void page_pool_set_pp_info(struct page_pool *pool,
+					 netmem_ref netmem)
+{
+}
+static inline void page_pool_clear_pp_info(netmem_ref netmem)
+{
+}
+static inline int page_pool_check_memory_provider(struct net_device *dev,
+						  struct netdev_rx_queue *rxq)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 3a3277ba167b..ce5167eb5548 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -4,8 +4,9 @@
 #include <linux/netdevice.h>
 #include <linux/xarray.h>
 #include <net/net_debug.h>
-#include <net/page_pool/types.h>
+#include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
+#include <net/page_pool/types.h>
 #include <net/sock.h>
 
 #include "page_pool_priv.h"
@@ -344,6 +345,30 @@ void page_pool_unlist(struct page_pool *pool)
 	mutex_unlock(&page_pools_lock);
 }
 
+int page_pool_check_memory_provider(struct net_device *dev,
+				    struct netdev_rx_queue *rxq)
+{
+	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
+	struct page_pool *pool;
+	struct hlist_node *n;
+
+	if (!binding)
+		return 0;
+
+	mutex_lock(&page_pools_lock);
+	hlist_for_each_entry_safe(pool, n, &dev->page_pools, user.list) {
+		if (pool->mp_priv != binding)
+			continue;
+
+		if (pool->slow.queue == rxq) {
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
2.46.0.469.g59c65b2a67-goog


