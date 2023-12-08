Return-Path: <linux-arch+bounces-761-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEDF8097B7
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 01:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354BA2820D8
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 00:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964B653;
	Fri,  8 Dec 2023 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWkp78Jt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD256171D
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 16:52:57 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1ed4b268dso18386377b3.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 16:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996777; x=1702601577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfCMsfp1IUoZ64EVVtr7gxYSAUWCUtGUA5R8s2RxKzs=;
        b=XWkp78Jt2QfvZg8KL7llBcvri5RjxOftzxLo0jx+7924tKzy++MPlqogZva2qqiyHY
         +bueHNbRUnR3T9ac90rBm7qI3/wDGbnJN/nP8rsklNS96u4ZWHZSFl+syYtRZ0VX77x3
         4H+75nfKvExAlegJE/i8inw6F53Al++9/MEQy42vYTBYdujlyUcroYYZtih02yNAIzge
         8n9USaAsYZMIKt5sMYTcgQ2a0AtrWPCAh6X7T6YCdxNsTCfWn+sGys4zJnbJwZRVveoz
         xBNWojBDl1810EOBaMMJh2y57X8lkYKiRr9DE5U1SXABZldjMU/S2aKk893QNxUF4YmV
         Pt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996777; x=1702601577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfCMsfp1IUoZ64EVVtr7gxYSAUWCUtGUA5R8s2RxKzs=;
        b=scxrEP5tlAA3NellrSBhvohO/rZlRaeRFlrX6REhkxx29KCtQd9FWmd52ve0fBnmiU
         0OJIwoutZHlWIbfS650AwjcG4dW7M6wbB96fl4Ji3Hg34xP6kt822nyFXOFQxF9gqqEi
         J0gQKxgZOS0R1xbeqWfdHjbfEW8b5gzAgx1Z9+itnmuZxu/dEif1TM+Sr/ZJfovKDQBD
         u/4ZHgWA6NAHJDNtV1GKo5vuS4DpTwTUclH9Bhb2bEnOcyn9y2VuAt3VPQ1CuF0JWiwJ
         YNI9HpY6rGJ0QrsfbP5cMlj53pVlaVu9BANtm5kkYBo5UembAIQxmu1cluwN1xXeEKD1
         tbQQ==
X-Gm-Message-State: AOJu0YyhEiTgvQTt/eXNlI+PEBjHEwWOcue/0peuREX6BaCowFAqLHzn
	Qj9cn83SUr4j9DgUgIuUlVlnd5zM3eY/QIBp8w==
X-Google-Smtp-Source: AGHT+IEutjJnS2EH/ZQ+5x+IuH211lQgvDfZASfUKd2jgJtW5JenzTRObxK0Vp6bTrTGEljS7VIcMH18dMhy9n5y3A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a81:441f:0:b0:5d5:5183:ebdb with SMTP
 id r31-20020a81441f000000b005d55183ebdbmr57205ywa.10.1701996776836; Thu, 07
 Dec 2023 16:52:56 -0800 (PST)
Date: Thu,  7 Dec 2023 16:52:32 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-2-almasrymina@google.com>
Subject: [net-next v1 01/16] net: page_pool: factor out releasing DMA from
 releasing the page
From: Mina Almasry <almasrymina@google.com>
To: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

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
index c2e7c9a6efbe..ca1b3b65c9b5 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -548,21 +548,16 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
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
 
@@ -571,7 +566,19 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
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
2.43.0.472.g3155946c3a-goog


