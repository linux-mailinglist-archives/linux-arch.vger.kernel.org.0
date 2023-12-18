Return-Path: <linux-arch+bounces-1113-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0A58164C1
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 03:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CB81C20FE5
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 02:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B100107AB;
	Mon, 18 Dec 2023 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ILoJPf9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649891119A
	for <linux-arch@vger.kernel.org>; Mon, 18 Dec 2023 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5d12853cb89so30426027b3.3
        for <linux-arch@vger.kernel.org>; Sun, 17 Dec 2023 18:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702867248; x=1703472048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7ZiIb8MLUHR5WE0ilENIpcZDtQSwPuT0/gwz/yRXbY=;
        b=3ILoJPf9205oVpGba9KbKAe530sNaVfOo7qkOKIHsCfvN8sCKr2ia1FRwsndv6v2wZ
         j/qQuCkP1E4p9fn8SSh86lfKGD1BdFlst5axvtP4xgKPoriHUPTw322tZ2XEveScNb7h
         uCwh16bN9HgOENMIyuF88fDnvBjGF1bG8EEiDQhfULpERctkWJJSV+/k9yF69LFQMsiL
         IhweCn7jeD4A5+tGn3Iwy9b7G36ZuFqJ5lIo8/N40xz85cS24RidtSAzq0ZjBT76hA5d
         KYDH5+vNSzpkSdgHF2sFm97Vk2LmQVIAFhyiuLz5oxpZUxx7U0fOmI9zg3/AUuFndHjR
         ggHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867248; x=1703472048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7ZiIb8MLUHR5WE0ilENIpcZDtQSwPuT0/gwz/yRXbY=;
        b=GsTJNXMi82K8aVDZlIsPkTH3GoCPfyIY7vjJM66SyGe/gD6HpVHA2FOpEXZvUg8jbZ
         byQhrfuSCNsZdrSlgOVNl6yw69aEE0JRXzrUyCLMGgR3KK5fhOZ2KjboST0pVlxqkAF6
         q774rVUtwh9AR/cqxA4EAmWWaTunA77v7QFKDt6kzYaUxmSPFcqadK8NY2gycZ1Dr2KQ
         kp3sClXBlNa1cRbnqUcoqbwNjpa3S+OYCAmb4ajiWOixTvlKMOeJQhfDn9jnkWMqLJCY
         AAz6lRGtFghHRIOHQxNPKxdM5+3sVsLn2c5+KKkdfYIBdDezWeICyjkyS54bEl+oB2t7
         WUWQ==
X-Gm-Message-State: AOJu0YzV7XJ2s6oJd4+7ZRMphwUaORhuxMjHyYuK2zviyxvyKqha9NOk
	V/0jJx6DpXCTK9FPSCuzANepHhjw0sbQcMOg8Q==
X-Google-Smtp-Source: AGHT+IGYt6iqPG2FjUKXUN8ySlIMViPuOzAnT09JcLEECZ7CdlQnRc1ni84YQQ9aTrK9dTaYGwfeTFP3mUL+lGAiEw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:5cbf:3534:fb34:758e])
 (user=almasrymina job=sendgmr) by 2002:a25:83c1:0:b0:dbc:ff55:6067 with SMTP
 id v1-20020a2583c1000000b00dbcff556067mr1368244ybm.0.1702867248313; Sun, 17
 Dec 2023 18:40:48 -0800 (PST)
Date: Sun, 17 Dec 2023 18:40:16 -0800
In-Reply-To: <20231218024024.3516870-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218024024.3516870-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218024024.3516870-10-almasrymina@google.com>
Subject: [RFC PATCH net-next v5 09/14] net: support non paged skb frags
From: Mina Almasry <almasrymina@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

Make skb_frag_page() fail in the case where the frag is not backed
by a page, and fix its relevant callers to handle this case.

Signed-off-by: Mina Almasry <almasrymina@google.com>


---

Changes in v1:
- Fix illegal_highdma() (Yunsheng).
- Rework napi_pp_put_page() slightly to reduce code churn (Willem).

(cherry picked from commit e11c8035ed635e22aab224a89c48d93b5e881278)

also squashed assorted fixes
---
 include/linux/skbuff.h | 47 +++++++++++++++++++++++++++++++++++++-----
 net/core/dev.c         |  3 ++-
 net/core/gro.c         |  2 +-
 net/core/skbuff.c      | 11 ++++++++++
 net/ipv4/tcp.c         |  3 +++
 5 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1189d8d22da8..890fc2b94fc7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3452,17 +3452,53 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
 	fragto->bv_offset = fragfrom->bv_offset;
 }
 
+/* Returns true if the skb_frag contains a net_iov. */
+static inline bool skb_frag_is_net_iov(const skb_frag_t *frag)
+{
+	return netmem_is_net_iov(frag->bv_page);
+}
+
+/**
+ * skb_frag_net_iov - retrieve the net_iov referred to by fragment
+ * @frag: the fragment
+ *
+ * Returns the &struct net_iov associated with @frag. Returns NULL if this
+ * frag has no associated net_iov.
+ */
+static inline struct net_iov *skb_frag_net_iov(const skb_frag_t *frag)
+{
+	if (!skb_frag_is_net_iov(frag))
+		return NULL;
+
+	return netmem_to_net_iov(frag->bv_page);
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
+	if (skb_frag_is_net_iov(frag))
+		return NULL;
+
 	return netmem_to_page(frag->bv_page);
 }
 
+/**
+ * skb_frag_netmem - retrieve the netmem referred to by a fragment
+ * @frag: the fragment
+ *
+ * Returns the &struct netmem associated with @frag.
+ */
+static inline struct netmem *skb_frag_netmem(const skb_frag_t *frag)
+{
+	return frag->bv_page;
+}
+
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
@@ -3491,13 +3527,11 @@ bool napi_pp_put_page(struct netmem *netmem, bool napi_safe);
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	struct page *page = skb_frag_page(frag);
-
 #ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page_to_netmem(page), napi_safe))
+	if (recycle && napi_pp_put_page(skb_frag_netmem(frag), napi_safe))
 		return;
 #endif
-	put_page(page);
+	put_page(skb_frag_page(frag));
 }
 
 /**
@@ -3537,6 +3571,9 @@ static inline void skb_frag_unref(struct sk_buff *skb, int f)
  */
 static inline void *skb_frag_address(const skb_frag_t *frag)
 {
+	if (!skb_frag_page(frag))
+		return NULL;
+
 	return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 20ba528ef426..ad616b3c8e35 100644
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
index 96f85543f1dc..671775bad5f9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1239,6 +1239,14 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 		struct page *p;
 		u8 *vaddr;
 
+		if (skb_frag_is_net_iov(frag)) {
+			printk("%sskb frag %d: not readable\n", level, i);
+			len -= frag->bv_len;
+			if (!len)
+				break;
+			continue;
+		}
+
 		skb_frag_foreach_page(frag, skb_frag_off(frag),
 				      skb_frag_size(frag), p, p_off, p_len,
 				      copied) {
@@ -3004,6 +3012,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
+		if (WARN_ON_ONCE(!skb_frag_page(f)))
+			return false;
+
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
 				     offset, len, spd, false, sk, pipe))
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1d6b80145efb..82485af12cdc 100644
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


