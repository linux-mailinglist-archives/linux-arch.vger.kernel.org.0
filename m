Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3954C74E146
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 00:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGJWeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 18:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGJWdz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 18:33:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB380E5D
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:33:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c83284edf0eso1866172276.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689028429; x=1691620429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K10CMsALExOmOcR/YTwAYoH6sOUce0sACyLlyAd3oCA=;
        b=PmjrhD360OT99Lc8iPVcJYoR6DDqdeqIAZ5+tJAhFT5ahoktvUJx3QBnBPzN/WyXln
         kbA5Ozqmx/gY8WIxPOw00lEwu6Irt1PeBniAsNqQA8De/a7Gmw+d3Ar8j+YKrZssZ8uA
         BuSorRLnfwVf9kLGmV78yHD3Id1Ztae6MVmUiqkzc97p1exlkKRRIKvklbv9OqJSUqmP
         Qk97r7IUXC5lwlf/gsOz/X4tKxwtoTHHXF4t3kR8h/ivJz2kuJv7koREvjKNpq8Fdh4o
         MhP81DlKHR9GRSfe72HCOY8i4aU5RoyUS+8Tp6rfoY7xD/75fsJWZLCBFtePU5WPjwxt
         ZKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028429; x=1691620429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K10CMsALExOmOcR/YTwAYoH6sOUce0sACyLlyAd3oCA=;
        b=Hwkim7IlZERy/zczOM9C2yOAkSphWijPOYRtMZLeKpL+xtANQQfw80vBw4HM73g5Yw
         aMEk2EKYkMoDPVWjM/2jb7YGeVqOY9dBKd2mTF8i5ToLai1g4PMKyLBmpoC4GfSdowWp
         jLTT72cyQKi1YUBu2Mtu8gsa7HKxT5JnFHdkbU8iaL/5VNjYOKVBRvtIPy3HLn17AXmv
         hcPL11MqPHQxlzGcx1f0V+syi/100qaU2NHqmDETxgrB4oAQJWUhKgewn+NF9Jx9a2oA
         gjgPhulDXyCE6Goerrwvbqsdq00Vsg1sQIzOA9nNxmb9/D02m+II+tCWa1BHukWlFbhs
         va2A==
X-Gm-Message-State: ABy/qLZjbuk7PlkOz4BqXws85EynmyxidCPtAx43rHEW/kqDhjvyXnI+
        4Ez2mCaf6Tj3IoEyiw0GpebkRijgumqQX0L/Ig==
X-Google-Smtp-Source: APBJJlELfkUsONGQv1JgPO9H1X9zJoqx1LLA0iy04SlqfvxZOZRiNmkJzPsHKMMO+0eNN0K5dDAd6ysBuYoO3e4CPQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c0f:bfb6:9942:8c53])
 (user=almasrymina job=sendgmr) by 2002:a25:1ed4:0:b0:c48:b822:36db with SMTP
 id e203-20020a251ed4000000b00c48b82236dbmr78934ybe.10.1689028429046; Mon, 10
 Jul 2023 15:33:49 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:32:53 -0700
In-Reply-To: <20230710223304.1174642-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230710223304.1174642-3-almasrymina@google.com>
Subject: [RFC PATCH 02/10] dma-buf: add support for NET_RX pages
From:   Mina Almasry <almasrymina@google.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Mina Almasry <almasrymina@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the paged attachment mappings support to create NET_RX pages.
NET_RX pages are pages that can be used in the networking receive path:

Bind the pages to the driver's rx queues specified by the create_flags
param, and create a gen_pool to hold the free pages available for the
driver to allocate.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/dma-buf/dma-buf.c    | 174 +++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h      |  20 ++++
 include/linux/netdevice.h    |   1 +
 include/uapi/linux/dma-buf.h |   2 +
 4 files changed, 197 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 50b1d813cf5c..acb86bf406f4 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -27,6 +27,7 @@
 #include <linux/dma-resv.h>
 #include <linux/mm.h>
 #include <linux/mount.h>
+#include <linux/netdevice.h>
 #include <linux/pseudo_fs.h>
 
 #include <uapi/linux/dma-buf.h>
@@ -1681,6 +1682,8 @@ static void dma_buf_pages_destroy(struct percpu_ref *ref)
 	pci_dev_put(priv->pci_dev);
 }
 
+const struct dma_buf_pages_type_ops net_rx_ops;
+
 static long dma_buf_create_pages(struct file *file,
 				 struct dma_buf_create_pages_info *create_info)
 {
@@ -1793,6 +1796,9 @@ static long dma_buf_create_pages(struct file *file,
 	priv->create_flags = create_info->create_flags;
 
 	switch (priv->type) {
+	case DMA_BUF_PAGES_NET_RX:
+		priv->type_ops = &net_rx_ops;
+		break;
 	default:
 		err = -EINVAL;
 		goto out_put_new_file;
@@ -1966,3 +1972,171 @@ static void __exit dma_buf_deinit(void)
 	dma_buf_uninit_sysfs_statistics();
 }
 __exitcall(dma_buf_deinit);
+
+/********************************
+ *	dma_buf_pages_net_rx	*
+ ********************************/
+
+void dma_buf_pages_net_rx_release(struct dma_buf_pages *priv, struct file *file)
+{
+	struct netdev_rx_queue *rxq;
+	unsigned long xa_idx;
+
+	xa_for_each(&priv->net_rx.bound_rxq_list, xa_idx, rxq)
+		if (rxq->dmabuf_pages == file)
+			rxq->dmabuf_pages = NULL;
+}
+
+static int dev_is_class(struct device *dev, void *class)
+{
+	if (dev->class != NULL && !strcmp(dev->class->name, class))
+		return 1;
+
+	return 0;
+}
+
+int dma_buf_pages_net_rx_init(struct dma_buf_pages *priv, struct file *file)
+{
+	struct netdev_rx_queue *rxq;
+	struct net_device *netdev;
+	int xa_id, err, rxq_idx;
+	struct device *device;
+
+	priv->net_rx.page_pool =
+		gen_pool_create(PAGE_SHIFT, dev_to_node(&priv->pci_dev->dev));
+
+	if (!priv->net_rx.page_pool)
+		return -ENOMEM;
+
+	/*
+	 * We start with PAGE_SIZE instead of 0 since gen_pool_alloc_*() returns
+	 * NULL on error
+	 */
+	err = gen_pool_add_virt(priv->net_rx.page_pool, PAGE_SIZE, 0,
+				PAGE_SIZE * priv->num_pages,
+				dev_to_node(&priv->pci_dev->dev));
+	if (err)
+		goto out_destroy_pool;
+
+	xa_init_flags(&priv->net_rx.bound_rxq_list, XA_FLAGS_ALLOC);
+
+	device = device_find_child(&priv->pci_dev->dev, "net", dev_is_class);
+	if (!device) {
+		err = -ENODEV;
+		goto out_destroy_xarray;
+	}
+
+	netdev = to_net_dev(device);
+	if (!netdev) {
+		err = -ENODEV;
+		goto out_put_dev;
+	}
+
+	for (rxq_idx = 0; rxq_idx < (sizeof(priv->create_flags) * 8);
+	     rxq_idx++) {
+		if (!(priv->create_flags & (1ULL << rxq_idx)))
+			continue;
+
+		if (rxq_idx >= netdev->num_rx_queues) {
+			err = -ERANGE;
+			goto out_release_rx;
+		}
+
+		rxq = __netif_get_rx_queue(netdev, rxq_idx);
+
+		err = xa_alloc(&priv->net_rx.bound_rxq_list, &xa_id, rxq,
+			       xa_limit_32b, GFP_KERNEL);
+		if (err)
+			goto out_release_rx;
+
+		/* We previously have done a dma_buf_attach(), which validates
+		 * that the net_device we're trying to attach to can reach the
+		 * dmabuf, so we don't need to check here as well.
+		 */
+		rxq->dmabuf_pages = file;
+	}
+	put_device(device);
+	return 0;
+
+out_release_rx:
+	dma_buf_pages_net_rx_release(priv, file);
+out_put_dev:
+	put_device(device);
+out_destroy_xarray:
+	xa_destroy(&priv->net_rx.bound_rxq_list);
+out_destroy_pool:
+	gen_pool_destroy(priv->net_rx.page_pool);
+	return err;
+}
+
+void dma_buf_pages_net_rx_free(struct dma_buf_pages *priv)
+{
+	xa_destroy(&priv->net_rx.bound_rxq_list);
+	gen_pool_destroy(priv->net_rx.page_pool);
+}
+
+static unsigned long dma_buf_page_to_gen_pool_addr(struct page *page)
+{
+	struct dma_buf_pages *priv;
+	struct dev_pagemap *pgmap;
+	unsigned long offset;
+
+	pgmap = page->pgmap;
+	priv = container_of(pgmap, struct dma_buf_pages, pgmap);
+	offset = page - priv->pages;
+	/* Offset + 1 is due to the fact that we want to avoid 0 virt address
+	 * returned from the gen_pool. The gen_pool returns 0 on error, and virt
+	 * address 0 is indistinguishable from an error.
+	 */
+	return (offset + 1) << PAGE_SHIFT;
+}
+
+static struct page *
+dma_buf_gen_pool_addr_to_page(unsigned long addr, struct dma_buf_pages *priv)
+{
+	/* - 1 is due to the fact that we want to avoid 0 virt address
+	 * returned from the gen_pool. See comment in dma_buf_create_pages()
+	 * for details.
+	 */
+	unsigned long offset = (addr >> PAGE_SHIFT) - 1;
+	return &priv->pages[offset];
+}
+
+void dma_buf_page_free_net_rx(struct dma_buf_pages *priv, struct page *page)
+{
+	unsigned long addr = dma_buf_page_to_gen_pool_addr(page);
+
+	if (gen_pool_has_addr(priv->net_rx.page_pool, addr, PAGE_SIZE))
+		gen_pool_free(priv->net_rx.page_pool, addr, PAGE_SIZE);
+}
+
+const struct dma_buf_pages_type_ops net_rx_ops = {
+	.dma_buf_pages_init		= dma_buf_pages_net_rx_init,
+	.dma_buf_pages_release		= dma_buf_pages_net_rx_release,
+	.dma_buf_pages_destroy		= dma_buf_pages_net_rx_free,
+	.dma_buf_page_free		= dma_buf_page_free_net_rx,
+};
+
+struct page *dma_buf_pages_net_rx_alloc(struct dma_buf_pages *priv)
+{
+	unsigned long gen_pool_addr;
+	struct page *pg;
+
+	if (!(priv->type & DMA_BUF_PAGES_NET_RX))
+		return NULL;
+
+	gen_pool_addr = gen_pool_alloc(priv->net_rx.page_pool, PAGE_SIZE);
+	if (!gen_pool_addr)
+		return NULL;
+
+	if (!PAGE_ALIGNED(gen_pool_addr)) {
+		net_err_ratelimited("dmabuf page pool allocation not aligned");
+		gen_pool_free(priv->net_rx.page_pool, gen_pool_addr, PAGE_SIZE);
+		return NULL;
+	}
+
+	pg = dma_buf_gen_pool_addr_to_page(gen_pool_addr, priv);
+
+	percpu_ref_get(&priv->pgmap.ref);
+	return pg;
+}
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 5789006180ea..e8e66d6407d0 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -22,6 +22,9 @@
 #include <linux/fs.h>
 #include <linux/dma-fence.h>
 #include <linux/wait.h>
+#include <linux/genalloc.h>
+#include <linux/xarray.h>
+#include <net/page_pool.h>
 
 struct device;
 struct dma_buf;
@@ -552,6 +555,11 @@ struct dma_buf_pages_type_ops {
 				  struct page *page);
 };
 
+struct dma_buf_pages_net_rx {
+	struct gen_pool *page_pool;
+	struct xarray bound_rxq_list;
+};
+
 struct dma_buf_pages {
 	/* fields for dmabuf */
 	struct dma_buf *dmabuf;
@@ -568,6 +576,10 @@ struct dma_buf_pages {
 	unsigned int type;
 	const struct dma_buf_pages_type_ops *type_ops;
 	__u64 create_flags;
+
+	union {
+		struct dma_buf_pages_net_rx net_rx;
+	};
 };
 
 /**
@@ -671,6 +683,8 @@ static inline bool is_dma_buf_pages_file(struct file *file)
 	return file->f_op == &dma_buf_pages_fops;
 }
 
+struct page *dma_buf_pages_net_rx_alloc(struct dma_buf_pages *priv);
+
 static inline bool is_dma_buf_page(struct page *page)
 {
 	return (is_zone_device_page(page) && page->pgmap &&
@@ -718,6 +732,12 @@ static inline int dma_buf_map_sg(struct device *dev, struct scatterlist *sg,
 {
 	return 0;
 }
+
+static inline struct page *dma_buf_pages_net_rx_alloc(struct dma_buf_pages *priv)
+{
+	return NULL;
+}
+
 #endif
 
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c2f0c6002a84..7a087ffa9baa 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -796,6 +796,7 @@ struct netdev_rx_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
+	struct file __rcu		*dmabuf_pages;
 } ____cacheline_aligned_in_smp;
 
 /*
diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
index d0f63a2ab7e4..b392cef9d3c6 100644
--- a/include/uapi/linux/dma-buf.h
+++ b/include/uapi/linux/dma-buf.h
@@ -186,6 +186,8 @@ struct dma_buf_create_pages_info {
 	__u64 create_flags;
 };
 
+#define DMA_BUF_PAGES_NET_RX		(1 << 0)
+
 #define DMA_BUF_CREATE_PAGES	_IOW(DMA_BUF_BASE, 4, struct dma_buf_create_pages_info)
 
 #endif
-- 
2.41.0.390.g38632f3daf-goog

