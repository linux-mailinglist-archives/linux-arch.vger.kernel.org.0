Return-Path: <linux-arch+bounces-771-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A78809816
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 01:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45411282370
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9975691;
	Fri,  8 Dec 2023 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CARj6FzP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BCE173E
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 16:53:18 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d988d69812so18524317b3.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 16:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996797; x=1702601597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffR5lRGBwRWz92voabMKfnUxOBX9ei9jc/R/TuPbdfY=;
        b=CARj6FzPCQ1sS6YCVmsJB2NuIjXU5lWVvtkUA/k/Ll427ms3YefKFgMH2SMQQf4uBm
         Y2ixiCLENlCGWmGmNRwE04NsaWWaoc4v0jHlbOrFkzgIyF6Pu+sLahVyJ5wZPPRlSi4L
         kLQRg9ZKrOYxNvgxMBRA/rmTJwWc4ML4fjSMjZRL50MXqbO50Ww/Kf4PZtBI4Q1sNKsS
         7nI8xXGI/uXnpLQUYfGgpCCEL7LIrUJhauFjUzSAypMIPyixSiMFc2VlLXB8UKV9yYkX
         ZP3x0ifY9/bD9o8CH1cl3tnMc12Q65gmXLdDzgfdTONQe3SLK3C9tEsoS2nOSd2zRAxy
         g3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996797; x=1702601597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffR5lRGBwRWz92voabMKfnUxOBX9ei9jc/R/TuPbdfY=;
        b=CzsnMdC5+iBcY2Y3ZTrUeYyY2dTpuwP8poqUuE85b24X61adoqfFF+J5GcUAibapkL
         58r0Gf6xin5mryn8D+wpIss1dGgqTodlo3gEe2kOm2WW9TsNU3CVBjIL1NxNO6pBcB5l
         tH4zGD84cVrFMTfNfGC1qUxk2YmP7CaSzFQifBN9nP6ClTVHrd6OBokxS5YmA2fmBf/1
         Mbfsa2JV4OYT0bkjxPdArvXzhDitkP6Tl6MVqsPbw43GWg0VqNd6az4yr1wqI30bLNpY
         vfy2CzJuv7LK0od90oaGIFQb8qBgZqLSrasHtpWyuFWsamBbQOyR0hI9JdHiJagglTfN
         W3+g==
X-Gm-Message-State: AOJu0YxD5FdCBCeEmHKgE78p0cavXQS5Ol2z1h1Kyek7YwcnFuU5t+SZ
	lPA4A5PV0TO93Iu3rSEbedDCOjgOgk4+NucqWg==
X-Google-Smtp-Source: AGHT+IH8QZVgyP79RbEsqH0j0RL1Mpin9iL/UFr2+o7Otvdv7pJ6u3sBW0Y9+P6SJHsoq2x+yqVIWLpUXWuYkWSTkw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a25:ccd5:0:b0:daf:6333:17c3 with SMTP
 id l204-20020a25ccd5000000b00daf633317c3mr42079ybf.1.1701996797568; Thu, 07
 Dec 2023 16:53:17 -0800 (PST)
Date: Thu,  7 Dec 2023 16:52:42 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-12-almasrymina@google.com>
Subject: [net-next v1 11/16] net: support non paged skb frags
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

Make skb_frag_page() fail in the case where the frag is not backed
by a page, and fix its relevant callers to handle this case.

Correctly handle skb_frag refcounting in the page_pool_iovs case.

Signed-off-by: Mina Almasry <almasrymina@google.com>


---

Changes in v1:
- Fix illegal_highdma() (Yunsheng).
- Rework napi_pp_put_page() slightly to reduce code churn (Willem).

---
 include/linux/skbuff.h | 42 +++++++++++++++++++++++++++++++++++-------
 net/core/dev.c         |  3 ++-
 net/core/gro.c         |  2 +-
 net/core/skbuff.c      |  3 +++
 net/ipv4/tcp.c         |  3 +++
 5 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b370eb8d70f7..851f448d2181 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -37,6 +37,8 @@
 #endif
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
 
 /**
  * DOC: skb checksums
@@ -3414,15 +3416,38 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
 	fragto->bv_offset = fragfrom->bv_offset;
 }
 
+/* Returns true if the skb_frag contains a page_pool_iov. */
+static inline bool skb_frag_is_page_pool_iov(const skb_frag_t *frag)
+{
+	return page_is_page_pool_iov(frag->bv_page);
+}
+
 /**
  * skb_frag_page - retrieve the page referred to by a paged fragment
  * @frag: the paged fragment
  *
- * Returns the &struct page associated with @frag.
+ * Returns the &struct page associated with @frag. Returns NULL if this frag
+ * has no associated page.
  */
 static inline struct page *skb_frag_page(const skb_frag_t *frag)
 {
-	return frag->bv_page;
+	if (!page_is_page_pool_iov(frag->bv_page))
+		return frag->bv_page;
+
+	return NULL;
+}
+
+/**
+ * skb_frag_page_pool_iov - retrieve the page_pool_iov referred to by fragment
+ * @frag: the fragment
+ *
+ * Returns the &struct page_pool_iov associated with @frag. Returns NULL if this
+ * frag has no associated page_pool_iov.
+ */
+static inline struct page_pool_iov *
+skb_frag_page_pool_iov(const skb_frag_t *frag)
+{
+	return page_to_page_pool_iov(frag->bv_page);
 }
 
 /**
@@ -3433,7 +3458,7 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
  */
 static inline void __skb_frag_ref(skb_frag_t *frag)
 {
-	get_page(skb_frag_page(frag));
+	page_pool_page_get_many(frag->bv_page, 1);
 }
 
 /**
@@ -3453,13 +3478,13 @@ bool napi_pp_put_page(struct page *page, bool napi_safe);
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	struct page *page = skb_frag_page(frag);
-
 #ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page, napi_safe))
+	if (recycle && napi_pp_put_page(frag->bv_page, napi_safe))
 		return;
+	page_pool_page_put_many(frag->bv_page, 1);
+#else
+	put_page(skb_frag_page(frag));
 #endif
-	put_page(page);
 }
 
 /**
@@ -3499,6 +3524,9 @@ static inline void skb_frag_unref(struct sk_buff *skb, int f)
  */
 static inline void *skb_frag_address(const skb_frag_t *frag)
 {
+	if (!skb_frag_page(frag))
+		return NULL;
+
 	return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 30667e4c3b95..1ae9257df441 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3709,8 +3709,9 @@ static int illegal_highdma(struct net_device *dev, struct sk_buff *skb)
 	if (!(dev->features & NETIF_F_HIGHDMA)) {
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			struct page *page = skb_frag_page(frag);
 
-			if (PageHighMem(skb_frag_page(frag)))
+			if (page && PageHighMem(page))
 				return 1;
 		}
 	}
diff --git a/net/core/gro.c b/net/core/gro.c
index 0759277dc14e..42d7f6755f32 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -376,7 +376,7 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 	NAPI_GRO_CB(skb)->frag0 = NULL;
 	NAPI_GRO_CB(skb)->frag0_len = 0;
 
-	if (!skb_headlen(skb) && pinfo->nr_frags &&
+	if (!skb_headlen(skb) && pinfo->nr_frags && skb_frag_page(frag0) &&
 	    !PageHighMem(skb_frag_page(frag0)) &&
 	    (!NET_IP_ALIGN || !((skb_frag_off(frag0) + nhoff) & 3))) {
 		NAPI_GRO_CB(skb)->frag0 = skb_frag_address(frag0);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 07f802f1adf1..2ce64f57a0f6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2999,6 +2999,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
+		if (WARN_ON_ONCE(!skb_frag_page(f)))
+			return false;
+
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
 				     offset, len, spd, false, sk, pipe))
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 70a1bafbefba..e22681c4bfac 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2157,6 +2157,9 @@ static int tcp_zerocopy_receive(struct sock *sk,
 			break;
 		}
 		page = skb_frag_page(frags);
+		if (WARN_ON_ONCE(!page))
+			break;
+
 		prefetchw(page);
 		pages[pages_to_map++] = page;
 		length += PAGE_SIZE;
-- 
2.43.0.472.g3155946c3a-goog


