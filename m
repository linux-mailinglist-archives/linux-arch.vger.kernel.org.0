Return-Path: <linux-arch+bounces-6354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCED957D6F
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 08:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6692A283C06
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 06:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAABA15B54B;
	Tue, 20 Aug 2024 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHNpqZ5V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12215C13C
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133910; cv=none; b=TytX9G6kBNcT038aJpRkzJhMzpNZ3CDIQ9VvY21NzUI1RGRSUcIc7vJRQtceW+MF0n5g5ZgrcSh8DeNJjUzq3bszPCpu+fhQsJWp8ht7ukNFZlP1iAREUAPxJbK0XTO7kcOKAJ4t6EiU0JtsMnoatcETNz5RRrWl94MpbvIg1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133910; c=relaxed/simple;
	bh=nbb5pyZ8t8794ZNp3j7udyt9guopezZmvQ5JLYPTAAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g+1ieP3m4naI3hDaRE3eS9JmYiwdaSyK4lXIE4S15AmA+V6RcpfnXuARNroJSXG1AwHcUkahzM49hZuHf5RdHonR51Sbkkl/kGsHa5zCvRTJ2OQxS6V0TeRzmTWfoHiqv7CL2cMJSwmygXOiJmooeVs0Tpitk7OfGOnZJ4Ibrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHNpqZ5V; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b71aa9349dso39535997b3.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 23:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724133904; x=1724738704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2K44zR0T8E1hkekkM0TdYT2cdHj1vI89dtBA8wdsIB8=;
        b=vHNpqZ5VnnZQyxb0A4vPYNciaTnZenTX1fGx2XTPCRK+3A8bmo/g2nsyCbdc1BRLlS
         KF4Jh71IGoOoKYiDg9sKcIhZffSkYYpb0mTktSHtPJnMRgvYmK8vTuJHS1expQb0SPmF
         5SfyrI05WRVsZVTyS+jTxiChPwwa7j2Y4Ku/AHS6z94zlS7gXsfhSyDQ2AAI2u2uTgDV
         oOG/e/07ecqQAiN5bJsnDuOJ//+or7AVTKs1Mdv1n0DxXQBtUoZ0rjFodKzhW2pwljAu
         W70JrcLGRy1AIIaM6OByv8W7WNwf+Kjm3ie1jFjpkGbG1w+FAxmLUVbQDcRQZXc6gMnF
         cUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724133904; x=1724738704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2K44zR0T8E1hkekkM0TdYT2cdHj1vI89dtBA8wdsIB8=;
        b=r3USa+YhmkESWFl46BwfFWGcHbBcAcSUpfnV5PG6O38RRdfm/977gXRohui7urGugK
         dVqNqnvCIqIG9vkxFG5880nrRcBXPxPFjjgsrIVNpZ8+yE1fviFinfV3/B/YM7Cl4vgI
         4Eb9QcWazfVhfLUORT3g/JS6IW+vh04ZPaca48ehBeFB9ZDskwHmm8/xeodjA5h7fwzZ
         r2dhq8oOxXrJ/5TKdswht1ZgyKPOlbdQVzX+lttkZgVgVe1qh61P4GBww8nvAt1Nagph
         5httQcQ8BoOS0nZAwf+Z/9wjCDjJA2gYzKinOLOnpiGNQmbLqwukO3aMbhVy/fvkR6Gh
         qYBw==
X-Forwarded-Encrypted: i=1; AJvYcCWaUazDJXcrr5aKY4vibsXAELhw7loa51voyhqAYs1sxI2pdzjUdX1DEiZDwqVKgV34UvW5IPaKzmWFKZpL6w0Bn502nW7Zm/Sk5w==
X-Gm-Message-State: AOJu0YwXnOyR/H3PNSbo3zYS8YBtqtPj/cfGaGODjf6TEkdpw+A8/oxc
	z3QwBQRNZJ5TBKC4VvnVFRDpULGn1VmWYCjM2G9iDKzy3aBqdAmmUqmhqrPv5XYcXFWw2JY0Dlh
	nhrg2KCJdwrmBx+E36DaQ5Q==
X-Google-Smtp-Source: AGHT+IF3Am/Xi+5yq8vMb8XFlPA/wUXcE8HL7dBpX5yWUBAc8O//tSd5dE5jBBEnS6WNz3Jjr4BcSYDxdtS363t9IQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:2711:b0:6b2:7bd8:d79d with
 SMTP id 00721157ae682-6b27bd8da5emr288327b3.8.1724133903536; Mon, 19 Aug 2024
 23:05:03 -0700 (PDT)
Date: Tue, 20 Aug 2024 06:04:46 +0000
In-Reply-To: <20240820060456.1485518-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240820060456.1485518-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820060456.1485518-4-almasrymina@google.com>
Subject: [PATCH net-next v21 03/13] netdev: support binding dma-buf to netdevice
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>
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
that the given queue is bound, and the binding is actuated by resetting
the rx queue using the queue API.

The netdev_dmabuf_binding struct is refcounted, and releases its
resources only when all the refs are released.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com> # excluding netlink
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

---

v21:

- Move definition of net_devmem_dmabuf_bindings to inside the #ifdef to
  prevent unused static variable warning.

v20:
- rename dev_get_max_mp_channel to dev_get_min_mp_channel_count (Jakub)
- Removed unnecessary includes from dev.c
- Fixed bug with return value of dev_get_min_mp_channel_count getting
  implicitly cast to unsigned int (Jakub)
- Combine netlink attr checks into one statement with || (Jakub)
- Removed unnecessary include from ethtool/common.c

v19:
- Prevent deactivating queues bound to mp (Jakub).
- disable attaching xdp to memory provider netdev (Jakub).
- Address various nits from Jakub.
- In the netlink API, check for presence of queue_id, queue_type and
  that the queue_type is RX (Jakub).

v17:
- Add missing kfree(owner) (Jakub)
- Fix issue found by Taehee, where may access an rxq that has already
  been freed if the driver has been unloaded in the meantime (thanks!)

v16:
- Fix rtnl_lock() not being acquired on unbind path (Reported by
  Taehee).
- Use unlocked versions of dma_buf_[un]map_attachment (Reported by
  Taehee).
- Use real_num_rx_queues instead of num_rx_queues (Taehee).
- bound_rxq_list -> bound_rxqs (Jakub).
- Removed READ_ONCE/WRITE_ONCE infavor of rtnl_lock() sync. (Jakub).
- Use ERR_CAST instead of out param (Jakub).
- Add NULL Check for kzalloc_node() call (Paolo).
- Move genl_sk_priv_get, genlmsg_new, genlmsg_input outside of the lock
  acquisition (Jakub).
- Add netif_device_present() check (Jakub).
- Use nla_for_each_attr_type(Jakub).

v13:
- Fixed a couple of places that still listed DMA_BIDIRECTIONAL (Pavel).
- Added reviewed-by from Pavel.

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
 include/linux/netdevice.h               |   2 +
 include/net/devmem.h                    | 115 +++++++++++
 include/net/netdev_rx_queue.h           |   2 +
 include/net/netmem.h                    |  10 +
 include/net/page_pool/types.h           |   6 +
 net/core/Makefile                       |   2 +-
 net/core/dev.c                          |  19 ++
 net/core/devmem.c                       | 262 ++++++++++++++++++++++++
 net/core/netdev-genl-gen.c              |   4 +
 net/core/netdev-genl-gen.h              |   4 +
 net/core/netdev-genl.c                  | 106 +++++++++-
 net/ethtool/common.c                    |   8 +
 13 files changed, 541 insertions(+), 3 deletions(-)
 create mode 100644 include/net/devmem.h
 create mode 100644 net/core/devmem.c

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 4930e8142aa6..0c747530c275 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -667,6 +667,10 @@ operations:
           attributes:
             - id
 
+kernel-family:
+  headers: [ "linux/list.h"]
+  sock-priv: struct list_head
+
 mcast-groups:
   list:
     -
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0ef3eaa23f4b..0f448216ee0c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3920,6 +3920,8 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
+u32 dev_get_min_mp_channel_count(const struct net_device *dev);
+
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
diff --git a/include/net/devmem.h b/include/net/devmem.h
new file mode 100644
index 000000000000..c7bd6a0a6b9e
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
+	struct xarray bound_rxqs;
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
+struct net_devmem_dmabuf_binding *
+net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd);
+void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
+int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				    struct net_devmem_dmabuf_binding *binding);
+void dev_dmabuf_uninstall(struct net_device *dev);
+#else
+static inline void
+__net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
+{
+}
+
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd)
+{
+	return ERR_PTR(-EOPNOTSUPP);
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
+
+static inline void dev_dmabuf_uninstall(struct net_device *dev)
+{
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
index e78ca52d67fb..ac34f5fb4f71 100644
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
index 46cc9b89ac79..41e96c2f94b5 100644
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
index 50569fed7868..4afd6dd56351 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -139,6 +139,10 @@ struct page_pool_stats {
  */
 #define PAGE_POOL_FRAG_GROUP_ALIGN	(4 * sizeof(long))
 
+struct pp_memory_provider_params {
+	void *mp_priv;
+};
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
@@ -197,6 +201,8 @@ struct page_pool {
 	 */
 	struct ptr_ring ring;
 
+	void *mp_priv;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/Makefile b/net/core/Makefile
index f82232b358a2..6b43611fb4a4 100644
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
index e7260889d4cb..019f86a3d614 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9537,6 +9537,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 			NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the same time");
 			return -EEXIST;
 		}
+		if (dev_get_min_mp_channel_count(dev)) {
+			NL_SET_ERR_MSG(extack, "XDP can't be installed on a netdev using memory providers");
+			return -EINVAL;
+		}
 		if (!offload && bpf_prog_is_offloaded(new_prog->aux)) {
 			NL_SET_ERR_MSG(extack, "Using offloaded program without HW_MODE flag is not supported");
 			return -EINVAL;
@@ -9821,6 +9825,20 @@ int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
 	return err;
 }
 
+u32 dev_get_min_mp_channel_count(const struct net_device *dev)
+{
+	u32 i, max = 0;
+
+	ASSERT_RTNL();
+
+	for (i = 0; i < dev->real_num_rx_queues; i++)
+		if (dev->_rx[i].mp_params.mp_priv)
+			/* The channel count is the idx plus 1. */
+			max = i + 1;
+
+	return max;
+}
+
 /**
  * dev_index_reserve() - allocate an ifindex in a namespace
  * @net: the applicable net namespace
@@ -11343,6 +11361,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_tcx_uninstall(dev);
 		dev_xdp_uninstall(dev);
 		bpf_dev_bound_netdev_unregister(dev);
+		dev_dmabuf_uninstall(dev);
 
 		netdev_offload_xstats_disable_all(dev);
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
new file mode 100644
index 000000000000..0787311a8cdf
--- /dev/null
+++ b/net/core/devmem.c
@@ -0,0 +1,262 @@
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
+/* Protected by rtnl_lock() */
+static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
+
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
+	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
+					  DMA_FROM_DEVICE);
+	dma_buf_detach(binding->dmabuf, binding->attachment);
+	dma_buf_put(binding->dmabuf);
+	xa_destroy(&binding->bound_rxqs);
+	kfree(binding);
+}
+
+void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
+{
+	struct netdev_rx_queue *rxq;
+	unsigned long xa_idx;
+	unsigned int rxq_idx;
+
+	if (binding->list.next)
+		list_del(&binding->list);
+
+	xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
+		if (rxq->mp_params.mp_priv == binding) {
+			rxq->mp_params.mp_priv = NULL;
+
+			rxq_idx = get_netdev_rx_queue_index(rxq);
+
+			WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
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
+	if (rxq_idx >= dev->real_num_rx_queues)
+		return -ERANGE;
+
+	rxq = __netif_get_rx_queue(dev, rxq_idx);
+	if (rxq->mp_params.mp_priv)
+		return -EEXIST;
+
+	if (dev_xdp_prog_count(dev))
+		return -EEXIST;
+
+	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b,
+		       GFP_KERNEL);
+	if (err)
+		return err;
+
+	rxq->mp_params.mp_priv = binding;
+
+	err = netdev_rx_queue_restart(dev, rxq_idx);
+	if (err)
+		goto err_xa_erase;
+
+	return 0;
+
+err_xa_erase:
+	rxq->mp_params.mp_priv = NULL;
+	xa_erase(&binding->bound_rxqs, xa_idx);
+
+	return err;
+}
+
+struct net_devmem_dmabuf_binding *net_devmem_bind_dmabuf(struct net_device *dev,
+							 unsigned int dmabuf_fd)
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
+		return ERR_CAST(dmabuf);
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
+	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
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
+	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
+						       DMA_FROM_DEVICE);
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
+		if (!owner) {
+			err = -ENOMEM;
+			goto err_free_chunks;
+		}
+
+		owner->base_virtual = virtual;
+		owner->base_dma_addr = dma_addr;
+		owner->num_niovs = len / PAGE_SIZE;
+		owner->binding = binding;
+
+		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
+					 dma_addr, len, dev_to_node(&dev->dev),
+					 owner);
+		if (err) {
+			kfree(owner);
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
+	return binding;
+
+err_free_chunks:
+	gen_pool_for_each_chunk(binding->chunk_pool,
+				net_devmem_dmabuf_free_chunk_owner, NULL);
+	gen_pool_destroy(binding->chunk_pool);
+err_unmap:
+	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
+					  DMA_FROM_DEVICE);
+err_detach:
+	dma_buf_detach(dmabuf, binding->attachment);
+err_free_id:
+	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+err_free_binding:
+	kfree(binding);
+err_put_dmabuf:
+	dma_buf_put(dmabuf);
+	return ERR_PTR(err);
+}
+
+void dev_dmabuf_uninstall(struct net_device *dev)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	struct netdev_rx_queue *rxq;
+	unsigned long xa_idx;
+	unsigned int i;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		binding = dev->_rx[i].mp_params.mp_priv;
+		if (!binding)
+			continue;
+
+		xa_for_each(&binding->bound_rxqs, xa_idx, rxq)
+			if (rxq == &dev->_rx[i])
+				xa_erase(&binding->bound_rxqs, xa_idx);
+	}
+}
+#endif
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 6b7fe6035067..b28424ae06d5 100644
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
index 67c34005750c..8cda334fd042 100644
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
index 2d726e65211d..4201f9555772 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -10,6 +10,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/busy_poll.h>
+#include <net/devmem.h>
 
 #include "netdev-genl-gen.h"
 #include "dev.h"
@@ -721,10 +722,111 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
-/* Stub */
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return 0;
+	struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
+	struct net_devmem_dmabuf_binding *binding;
+	struct list_head *sock_binding_list;
+	u32 ifindex, dmabuf_fd, rxq_idx;
+	struct net_device *netdev;
+	struct sk_buff *rsp;
+	struct nlattr *attr;
+	int rem, err = 0;
+	void *hdr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_QUEUES))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
+	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
+
+	sock_binding_list = genl_sk_priv_get(&netdev_nl_family,
+					     NETLINK_CB(skb).sk);
+	if (IS_ERR(sock_binding_list))
+		return PTR_ERR(sock_binding_list);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_genlmsg_free;
+	}
+
+	rtnl_lock();
+
+	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
+	if (!netdev || !netif_device_present(netdev)) {
+		err = -ENODEV;
+		goto err_unlock;
+	}
+
+	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd);
+	if (IS_ERR(binding)) {
+		err = PTR_ERR(binding);
+		goto err_unlock;
+	}
+
+	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
+			       genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem) {
+		err = nla_parse_nested(
+			tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, attr,
+			netdev_queue_id_nl_policy, info->extack);
+		if (err < 0)
+			goto err_unbind;
+
+		if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_ID) ||
+		    NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_TYPE) ||
+		    nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
+			err = -EINVAL;
+			goto err_unlock;
+		}
+
+		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
+
+		err = net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx, binding);
+		if (err)
+			goto err_unbind;
+	}
+
+	list_add(&binding->list, sock_binding_list);
+
+	rtnl_unlock();
+
+	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
+	genlmsg_end(rsp, hdr);
+
+	return genlmsg_reply(rsp, info);
+
+err_unbind:
+	net_devmem_unbind_dmabuf(binding);
+err_unlock:
+	rtnl_unlock();
+err_genlmsg_free:
+	nlmsg_free(rsp);
+	return err;
+}
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
+	list_for_each_entry_safe(binding, temp, priv, list) {
+		rtnl_lock();
+		net_devmem_unbind_dmabuf(binding);
+		rtnl_unlock();
+	}
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7257ae272296..496a5f040142 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -657,6 +657,7 @@ int ethtool_check_max_channel(struct net_device *dev,
 {
 	u64 max_rxnfc_in_use;
 	u32 max_rxfh_in_use;
+	int max_mp_in_use;
 
 	/* ensure the new Rx count fits within the configured Rx flow
 	 * indirection table/rxnfc settings
@@ -675,6 +676,13 @@ int ethtool_check_max_channel(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	max_mp_in_use = dev_get_min_mp_channel_count(dev);
+	if (channels.combined_count + channels.rx_count <= max_mp_in_use) {
+		if (info)
+			GENL_SET_ERR_MSG_FMT(info, "requested channel counts are too low for existing memory provider setting (%d)", max_mp_in_use);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.46.0.184.g6999bdac58-goog


