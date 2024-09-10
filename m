Return-Path: <linux-arch+bounces-7187-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDBF973E99
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 19:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B900B26E1C
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB5A1A2643;
	Tue, 10 Sep 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4+VPHWb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659B1A38CA
	for <linux-arch@vger.kernel.org>; Tue, 10 Sep 2024 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988514; cv=none; b=VSMPH1yQ+fKhlo5QB6XOzPIbJwggeJG6wweNN8L99ceg0BTGP/Kyy8v9v3NrqtDLfOVgcuGfbhsDoiqDqvfHA+FRgiXJfuZdlx1QICBfPEnqpf2SIN0LDEJorDcBvz0iA/CTh74xWujxHXRA4qkr8MmgXf0b2siBv2oXN/f/OF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988514; c=relaxed/simple;
	bh=RgyNAfEBhp/smBQtbpfWq+lkVMYaMsQIm+aQ3M/26bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C+kUvK9EuRQx/Tbkdt1eIFSeWTTRsy4ONcoEa/Kvv7VdHqloPAGUwiqY5y8UCSjxRZ+UePn9NRBSeGM2EdTLfHZ3SUAMIjcrZTX7LRNGQ4oFDe3EqxiXOjr9U2PNnSoFYOm8kye0+cCFMfSDTeZYGlJ2RU7A66L/qYj0+6lWuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P4+VPHWb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d882c11ce4so6055024a91.2
        for <linux-arch@vger.kernel.org>; Tue, 10 Sep 2024 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725988507; x=1726593307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dPKXKPWBPhBtsBzC/xYTXNqzchTyIq+Cb/jvxLoqT7A=;
        b=P4+VPHWbU+q0175//NWMbtLnn02RG++o2K++LpE9cboj37e498U5wmJ+3ltzmsCf5I
         UL+suYFtJl5FyNeLkYSPfDOjZheKOSIZWWdru2U0KrBFyrUQyGTmiZ047qIK0KVnt+sM
         edyU+c1U+iAQ7X9JKErW8zPe/JfljA3szddC6w1gu0PjX87BjHsNQeUgVwUHbSSi2lgM
         fneDs64+2MSxk7crq6MUMQTWzCPbBCD9/gC3fK9A3VUoY3ypPdxf56DiY2/7tdzQZOOD
         veJ8lMwxJRo2KHEOIlAzj2SDT5JD6IFwZPUEVAlRf+KeIr76XgPJTG8X/fFGPv3d9Xrk
         sR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988507; x=1726593307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPKXKPWBPhBtsBzC/xYTXNqzchTyIq+Cb/jvxLoqT7A=;
        b=BOzN62pSZimlXlqqCkkkSlxr2qUbLTXhtAn3QBK8Mm/xQBYGMc2woAOZfjAjsQSufy
         kIBKgPmIeCYgIC1OT43W0e9FP+7xwbm0yZarvnygQUKPKUBzyswddIkLOivTom7Ai9aV
         S3kVCs0ZTLq9Ab0VaiSMsfTKdg0ia2ybTqiHFdiNWhAxvb97OoITyPsdsOz0oniZGcGG
         3ie+M008aymFsTvcHvmcr7+2D3ZaCJx4Y0FOid+bWjmboJrg+okysK4rqca4Nc4Xt7QC
         PD4hrokf6PPEKp0ZAtUtq+EnpyBgkbXh9BpVjOmNdP+Sl4cDEPi6z/opGicbe8Xf2O6t
         2dcg==
X-Forwarded-Encrypted: i=1; AJvYcCXLm6BJSjuC1/S6BaeAM7LxUfHm/7NhsH2ozbNtIc/+75O7V0MvMkeUG1n+XqTexXfiipOi9vjmMfVI@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRE+mvuDFKSdmOYK6QV4OObm7fiLdj1WuzthHHCLAGJxN2+FY
	DizZUKArTDqrvMzEUPhWClmjKatt8EUKIKcKu2Z/3PxyShdBhhsu+TuTRQIkSSDQ9mtkYqDEO8n
	y6KKQCO4UJU2sJRXkR58oUA==
X-Google-Smtp-Source: AGHT+IHprgEU5lGmB7zK4qOoPSG28gVrtG6xeSJrS/8FBFCxmDdNKwlLp8WA4Ju/fuJSlePVsz6KG1KtZVkFpwVTbA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a17:90a:d186:b0:2da:5a61:646f with
 SMTP id 98e67ed59e1d1-2dad51b75f6mr67079a91.8.1725988506872; Tue, 10 Sep 2024
 10:15:06 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:14:47 +0000
In-Reply-To: <20240910171458.219195-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910171458.219195-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910171458.219195-4-almasrymina@google.com>
Subject: [PATCH net-next v26 03/13] netdev: support binding dma-buf to netdevice
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>

---

v25:
- Move include/net/devmem.h to net/core/devmem.h.
- netmem.h no longer includes devmem.h (which enables moving devmem.h to
  internal include file).

v24:
- Fix a couple of problematic goto err_ on error paths (Jakub & Vadim)
- Add NL_SET_BAD_ATTR (Jakub).
- Fix wrong include order causing ynl check to fail (NIPA)
- Add extack error messages (Jakub).

v23:
- Create CONFIG_NET_DEVMEM instead of checking for
  CONFIG_DMA_SHARED_BUFFER && CONFIG_GENERIC_ALLOCATOR (Jakub).
- Rework loop in dev_get_min_mp_channel_count (Jakub).
- Sort includes (Jakub).
- WARN_ON if queue in bound_rxqs doesn't match the memory provider being
  unbound (Jakub).
- Add some extack error messages (Jakub).
- Move dev_xdp_prog_count check to the device bending rather than the
  queue binding (Jakub).
- goto err_unbind on genlmsg_reply failure (Jakub).

v22:
- Disable binding xdp to mp bound netdevs, and propagating xdp
  configuration to mp bound netdevs
- Add extack error messages.
- Prevent binding dmabuf to a queue with xsk_buff_pool (Jakub)
- Prevent xp_assign_dev to a device using memory provider (Jakub)

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
 include/net/netdev_rx_queue.h           |   2 +
 include/net/netmem.h                    |   8 +
 include/net/page_pool/types.h           |   6 +
 net/Kconfig                             |   5 +
 net/core/Makefile                       |   1 +
 net/core/dev.c                          |  26 +++
 net/core/devmem.c                       | 274 ++++++++++++++++++++++++
 net/core/devmem.h                       | 124 +++++++++++
 net/core/netdev-genl-gen.c              |   4 +
 net/core/netdev-genl-gen.h              |   4 +
 net/core/netdev-genl.c                  | 128 ++++++++++-
 net/ethtool/common.c                    |   8 +
 net/xdp/xsk_buff_pool.c                 |   5 +
 15 files changed, 596 insertions(+), 5 deletions(-)
 create mode 100644 net/core/devmem.c
 create mode 100644 net/core/devmem.h

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
index 2e40a137dc12..2a4c837065ca 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3942,6 +3942,8 @@ u8 dev_xdp_prog_count(struct net_device *dev);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
+u32 dev_get_min_mp_channel_count(const struct net_device *dev);
+
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
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
index 46cc9b89ac79..c23e224dd6a0 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -8,6 +8,14 @@
 #ifndef _NET_NETMEM_H
 #define _NET_NETMEM_H
 
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
diff --git a/net/Kconfig b/net/Kconfig
index d27d0deac0bf..7574b066d7cd 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -66,6 +66,11 @@ config SKB_DECRYPTED
 config SKB_EXTENSIONS
 	bool
 
+config NET_DEVMEM
+	def_bool y
+	depends on DMA_SHARED_BUFFER
+	depends on GENERIC_ALLOCATOR
+
 menu "Networking options"
 
 source "net/packet/Kconfig"
diff --git a/net/core/Makefile b/net/core/Makefile
index f82232b358a2..c3ebbaf9c81e 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
 obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
+obj-$(CONFIG_NET_DEVMEM) += devmem.o
diff --git a/net/core/dev.c b/net/core/dev.c
index 8f4dead64284..7818d7f6295e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -161,6 +161,7 @@
 #include <linux/phy_link_topology.h>
 
 #include "dev.h"
+#include "devmem.h"
 #include "net-sysfs.h"
 
 static DEFINE_SPINLOCK(ptype_lock);
@@ -9367,6 +9368,11 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
 
+	if (dev_get_min_mp_channel_count(dev)) {
+		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
+		return -EBUSY;
+	}
+
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
 EXPORT_SYMBOL_GPL(dev_xdp_propagate);
@@ -9399,6 +9405,11 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
+	if (dev_get_min_mp_channel_count(dev)) {
+		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
+		return -EBUSY;
+	}
+
 	memset(&xdp, 0, sizeof(xdp));
 	xdp.command = mode == XDP_MODE_HW ? XDP_SETUP_PROG_HW : XDP_SETUP_PROG;
 	xdp.extack = extack;
@@ -9823,6 +9834,20 @@ int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
 	return err;
 }
 
+u32 dev_get_min_mp_channel_count(const struct net_device *dev)
+{
+	int i;
+
+	ASSERT_RTNL();
+
+	for (i = dev->real_num_rx_queues - 1; i >= 0; i--)
+		if (dev->_rx[i].mp_params.mp_priv)
+			/* The channel count is the idx plus 1. */
+			return i + 1;
+
+	return 0;
+}
+
 /**
  * dev_index_reserve() - allocate an ifindex in a namespace
  * @net: the applicable net namespace
@@ -11359,6 +11384,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_tcx_uninstall(dev);
 		dev_xdp_uninstall(dev);
 		bpf_dev_bound_netdev_unregister(dev);
+		dev_dmabuf_uninstall(dev);
 
 		netdev_offload_xstats_disable_all(dev);
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
new file mode 100644
index 000000000000..8dd7beb080d2
--- /dev/null
+++ b/net/core/devmem.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *      Devmem TCP
+ *
+ *      Authors:	Mina Almasry <almasrymina@google.com>
+ *			Willem de Bruijn <willemdebruijn.kernel@gmail.com>
+ *			Kaiyuan Zhang <kaiyuanz@google.com
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/genalloc.h>
+#include <linux/mm.h>
+#include <linux/netdevice.h>
+#include <linux/types.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+#include <net/page_pool/helpers.h>
+#include <trace/events/page_pool.h>
+
+#include "devmem.h"
+
+/* Device memory support */
+
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
+		WARN_ON(rxq->mp_params.mp_priv != binding);
+
+		rxq->mp_params.mp_priv = NULL;
+
+		rxq_idx = get_netdev_rx_queue_index(rxq);
+
+		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
+	}
+
+	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+
+	net_devmem_dmabuf_binding_put(binding);
+}
+
+int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				    struct net_devmem_dmabuf_binding *binding,
+				    struct netlink_ext_ack *extack)
+{
+	struct netdev_rx_queue *rxq;
+	u32 xa_idx;
+	int err;
+
+	if (rxq_idx >= dev->real_num_rx_queues) {
+		NL_SET_ERR_MSG(extack, "rx queue index out of range");
+		return -ERANGE;
+	}
+
+	rxq = __netif_get_rx_queue(dev, rxq_idx);
+	if (rxq->mp_params.mp_priv) {
+		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
+		return -EEXIST;
+	}
+
+#ifdef CONFIG_XDP_SOCKETS
+	if (rxq->pool) {
+		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
+		return -EBUSY;
+	}
+#endif
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
+struct net_devmem_dmabuf_binding *
+net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netlink_ext_ack *extack)
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
+		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
+		goto err_free_id;
+	}
+
+	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
+						       DMA_FROM_DEVICE);
+	if (IS_ERR(binding->sgt)) {
+		err = PTR_ERR(binding->sgt);
+		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
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
+			if (rxq == &dev->_rx[i]) {
+				xa_erase(&binding->bound_rxqs, xa_idx);
+				break;
+			}
+	}
+}
diff --git a/net/core/devmem.h b/net/core/devmem.h
new file mode 100644
index 000000000000..c50f91d858dd
--- /dev/null
+++ b/net/core/devmem.h
@@ -0,0 +1,124 @@
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
+struct netlink_ext_ack;
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
+#if defined(CONFIG_NET_DEVMEM)
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
+void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
+struct net_devmem_dmabuf_binding *
+net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netlink_ext_ack *extack);
+void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
+int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				    struct net_devmem_dmabuf_binding *binding,
+				    struct netlink_ext_ack *extack);
+void dev_dmabuf_uninstall(struct net_device *dev);
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
+#else
+static inline void
+__net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
+{
+}
+
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netlink_ext_ack *extack)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void
+net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
+{
+}
+
+static inline int
+net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				struct net_devmem_dmabuf_binding *binding,
+				struct netlink_ext_ack *extack)
+
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dev_dmabuf_uninstall(struct net_device *dev)
+{
+}
+#endif
+
+#endif /* _NET_DEVMEM_H */
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
index 699c34b9b03c..9153a8ab0cf8 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -3,16 +3,17 @@
 #include <linux/netdevice.h>
 #include <linux/notifier.h>
 #include <linux/rtnetlink.h>
+#include <net/busy_poll.h>
 #include <net/net_namespace.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <net/sock.h>
 #include <net/xdp.h>
 #include <net/xdp_sock.h>
-#include <net/netdev_rx_queue.h>
-#include <net/netdev_queues.h>
-#include <net/busy_poll.h>
 
-#include "netdev-genl-gen.h"
 #include "dev.h"
+#include "devmem.h"
+#include "netdev-genl-gen.h"
 
 struct netdev_nl_dump_ctx {
 	unsigned long	ifindex;
@@ -723,10 +724,127 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
-/* Stub */
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
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
+	if (dev_xdp_prog_count(netdev)) {
+		NL_SET_ERR_MSG(info->extack, "unable to bind dmabuf to device with XDP program attached");
+		err = -EEXIST;
+		goto err_unlock;
+	}
+
+	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extack);
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
+		    NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_TYPE)) {
+			err = -EINVAL;
+			goto err_unbind;
+		}
+
+		if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
+			NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]);
+			err = -EINVAL;
+			goto err_unbind;
+		}
+
+		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
+
+		err = net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx, binding,
+						      info->extack);
+		if (err)
+			goto err_unbind;
+	}
+
+	list_add(&binding->list, sock_binding_list);
+
+	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
+	genlmsg_end(rsp, hdr);
+
+	err = genlmsg_reply(rsp, info);
+	if (err)
+		goto err_unbind;
+
+	rtnl_unlock();
+
 	return 0;
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
index 781834ef57c3..91203851a476 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -654,6 +654,7 @@ int ethtool_check_max_channel(struct net_device *dev,
 {
 	u64 max_rxnfc_in_use;
 	u32 max_rxfh_in_use;
+	int max_mp_in_use;
 
 	/* ensure the new Rx count fits within the configured Rx flow
 	 * indirection table/rxnfc settings
@@ -672,6 +673,13 @@ int ethtool_check_max_channel(struct net_device *dev,
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
 
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index c0e0204b9630..6b2756f95629 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -211,6 +211,11 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
+	if (dev_get_min_mp_channel_count(netdev)) {
+		err = -EBUSY;
+		goto err_unreg_pool;
+	}
+
 	bpf.command = XDP_SETUP_XSK_POOL;
 	bpf.xsk.pool = pool;
 	bpf.xsk.queue_id = queue_id;
-- 
2.46.0.598.g6f2099f65c-goog


