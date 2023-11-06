Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF10A7E18D1
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 03:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKFCoz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 21:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjKFCox (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 21:44:53 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8715E13E
        for <linux-arch@vger.kernel.org>; Sun,  5 Nov 2023 18:44:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b31e000e97so55100487b3.1
        for <linux-arch@vger.kernel.org>; Sun, 05 Nov 2023 18:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238672; x=1699843472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xKJa4I8M00nBYKJxGW44sf+c8CRhaACyIJxG3DJfPA=;
        b=kPU0CZN9YttlE3LT7KY9sbebcPDKJagb8NoBLKYEmq1Q8hcYA7FwdNfhmolbqz6x90
         OFKb+ubxZ0h0pVp5SQKigLP0EZB1fv6Uvcdt6b1bR39oH1/5VhOp5oUKJBz9KgYHPbDq
         mZsz6oTSAkvgH1+JZYgRx/aQxrZhxqWVK1H472uG8gAP4Ev1v5c6u/GgWaBZ/XO82G+e
         +DVausM/OLLfTmAI2Ia/8L6sWmeWzOhH7Tnq07ZZAjCZWzHNSxnOPUUZh9nUXHm7FG8B
         R5AHvHMgv3W1zOE92a/unhROT17QDEJ6AwBvY9jTvyCfSJUzbe3cMhiNf5Ul76RIIE/h
         Lp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238672; x=1699843472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xKJa4I8M00nBYKJxGW44sf+c8CRhaACyIJxG3DJfPA=;
        b=FovuVnrGREdKloaMaAc6YlMH2le5anXkQmRIVf50IWzPea4ZlpJzyxXRKGZWa1jP65
         2hi791dEycHOzd0QaK1zRkU9sA4lCnwHZMU14g9Fkf+gKEWQ1OKT2VXNCqroaPBNhTvy
         yT/LMHs3VhCWZZY92/E0nECGC5IklFWu72Hm+75f2JWbtIP7q3XbvtGPDm5E3Qvi4twk
         yCfWgYXp/1HqTOfvpZHv5FgZrPBiwvKj0YdSc4q/c4XpMdzykpn2QH7bBemuJqEqZxjI
         5qbYreMYmoeBnDqSmyFXtrt8zfidZxQywMgYYRc6bS7yFh88gStNTrHKzRIPSRM3wRkv
         K91A==
X-Gm-Message-State: AOJu0YyVPLuewc3TRQtp+pA5iEYvx5VaUfC1TLQ2LenKMHrVWhyyzUWs
        ek4/YjkcjkVOMNxpMW8dK0+YAbl45crZEHkYng==
X-Google-Smtp-Source: AGHT+IHQZek7gksg2/4l9r8mKorM1hefc52r/xXnPMd1/CJoSrUbDmmvNsfJ2kDrXMdiPilQpsmvFoDWEPDC3BTnqw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a81:914a:0:b0:5a8:2fb9:aeab with SMTP
 id i71-20020a81914a000000b005a82fb9aeabmr164143ywg.3.1699238671757; Sun, 05
 Nov 2023 18:44:31 -0800 (PST)
Date:   Sun,  5 Nov 2023 18:44:05 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-7-almasrymina@google.com>
Subject: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory provider
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

Implement a memory provider that allocates dmabuf devmem page_pool_iovs.

Support of PP_FLAG_DMA_MAP and PP_FLAG_DMA_SYNC_DEV is omitted for
simplicity.

The provider receives a reference to the struct netdev_dmabuf_binding
via the pool->mp_priv pointer. The driver needs to set this pointer for
the provider in the page_pool_params.

The provider obtains a reference on the netdev_dmabuf_binding which
guarantees the binding and the underlying mapping remains alive until
the provider is destroyed.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/net/page_pool/helpers.h | 40 +++++++++++++++++
 include/net/page_pool/types.h   | 10 +++++
 net/core/page_pool.c            | 76 +++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 78cbb040af94..b93243c2a640 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -53,6 +53,7 @@
 #define _NET_PAGE_POOL_HELPERS_H
 
 #include <net/page_pool/types.h>
+#include <net/net_debug.h>
 
 #ifdef CONFIG_PAGE_POOL_STATS
 int page_pool_ethtool_stats_get_count(void);
@@ -111,6 +112,45 @@ page_pool_iov_binding(const struct page_pool_iov *ppiov)
 	return page_pool_iov_owner(ppiov)->binding;
 }
 
+static inline int page_pool_iov_refcount(const struct page_pool_iov *ppiov)
+{
+	return refcount_read(&ppiov->refcount);
+}
+
+static inline void page_pool_iov_get_many(struct page_pool_iov *ppiov,
+					  unsigned int count)
+{
+	refcount_add(count, &ppiov->refcount);
+}
+
+void __page_pool_iov_free(struct page_pool_iov *ppiov);
+
+static inline void page_pool_iov_put_many(struct page_pool_iov *ppiov,
+					  unsigned int count)
+{
+	if (!refcount_sub_and_test(count, &ppiov->refcount))
+		return;
+
+	__page_pool_iov_free(ppiov);
+}
+
+/* page pool mm helpers */
+
+static inline bool page_is_page_pool_iov(const struct page *page)
+{
+	return (unsigned long)page & PP_DEVMEM;
+}
+
+static inline struct page_pool_iov *page_to_page_pool_iov(struct page *page)
+{
+	if (page_is_page_pool_iov(page))
+		return (struct page_pool_iov *)((unsigned long)page &
+						~PP_DEVMEM);
+
+	DEBUG_NET_WARN_ON_ONCE(true);
+	return NULL;
+}
+
 /**
  * page_pool_dev_alloc_pages() - allocate a page.
  * @pool:	pool from which to allocate
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 64386325d965..1e67f9466250 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -124,6 +124,7 @@ struct mem_provider;
 
 enum pp_memory_provider_type {
 	__PP_MP_NONE, /* Use system allocator directly */
+	PP_MP_DMABUF_DEVMEM, /* dmabuf devmem provider */
 };
 
 struct pp_memory_provider_ops {
@@ -133,8 +134,15 @@ struct pp_memory_provider_ops {
 	bool (*release_page)(struct page_pool *pool, struct page *page);
 };
 
+extern const struct pp_memory_provider_ops dmabuf_devmem_ops;
+
 /* page_pool_iov support */
 
+/*  We overload the LSB of the struct page pointer to indicate whether it's
+ *  a page or page_pool_iov.
+ */
+#define PP_DEVMEM 0x01UL
+
 /* Owner of the dma-buf chunks inserted into the gen pool. Each scatterlist
  * entry from the dmabuf is inserted into the genpool as a chunk, and needs
  * this owner struct to keep track of some metadata necessary to create
@@ -158,6 +166,8 @@ struct page_pool_iov {
 	struct dmabuf_genpool_chunk_owner *owner;
 
 	refcount_t refcount;
+
+	struct page_pool *pp;
 };
 
 struct page_pool {
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7ea1f4682479..138ddea0b28f 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -20,6 +20,7 @@
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/genalloc.h>
 
 #include <trace/events/page_pool.h>
 
@@ -231,6 +232,9 @@ static int page_pool_init(struct page_pool *pool,
 	switch (pool->p.memory_provider) {
 	case __PP_MP_NONE:
 		break;
+	case PP_MP_DMABUF_DEVMEM:
+		pool->mp_ops = &dmabuf_devmem_ops;
+		break;
 	default:
 		err = -EINVAL;
 		goto free_ptr_ring;
@@ -996,3 +1000,75 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
+
+void __page_pool_iov_free(struct page_pool_iov *ppiov)
+{
+	if (ppiov->pp->mp_ops != &dmabuf_devmem_ops)
+		return;
+
+	netdev_free_devmem(ppiov);
+}
+EXPORT_SYMBOL_GPL(__page_pool_iov_free);
+
+/*** "Dmabuf devmem memory provider" ***/
+
+static int mp_dmabuf_devmem_init(struct page_pool *pool)
+{
+	struct netdev_dmabuf_binding *binding = pool->mp_priv;
+
+	if (!binding)
+		return -EINVAL;
+
+	if (pool->p.flags & PP_FLAG_DMA_MAP ||
+	    pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		return -EOPNOTSUPP;
+
+	netdev_devmem_binding_get(binding);
+	return 0;
+}
+
+static struct page *mp_dmabuf_devmem_alloc_pages(struct page_pool *pool,
+						 gfp_t gfp)
+{
+	struct netdev_dmabuf_binding *binding = pool->mp_priv;
+	struct page_pool_iov *ppiov;
+
+	ppiov = netdev_alloc_devmem(binding);
+	if (!ppiov)
+		return NULL;
+
+	ppiov->pp = pool;
+	pool->pages_state_hold_cnt++;
+	trace_page_pool_state_hold(pool, (struct page *)ppiov,
+				   pool->pages_state_hold_cnt);
+	return (struct page *)((unsigned long)ppiov | PP_DEVMEM);
+}
+
+static void mp_dmabuf_devmem_destroy(struct page_pool *pool)
+{
+	struct netdev_dmabuf_binding *binding = pool->mp_priv;
+
+	netdev_devmem_binding_put(binding);
+}
+
+static bool mp_dmabuf_devmem_release_page(struct page_pool *pool,
+					  struct page *page)
+{
+	struct page_pool_iov *ppiov;
+
+	if (WARN_ON_ONCE(!page_is_page_pool_iov(page)))
+		return false;
+
+	ppiov = page_to_page_pool_iov(page);
+	page_pool_iov_put_many(ppiov, 1);
+	/* We don't want the page pool put_page()ing our page_pool_iovs. */
+	return false;
+}
+
+const struct pp_memory_provider_ops dmabuf_devmem_ops = {
+	.init			= mp_dmabuf_devmem_init,
+	.destroy		= mp_dmabuf_devmem_destroy,
+	.alloc_pages		= mp_dmabuf_devmem_alloc_pages,
+	.release_page		= mp_dmabuf_devmem_release_page,
+};
+EXPORT_SYMBOL(dmabuf_devmem_ops);
-- 
2.42.0.869.gea05f2083d-goog

