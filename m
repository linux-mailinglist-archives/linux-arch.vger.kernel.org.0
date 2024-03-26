Return-Path: <linux-arch+bounces-3210-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0177288D1FE
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 23:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAECD323CF1
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 22:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A672D142640;
	Tue, 26 Mar 2024 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqdmVMWt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665431419BA
	for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493482; cv=none; b=SIGSF54iD3OM7ylxadPqyYx+nsoTY/b5DpRfO8+fdhZctkeDmw0R06uug9TyDlzZ01Mj+j8ZnGPt+rfiXPQYGSdsG7FIg2ZTMxabrxNG6+fqwc/vv6/s57LDD6l3yezRyZQpEU3T2z6HT7ZITgQCZFI3L2BgkN+0h/fKffauWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493482; c=relaxed/simple;
	bh=MFtFD7QvgVI9yOUwmuW/Gat4cRYyJqW0KYyD43iFUVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pUvlX9h/Jn1SqKtOUDfhE0oeKOzo7UjFXQrxQp+118q3ocU+SMTvyWBZAu25JKYy6NTW30JCGEmejEkiZeq6SMDZ4A9y2X4Y7dowbNizkNO/k3yt0KQbGYCj9LdGpOR/00aoA6J9k6mDYSfFumYjx1h/+QQLC/GgG4GlcqPICs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqdmVMWt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd62fa20fso121029707b3.3
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711493475; x=1712098275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZzmmX233kO6dJHGiFcs8o01xSEeeqyqo5FiT9OgEo8=;
        b=pqdmVMWtXGqNjr4+1vcrUbtuGkxeFJIA1d0QrFfhCSoS1LW/Gsj7FRM3kUa87oiBPI
         AIyazPfQylWTpox0TpALZ7euR7pLs04u0WF4PS90aNVuVDWXtNVfkZ1yUU5hjv1coee6
         IhjF7roaPuv6gWPfe9PPFIpxUMDZPdZ0/QChHr4yv1a/dv+raZj/5eB4O60laUKL3TDY
         qoHuQiwyOLG2ILMZP2JUf748ziJBN8LKm4apheW0jLRIUv3w9BrWXuA/ZwdQcSuf92h4
         Vcfvsm1yZGz0U1AWjhH1gctpDc3ZBt9uDXLsSQsNGLY8RKybF7okKnGsHGBXQRMXWzyf
         w+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493475; x=1712098275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZzmmX233kO6dJHGiFcs8o01xSEeeqyqo5FiT9OgEo8=;
        b=UhfnPjOvodZEF/z8aDxLw2wUSb/fxe8HQSy3rEpPoeai7HtFSgUdNac9ed0Lwxqz0M
         hj4lOrVq6FuaDjOhBwpRoJjqzOOCuwI01JdzkIp9o1sgC+XMalwLOA9umsAB7pWsTpNN
         89mifO6yKWbOQnUFWu8rBkSGN7mvAx04hzI89L/f+ckxmMew4YpBlsE3w2WkLN2hT4Po
         JcFcWrfiC7LEq1l82i4R68tvgax3hDU++hlrtDV4I7S9j3pFQWEKX9SP2hVtDivS8EIx
         gkt+spoRDslePrC9+xbzkaWNru1+72HmZMn0UZyQyWZlYLoLXyTY84ipFeG7gRF0PlYW
         bx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcDt+J2V8+heNibRdOJVV0a+Cgc7RiDDIlZp/QeZHDkvHNETtkxNCEcUB330M65/jLBzCsYZgop/9fjslfE+yVANNjB3A79eOr/g==
X-Gm-Message-State: AOJu0YwpTAPwkp0oXr8Uq5y2NvwPQwWz+0gCetMF66s2YazNmNvM17JQ
	+hoFZtetkyY0/+IBp6FSgIbjGaHaOFChEsuERjFey9mNYINDQJ13RKMQHLe9gd4GWZwm4QT/qXo
	Mj1KtWOQiMe6RWNX6iR5znA==
X-Google-Smtp-Source: AGHT+IEdweUGIR8RlliYPxgmCB5NPj7h583EZe+Yg+FD0SYphKZA41Usogavdhs3vjHXEwXSKCTDdpaqjb4oBXVhgQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:c51e:bdd0:7cc8:695c])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:b9e:b0:611:28f9:aa21 with
 SMTP id ck30-20020a05690c0b9e00b0061128f9aa21mr2572176ywb.4.1711493474784;
 Tue, 26 Mar 2024 15:51:14 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:50:40 -0700
In-Reply-To: <20240326225048.785801-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326225048.785801-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326225048.785801-10-almasrymina@google.com>
Subject: [RFC PATCH net-next v7 09/14] net: support non paged skb frags
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

Make skb_frag_page() fail in the case where the frag is not backed
by a page, and fix its relevant callers to handle this case.

Signed-off-by: Mina Almasry <almasrymina@google.com>


---

v6:
- Rebased on top of the merged netmem changes.

Changes in v1:
- Fix illegal_highdma() (Yunsheng).
- Rework napi_pp_put_page() slightly to reduce code churn (Willem).

---
 include/linux/skbuff.h | 53 +++++++++++++++++++++++++++++++++++-------
 net/core/dev.c         |  3 ++-
 net/core/gro.c         |  3 ++-
 net/core/skbuff.c      | 11 +++++++++
 net/ipv4/esp4.c        |  2 +-
 net/ipv4/tcp.c         |  3 +++
 net/ipv6/esp6.c        |  2 +-
 7 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 78659c8efa4e..8143aee8d911 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3483,17 +3483,53 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
 	fragto->offset = fragfrom->offset;
 }
 
+/* Returns true if the skb_frag contains a net_iov. */
+static inline bool skb_frag_is_net_iov(const skb_frag_t *frag)
+{
+	return netmem_is_net_iov(frag->netmem);
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
+	return netmem_to_net_iov(frag->netmem);
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
 	return netmem_to_page(frag->netmem);
 }
 
+/**
+ * skb_frag_netmem - retrieve the netmem referred to by a fragment
+ * @frag: the fragment
+ *
+ * Returns the &netmem_ref associated with @frag.
+ */
+static inline netmem_ref skb_frag_netmem(const skb_frag_t *frag)
+{
+	return frag->netmem;
+}
+
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
@@ -3524,25 +3560,23 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 bool napi_pp_put_page(netmem_ref netmem, bool napi_safe);
 
 static inline void
-skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
+skb_page_unref(const struct sk_buff *skb, netmem_ref netmem, bool napi_safe)
 {
 #ifdef CONFIG_PAGE_POOL
-	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
+	if (skb->pp_recycle && napi_pp_put_page(netmem, napi_safe))
 		return;
 #endif
-	put_page(page);
+	put_page(netmem_to_page(netmem));
 }
 
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
@@ -3582,6 +3616,9 @@ static inline void skb_frag_unref(struct sk_buff *skb, int f)
  */
 static inline void *skb_frag_address(const skb_frag_t *frag)
 {
+	if (!skb_frag_page(frag))
+		return NULL;
+
 	return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index e10610698a0a..8228432cb600 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3411,8 +3411,9 @@ static int illegal_highdma(struct net_device *dev, struct sk_buff *skb)
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
index ee30d4f0c038..eef20c82c5c3 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -380,7 +380,8 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 	pinfo = skb_shinfo(skb);
 	frag0 = &pinfo->frags[0];
 
-	if (pinfo->nr_frags && !PageHighMem(skb_frag_page(frag0)) &&
+	if (pinfo->nr_frags && skb_frag_page(frag0) &&
+	    !PageHighMem(skb_frag_page(frag0)) &&
 	    (!NET_IP_ALIGN || !((skb_frag_off(frag0) + nhoff) & 3))) {
 		NAPI_GRO_CB(skb)->frag0 = skb_frag_address(frag0);
 		NAPI_GRO_CB(skb)->frag0_len = min_t(unsigned int,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b7e974f0ae51..b4ea842ac9c7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1375,6 +1375,14 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
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
@@ -3142,6 +3150,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
+		if (WARN_ON_ONCE(!skb_frag_page(f)))
+			return false;
+
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
 				     offset, len, spd, false, sk, pipe))
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d33d12421814..3b2a6a033efa 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(skb, page_to_netmem(sg_page(sg)), false);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d20b62d52171..9f6497c53d61 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2167,6 +2167,9 @@ static int tcp_zerocopy_receive(struct sock *sk,
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
index 7371886d4f9f..342c07f0c6c4 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(skb, page_to_netmem(sg_page(sg)), false);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.44.0.396.g6e790dbe36-goog


