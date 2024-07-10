Return-Path: <linux-arch+bounces-5333-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F6992C752
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 02:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC585B22608
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 00:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499112BB0D;
	Wed, 10 Jul 2024 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7mSU6OQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395F79F9
	for <linux-arch@vger.kernel.org>; Wed, 10 Jul 2024 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570692; cv=none; b=b77tMvf3je/pzarjDApyetI9aMfQlkoJja42i/KBKTsvNtm8zwFHbKQf0Ki9FMrGcfSpOgBEHAMuoDkv6IBra6TsIOYEKnPubfGAnqSToC9inWIdKrgKICM8pCLvsOBjpTehnVx8So+mpATQwPSwG6bCRNVN/tDFKrTIoDJhOV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570692; c=relaxed/simple;
	bh=8iRNGbI2qpWdMa2+XsAmpKFN8DTwATpwGIsjcNeJ358=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ASkp23DQ6qpQ48hPPg1MMgQxl/Cze0UW6eJt/YCBp4iuyEOF9V8Tge9kmqCLGtyAy1SWDDQ4NMJmepQIHANhJCOi4DM5FD0YM2apQSCFs8Qc3D8eaJq3d5wKlQYByvUk8Sj8xhzDWX+Yi+HFzeqHjTA7YdQvVaQFUIwO9wly7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7mSU6OQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b5588bcafso93415267b3.1
        for <linux-arch@vger.kernel.org>; Tue, 09 Jul 2024 17:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720570685; x=1721175485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FiHUzaFg849KyOorJyN4CA3fGzdjtZ4jZKx/Ko1Z19E=;
        b=T7mSU6OQSdx5r7RMXPbFpy+QCdh+plj1xiLz+sx9XgdmiLwuQ8VzMVQdHQB7mfmYBa
         hgh57GjxHr0qrpwidNjvMkWxtwg/EoXvm9KSp+jK/o6p43HC3fxFyxWIG2Q4UyqZURjb
         9G+ItoHh/14ZVbcCFYVpdj5XEbBwtm/pdPoxM2S1rrkzg7PBR1EnrBrgHtDvaZie8Wb+
         GhXtdSZQvUhNv0RGplMfKqmaSGJNRku7QTLFR6nZGKFjuGlgUNKqaBpnWrrbrmay8yxj
         cJFBQ+D5cHt5+xlj2KvlHSELvs6cOvV2UUK+EykNC8WH8XVfGjXPP4NpdbNjzFkllyk9
         JfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720570685; x=1721175485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FiHUzaFg849KyOorJyN4CA3fGzdjtZ4jZKx/Ko1Z19E=;
        b=ZLs7m2Ff0hoSKb03QcLR6FU6nuFBtmMLO8NZMZaetWLXvoR7K5Aun54QpW7gYFTfqf
         BeyE5EMMUHFmcRxYBjfT7rcMbuwS9RdDFaM0UNQ9IQbtuCB/EM+SmnlzNtregAHfKe6p
         J58TlFb3nysnh4WDZ4N3xBBKxPrwbgEYC/Pz4b7nTmaDbBoIS095zh0Gfr5S8dNoWR9S
         0kdxWw6JsnSxr7RFFeijYPAW90lUhDKhv6rjtF6b/pcczeZDKG8I7q4zwkEi7x+kELxO
         HpiDi0+wcrRigXO015PRstW3aZd7b2QZqnziJEusBsVCvstQRUdYcbTFCnrfEfpe6xbe
         pYhg==
X-Forwarded-Encrypted: i=1; AJvYcCX4/YX/9I7EOZf/RaG+a0mMZVm8dZgUDo6r25xJhUM7RbDadUrvdKs/WzODewCee5OVKEApjGb6Rb3YQvSTTLBOrlHq3HAcgUWheQ==
X-Gm-Message-State: AOJu0Ywq3LAVltHTCh+hnjVqkXdixLgofar2YMzD8Q3WM9355yxxqYYL
	/7GgcSx5UfBQuUFhZusdzVnzM43ckonjeBlF7RSagbxGkiHEbl/0cXZerUhr368pjJoEycTmG4i
	sARF2XgPx7RCICxaYrNU4+Q==
X-Google-Smtp-Source: AGHT+IHcFAsM+veseQhMuDq4fdqXiB6re5s3LfkswUKIbj6jAQ43SYp2VyIeUbPghMzmsGuob0dyETBl2a6XDeDZyQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:6b0e:b0:62d:a29:537f with
 SMTP id 00721157ae682-658eec67a34mr1440037b3.4.1720570685564; Tue, 09 Jul
 2024 17:18:05 -0700 (PDT)
Date: Wed, 10 Jul 2024 00:17:40 +0000
In-Reply-To: <20240710001749.1388631-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710001749.1388631-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710001749.1388631-8-almasrymina@google.com>
Subject: [PATCH net-next v16 07/13] net: support non paged skb frags
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
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
index 9c29bdd5596d8..8ebb0b3996b0c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3515,21 +3515,58 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
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
@@ -3539,6 +3576,9 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
  */
 static inline void *skb_frag_address(const skb_frag_t *frag)
 {
+	if (!skb_frag_page(frag))
+		return NULL;
+
 	return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
 }
 
diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 16c241a234728..0f3c58007488a 100644
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
index 572f46eb937a0..6e79ebc5cee3c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3434,8 +3434,9 @@ static int illegal_highdma(struct net_device *dev, struct sk_buff *skb)
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
index b3b43de1a6502..26f09c3e830b7 100644
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
index 4c72b81dfcd95..1ff6bb1c0be08 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1367,6 +1367,14 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
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
@@ -3159,6 +3167,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
+		if (WARN_ON_ONCE(!skb_frag_page(f)))
+			return false;
+
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
 				     offset, len, spd, false, sk, pipe))
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 3968d3f98e083..4ce0bc41e7806 100644
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
index e03a342c9162b..8050148d302b1 100644
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
index 34a9a5b9ed00b..0318aea0d4ce6 100644
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
2.45.2.803.g4e1b14247a-goog


