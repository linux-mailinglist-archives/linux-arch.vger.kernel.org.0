Return-Path: <linux-arch+bounces-6577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC55195E157
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2024 06:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36D72824BB
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2024 04:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E38175F;
	Sun, 25 Aug 2024 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gI4xAKs2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694636F076
	for <linux-arch@vger.kernel.org>; Sun, 25 Aug 2024 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724559341; cv=none; b=EgCj91RohK7q/FdH8zrg9frA4pmns3bi+NyQT6EICG6AKaZvJAQHwnLfr2Jds+XCTXwvq4q0DTvtLEpYwU9/0Dx5PHNGAI0DGXyF9FORz0FDkekT2x41rNrX/Ek91zT65MhHep1T4vLVO1HDK6WBfxnydE5saBrRrISaaCin8aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724559341; c=relaxed/simple;
	bh=UG4Odx7ZlnicK/H+zvvvn0IwK+xDR9UZKy6QGbiGbHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qwm09YljAqwsW8b024aX/s+AM9YJhI1L7FTe903WCghU18/dJ2YvOPqh7FsBGbvqUQTUu6w8TjdTN8kkbkGpR2GflGAmYRXtu8hZEMfRd+NUPUv9zI0e9AuJF/v755TFMlFmPEzWLxl0ZgO+UiP6XRZjuANAJsmt4byvWnfnJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gI4xAKs2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6507e2f0615so2723461a12.1
        for <linux-arch@vger.kernel.org>; Sat, 24 Aug 2024 21:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724559331; x=1725164131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBaBPkUGzp81y+Ko+TRyZGwAtxViy7iHwU3rKfDaFg4=;
        b=gI4xAKs2OAujyP/oyo2kC5F+uTCu/igAGfibNoHDGlJUpw+eP5msKV13JljNn1gZNh
         KsKfstR9/PdyaJBDbKhESZJeedhBMl/DcECYDi3ZiuBJ4IdMIZpp0WOjHu2hzI6GjyYj
         MBpsZyu2kAeXRVO57XIJyKQjSOqp85JpzG5BbmTy7I2y18eKQr8DyPyQKJqhoPgTl3rl
         OOPBue3iVvxx7dtWnzHUpIOCd9ladbLwjam7tPRYocW58rLz7YgrF2SdzUi3CeIJSjNd
         agf56tMNfsPRv9oyCqRU5S71z4n+RXTHZrmp9U8IUADFvl5ICkngFRpmtZ+NO7FFEqsf
         8a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724559331; x=1725164131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBaBPkUGzp81y+Ko+TRyZGwAtxViy7iHwU3rKfDaFg4=;
        b=JgeL/HWS5ZiJtqXwV82V7D7lNEvy78yJ5RpfBbpRCF5676oeBGSy8KLqheXhYVKses
         j5LxucIUQ4W/ZGJmM8nhdV8Rgma4I1qHsj9uvZm1FU1Oab++/qz2cMIjegHeZfJNYrtm
         Heh03yrOgljUSREDpW9/EPqr/BD/wxN26DgJ1YWqz2ABHn4n2mz80Ofo9GcBpY5XICAO
         famw8pN9w6zwEPGSabEcBPvLlGI/XUe8oLt+KKEiAZaeJOCLKrxQ8KDQNL/1zrqZC+SY
         25aAT3LpYdtCFpQ59fFBBUXc8lGdRbCpUARVePeqtLVqOLiqIbSkNzZ246qLZL4YVnN6
         Xkyw==
X-Forwarded-Encrypted: i=1; AJvYcCUyJrXJpFeWlmxDPN7r49Hu6RJhfMOkUHQ8B7dEVm8RNFbe8u0u7TcC9eLTWPIsny2AZB/zHjDo7D5I@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbWboBA7SKlDLxpS0/vVSmFQLeVQR5PGJJzt2zlQHZmrv4IbJ
	esyBHm10YB1PQULOyhey505L4xqpQPnXL5a+FCRYadGMPgTSrrYfKBHLY1H4S1ms3ky/gX6habZ
	4XwlfoxWL7j5EkAXxf2ORfQ==
X-Google-Smtp-Source: AGHT+IFYddEuV+6QD0mIFU1bJlBuaZgRaIPbtrt42PbKm8wRXB/WccdhoJa9w5dg05KWL7sZC43e64uPo59mKi+SYA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a65:6884:0:b0:7c2:1887:5f9f with SMTP
 id 41be03b00d2f7-7cf54e4c5dfmr11034a12.3.1724559331211; Sat, 24 Aug 2024
 21:15:31 -0700 (PDT)
Date: Sun, 25 Aug 2024 04:15:05 +0000
In-Reply-To: <20240825041511.324452-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240825041511.324452-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240825041511.324452-8-almasrymina@google.com>
Subject: [PATCH net-next v22 07/13] net: support non paged skb frags
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Make skb_frag_page() fail in the case where the frag is not backed
by a page, and fix its relevant callers to handle this case.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>


---

v10:
- Fixed newly generated kdoc warnings found by patchwork. While we're
  at it, fix the Return section of the functions I touched.

v6:
- Rebased on top of the merged netmem changes.

Changes in v1:
- Fix illegal_highdma() (Yunsheng).
- Rework napi_pp_put_page() slightly to reduce code churn (Willem).

---
 include/linux/skbuff.h     | 42 +++++++++++++++++++++++++++++++++++++-
 include/linux/skbuff_ref.h |  9 ++++----
 net/core/dev.c             |  3 ++-
 net/core/gro.c             |  3 ++-
 net/core/skbuff.c          | 11 ++++++++++
 net/ipv4/esp4.c            |  3 ++-
 net/ipv4/tcp.c             |  3 +++
 net/ipv6/esp6.c            |  3 ++-
 8 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cf8f6ce06742..dbadf2dd6b35 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3523,21 +3523,58 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
 	fragto->offset = fragfrom->offset;
 }
 
+/* Return: true if the skb_frag contains a net_iov. */
+static inline bool skb_frag_is_net_iov(const skb_frag_t *frag)
+{
+	return netmem_is_net_iov(frag->netmem);
+}
+
+/**
+ * skb_frag_net_iov - retrieve the net_iov referred to by fragment
+ * @frag: the fragment
+ *
+ * Return: the &struct net_iov associated with @frag. Returns NULL if this
+ * frag has no associated net_iov.
+ */
+static inline struct net_iov *skb_frag_net_iov(const skb_frag_t *frag)
+{
+	if (!skb_frag_is_net_iov(frag))
+		return NULL;
+
+	return netmem_to_net_iov(frag->netmem);
+}
+
 /**
  * skb_frag_page - retrieve the page referred to by a paged fragment
  * @frag: the paged fragment
  *
- * Returns the &struct page associated with @frag.
+ * Return: the &struct page associated with @frag. Returns NULL if this frag
+ * has no associated page.
  */
 static inline struct page *skb_frag_page(const skb_frag_t *frag)
 {
+	if (skb_frag_is_net_iov(frag))
+		return NULL;
+
 	return netmem_to_page(frag->netmem);
 }
 
+/**
+ * skb_frag_netmem - retrieve the netmem referred to by a fragment
+ * @frag: the fragment
+ *
+ * Return: the &netmem_ref associated with @frag.
+ */
+static inline netmem_ref skb_frag_netmem(const skb_frag_t *frag)
+{
+	return frag->netmem;
+}
+
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom);
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 			 struct bpf_prog *prog);
+
 /**
  * skb_frag_address - gets the address of the data contained in a paged fragment
  * @frag: the paged fragment buffer
@@ -3547,6 +3584,9 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
  */
 static inline void *skb_frag_address(const skb_frag_t *frag)
 {
+	if (!skb_frag_page(frag))
+		return NULL;
+
 	return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
 }
 
diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 16c241a23472..0f3c58007488 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -34,14 +34,13 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 
 bool napi_pp_put_page(netmem_ref netmem);
 
-static inline void
-skb_page_unref(struct page *page, bool recycle)
+static inline void skb_page_unref(netmem_ref netmem, bool recycle)
 {
 #ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page_to_netmem(page)))
+	if (recycle && napi_pp_put_page(netmem))
 		return;
 #endif
-	put_page(page);
+	put_page(netmem_to_page(netmem));
 }
 
 /**
@@ -54,7 +53,7 @@ skb_page_unref(struct page *page, bool recycle)
  */
 static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
 {
-	skb_page_unref(skb_frag_page(frag), recycle);
+	skb_page_unref(skb_frag_netmem(frag), recycle);
 }
 
 /**
diff --git a/net/core/dev.c b/net/core/dev.c
index 2cab5f969778..8be922165737 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3432,8 +3432,9 @@ static int illegal_highdma(struct net_device *dev, struct sk_buff *skb)
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
index b3b43de1a650..26f09c3e830b 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -408,7 +408,8 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 	pinfo = skb_shinfo(skb);
 	frag0 = &pinfo->frags[0];
 
-	if (pinfo->nr_frags && !PageHighMem(skb_frag_page(frag0)) &&
+	if (pinfo->nr_frags && skb_frag_page(frag0) &&
+	    !PageHighMem(skb_frag_page(frag0)) &&
 	    (!NET_IP_ALIGN || !((skb_frag_off(frag0) + nhoff) & 3))) {
 		NAPI_GRO_CB(skb)->frag0 = skb_frag_address(frag0);
 		NAPI_GRO_CB(skb)->frag0_len = min_t(unsigned int,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e418da9e2379..d3bcb37c9e7a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1371,6 +1371,14 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 		struct page *p;
 		u8 *vaddr;
 
+		if (skb_frag_is_net_iov(frag)) {
+			printk("%sskb frag %d: not readable\n", level, i);
+			len -= skb_frag_size(frag);
+			if (!len)
+				break;
+			continue;
+		}
+
 		skb_frag_foreach_page(frag, skb_frag_off(frag),
 				      skb_frag_size(frag), p, p_off, p_len,
 				      copied) {
@@ -3163,6 +3171,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
+		if (WARN_ON_ONCE(!skb_frag_page(f)))
+			return false;
+
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
 				     offset, len, spd, false, sk, pipe))
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 47378ca41904..f3281312eb5e 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -115,7 +115,8 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(sg_page(sg), skb->pp_recycle);
+			skb_page_unref(page_to_netmem(sg_page(sg)),
+				       skb->pp_recycle);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8514257f4ecd..20a1b0333017 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2177,6 +2177,9 @@ static int tcp_zerocopy_receive(struct sock *sk,
 			break;
 		}
 		page = skb_frag_page(frags);
+		if (WARN_ON_ONCE(!page))
+			break;
+
 		prefetchw(page);
 		pages[pages_to_map++] = page;
 		length += PAGE_SIZE;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 3920e8aa1031..b2400c226a32 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -132,7 +132,8 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(sg_page(sg), skb->pp_recycle);
+			skb_page_unref(page_to_netmem(sg_page(sg)),
+				       skb->pp_recycle);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.46.0.295.g3b9ea8a38a-goog


