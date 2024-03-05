Return-Path: <linux-arch+bounces-2793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20DB8712DE
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 03:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124431C20F08
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783C248CD4;
	Tue,  5 Mar 2024 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJ4N1cNG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63425565
	for <linux-arch@vger.kernel.org>; Tue,  5 Mar 2024 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604133; cv=none; b=G7fhBD6XN/NnzGlzN5mZ1M8xRLYDlhVMViIUAwWi+HlvRi8eKUZdQtcVPuFbhNXjNVCGE6vul4vpAFv8rhQAY///T3EYXUvKRC5B9QYqg9yRlYTDtOkPkETq2WKOHPziekE4sudt/B3GqI/wqmSk+ss4e44STx2eitNzu8oJOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604133; c=relaxed/simple;
	bh=T0qV65XkAxB3ctQN5jS97vYAxzQJyzeEP40ncb8u/BE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LllNH70ua9J/K7aawXgXePO8kwm4T/a84h6sZm0+pQIXFJhtA8fNo+93lO4ylknrO1didvpzSIcIM99il+CRe0cR16oaZozld3lCqG7JA8GsGOb8tPRYWzLljwwET09dfds1Wz6LghiRkq4Eop6zuJmLiyFu2p3b4uLJUUN+z+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJ4N1cNG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so7860139276.2
        for <linux-arch@vger.kernel.org>; Mon, 04 Mar 2024 18:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709604128; x=1710208928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QY3DuM4qplU/KN4X3vmRPMJtzSSfTGWtfxbkC1MqWMw=;
        b=WJ4N1cNGyQu7HinPUPNRJsWDNxfYHiVh5+uS/QVn9+DM+dknDpYBZuh151jC7Hw1qA
         tteR1luH8FJRC0fpLrB2b2SqYexs3DLwzLy1A7z5skD9ycX9w0UfIQCrX2p2bvRHIoag
         PKE705x6rpvdgRs7RffmzoUHvKk+uB/g0DsGkeBuhtw7Ye0KZDncIkHiD4gg32gHKp53
         exqPJpcMuH6aHsOtvqSjzSdLtJ+2BShAoWM58L8d7PC/gDWtRffRyrKzaxbpDEV1eYCl
         tTWaGO2Hrh3g5/MwnGi3U7qWEnBIFt1q1S+eIJ/fd6yryi1ANBK3ab9K7B0STGs8Lsr7
         ZZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604128; x=1710208928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QY3DuM4qplU/KN4X3vmRPMJtzSSfTGWtfxbkC1MqWMw=;
        b=DylJ9EiUSo1jCYlxb2kzIxtOe3NQY197SEdGkWEHZWu4boLgvpMJgb0DRlG7rRQKhs
         JvzNYXNR8Uxrrpidbr7PDbyxCu4imw6vgFxtkTbmnHvTchkyeMG/F1ZSBl6BuTRJf4v3
         8nRtIAvG046mS7UYiLDDOlFYqe6xGyWExMKo8uQGEVMuQvU9dF+tKVeS1J4fFB1/FFF4
         PlvhoIffS9qpkpUhRx2MNu0+dTcNW58P47lKn74dRbS+HHTjYQqdaJkotcDslxoVjOgp
         j+1G6lWOmHMYWsYRe4LKIPHYYv4fg3ybm6sB+F6WV8vZND/ilQmRORP0Eg+0+JAQvYd+
         wQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgsGIH+xhphvqH+wsijFqZKdEI3JtrWMBsuFK0lUJHlTOfLOeV1cTXuzr4KU2sAXcunHQax0ZvFns+T2wn9SZ7J8T66k6cK60few==
X-Gm-Message-State: AOJu0YxZM0uIPIHFoPpCeLp8mbmGHf50L2QwwvV2E5RSdqUg5QjBAuYv
	BUW8Ds8oAGPAdcZcWFFvRrge8DNh3c9/XQXVerD/p3l8tNT6jhRN+6LPtmu7zwXVVj7Pq2Bsgd0
	m3hKzemYuZ/uYUpXF4LmoqQ==
X-Google-Smtp-Source: AGHT+IEFQdHj2OFnh1b5rSYsHcYYdvvvtESy3jObBse5Vk+f2iTlIM6JkWI3fQET6RLpMtbi4+Kar8z9bXGQUnnTHQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b614:914c:63cd:3830])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1142:b0:dce:5218:c89b with
 SMTP id p2-20020a056902114200b00dce5218c89bmr468010ybu.5.1709604128353; Mon,
 04 Mar 2024 18:02:08 -0800 (PST)
Date: Mon,  4 Mar 2024 18:01:40 -0800
In-Reply-To: <20240305020153.2787423-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305020153.2787423-6-almasrymina@google.com>
Subject: [RFC PATCH net-next v6 05/15] netdev: support binding dma-buf to netdevice
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
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
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

RFC v6:
- Validate rx queue index
- Refactor new functions into devmem.c (Pavel)

RFC v5:
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
 include/net/devmem.h          | 115 +++++++++++++
 include/net/netdev_rx_queue.h |   1 +
 include/net/netmem.h          |  10 ++
 net/core/Makefile             |   2 +-
 net/core/dev.c                |   3 +
 net/core/devmem.c             | 293 ++++++++++++++++++++++++++++++++++
 net/core/netdev-genl.c        | 121 +++++++++++++-
 7 files changed, 542 insertions(+), 3 deletions(-)
 create mode 100644 include/net/devmem.h
 create mode 100644 net/core/devmem.c

diff --git a/include/net/devmem.h b/include/net/devmem.h
new file mode 100644
index 000000000000..85ccbbe84c65
--- /dev/null
+++ b/include/net/devmem.h
@@ -0,0 +1,115 @@
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
+struct netdev_dmabuf_binding {
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
+	/* The portid of the user that owns this binding. Used for netlink to
+	 * notify us of the user dropping the bind.
+	 */
+	u32 owner_nlportid;
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
+	struct netdev_dmabuf_binding *binding;
+};
+
+#ifdef CONFIG_DMA_SHARED_BUFFER
+void __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding);
+int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netdev_dmabuf_binding **out);
+void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding);
+int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				struct netdev_dmabuf_binding *binding);
+#else
+static inline void
+__netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding)
+{
+}
+
+static inline int netdev_bind_dmabuf(struct net_device *dev,
+				     unsigned int dmabuf_fd,
+				     struct netdev_dmabuf_binding **out)
+{
+	return -EOPNOTSUPP;
+}
+static inline void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding)
+{
+}
+
+static inline int
+netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+			    struct netdev_dmabuf_binding *binding)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+static inline void
+netdev_dmabuf_binding_get(struct netdev_dmabuf_binding *binding)
+{
+	refcount_inc(&binding->ref);
+}
+
+static inline void
+netdev_dmabuf_binding_put(struct netdev_dmabuf_binding *binding)
+{
+	if (!refcount_dec_and_test(&binding->ref))
+		return;
+
+	__netdev_dmabuf_binding_free(binding);
+}
+
+#endif /* _NET_DEVMEM_H */
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index aa1716fb0e53..5dc35628633a 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -25,6 +25,7 @@ struct netdev_rx_queue {
 	 * Readers and writers must hold RTNL
 	 */
 	struct napi_struct		*napi;
+	struct netdev_dmabuf_binding *binding;
 } ____cacheline_aligned_in_smp;
 
 /*
diff --git a/include/net/netmem.h b/include/net/netmem.h
index d8b810245c1d..72e932a1a948 100644
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
diff --git a/net/core/Makefile b/net/core/Makefile
index 821aec06abf1..592f955c1241 100644
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
index fe054cbd41e9..bbea1b252529 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -155,6 +155,9 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
+#include <linux/genalloc.h>
+#include <linux/dma-buf.h>
+#include <net/devmem.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
diff --git a/net/core/devmem.c b/net/core/devmem.c
new file mode 100644
index 000000000000..779ad990971e
--- /dev/null
+++ b/net/core/devmem.c
@@ -0,0 +1,293 @@
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
+
+/* Device memory support */
+
+#ifdef CONFIG_DMA_SHARED_BUFFER
+static void netdev_dmabuf_free_chunk_owner(struct gen_pool *genpool,
+					   struct gen_pool_chunk *chunk,
+					   void *not_used)
+{
+	struct dmabuf_genpool_chunk_owner *owner = chunk->owner;
+
+	kvfree(owner->niovs);
+	kfree(owner);
+}
+
+void __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding)
+{
+	size_t size, avail;
+
+	gen_pool_for_each_chunk(binding->chunk_pool,
+				netdev_dmabuf_free_chunk_owner, NULL);
+
+	size = gen_pool_size(binding->chunk_pool);
+	avail = gen_pool_avail(binding->chunk_pool);
+
+	if (!WARN(size != avail, "can't destroy genpool. size=%lu, avail=%lu",
+		  size, avail))
+		gen_pool_destroy(binding->chunk_pool);
+
+	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
+				 DMA_BIDIRECTIONAL);
+	dma_buf_detach(binding->dmabuf, binding->attachment);
+	dma_buf_put(binding->dmabuf);
+	xa_destroy(&binding->bound_rxq_list);
+	kfree(binding);
+}
+
+static int netdev_restart_rx_queue(struct net_device *dev, int rxq_idx)
+{
+	void *new_mem;
+	void *old_mem;
+	int err;
+
+	if (!dev || !dev->netdev_ops)
+		return -EINVAL;
+
+	if (!dev->netdev_ops->ndo_queue_stop ||
+	    !dev->netdev_ops->ndo_queue_mem_free ||
+	    !dev->netdev_ops->ndo_queue_mem_alloc ||
+	    !dev->netdev_ops->ndo_queue_start)
+		return -EOPNOTSUPP;
+
+	new_mem = dev->netdev_ops->ndo_queue_mem_alloc(dev, rxq_idx);
+	if (!new_mem)
+		return -ENOMEM;
+
+	err = dev->netdev_ops->ndo_queue_stop(dev, rxq_idx, &old_mem);
+	if (err)
+		goto err_free_new_mem;
+
+	err = dev->netdev_ops->ndo_queue_start(dev, rxq_idx, new_mem);
+	if (err)
+		goto err_start_queue;
+
+	dev->netdev_ops->ndo_queue_mem_free(dev, old_mem);
+
+	return 0;
+
+err_start_queue:
+	dev->netdev_ops->ndo_queue_start(dev, rxq_idx, old_mem);
+
+err_free_new_mem:
+	dev->netdev_ops->ndo_queue_mem_free(dev, new_mem);
+
+	return err;
+}
+
+/* Protected by rtnl_lock() */
+static DEFINE_XARRAY_FLAGS(netdev_dmabuf_bindings, XA_FLAGS_ALLOC1);
+
+void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding)
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
+		if (rxq->binding == binding) {
+			/* We hold the rtnl_lock while binding/unbinding
+			 * dma-buf, so we can't race with another thread that
+			 * is also modifying this value. However, the driver
+			 * may read this config while it's creating its
+			 * rx-queues. WRITE_ONCE() here to match the
+			 * READ_ONCE() in the driver.
+			 */
+			WRITE_ONCE(rxq->binding, NULL);
+
+			rxq_idx = get_netdev_rx_queue_index(rxq);
+
+			netdev_restart_rx_queue(binding->dev, rxq_idx);
+		}
+	}
+
+	xa_erase(&netdev_dmabuf_bindings, binding->id);
+
+	netdev_dmabuf_binding_put(binding);
+}
+
+int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				struct netdev_dmabuf_binding *binding)
+{
+	struct netdev_rx_queue *rxq;
+	u32 xa_idx;
+	int err;
+
+	if (rxq_idx >= dev->num_rx_queues)
+		return -ERANGE;
+
+	rxq = __netif_get_rx_queue(dev, rxq_idx);
+
+	if (rxq->binding)
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
+	WRITE_ONCE(rxq->binding, binding);
+
+	err = netdev_restart_rx_queue(dev, rxq_idx);
+	if (err)
+		goto err_xa_erase;
+
+	return 0;
+
+err_xa_erase:
+	xa_erase(&binding->bound_rxq_list, xa_idx);
+	WRITE_ONCE(rxq->binding, NULL);
+
+	return err;
+}
+
+int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netdev_dmabuf_binding **out)
+{
+	struct netdev_dmabuf_binding *binding;
+	static u32 id_alloc_next;
+	struct scatterlist *sg;
+	struct dma_buf *dmabuf;
+	unsigned int sg_idx, i;
+	unsigned long virtual;
+	int err;
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	dmabuf = dma_buf_get(dmabuf_fd);
+	if (IS_ERR_OR_NULL(dmabuf))
+		return -EBADFD;
+
+	binding = kzalloc_node(sizeof(*binding), GFP_KERNEL,
+			       dev_to_node(&dev->dev));
+	if (!binding) {
+		err = -ENOMEM;
+		goto err_put_dmabuf;
+	}
+	binding->dev = dev;
+
+	err = xa_alloc_cyclic(&netdev_dmabuf_bindings, &binding->id, binding,
+			      xa_limit_32b, &id_alloc_next, GFP_KERNEL);
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
+				netdev_dmabuf_free_chunk_owner, NULL);
+	gen_pool_destroy(binding->chunk_pool);
+err_unmap:
+	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
+				 DMA_BIDIRECTIONAL);
+err_detach:
+	dma_buf_detach(dmabuf, binding->attachment);
+err_free_id:
+	xa_erase(&netdev_dmabuf_bindings, binding->id);
+err_free_binding:
+	kfree(binding);
+err_put_dmabuf:
+	dma_buf_put(dmabuf);
+	return err;
+}
+#endif
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 0ed292d87ae0..8f0867ae5eeb 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -9,6 +9,7 @@
 #include <net/xdp_sock.h>
 #include <net/netdev_rx_queue.h>
 #include <net/busy_poll.h>
+#include <net/devmem.h>
 
 #include "netdev-genl-gen.h"
 #include "dev.h"
@@ -469,10 +470,93 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
-/* Stub */
+static LIST_HEAD(netdev_rbinding_list);
+
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return 0;
+	struct nlattr *tb[ARRAY_SIZE(netdev_queue_dmabuf_nl_policy)];
+	struct netdev_dmabuf_binding *out_binding;
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
+	err = netdev_bind_dmabuf(netdev, dmabuf_fd, &out_binding);
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
+
+		if (err < 0)
+			goto err_unbind;
+
+		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_DMABUF_IDX]);
+
+		if (rxq_idx >= netdev->num_rx_queues) {
+			err = -ERANGE;
+			goto err_unbind;
+		}
+
+		err = netdev_bind_dmabuf_to_queue(netdev, rxq_idx, out_binding);
+		if (err)
+			goto err_unbind;
+	}
+
+	out_binding->owner_nlportid = info->snd_portid;
+	list_add(&out_binding->list, &netdev_rbinding_list);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp) {
+		err = -ENOMEM;
+		goto err_unbind;
+	}
+
+	hdr = genlmsg_put(rsp, info->snd_portid, info->snd_seq,
+			  &netdev_nl_family, 0, info->genlhdr->cmd);
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
+	netdev_unbind_dmabuf(out_binding);
+err_unlock:
+	rtnl_unlock();
+	return err;
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
@@ -495,10 +579,37 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int netdev_netlink_notify(struct notifier_block *nb, unsigned long state,
+				 void *_notify)
+{
+	struct netlink_notify *notify = _notify;
+	struct netdev_dmabuf_binding *rbinding;
+
+	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
+		return NOTIFY_DONE;
+
+	rtnl_lock();
+
+	list_for_each_entry(rbinding, &netdev_rbinding_list, list) {
+		if (rbinding->owner_nlportid == notify->portid) {
+			netdev_unbind_dmabuf(rbinding);
+			break;
+		}
+	}
+
+	rtnl_unlock();
+
+	return NOTIFY_OK;
+}
+
 static struct notifier_block netdev_genl_nb = {
 	.notifier_call	= netdev_genl_netdevice_event,
 };
 
+static struct notifier_block netdev_netlink_notifier = {
+	.notifier_call = netdev_netlink_notify,
+};
+
 static int __init netdev_genl_init(void)
 {
 	int err;
@@ -511,8 +622,14 @@ static int __init netdev_genl_init(void)
 	if (err)
 		goto err_unreg_ntf;
 
+	err = netlink_register_notifier(&netdev_netlink_notifier);
+	if (err)
+		goto err_unreg_family;
+
 	return 0;
 
+err_unreg_family:
+	genl_unregister_family(&netdev_nl_family);
 err_unreg_ntf:
 	unregister_netdevice_notifier(&netdev_genl_nb);
 	return err;
-- 
2.44.0.rc1.240.g4c46232300-goog


