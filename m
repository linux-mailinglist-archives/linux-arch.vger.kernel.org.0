Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E87E18D6
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 03:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjKFCo5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 21:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjKFCoy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 21:44:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F1D61
        for <linux-arch@vger.kernel.org>; Sun,  5 Nov 2023 18:44:34 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86766bba9fso2274477276.1
        for <linux-arch@vger.kernel.org>; Sun, 05 Nov 2023 18:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238673; x=1699843473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQu48K4LNQ8WFJH6/Q5I7aNtbI5kIYTQfwkiquHqTME=;
        b=N5RhBrIqL6fIiMOsYG8SLCQWLyW4c0MlgoRmV8kWl/TlVyQadZXrEIdXt2DxU+M47Y
         76dp3mFzyiAE/FTCdMcup+83CQOgNE8i44gvvr1W0YJG8NkOUQMDsMRxunjeewFr/8e3
         JAahbR8rhWaykQEJLAHjzvxUAJ4pkZo+HPwjlMYz/+ixIU1UMQe2I/7Gfn+Q/BJjo7KZ
         +5lqMiL925kkqlXs2VwoAyLlOYjjy+MZg2UOlZeg9XGYjeFI8C0QjqF9DZ3eTAHpopb0
         1bctWyNN21f05DffBSO2iY3a4JE+ZwPzvwLzt8Eqbylrxwf7ZGBtlwidyhLJXgFiY6Jl
         UxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238673; x=1699843473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQu48K4LNQ8WFJH6/Q5I7aNtbI5kIYTQfwkiquHqTME=;
        b=duheQSpkTiHRmNbmtma+zGO7i7q0kFwyjDMLicOC9FMcDu+gZXSrPzg2xNCVg3rHHl
         3an4EpCHM9tdYXRWKCYt1a2lMB+GuvYl0b371AJ/arEC+5QVxbRwYlV68NUknumm4kLu
         AhwMsrnMfMfMZl5ug8lJlI+0Zw1Zwr8P9UQeqPut+NlCREf/kIBec9637wSN9i3KCN2L
         AvkrMbzsOSJ6Nk9ixqmsaCGg+EjY0rYw4+TVCmdtseHJlIuWmDXQyXgJdP0/BMUTxSnI
         r5CKoNG/HVpTRwv1clsUrIMRryvSN1JR7377L3DdZfh9O4xQRRADnCbjhx12LQKW6GAC
         oJDQ==
X-Gm-Message-State: AOJu0YyM5H+oStDLVAqJe1TbPc1a8MrAjD8envztMYMH6cVRUFaHcTOH
        pGelzMfrOlmTpS/nfP84TJ6vlOqUD/3YIGbMYw==
X-Google-Smtp-Source: AGHT+IEZMbWQfzrxoPZHwOWR4BvATqps1Lm805Xf6dRuk23Kr0wtrH56ZlHocpW6kuXWCf2FI0sYhcvf7cTOroJczw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:d785:0:b0:da0:5af7:d51a with SMTP
 id o127-20020a25d785000000b00da05af7d51amr582834ybg.0.1699238673723; Sun, 05
 Nov 2023 18:44:33 -0800 (PST)
Date:   Sun,  5 Nov 2023 18:44:06 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-8-almasrymina@google.com>
Subject: [RFC PATCH v3 07/12] page-pool: device memory support
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
        Praveen Kaligineedi <pkaligineedi@google.com>
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

Overload the LSB of struct page* to indicate that it's a page_pool_iov.

Refactor mm calls on struct page* into helpers, and add page_pool_iov
handling on those helpers. Modify callers of these mm APIs with calls to
these helpers instead.

In areas where struct page* is dereferenced, add a check for special
handling of page_pool_iov.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/net/page_pool/helpers.h | 74 ++++++++++++++++++++++++++++++++-
 net/core/page_pool.c            | 63 ++++++++++++++++++++--------
 2 files changed, 118 insertions(+), 19 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index b93243c2a640..08f1a2cc70d2 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -151,6 +151,64 @@ static inline struct page_pool_iov *page_to_page_pool_iov(struct page *page)
 	return NULL;
 }
 
+static inline int page_pool_page_ref_count(struct page *page)
+{
+	if (page_is_page_pool_iov(page))
+		return page_pool_iov_refcount(page_to_page_pool_iov(page));
+
+	return page_ref_count(page);
+}
+
+static inline void page_pool_page_get_many(struct page *page,
+					   unsigned int count)
+{
+	if (page_is_page_pool_iov(page))
+		return page_pool_iov_get_many(page_to_page_pool_iov(page),
+					      count);
+
+	return page_ref_add(page, count);
+}
+
+static inline void page_pool_page_put_many(struct page *page,
+					   unsigned int count)
+{
+	if (page_is_page_pool_iov(page))
+		return page_pool_iov_put_many(page_to_page_pool_iov(page),
+					      count);
+
+	if (count > 1)
+		page_ref_sub(page, count - 1);
+
+	put_page(page);
+}
+
+static inline bool page_pool_page_is_pfmemalloc(struct page *page)
+{
+	if (page_is_page_pool_iov(page))
+		return false;
+
+	return page_is_pfmemalloc(page);
+}
+
+static inline bool page_pool_page_is_pref_nid(struct page *page, int pref_nid)
+{
+	/* Assume page_pool_iov are on the preferred node without actually
+	 * checking...
+	 *
+	 * This check is only used to check for recycling memory in the page
+	 * pool's fast paths. Currently the only implementation of page_pool_iov
+	 * is dmabuf device memory. It's a deliberate decision by the user to
+	 * bind a certain dmabuf to a certain netdev, and the netdev rx queue
+	 * would not be able to reallocate memory from another dmabuf that
+	 * exists on the preferred node, so, this check doesn't make much sense
+	 * in this case. Assume all page_pool_iovs can be recycled for now.
+	 */
+	if (page_is_page_pool_iov(page))
+		return true;
+
+	return page_to_nid(page) == pref_nid;
+}
+
 /**
  * page_pool_dev_alloc_pages() - allocate a page.
  * @pool:	pool from which to allocate
@@ -301,6 +359,9 @@ static inline long page_pool_defrag_page(struct page *page, long nr)
 {
 	long ret;
 
+	if (page_is_page_pool_iov(page))
+		return -EINVAL;
+
 	/* If nr == pp_frag_count then we have cleared all remaining
 	 * references to the page:
 	 * 1. 'n == 1': no need to actually overwrite it.
@@ -431,7 +492,12 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
  */
 static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
 {
-	dma_addr_t ret = page->dma_addr;
+	dma_addr_t ret;
+
+	if (page_is_page_pool_iov(page))
+		return page_pool_iov_dma_addr(page_to_page_pool_iov(page));
+
+	ret = page->dma_addr;
 
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
 		ret <<= PAGE_SHIFT;
@@ -441,6 +507,12 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
 
 static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 {
+	/* page_pool_iovs are mapped and their dma-addr can't be modified. */
+	if (page_is_page_pool_iov(page)) {
+		DEBUG_NET_WARN_ON_ONCE(true);
+		return false;
+	}
+
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
 		page->dma_addr = addr >> PAGE_SHIFT;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 138ddea0b28f..d211996d423b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -317,7 +317,7 @@ static struct page *page_pool_refill_alloc_cache(struct page_pool *pool)
 		if (unlikely(!page))
 			break;
 
-		if (likely(page_to_nid(page) == pref_nid)) {
+		if (likely(page_pool_page_is_pref_nid(page, pref_nid))) {
 			pool->alloc.cache[pool->alloc.count++] = page;
 		} else {
 			/* NUMA mismatch;
@@ -362,7 +362,15 @@ static void page_pool_dma_sync_for_device(struct page_pool *pool,
 					  struct page *page,
 					  unsigned int dma_sync_size)
 {
-	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
+	dma_addr_t dma_addr;
+
+	/* page_pool_iov memory provider do not support PP_FLAG_DMA_SYNC_DEV */
+	if (page_is_page_pool_iov(page)) {
+		DEBUG_NET_WARN_ON_ONCE(true);
+		return;
+	}
+
+	dma_addr = page_pool_get_dma_addr(page);
 
 	dma_sync_size = min(dma_sync_size, pool->p.max_len);
 	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
@@ -374,6 +382,12 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 {
 	dma_addr_t dma;
 
+	if (page_is_page_pool_iov(page)) {
+		/* page_pool_iovs are already mapped */
+		DEBUG_NET_WARN_ON_ONCE(true);
+		return true;
+	}
+
 	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
 	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
 	 * into page private data (i.e 32bit cpu with 64bit DMA caps)
@@ -405,22 +419,33 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 static void page_pool_set_pp_info(struct page_pool *pool,
 				  struct page *page)
 {
-	page->pp = pool;
-	page->pp_magic |= PP_SIGNATURE;
-
-	/* Ensuring all pages have been split into one fragment initially:
-	 * page_pool_set_pp_info() is only called once for every page when it
-	 * is allocated from the page allocator and page_pool_fragment_page()
-	 * is dirtying the same cache line as the page->pp_magic above, so
-	 * the overhead is negligible.
-	 */
-	page_pool_fragment_page(page, 1);
+	if (!page_is_page_pool_iov(page)) {
+		page->pp = pool;
+		page->pp_magic |= PP_SIGNATURE;
+
+		/* Ensuring all pages have been split into one fragment
+		 * initially:
+		 * page_pool_set_pp_info() is only called once for every page
+		 * when it is allocated from the page allocator and
+		 * page_pool_fragment_page() is dirtying the same cache line as
+		 * the page->pp_magic above, so * the overhead is negligible.
+		 */
+		page_pool_fragment_page(page, 1);
+	} else {
+		page_to_page_pool_iov(page)->pp = pool;
+	}
+
 	if (pool->p.init_callback)
 		pool->p.init_callback(page, pool->p.init_arg);
 }
 
 static void page_pool_clear_pp_info(struct page *page)
 {
+	if (page_is_page_pool_iov(page)) {
+		page_to_page_pool_iov(page)->pp = NULL;
+		return;
+	}
+
 	page->pp_magic = 0;
 	page->pp = NULL;
 }
@@ -630,7 +655,7 @@ static bool page_pool_recycle_in_cache(struct page *page,
 		return false;
 	}
 
-	/* Caller MUST have verified/know (page_ref_count(page) == 1) */
+	/* Caller MUST have verified/know (page_pool_page_ref_count(page) == 1) */
 	pool->alloc.cache[pool->alloc.count++] = page;
 	recycle_stat_inc(pool, cached);
 	return true;
@@ -655,9 +680,10 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	 * refcnt == 1 means page_pool owns page, and can recycle it.
 	 *
 	 * page is NOT reusable when allocated when system is under
-	 * some pressure. (page_is_pfmemalloc)
+	 * some pressure. (page_pool_page_is_pfmemalloc)
 	 */
-	if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
+	if (likely(page_pool_page_ref_count(page) == 1 &&
+		   !page_pool_page_is_pfmemalloc(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
 		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
@@ -772,7 +798,8 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 	if (likely(page_pool_defrag_page(page, drain_count)))
 		return NULL;
 
-	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
+	if (page_pool_page_ref_count(page) == 1 &&
+	    !page_pool_page_is_pfmemalloc(page)) {
 		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
 			page_pool_dma_sync_for_device(pool, page, -1);
 
@@ -848,9 +875,9 @@ static void page_pool_empty_ring(struct page_pool *pool)
 	/* Empty recycle ring */
 	while ((page = ptr_ring_consume_bh(&pool->ring))) {
 		/* Verify the refcnt invariant of cached pages */
-		if (!(page_ref_count(page) == 1))
+		if (!(page_pool_page_ref_count(page) == 1))
 			pr_crit("%s() page_pool refcnt %d violation\n",
-				__func__, page_ref_count(page));
+				__func__, page_pool_page_ref_count(page));
 
 		page_pool_return_page(pool, page);
 	}
-- 
2.42.0.869.gea05f2083d-goog

