Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF1174E149
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 00:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGJWeC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 18:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjGJWeA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 18:34:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4109E4F
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:33:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57059e6f9c7so73873887b3.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689028432; x=1691620432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtAFtzT26HwoXDlgQMNRwGQzav+ArXt3GcR/tyBO9gA=;
        b=HkBlwsebRlph1pf39ww19ir3TXRKAaMo7qsHRnHvMwd7eaBtsd+aEsyn2PFrjYVPN/
         Q1m2zbfqNxMH7b2QmwqEmx7Hw8+0VDdPsjPbv5ClyeuSbRANbqwhxJwBlxKfNPSzGspo
         7yQorKtO9RR3lY8Caocl1cEReHVAh3gKZjRNe8K/5mwfYof1P1cHyHw8LwIbAtpadOQi
         xt/cqEvGCmmTBBOu377T/OItahks2lVVcdnKMKB3565gPdYG/TvH20z3G9f0jRiObQC7
         /Ikbp8b7IOidW9ZdGHVTIfQ7XQf/3jcuOVmetsVhHpuKf5wo9wt+kW67ruZRHH/8+c9U
         xfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028432; x=1691620432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtAFtzT26HwoXDlgQMNRwGQzav+ArXt3GcR/tyBO9gA=;
        b=fF8LfAA3sOV+0i9zlZeaBtB6zq5wwsDur9wnadvFHp76gLrfoTf/PPuCoAKCJ29IIO
         EXdYmCziV9Su1GPY8drcrLdAEvu3KJ72eJDkr5z1T2D29TT5sLXPIBo8uM0rAM7BBQCl
         xoQGuWkAcqcsl7Wz8yglsRTvj7+KZ1pGuyNbgbFrRMPol+sR4swLOMqkY5SFK0p6cu1X
         B5bUb62EJ2SyXcJ9bVL0kx8/ykTX7Sa5e8+yoe0GZ3aDe4MNxCwC5aeOBbMDMmqvIJlc
         AuPVlmurN0q+S1OShby6Sb+K8npEdEMJgUH0IBwYH6MVdNH/pxJrDDk6Fs9Z4SZqrm+E
         xnEA==
X-Gm-Message-State: ABy/qLbpHUn0i+WDFGl2e8qPPg1mdPjSReXBbEHE8T+3AfdLTbQg6BTu
        g/P7/ZVtVHxBzDhUirxbwv6OUq9eED12nYy4zA==
X-Google-Smtp-Source: APBJJlHZU5kmoFW1exgCNXZVHrLAP9FADaXQZjpO/QBcTqC0+9vh1t2Y55mCZ3uaTrm2ya/0CivoRDUtK7ota9l6xA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c0f:bfb6:9942:8c53])
 (user=almasrymina job=sendgmr) by 2002:a81:7e0c:0:b0:56c:e9fe:3cb4 with SMTP
 id o12-20020a817e0c000000b0056ce9fe3cb4mr204351ywn.1.1689028432231; Mon, 10
 Jul 2023 15:33:52 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:32:54 -0700
In-Reply-To: <20230710223304.1174642-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230710223304.1174642-4-almasrymina@google.com>
Subject: [RFC PATCH 03/10] dma-buf: add support for NET_TX pages
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Used the paged attachment mappings support to create NET_TX pages.
NET_TX pages can be used in the networking transmit path:

1. Create an iov_iter & bio_vec entries to represent this dmabuf.

2. Initialize the bio_vec with the backing dmabuf pages.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/dma-buf/dma-buf.c    | 47 ++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h      |  7 ++++++
 include/uapi/linux/dma-buf.h |  1 +
 3 files changed, 55 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index acb86bf406f4..3ca71297b9b4 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1683,6 +1683,7 @@ static void dma_buf_pages_destroy(struct percpu_ref *ref)
 }
 
 const struct dma_buf_pages_type_ops net_rx_ops;
+const struct dma_buf_pages_type_ops net_tx_ops;
 
 static long dma_buf_create_pages(struct file *file,
 				 struct dma_buf_create_pages_info *create_info)
@@ -1799,6 +1800,9 @@ static long dma_buf_create_pages(struct file *file,
 	case DMA_BUF_PAGES_NET_RX:
 		priv->type_ops = &net_rx_ops;
 		break;
+	case DMA_BUF_PAGES_NET_TX:
+		priv->type_ops = &net_tx_ops;
+		break;
 	default:
 		err = -EINVAL;
 		goto out_put_new_file;
@@ -2140,3 +2144,46 @@ struct page *dma_buf_pages_net_rx_alloc(struct dma_buf_pages *priv)
 	percpu_ref_get(&priv->pgmap.ref);
 	return pg;
 }
+
+/********************************
+ *	dma_buf_pages_net_tx	*
+ ********************************/
+
+static void dma_buf_pages_net_tx_release(struct dma_buf_pages *priv,
+					 struct file *file)
+{
+	int i;
+	for (i = 0; i < priv->num_pages; i++)
+		put_page(&priv->pages[i]);
+}
+
+static int dma_buf_pages_net_tx_init(struct dma_buf_pages *priv,
+				     struct file *file)
+{
+	int i;
+	priv->net_tx.tx_bv = kvmalloc_array(priv->num_pages,
+					    sizeof(struct bio_vec), GFP_KERNEL);
+	if (!priv->net_tx.tx_bv)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_pages; i++) {
+		priv->net_tx.tx_bv[i].bv_page = &priv->pages[i];
+		priv->net_tx.tx_bv[i].bv_offset = 0;
+		priv->net_tx.tx_bv[i].bv_len = PAGE_SIZE;
+	}
+	percpu_ref_get_many(&priv->pgmap.ref, priv->num_pages);
+	iov_iter_bvec(&priv->net_tx.iter, WRITE, priv->net_tx.tx_bv,
+		      priv->num_pages, priv->dmabuf->size);
+	return 0;
+}
+
+static void dma_buf_pages_net_tx_free(struct dma_buf_pages *priv)
+{
+	kvfree(priv->net_tx.tx_bv);
+}
+
+const struct dma_buf_pages_type_ops net_tx_ops = {
+	.dma_buf_pages_init		= dma_buf_pages_net_tx_init,
+	.dma_buf_pages_release		= dma_buf_pages_net_tx_release,
+	.dma_buf_pages_destroy		= dma_buf_pages_net_tx_free,
+};
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index e8e66d6407d0..93228a2fec47 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/dma-fence.h>
 #include <linux/wait.h>
+#include <linux/uio.h>
 #include <linux/genalloc.h>
 #include <linux/xarray.h>
 #include <net/page_pool.h>
@@ -555,6 +556,11 @@ struct dma_buf_pages_type_ops {
 				  struct page *page);
 };
 
+struct dma_buf_pages_net_tx {
+	struct iov_iter iter;
+	struct bio_vec *tx_bv;
+};
+
 struct dma_buf_pages_net_rx {
 	struct gen_pool *page_pool;
 	struct xarray bound_rxq_list;
@@ -579,6 +585,7 @@ struct dma_buf_pages {
 
 	union {
 		struct dma_buf_pages_net_rx net_rx;
+		struct dma_buf_pages_net_tx net_tx;
 	};
 };
 
diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
index b392cef9d3c6..546f211a7556 100644
--- a/include/uapi/linux/dma-buf.h
+++ b/include/uapi/linux/dma-buf.h
@@ -187,6 +187,7 @@ struct dma_buf_create_pages_info {
 };
 
 #define DMA_BUF_PAGES_NET_RX		(1 << 0)
+#define DMA_BUF_PAGES_NET_TX		(2 << 0)
 
 #define DMA_BUF_CREATE_PAGES	_IOW(DMA_BUF_BASE, 4, struct dma_buf_create_pages_info)
 
-- 
2.41.0.390.g38632f3daf-goog

