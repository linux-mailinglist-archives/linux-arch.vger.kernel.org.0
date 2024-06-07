Return-Path: <linux-arch+bounces-4734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD48FF8F4
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 02:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986861C23EE2
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 00:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40B1C2BE;
	Fri,  7 Jun 2024 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XppgQpUu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D68802
	for <linux-arch@vger.kernel.org>; Fri,  7 Jun 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717721503; cv=none; b=LQ4JYZcsqsFnCXPgQMi7+F5G7yktjGLh4XfN12wuCXkIx7on58xEJgMN0JIkJ4jz0Z7JLKVwpn/b7AT8feTXuPgz3Eci2/ZAnvMpQqpUqOM1ERBq5YSHeQg6hQLOYZPE/AzCDDDlMjDdA3CfZwrU7LcALOlFnEla6EN86N+HrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717721503; c=relaxed/simple;
	bh=CXGiinHioXJgBlfOHlHw7Lqc5mdPxVFLbtysS3Fyeg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a41lRpNEIeZnE17pZwffKZX1DO447H8v15ykM3JVznqD4wH8tHta0bEGcgEBk4yxFgbCfQi1kwb4z1Mjqd9K/KfnctZ7dUC7u4CYkQbLLfZnQYYWQXzFvA+sD2iG0RFtJIF2PFK7MLqSlrfWyL+V+Bh+/bKpiZfegwpTMyycoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XppgQpUu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627e9a500faso24606337b3.1
        for <linux-arch@vger.kernel.org>; Thu, 06 Jun 2024 17:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717721498; x=1718326298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hV0MYyl2CCP2KFKBxgMyl/QukwuRZ0hmnQnDVkP9qog=;
        b=XppgQpUu3C2FjUwB5O2IgznBtVx504I3Ur5u1eFwy7ZBNydZgnyzezkpAWRt8X/AZO
         EsWNRFzh9yPrDfAiCcPqGVJ4gX89DO0SHZDO5AmuYjgcehVCM/6ZUwCv5ShCDsB484Gx
         5rLSpmJg9f0q0nC1iBA0ZFLSi0akAkPP9/AxHDrq1C/61BuCSA7vVvFPUt+9dLA7WWM0
         T0ASUV/ZU+VXdPr9HTPg50Fd3XVjyKxatr13iOFD1Lkf5oo3kRnAvOYzYAnKIyLOMCbr
         s1ZcUQtRWBoh2yUyYlY+5e5jvJuOGGLQDU7SgaLVAmN2SrDgWasaeb1+GkfUnwuCZ/9i
         IFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717721498; x=1718326298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hV0MYyl2CCP2KFKBxgMyl/QukwuRZ0hmnQnDVkP9qog=;
        b=wJpfR/1jfMEm8rx27E3kTvVr++5eL9SLAT7ngWIHwpWngvDan6teWRCNyWeg3nYJ8P
         g5W7jgFNig24opQNSD6+LFOZwxDRI6QJfTxL7uDixwPyetcGe5LK6qo3Z98brkh8U4hq
         29MHzdKhC/4+Wy9PPtxj+vetlCPCKnaob15pjtVdltjWaCJD9JPnYA4ULK1lPTdFZobO
         1njzz7x4n2OQPVTJb1ZCR74y/vVseBz8W7VHQt7HibmlMGH5ilvxMdT9sZKDMscPTjlk
         /NIrRrGAI3lFDkvAeIOFqoNf/ZAZfW0N36egT2l4K852hY1+9keCqpa+GJ/V4j1OvV+z
         f/9g==
X-Forwarded-Encrypted: i=1; AJvYcCUqS0auxBDNtwqx8qqnRzPbw9i+EhrUFFehOYkZLhY97lpCDsmx3sz3DpHhjIc0CbRxcLvjClfXmSqWVTPUCS6vM/yNf8Dc4ELOSg==
X-Gm-Message-State: AOJu0Yz6mI1OvDJaa1cL+TpzwjN4YQXyIfEBj9gF3uX1Wz+tK568iHYi
	BG+QC+H87ZnDT9KRwh40Aw9DphhJcIW2Ancq7u0qQhKwFKMCIctJL4on4FFTw0V/1Tc1V9srC10
	eX99wjj///ZisLv7lumsjTw==
X-Google-Smtp-Source: AGHT+IEbdJYHGTXQgL+K0BLn/GocFCRdqLWpo0CUT2Sa0ixhlITl6Td08dXY56L4YgpDIbN1JAAcE3Zb1K3lK0eBiQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:fc9:b0:61b:e6fb:9e08 with
 SMTP id 00721157ae682-62cd56861e4mr2906837b3.8.1717721497573; Thu, 06 Jun
 2024 17:51:37 -0700 (PDT)
Date: Fri,  7 Jun 2024 00:51:13 +0000
In-Reply-To: <20240607005127.3078656-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240607005127.3078656-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607005127.3078656-4-almasrymina@google.com>
Subject: [PATCH net-next v11 03/13] netdev: support binding dma-buf to netdevice
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
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a netdev_dmabuf_binding struct which represents the
dma-buf-to-netdevice binding. The netlink API will bind the dma-buf to
rx queues on the netdevice. On the binding, the dma_buf_attach
& dma_buf_map_attachment will occur. The entries in the sg_table from
mapping will be inserted into a genpool to make it ready
for allocation.

The chunks in the genpool are owned by a dmabuf_chunk_owner struct which
holds the dma-buf offset of the base of the chunk and the dma_addr of
the chunk. Both are needed to use allocations that come from this chunk.

We create a new type that represents an allocation from the genpool:
net_iov. We setup the net_iov allocation size in the
genpool to PAGE_SIZE for simplicity: to match the PAGE_SIZE normally
allocated by the page pool and given to the drivers.

The user can unbind the dmabuf from the netdevice by closing the netlink
socket that established the binding. We do this so that the binding is
automatically unbound even if the userspace process crashes.

The binding and unbinding leaves an indicator in struct netdev_rx_queue
that the given queue is bound, but the binding doesn't take effect until
the driver actually reconfigures its queues, and re-initializes its page
pool.

The netdev_dmabuf_binding struct is refcounted, and releases its
resources only when all the refs are released.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v11:
- Fix build error with CONFIG_DMA_SHARED_BUFFER &&
  !CONFIG_GENERIC_ALLOCATOR
- Rebased on top of no memory provider ops.

v10:
- Moved net_iov_dma_addr() to devmem.h and made it devmem specific
  helper (David).

v9: https://lore.kernel.org/all/20240403002053.2376017-5-almasrymina@google.com/
- Removed net_devmem_restart_rx_queues and put it in its own patch
  (David).

v8:
- move dmabuf_devmem_ops usage to later patch to avoid patch-by-patch
  build error.

v7:
- Use IS_ERR() instead of IS_ERR_OR_NULL() for the dma_buf_get() return
  value.
- Changes netdev_* naming in devmem.c to net_devmem_* (Yunsheng).
- DMA_BIDIRECTIONAL -> DMA_FROM_DEVICE (Yunsheng).
- Added a comment around recovering of the old rx queue in
  net_devmem_restart_rx_queue(), and added freeing of old_mem if the
  restart of the old queue fails. (Yunsheng).
- Use kernel-family sock-priv (Jakub).
- Put pp_memory_provider_params in netdev_rx_queue instead of the
  dma-buf specific binding (Pavel & David).
- Move queue management ops to queue_mgmt_ops instead of netdev_ops
  (Jakub).
- Remove excess whitespaces (Jakub).
- Use genlmsg_iput (Jakub).

v6:
- Validate rx queue index
- Refactor new functions into devmem.c (Pavel)

v5:
- Renamed page_pool_iov to net_iov, and moved that support to devmem.h
  or netmem.h.

v1:
- Introduce devmem.h instead of bloating netdevice.h (Jakub)
- ENOTSUPP -> EOPNOTSUPP (checkpatch.pl I think)
- Remove unneeded rcu protection for binding->list (rtnl protected)
- Removed extraneous err_binding_put: label.
- Removed dma_addr += len (Paolo).
- Don't override err on netdev_bind_dmabuf_to_queue failure.
- Rename devmem -> dmabuf (David).
- Add id to dmabuf binding (David/Stan).
- Fix missing xa_destroy bound_rq_list.
- Use queue api to reset bound RX queues (Jakub).
- Update netlink API for rx-queue type (tx/re) (Jakub).

RFC v3:
- Support multi rx-queue binding

---
 Documentation/netlink/specs/netdev.yaml |   4 +
 include/net/devmem.h                    | 111 +++++++++++
 include/net/netdev_rx_queue.h           |   2 +
 include/net/netmem.h                    |  10 +
 include/net/page_pool/types.h           |   6 +
 net/core/Makefile                       |   2 +-
 net/core/dev.c                          |   3 +
 net/core/devmem.c                       | 252 ++++++++++++++++++++++++
 net/core/netdev-genl-gen.c              |   4 +
 net/core/netdev-genl-gen.h              |   4 +
 net/core/netdev-genl.c                  | 101 +++++++++-
 11 files changed, 496 insertions(+), 3 deletions(-)
 create mode 100644 include/net/devmem.h
 create mode 100644 net/core/devmem.c

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 899ac0882a098..d6d7cb01c145c 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -673,6 +673,10 @@ operations:
             - tx-packets
             - tx-bytes
 
+kernel-family:
+  headers: [ "linux/list.h"]
+  sock-priv: struct list_head
+
 mcast-groups:
   list:
     -
diff --git a/include/net/devmem.h b/include/net/devmem.h
new file mode 100644
index 0000000000000..eaf3fd965d7a8
--- /dev/null
+++ b/include/net/devmem.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Device memory TCP support
+ *
+ * Authors:	Mina Almasry <almasrymina@google.com>
+ *		Willem de Bruijn <willemb@google.com>
+ *		Kaiyuan Zhang <kaiyuanz@google.com>
+ *
+ */
+#ifndef _NET_DEVMEM_H
+#define _NET_DEVMEM_H
+
+struct net_devmem_dmabuf_binding {
+	struct dma_buf *dmabuf;
+	struct dma_buf_attachment *attachment;
+	struct sg_table *sgt;
+	struct net_device *dev;
+	struct gen_pool *chunk_pool;
+
+	/* The user holds a ref (via the netlink API) for as long as they want
+	 * the binding to remain alive. Each page pool using this binding holds
+	 * a ref to keep the binding alive. Each allocated net_iov holds a
+	 * ref.
+	 *
+	 * The binding undos itself and unmaps the underlying dmabuf once all
+	 * those refs are dropped and the binding is no longer desired or in
+	 * use.
+	 */
+	refcount_t ref;
+
+	/* The list of bindings currently active. Used for netlink to notify us
+	 * of the user dropping the bind.
+	 */
+	struct list_head list;
+
+	/* rxq's this binding is active on. */
+	struct xarray bound_rxq_list;
+
+	/* ID of this binding. Globally unique to all bindings currently
+	 * active.
+	 */
+	u32 id;
+};
+
+/* Owner of the dma-buf chunks inserted into the gen pool. Each scatterlist
+ * entry from the dmabuf is inserted into the genpool as a chunk, and needs
+ * this owner struct to keep track of some metadata necessary to create
+ * allocations from this chunk.
+ */
+struct dmabuf_genpool_chunk_owner {
+	/* Offset into the dma-buf where this chunk starts.  */
+	unsigned long base_virtual;
+
+	/* dma_addr of the start of the chunk.  */
+	dma_addr_t base_dma_addr;
+
+	/* Array of net_iovs for this chunk. */
+	struct net_iov *niovs;
+	size_t num_niovs;
+
+	struct net_devmem_dmabuf_binding *binding;
+};
+
+#if defined(CONFIG_DMA_SHARED_BUFFER) && defined(CONFIG_GENERIC_ALLOCATOR)
+void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
+int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+			   struct net_devmem_dmabuf_binding **out);
+void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
+int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				    struct net_devmem_dmabuf_binding *binding);
+#else
+static inline void
+__net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
+{
+}
+
+static inline int net_devmem_bind_dmabuf(struct net_device *dev,
+					 unsigned int dmabuf_fd,
+					 struct net_devmem_dmabuf_binding **out)
+{
+	return -EOPNOTSUPP;
+}
+static inline void
+net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
+{
+}
+
+static inline int
+net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				struct net_devmem_dmabuf_binding *binding)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+static inline void
+net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
+{
+	refcount_inc(&binding->ref);
+}
+
+static inline void
+net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
+{
+	if (!refcount_dec_and_test(&binding->ref))
+		return;
+
+	__net_devmem_dmabuf_binding_free(binding);
+}
+
+#endif /* _NET_DEVMEM_H */
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index e78ca52d67fbf..ac34f5fb4f71d 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -6,6 +6,7 @@
 #include <linux/netdevice.h>
 #include <linux/sysfs.h>
 #include <net/xdp.h>
+#include <net/page_pool/types.h>
 
 /* This structure contains an instance of an RX queue. */
 struct netdev_rx_queue {
@@ -25,6 +26,7 @@ struct netdev_rx_queue {
 	 * Readers and writers must hold RTNL
 	 */
 	struct napi_struct		*napi;
+	struct pp_memory_provider_params mp_params;
 } ____cacheline_aligned_in_smp;
 
 /*
diff --git a/include/net/netmem.h b/include/net/netmem.h
index d8b810245c1da..72e932a1a9489 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -8,6 +8,16 @@
 #ifndef _NET_NETMEM_H
 #define _NET_NETMEM_H
 
+#include <net/devmem.h>
+
+/* net_iov */
+
+struct net_iov {
+	struct dmabuf_genpool_chunk_owner *owner;
+};
+
+/* netmem */
+
 /**
  * typedef netmem_ref - a nonexistent type marking a reference to generic
  * network memory.
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 7e8477057f3d1..9f3c3ee2ee755 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -128,6 +128,10 @@ struct page_pool_stats {
 };
 #endif
 
+struct pp_memory_provider_params {
+	void *mp_priv;
+};
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
@@ -194,6 +198,8 @@ struct page_pool {
 	 */
 	struct ptr_ring ring;
 
+	void *mp_priv;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/Makefile b/net/core/Makefile
index f82232b358a2c..6b43611fb4a43 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -13,7 +13,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
 			fib_notifier.o xdp.o flow_offload.o gro.o \
-			netdev-genl.o netdev-genl-gen.o gso.o
+			netdev-genl.o netdev-genl-gen.o gso.o devmem.o
 
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
diff --git a/net/core/dev.c b/net/core/dev.c
index e62698c7a0e63..25faa1fd64fc1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -158,6 +158,9 @@
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
 #include <net/rps.h>
+#include <linux/genalloc.h>
+#include <linux/dma-buf.h>
+#include <net/devmem.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
diff --git a/net/core/devmem.c b/net/core/devmem.c
new file mode 100644
index 0000000000000..951a06004c430
--- /dev/null
+++ b/net/core/devmem.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *      Devmem TCP
+ *
+ *      Authors:	Mina Almasry <almasrymina@google.com>
+ *			Willem de Bruijn <willemdebruijn.kernel@gmail.com>
+ *			Kaiyuan Zhang <kaiyuanz@google.com
+ */
+
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/netdevice.h>
+#include <trace/events/page_pool.h>
+#include <net/netdev_rx_queue.h>
+#include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
+#include <linux/genalloc.h>
+#include <linux/dma-buf.h>
+#include <net/devmem.h>
+#include <net/netdev_queues.h>
+
+/* Device memory support */
+
+#if defined(CONFIG_DMA_SHARED_BUFFER) && defined(CONFIG_GENERIC_ALLOCATOR)
+static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
+					       struct gen_pool_chunk *chunk,
+					       void *not_used)
+{
+	struct dmabuf_genpool_chunk_owner *owner = chunk->owner;
+
+	kvfree(owner->niovs);
+	kfree(owner);
+}
+
+void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
+{
+	size_t size, avail;
+
+	gen_pool_for_each_chunk(binding->chunk_pool,
+				net_devmem_dmabuf_free_chunk_owner, NULL);
+
+	size = gen_pool_size(binding->chunk_pool);
+	avail = gen_pool_avail(binding->chunk_pool);
+
+	if (!WARN(size != avail, "can't destroy genpool. size=%zu, avail=%zu",
+		  size, avail))
+		gen_pool_destroy(binding->chunk_pool);
+
+	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
+				 DMA_FROM_DEVICE);
+	dma_buf_detach(binding->dmabuf, binding->attachment);
+	dma_buf_put(binding->dmabuf);
+	xa_destroy(&binding->bound_rxq_list);
+	kfree(binding);
+}
+
+/* Protected by rtnl_lock() */
+static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
+
+void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
+{
+	struct netdev_rx_queue *rxq;
+	unsigned long xa_idx;
+	unsigned int rxq_idx;
+
+	if (!binding)
+		return;
+
+	if (binding->list.next)
+		list_del(&binding->list);
+
+	xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
+		if (rxq->mp_params.mp_priv == binding) {
+			/* We hold the rtnl_lock while binding/unbinding
+			 * dma-buf, so we can't race with another thread that
+			 * is also modifying this value. However, the page_pool
+			 * may read this config while it's creating its
+			 * rx-queues. WRITE_ONCE() here to match the
+			 * READ_ONCE() in the page_pool.
+			 */
+			WRITE_ONCE(rxq->mp_params.mp_priv, NULL);
+
+			rxq_idx = get_netdev_rx_queue_index(rxq);
+
+			netdev_rx_queue_restart(binding->dev, rxq_idx);
+		}
+	}
+
+	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+
+	net_devmem_dmabuf_binding_put(binding);
+}
+
+int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				    struct net_devmem_dmabuf_binding *binding)
+{
+	struct netdev_rx_queue *rxq;
+	u32 xa_idx;
+	int err;
+
+	if (rxq_idx >= dev->num_rx_queues)
+		return -ERANGE;
+
+	rxq = __netif_get_rx_queue(dev, rxq_idx);
+	if (rxq->mp_params.mp_priv)
+		return -EEXIST;
+
+	err = xa_alloc(&binding->bound_rxq_list, &xa_idx, rxq, xa_limit_32b,
+		       GFP_KERNEL);
+	if (err)
+		return err;
+
+	/* We hold the rtnl_lock while binding/unbinding dma-buf, so we can't
+	 * race with another thread that is also modifying this value. However,
+	 * the driver may read this config while it's creating its * rx-queues.
+	 * WRITE_ONCE() here to match the READ_ONCE() in the driver.
+	 */
+	WRITE_ONCE(rxq->mp_params.mp_priv, binding);
+
+	err = netdev_rx_queue_restart(dev, rxq_idx);
+	if (err)
+		goto err_xa_erase;
+
+	return 0;
+
+err_xa_erase:
+	WRITE_ONCE(rxq->mp_params.mp_priv, NULL);
+	xa_erase(&binding->bound_rxq_list, xa_idx);
+
+	return err;
+}
+
+int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+			   struct net_devmem_dmabuf_binding **out)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	static u32 id_alloc_next;
+	struct scatterlist *sg;
+	struct dma_buf *dmabuf;
+	unsigned int sg_idx, i;
+	unsigned long virtual;
+	int err;
+
+	dmabuf = dma_buf_get(dmabuf_fd);
+	if (IS_ERR(dmabuf))
+		return -EBADFD;
+
+	binding = kzalloc_node(sizeof(*binding), GFP_KERNEL,
+			       dev_to_node(&dev->dev));
+	if (!binding) {
+		err = -ENOMEM;
+		goto err_put_dmabuf;
+	}
+
+	binding->dev = dev;
+
+	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
+			      binding, xa_limit_32b, &id_alloc_next,
+			      GFP_KERNEL);
+	if (err < 0)
+		goto err_free_binding;
+
+	xa_init_flags(&binding->bound_rxq_list, XA_FLAGS_ALLOC);
+
+	refcount_set(&binding->ref, 1);
+
+	binding->dmabuf = dmabuf;
+
+	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
+	if (IS_ERR(binding->attachment)) {
+		err = PTR_ERR(binding->attachment);
+		goto err_free_id;
+	}
+
+	binding->sgt =
+		dma_buf_map_attachment(binding->attachment, DMA_BIDIRECTIONAL);
+	if (IS_ERR(binding->sgt)) {
+		err = PTR_ERR(binding->sgt);
+		goto err_detach;
+	}
+
+	/* For simplicity we expect to make PAGE_SIZE allocations, but the
+	 * binding can be much more flexible than that. We may be able to
+	 * allocate MTU sized chunks here. Leave that for future work...
+	 */
+	binding->chunk_pool =
+		gen_pool_create(PAGE_SHIFT, dev_to_node(&dev->dev));
+	if (!binding->chunk_pool) {
+		err = -ENOMEM;
+		goto err_unmap;
+	}
+
+	virtual = 0;
+	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
+		dma_addr_t dma_addr = sg_dma_address(sg);
+		struct dmabuf_genpool_chunk_owner *owner;
+		size_t len = sg_dma_len(sg);
+		struct net_iov *niov;
+
+		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
+				     dev_to_node(&dev->dev));
+		owner->base_virtual = virtual;
+		owner->base_dma_addr = dma_addr;
+		owner->num_niovs = len / PAGE_SIZE;
+		owner->binding = binding;
+
+		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
+					 dma_addr, len, dev_to_node(&dev->dev),
+					 owner);
+		if (err) {
+			err = -EINVAL;
+			goto err_free_chunks;
+		}
+
+		owner->niovs = kvmalloc_array(owner->num_niovs,
+					      sizeof(*owner->niovs),
+					      GFP_KERNEL);
+		if (!owner->niovs) {
+			err = -ENOMEM;
+			goto err_free_chunks;
+		}
+
+		for (i = 0; i < owner->num_niovs; i++) {
+			niov = &owner->niovs[i];
+			niov->owner = owner;
+		}
+
+		virtual += len;
+	}
+
+	*out = binding;
+
+	return 0;
+
+err_free_chunks:
+	gen_pool_for_each_chunk(binding->chunk_pool,
+				net_devmem_dmabuf_free_chunk_owner, NULL);
+	gen_pool_destroy(binding->chunk_pool);
+err_unmap:
+	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
+				 DMA_BIDIRECTIONAL);
+err_detach:
+	dma_buf_detach(dmabuf, binding->attachment);
+err_free_id:
+	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+err_free_binding:
+	kfree(binding);
+err_put_dmabuf:
+	dma_buf_put(dmabuf);
+	return err;
+}
+#endif
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 9acd0d893765a..3dcd25049e593 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -9,6 +9,7 @@
 #include "netdev-genl-gen.h"
 
 #include <uapi/linux/netdev.h>
+#include <linux/list.h>
 
 /* Integer value ranges */
 static const struct netlink_range_validation netdev_a_page_pool_id_range = {
@@ -187,4 +188,7 @@ struct genl_family netdev_nl_family __ro_after_init = {
 	.n_split_ops	= ARRAY_SIZE(netdev_nl_ops),
 	.mcgrps		= netdev_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(netdev_nl_mcgrps),
+	.sock_priv_size	= sizeof(struct list_head),
+	.sock_priv_init	= (void *)netdev_nl_sock_priv_init,
+	.sock_priv_destroy = (void *)netdev_nl_sock_priv_destroy,
 };
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index ca5a0983f2834..2c431b7dcbc84 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -10,6 +10,7 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/netdev.h>
+#include <linux/list.h>
 
 /* Common nested types */
 extern const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1];
@@ -40,4 +41,7 @@ enum {
 
 extern struct genl_family netdev_nl_family;
 
+void netdev_nl_sock_priv_init(struct list_head *priv);
+void netdev_nl_sock_priv_destroy(struct list_head *priv);
+
 #endif /* _LINUX_NETDEV_GEN_H */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index e254503723626..d6007bf4933c6 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -10,6 +10,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/busy_poll.h>
+#include <net/devmem.h>
 
 #include "netdev-genl-gen.h"
 #include "dev.h"
@@ -721,10 +722,92 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
-/* Stub */
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return 0;
+	struct nlattr *tb[ARRAY_SIZE(netdev_queue_dmabuf_nl_policy)];
+	struct net_devmem_dmabuf_binding *out_binding;
+	struct list_head *sock_binding_list;
+	u32 ifindex, dmabuf_fd, rxq_idx;
+	struct net_device *netdev;
+	struct sk_buff *rsp;
+	struct nlattr *attr;
+	int rem, err = 0;
+	void *hdr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_BIND_DMABUF_DMABUF_FD) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_BIND_DMABUF_QUEUES))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
+	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_BIND_DMABUF_DMABUF_FD]);
+
+	rtnl_lock();
+
+	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
+	if (!netdev) {
+		err = -ENODEV;
+		goto err_unlock;
+	}
+
+	err = net_devmem_bind_dmabuf(netdev, dmabuf_fd, &out_binding);
+	if (err)
+		goto err_unlock;
+
+	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		if (nla_type(attr) != NETDEV_A_BIND_DMABUF_QUEUES)
+			continue;
+
+		err = nla_parse_nested(
+			tb, ARRAY_SIZE(netdev_queue_dmabuf_nl_policy) - 1, attr,
+			netdev_queue_dmabuf_nl_policy, info->extack);
+		if (err < 0)
+			goto err_unbind;
+
+		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_DMABUF_IDX]);
+
+		err = net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx,
+						      out_binding);
+		if (err)
+			goto err_unbind;
+	}
+
+	sock_binding_list = genl_sk_priv_get(&netdev_nl_family,
+					     NETLINK_CB(skb).sk);
+	if (IS_ERR(sock_binding_list)) {
+		err = PTR_ERR(sock_binding_list);
+		goto err_unbind;
+	}
+
+	list_add(&out_binding->list, sock_binding_list);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp) {
+		err = -ENOMEM;
+		goto err_unbind;
+	}
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_genlmsg_free;
+	}
+
+	nla_put_u32(rsp, NETDEV_A_BIND_DMABUF_DMABUF_ID, out_binding->id);
+	genlmsg_end(rsp, hdr);
+
+	rtnl_unlock();
+
+	return genlmsg_reply(rsp, info);
+
+err_genlmsg_free:
+	nlmsg_free(rsp);
+err_unbind:
+	net_devmem_unbind_dmabuf(out_binding);
+err_unlock:
+	rtnl_unlock();
+	return err;
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
@@ -771,3 +854,17 @@ static int __init netdev_genl_init(void)
 }
 
 subsys_initcall(netdev_genl_init);
+
+void netdev_nl_sock_priv_init(struct list_head *priv)
+{
+	INIT_LIST_HEAD(priv);
+}
+
+void netdev_nl_sock_priv_destroy(struct list_head *priv)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	struct net_devmem_dmabuf_binding *temp;
+
+	list_for_each_entry_safe(binding, temp, priv, list)
+		net_devmem_unbind_dmabuf(binding);
+}
-- 
2.45.2.505.gda0bf45e8d-goog


