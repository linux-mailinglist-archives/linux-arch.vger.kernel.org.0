Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B9B7E18CE
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 03:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjKFCoz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 21:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjKFCow (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 21:44:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245EBFB
        for <linux-arch@vger.kernel.org>; Sun,  5 Nov 2023 18:44:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af69a4baso54796397b3.0
        for <linux-arch@vger.kernel.org>; Sun, 05 Nov 2023 18:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238669; x=1699843469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCln+P1ZLV/9SicyKW3j3Qj5ciapVl1fP7AJwqOPEjI=;
        b=YM1SEkq3uLkxlOuZL1VwFYmCBgjwqqpM8fBxRsaBTEy60dJ8XtbpbtQaaAxjD7HbFu
         g52d2hu5Vg6ifDN7YHs32I9K3GIv2Qd5wLNhAH/diZUToVYlgJu/OyTZOpJSxXcCAzvt
         Gwi1PZolJ8PvTWdsSKlJDDCzw4GNwXv0AN7cWW012U6w7cq0Q87y9MAbaHHV0EgpPNPe
         cBQpVXfq6A0DlhOT47C7P/06a3wQDPhtlJY4+II2nLCjUusdZOZgjsvTkjZaIAlQDZPu
         EXQjGMy9+0bXLt2elR/AhrrHlV3AaGPcasehjxjy1yTkvXTC6SqNSuFWE2hlNZVrl9rg
         SIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238669; x=1699843469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCln+P1ZLV/9SicyKW3j3Qj5ciapVl1fP7AJwqOPEjI=;
        b=LaGihgnaOWJOBXf0NhrDIdc2sZfSmUId18RqXvsNTGt0EsGRrHxto+ggnetBd+bTqm
         RBh1ELTM7MEs8GfCXam17+91f9aojz9iCm4mGHSwghwSuIFBFg9as+O4rnMf/jHif/m4
         NwqRkxdUdSLrhU6+IfswkNcbLqkFmtlAqxKXhVI3QlRT/n44+aaKru9PofGBxK/xMuoN
         KbxLG8gZBP2C8qPCAnm3uOacz9yi7nYQTbKwzZwsQI+G+2GZ649H+xahoLiLB4acMCEG
         KzhlMLbRfbCf1pCxUa0SOc/IfhMkq/qJ1MVds5t0XTHeOlzwaxa82dtqxKCd8BtNNTcJ
         hRWQ==
X-Gm-Message-State: AOJu0YwZVLA3I+IUGFqaNIXhRRTWtYUP3DmMBfZrGT+JUKmVYzrPD25j
        UozklOF8E7+q4qYxxdpYcqB/2YyhFV2LAU5SKw==
X-Google-Smtp-Source: AGHT+IFZen1iqDzFOOtrS1FJ3xpxQBaOHPO073Jp0lQAOyUF53fYpT9RjFB9mOvm7AmbRG1CjowhqVQUNAxlAUzmOA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:7909:0:b0:da3:ab41:304a with SMTP
 id u9-20020a257909000000b00da3ab41304amr308351ybc.4.1699238669418; Sun, 05
 Nov 2023 18:44:29 -0800 (PST)
Date:   Sun,  5 Nov 2023 18:44:04 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-6-almasrymina@google.com>
Subject: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement netdev devmem allocator. The allocator takes a given struct
netdev_dmabuf_binding as input and allocates page_pool_iov from that
binding.

The allocation simply delegates to the binding's genpool for the
allocation logic and wraps the returned memory region in a page_pool_iov
struct.

page_pool_iov are refcounted and are freed back to the binding when the
refcount drops to 0.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/netdevice.h       | 13 ++++++++++++
 include/net/page_pool/helpers.h | 28 +++++++++++++++++++++++++
 net/core/dev.c                  | 37 +++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index eeeda849115c..1c351c138a5b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
 };
 
 #ifdef CONFIG_DMA_SHARED_BUFFER
+struct page_pool_iov *
+netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
+void netdev_free_devmem(struct page_pool_iov *ppiov);
 void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		       struct netdev_dmabuf_binding **out);
@@ -850,6 +853,16 @@ void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				struct netdev_dmabuf_binding *binding);
 #else
+static inline struct page_pool_iov *
+netdev_alloc_devmem(struct netdev_dmabuf_binding *binding)
+{
+	return NULL;
+}
+
+static inline void netdev_free_devmem(struct page_pool_iov *ppiov)
+{
+}
+
 static inline void
 __netdev_devmem_binding_free(struct netdev_dmabuf_binding *binding)
 {
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 4ebd544ae977..78cbb040af94 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -83,6 +83,34 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 }
 #endif
 
+/* page_pool_iov support */
+
+static inline struct dmabuf_genpool_chunk_owner *
+page_pool_iov_owner(const struct page_pool_iov *ppiov)
+{
+	return ppiov->owner;
+}
+
+static inline unsigned int page_pool_iov_idx(const struct page_pool_iov *ppiov)
+{
+	return ppiov - page_pool_iov_owner(ppiov)->ppiovs;
+}
+
+static inline dma_addr_t
+page_pool_iov_dma_addr(const struct page_pool_iov *ppiov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = page_pool_iov_owner(ppiov);
+
+	return owner->base_dma_addr +
+	       ((dma_addr_t)page_pool_iov_idx(ppiov) << PAGE_SHIFT);
+}
+
+static inline struct netdev_dmabuf_binding *
+page_pool_iov_binding(const struct page_pool_iov *ppiov)
+{
+	return page_pool_iov_owner(ppiov)->binding;
+}
+
 /**
  * page_pool_dev_alloc_pages() - allocate a page.
  * @pool:	pool from which to allocate
diff --git a/net/core/dev.c b/net/core/dev.c
index c8c3709d42c8..2315bbc03ec8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -156,6 +156,7 @@
 #include <linux/genalloc.h>
 #include <linux/dma-buf.h>
 #include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -2077,6 +2078,42 @@ void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *binding)
 	kfree(binding);
 }
 
+struct page_pool_iov *netdev_alloc_devmem(struct netdev_dmabuf_binding *binding)
+{
+	struct dmabuf_genpool_chunk_owner *owner;
+	struct page_pool_iov *ppiov;
+	unsigned long dma_addr;
+	ssize_t offset;
+	ssize_t index;
+
+	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
+					(void **)&owner);
+	if (!dma_addr)
+		return NULL;
+
+	offset = dma_addr - owner->base_dma_addr;
+	index = offset / PAGE_SIZE;
+	ppiov = &owner->ppiovs[index];
+
+	netdev_devmem_binding_get(binding);
+
+	return ppiov;
+}
+
+void netdev_free_devmem(struct page_pool_iov *ppiov)
+{
+	struct netdev_dmabuf_binding *binding = page_pool_iov_binding(ppiov);
+
+	refcount_set(&ppiov->refcount, 1);
+
+	if (gen_pool_has_addr(binding->chunk_pool,
+			      page_pool_iov_dma_addr(ppiov), PAGE_SIZE))
+		gen_pool_free(binding->chunk_pool,
+			      page_pool_iov_dma_addr(ppiov), PAGE_SIZE);
+
+	netdev_devmem_binding_put(binding);
+}
+
 void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding)
 {
 	struct netdev_rx_queue *rxq;
-- 
2.42.0.869.gea05f2083d-goog

