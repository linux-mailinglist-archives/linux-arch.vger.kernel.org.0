Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526177E18B9
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 03:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjKFCoc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 21:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjKFCob (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 21:44:31 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06CFFB
        for <linux-arch@vger.kernel.org>; Sun,  5 Nov 2023 18:44:27 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so3560165a12.3
        for <linux-arch@vger.kernel.org>; Sun, 05 Nov 2023 18:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238667; x=1699843467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYspz1UCPlkFcqSl7poNxEIVxphi7wXN/DYo5EMn6TY=;
        b=uxK0RrhnXmCtHW7JzCAPp8JdYKYXx8E17Mwbcr4wTc3WzvlN2On6oc3u4qIk1r+Ew+
         +04LNJuhLHPJxwmb8Dlr50ngzlYCHdZn7iWLEIYtL+1TflgZz/gWTvh5D2yoV35mYIlo
         B/xvmFZCd8Gp2HLqH3Ghs0M3aapDOjUCQqinrOVJDMptAxyM/8ol7KWGCet9PmmRIgnh
         OTEkhSulLrKzrwu2XzWKHh/l/DmDdVdYwFoZy7tBu51oCVzZIn2MMNrAwAzXd2pZCjpS
         bVV9HL2tExYRXiDMK6qVabhWb5++ypj2FFEgWNkPbMPxnbeVGhogR+8KMZssX3Ze+cf3
         f9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238667; x=1699843467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYspz1UCPlkFcqSl7poNxEIVxphi7wXN/DYo5EMn6TY=;
        b=OfDfyxuMKur8xGogcKg0je1sOU7CNw9cVAxijnT/Rvyo9Qn1O3gR7NLJ/KHKS6W9BB
         4ndGIlTkONX/WTPe765Rw1iWzIWLx3wY7qy39A6FgUZVJ9lhT/q488Nd/zk5GHNH4mPh
         UXkUB+eUuhuBEBCd7IBM5zcRM9o36UwDsSUjzHq7F8jtQTrERPCiyvQ3AxbCBRiZ0E4J
         A0Z89s9ZcbXTQLY6dNIr1/Bdr6scO78JMWJ89Mf+ynqPjrnCYCPhRaCHtpxGzBDBNAhf
         HRiIWpZ3UDtOS2AcKtdOC+gbpdsbhvqYbT6ExRDAj2KstHh/R84mSqlc6ArqsCvDJE0m
         WzdA==
X-Gm-Message-State: AOJu0YzNNIBXcJOctda/2Yz5Fne/ddd3ssep0/jW0qJDhiiyxUHzazpt
        xQFBhIuEB++4a2miyq+FEsLBwN9bImIRNz7g+w==
X-Google-Smtp-Source: AGHT+IHC7qtI5cNRWsxVgcu52vp2ItrRo7jya2WHOJYqVlpdeNGfzBJvWk9SLPP8GDrTXyl15tXdDGLuruhozOUZ2g==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a63:3eca:0:b0:5ac:f96f:f87d with SMTP
 id l193-20020a633eca000000b005acf96ff87dmr478590pga.8.1699238667217; Sun, 05
 Nov 2023 18:44:27 -0800 (PST)
Date:   Sun,  5 Nov 2023 18:44:03 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-5-almasrymina@google.com>
Subject: [RFC PATCH v3 04/12] netdev: support binding dma-buf to netdevice
From:   Mina Almasry <almasrymina@google.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Cc:     Mina Almasry <almasrymina@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
page_pool_iov. We setup the page_pool_iov allocation size in the
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

RFC v3:
- Support multi rx-queue binding

---
 include/linux/netdevice.h     |  80 ++++++++++++++
 include/net/netdev_rx_queue.h |   1 +
 include/net/page_pool/types.h |  27 +++++
 net/core/dev.c                | 203 ++++++++++++++++++++++++++++++++++
 net/core/netdev-genl.c        | 116 ++++++++++++++++++-
 5 files changed, 425 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b8bf669212cc..eeeda849115c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -52,6 +52,8 @@
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <linux/xarray.h>
+#include <linux/refcount.h>
 
 struct netpoll_info;
 struct device;
@@ -808,6 +810,84 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index, u32 flow_id,
 #endif
 #endif /* CONFIG_RPS */
 
+struct netdev_dmabuf_binding {
+	struct dma_buf *dmabuf;
+	struct dma_buf_attachment *attachment;
+	struct sg_table *sgt;
+	struct net_device *dev;
+	struct gen_pool *chunk_pool;
+
+	/* The user holds a ref (via the netlink API) for as long as they want
+	 * the binding to remain alive. Each page pool using this binding holds
+	 * a ref to keep the binding alive. Each allocated page_pool_iov holds a
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
+};
+
+#ifdef CONFIG_DMA_SHARED_BUFFER
+void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *binding);
+int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netdev_dmabuf_binding **out);
+void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding);
+int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				struct netdev_dmabuf_binding *binding);
+#else
+static inline void
+__netdev_devmem_binding_free(struct netdev_dmabuf_binding *binding)
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
+netdev_devmem_binding_get(struct netdev_dmabuf_binding *binding)
+{
+	refcount_inc(&binding->ref);
+}
+
+static inline void
+netdev_devmem_binding_put(struct netdev_dmabuf_binding *binding)
+{
+	if (!refcount_dec_and_test(&binding->ref))
+		return;
+
+	__netdev_devmem_binding_free(binding);
+}
+
 /* XPS map type and offset of the xps map within net_device->xps_maps[]. */
 enum xps_map_type {
 	XPS_CPUS = 0,
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index cdcafb30d437..1bfcf60a145d 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -21,6 +21,7 @@ struct netdev_rx_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
+	struct netdev_dmabuf_binding *binding;
 } ____cacheline_aligned_in_smp;
 
 /*
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index d4bea053bb7e..64386325d965 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -133,6 +133,33 @@ struct pp_memory_provider_ops {
 	bool (*release_page)(struct page_pool *pool, struct page *page);
 };
 
+/* page_pool_iov support */
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
+	/* Array of page_pool_iovs for this chunk. */
+	struct page_pool_iov *ppiovs;
+	size_t num_ppiovs;
+
+	struct netdev_dmabuf_binding *binding;
+};
+
+struct page_pool_iov {
+	struct dmabuf_genpool_chunk_owner *owner;
+
+	refcount_t refcount;
+};
+
 struct page_pool {
 	struct page_pool_params p;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index a37a932a3e14..c8c3709d42c8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -153,6 +153,9 @@
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
 #include <net/netdev_rx_queue.h>
+#include <linux/genalloc.h>
+#include <linux/dma-buf.h>
+#include <net/page_pool/types.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -2040,6 +2043,206 @@ static int call_netdevice_notifiers_mtu(unsigned long val,
 	return call_netdevice_notifiers_info(val, &info.info);
 }
 
+/* Device memory support */
+
+#ifdef CONFIG_DMA_SHARED_BUFFER
+static void netdev_devmem_free_chunk_owner(struct gen_pool *genpool,
+					   struct gen_pool_chunk *chunk,
+					   void *not_used)
+{
+	struct dmabuf_genpool_chunk_owner *owner = chunk->owner;
+
+	kvfree(owner->ppiovs);
+	kfree(owner);
+}
+
+void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *binding)
+{
+	size_t size, avail;
+
+	gen_pool_for_each_chunk(binding->chunk_pool,
+				netdev_devmem_free_chunk_owner, NULL);
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
+	kfree(binding);
+}
+
+void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding)
+{
+	struct netdev_rx_queue *rxq;
+	unsigned long xa_idx;
+
+	if (!binding)
+		return;
+
+	list_del_rcu(&binding->list);
+
+	xa_for_each(&binding->bound_rxq_list, xa_idx, rxq)
+		if (rxq->binding == binding)
+			/* We hold the rtnl_lock while binding/unbinding
+			 * dma-buf, so we can't race with another thread that
+			 * is also modifying this value. However, the driver
+			 * may read this config while it's creating its
+			 * rx-queues. WRITE_ONCE() here to match the
+			 * READ_ONCE() in the driver.
+			 */
+			WRITE_ONCE(rxq->binding, NULL);
+
+	netdev_devmem_binding_put(binding);
+}
+
+int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
+				struct netdev_dmabuf_binding *binding)
+{
+	struct netdev_rx_queue *rxq;
+	u32 xa_idx;
+	int err;
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
+	/*We hold the rtnl_lock while binding/unbinding dma-buf, so we can't
+	 * race with another thread that is also modifying this value. However,
+	 * the driver may read this config while it's creating its * rx-queues.
+	 * WRITE_ONCE() here to match the READ_ONCE() in the driver.
+	 */
+	WRITE_ONCE(rxq->binding, binding);
+
+	return 0;
+}
+
+int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netdev_dmabuf_binding **out)
+{
+	struct netdev_dmabuf_binding *binding;
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
+		goto err_free_binding;
+	}
+
+	binding->sgt = dma_buf_map_attachment(binding->attachment,
+					      DMA_BIDIRECTIONAL);
+	if (IS_ERR(binding->sgt)) {
+		err = PTR_ERR(binding->sgt);
+		goto err_detach;
+	}
+
+	/* For simplicity we expect to make PAGE_SIZE allocations, but the
+	 * binding can be much more flexible than that. We may be able to
+	 * allocate MTU sized chunks here. Leave that for future work...
+	 */
+	binding->chunk_pool = gen_pool_create(PAGE_SHIFT,
+					      dev_to_node(&dev->dev));
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
+		struct page_pool_iov *ppiov;
+
+		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
+				     dev_to_node(&dev->dev));
+		owner->base_virtual = virtual;
+		owner->base_dma_addr = dma_addr;
+		owner->num_ppiovs = len / PAGE_SIZE;
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
+		owner->ppiovs = kvmalloc_array(owner->num_ppiovs,
+					       sizeof(*owner->ppiovs),
+					       GFP_KERNEL);
+		if (!owner->ppiovs) {
+			err = -ENOMEM;
+			goto err_free_chunks;
+		}
+
+		for (i = 0; i < owner->num_ppiovs; i++) {
+			ppiov = &owner->ppiovs[i];
+			ppiov->owner = owner;
+			refcount_set(&ppiov->refcount, 1);
+		}
+
+		dma_addr += len;
+		virtual += len;
+	}
+
+	*out = binding;
+
+	return 0;
+
+err_free_chunks:
+	gen_pool_for_each_chunk(binding->chunk_pool,
+				netdev_devmem_free_chunk_owner, NULL);
+	gen_pool_destroy(binding->chunk_pool);
+err_unmap:
+	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
+				 DMA_BIDIRECTIONAL);
+err_detach:
+	dma_buf_detach(dmabuf, binding->attachment);
+err_free_binding:
+	kfree(binding);
+err_put_dmabuf:
+	dma_buf_put(dmabuf);
+	return err;
+}
+#endif
+
 #ifdef CONFIG_NET_INGRESS
 static DEFINE_STATIC_KEY_FALSE(ingress_needed_key);
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 59d3d512d9cc..2c2a62593217 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -129,10 +129,89 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
-/* Stub */
+static LIST_HEAD(netdev_rbinding_list);
+
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return 0;
+	struct netdev_dmabuf_binding *out_binding;
+	u32 ifindex, dmabuf_fd, rxq_idx;
+	struct net_device *netdev;
+	struct sk_buff *rsp;
+	int rem, err = 0;
+	void *hdr;
+	struct nlattr *attr;
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
+		switch (nla_type(attr)) {
+		case NETDEV_A_BIND_DMABUF_QUEUES:
+			rxq_idx = nla_get_u32(attr);
+
+			if (rxq_idx >= netdev->num_rx_queues) {
+				err = -ERANGE;
+				goto err_unbind;
+			}
+
+			err = netdev_bind_dmabuf_to_queue(netdev, rxq_idx,
+							  out_binding);
+			if (err)
+				goto err_unbind;
+
+			break;
+		default:
+			break;
+		}
+	}
+
+	out_binding->owner_nlportid = info->snd_portid;
+	list_add_rcu(&out_binding->list, &netdev_rbinding_list);
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
@@ -155,10 +234,37 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
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
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(rbinding, &netdev_rbinding_list, list) {
+		if (rbinding->owner_nlportid == notify->portid) {
+			netdev_unbind_dmabuf(rbinding);
+			break;
+		}
+	}
+
+	rcu_read_unlock();
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
@@ -171,8 +277,14 @@ static int __init netdev_genl_init(void)
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
2.42.0.869.gea05f2083d-goog

