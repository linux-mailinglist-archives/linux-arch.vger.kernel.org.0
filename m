Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A0C7E18AC
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 03:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjKFCo2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 21:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFCoY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 21:44:24 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B710B
        for <linux-arch@vger.kernel.org>; Sun,  5 Nov 2023 18:44:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa86b8d66so56327117b3.3
        for <linux-arch@vger.kernel.org>; Sun, 05 Nov 2023 18:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238660; x=1699843460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYi74RniIHsB6Wn3ca/EzKecGeVK7nuy82fMJ6xIaLE=;
        b=ekokvDac7hthXuwHazBZXnazZwZOIg13sd3g4I+6yrjH/HnpYtSg5bQLFENcm4KKJX
         0cxb+MKVFM0WzGpZzmhK5wV/arz8D4rMqEExLFR7o8WJd702A7n/X05V3E4zpN+IK/zx
         OMQPhP+ReOyz1BXPXhZlRC297pcWXvurZvF5SggVf8FEG/JpDP2USI2vKnJxd8OicjBX
         6HKgUJQfXCzj5NYuqh5QKegGcs1QN1tXV+YtTDqpH/ObaIobxwCLnwOKoO6ft8AyOObl
         HrvbYbTsUXg7gi7Pt9WlCue5fuc+ty+nd3+hgllmHUXd+ESaHIo/pn5q90mwcafx6kBw
         uyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238660; x=1699843460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYi74RniIHsB6Wn3ca/EzKecGeVK7nuy82fMJ6xIaLE=;
        b=SYGui5tQbhH3jwv69d/khYeHXe5oxShqK3MwkULEq/hm/7Pk3MvfmqVDT89IU+1jxm
         9uQvIrlSi0C93FrhyOUBovTujQKjNTr0J5T7vHRxkEw2RmhjW4+bXs7BaFZzrPHIDgz5
         rVsA0i6VIVLq3F4ziS6XULlknK8gL2jQxw5grHRvI8Bmtbxwu+rckp0qQ2aPJaKXP6UB
         6Zfaqj3NuU5gJ0jsxwGM8QtI8HA2CAM5K4O4FDdSrkAILLZtbemIEO61y6NObTeiu4Nm
         ILvjXCkqdj+ISNkfFPT7DYUyI1xDv/zZ0cygv6KPvQVyrpbEwpOU8L+kN92Ol0IBxc8d
         XVBA==
X-Gm-Message-State: AOJu0YxAYPczGq/g82+XLa7Jdt+blwJ8GTFe7egUGmRiuO+yAgSnIHP5
        JOzyJ0wmtwbATqnqvFQuAe3Zds9JXQ/gfyt6jw==
X-Google-Smtp-Source: AGHT+IE9YqB9SYLUxgQ5eT9abp+8TWDhj3Fso2Go2CEiYjAa/XP+wuQiIsvJrogX9aN67VSXhqeSBYMoIbWBDLOY2A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:ac04:0:b0:d9a:520f:1988 with SMTP
 id w4-20020a25ac04000000b00d9a520f1988mr525338ybi.4.1699238660358; Sun, 05
 Nov 2023 18:44:20 -0800 (PST)
Date:   Sun,  5 Nov 2023 18:44:00 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-2-almasrymina@google.com>
Subject: [RFC PATCH v3 01/12] net: page_pool: factor out releasing DMA from
 releasing the page
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

Releasing the DMA mapping will be useful for other types
of pages, so factor it out. Make sure compiler inlines it,
to avoid any regressions.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

This is implemented by Jakub in his RFC:

https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com/T/

I take no credit for the idea or implementation. This is a critical
dependency of device memory TCP and thus I'm pulling it into this series
to make it revewable and mergable.

---
 net/core/page_pool.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 5e409b98aba0..578b6f2eeb46 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -514,21 +514,16 @@ static s32 page_pool_inflight(struct page_pool *pool)
 	return inflight;
 }
 
-/* Disconnects a page (from a page_pool).  API users can have a need
- * to disconnect a page (from a page_pool), to allow it to be used as
- * a regular page (that will eventually be returned to the normal
- * page-allocator via put_page).
- */
-static void page_pool_return_page(struct page_pool *pool, struct page *page)
+static __always_inline
+void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
 {
 	dma_addr_t dma;
-	int count;
 
 	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
 		/* Always account for inflight pages, even if we didn't
 		 * map them
 		 */
-		goto skip_dma_unmap;
+		return;
 
 	dma = page_pool_get_dma_addr(page);
 
@@ -537,7 +532,19 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr(page, 0);
-skip_dma_unmap:
+}
+
+/* Disconnects a page (from a page_pool).  API users can have a need
+ * to disconnect a page (from a page_pool), to allow it to be used as
+ * a regular page (that will eventually be returned to the normal
+ * page-allocator via put_page).
+ */
+void page_pool_return_page(struct page_pool *pool, struct page *page)
+{
+	int count;
+
+	__page_pool_release_page_dma(pool, page);
+
 	page_pool_clear_pp_info(page);
 
 	/* This may be the last page returned, releasing the pool, so
-- 
2.42.0.869.gea05f2083d-goog

