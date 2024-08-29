Return-Path: <linux-arch+bounces-6784-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A909963A93
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 08:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832981F218CD
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB9189F33;
	Thu, 29 Aug 2024 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AoCInjR7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D35178376
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 06:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911317; cv=none; b=PTBJY7v/79GVN2NFWHfOgTHrgrDGJJCKP5CBUopJUAJMBsicReTt36v0mDdKOz5ZUYwuw0wEDkjl0ONgQqnt6Ega5JOnnq8Kcz0x5/eYGLQ68bQuc7JSWKg8vO/ACO6sbcGZXgg98yfjfBaywDdQfpqx2McUlnxDNnqepUma/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911317; c=relaxed/simple;
	bh=4cEdGX9hish67s3GGBqTn4SNnvsFTqLO7DtrYBq1Zcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d64tnzUnNDawo5BZ3JBS34tUPVm4b25KwYabYjayyNfFKWgnsn63e5m8TCGtAFLXs5xpWFK0x+MaRnYUnXX5bMqyMi1XoyJwpO0xjfTtveAz/PYQ8S1angNol8cX11iBnD8GNka88a2dFVtjr1VjjO3iip2E5hyO4/2aEpuvMuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AoCInjR7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e116c697904so606236276.1
        for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724911310; x=1725516110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGpVRGfekhjDVyywEtenBlCrAd/FToUP+ZwUABZPRKU=;
        b=AoCInjR7gQjmEpnvo6PnipU3bzimeNEDwVnuqV9akPCbjXogSGuU3sRiXwe0jj+fSx
         wd3e8fItQor+WvMtlAc72VZqu8Tt5NpRjUxPDyHP4AMfOlS7JUJx5H1OGOUqDzrM8Naf
         68wGKGO7E9wJMG3JrH/KTL4+0on/f5eDKirreOaqKcJIbJvnbumN/Z7WcPBIHstjhVNI
         Hul9PgndnlXkmZXkSanMlPioOrx9rug64a8M6nJp6wf/wgzWL35WYIryrFYwmflhROez
         TtTX7R50y8zdcPI6rAEwGo3I0PS98C54Cf0CQLxXon8hP78+8QtB+iF3pckFNBS0o7S6
         so9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911310; x=1725516110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGpVRGfekhjDVyywEtenBlCrAd/FToUP+ZwUABZPRKU=;
        b=WrGbFZBhxZtgKPnifnKN8OcToJyiwWnk0yM9cMD5hnBcqqN2Tsym2OLCnq8rvpYGc5
         0LWkwU4tz0iKFjYEFBMOgLmBqGlox3izfgxlFghMt4zPAeVUzlJtTBiMStWlQaIotyGC
         8uSTNqX7A1PWqubIRpv8CfrZb9Zk1+rUKS/nxZzUH+Pt3j7/gdsgJ4R/mUMVodS4MoPy
         UF9EerU+/NpXD2a+30KNywRIzlvhI3IogYaQK4HdalQY79uFhN9KvAF1MUAXjoyJKBX6
         HTpws2T6R0rMvRZ8MgT8YHUd5J/GBPzjzq7GWYXQOxqO24/aTNX6J3cOzDkRPA/Zv7Mi
         DASw==
X-Forwarded-Encrypted: i=1; AJvYcCWMffhn1HsluVN8QfdIkn9UI8l0tnQHEwo/19/9HZfNOfRBMdmeQITREwfhC53Verwj6ZilYztRWys7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9saZMB++iO/RKcgrG+SccrznqgyWT+3cBDSPczm+H9Fbn0BxA
	vzliF2NFYEAKFf4jw5Lrssh81e803Tyu3k1uNHEkiHr3nXASrPOXbcDyHcx9fYGSN/kZJS2ouhn
	q+lw9zL1OZtSeBvZ6J4TRrw==
X-Google-Smtp-Source: AGHT+IE+xuiRVv5kCiJrpcsDPsQuxcPR6uqIR/31jSTihRTkYKevgcDJfLtHsTetelBryQJ3FF04uduBObwoQtbdRw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:ae95:0:b0:e08:6c33:7334 with SMTP
 id 3f1490d57ef6-e1a5ae0cee1mr8050276.8.1724911310105; Wed, 28 Aug 2024
 23:01:50 -0700 (PDT)
Date: Thu, 29 Aug 2024 06:01:21 +0000
In-Reply-To: <20240829060126.2792671-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829060126.2792671-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240829060126.2792671-9-almasrymina@google.com>
Subject: [PATCH net-next v23 08/13] net: add support for skbs with unreadable frags
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
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
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
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

For device memory TCP, we expect the skb headers to be available in host
memory for access, and we expect the skb frags to be in device memory
and unaccessible to the host. We expect there to be no mixing and
matching of device memory frags (unaccessible) with host memory frags
(accessible) in the same skb.

Add a skb->devmem flag which indicates whether the frags in this skb
are device memory frags or not.

__skb_fill_netmem_desc() now checks frags added to skbs for net_iov,
and marks the skb as skb->devmem accordingly.

Add checks through the network stack to avoid accessing the frags of
devmem skbs and avoid coalescing devmem skbs with non devmem skbs.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>


---

v16:
- Fix unreadable handling in skb_split_no_header() (Eric).

v11:
- drop excessive checks for frag 0 pull (Paolo)

v9: https://lore.kernel.org/netdev/20240403002053.2376017-11-almasrymina@google.com/
- change skb->readable to skb->unreadable (Pavel/David).

skb->readable was very complicated, because by default skbs are readable
so the flag needed to be set to true in all code paths where new skbs
were created or cloned. Forgetting to set skb->readable=true in some
paths caused crashes.

Flip it to skb->unreadable so that the default 0 value works well, and
we only need to set it to true when we add unreadable frags.

v6
- skb->dmabuf -> skb->readable (Pavel). Pavel's original suggestion was
  to remove the skb->dmabuf flag entirely, but when I looked into it
  closely, I found the issue that if we remove the flag we have to
  dereference the shinfo(skb) pointer to obtain the first frag, which
  can cause a performance regression if it dirties the cache line when
  the shinfo(skb) was not really needed. Instead, I converted the
  skb->dmabuf flag into a generic skb->readable flag which can be
  re-used by io_uring.

Changes in v1:
- Rename devmem -> dmabuf (David).
- Flip skb_frags_not_readable (Jakub).

---
 include/linux/skbuff.h | 19 +++++++++++++++++--
 include/net/tcp.h      |  5 +++--
 net/core/datagram.c    |  6 ++++++
 net/core/skbuff.c      | 43 ++++++++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp.c         |  3 +++
 net/ipv4/tcp_input.c   | 13 ++++++++++---
 net/ipv4/tcp_output.c  |  5 ++++-
 net/packet/af_packet.c |  4 ++--
 8 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index dbadf2dd6b35..d02a88bad953 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -827,6 +827,8 @@ enum skb_tstamp_type {
  *	@csum_level: indicates the number of consecutive checksums found in
  *		the packet minus one that have been verified as
  *		CHECKSUM_UNNECESSARY (max 3)
+ *	@unreadable: indicates that at least 1 of the fragments in this skb is
+ *		unreadable.
  *	@dst_pending_confirm: need to confirm neighbour
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
@@ -1008,7 +1010,7 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_not_inet:1;
 #endif
-
+	__u8			unreadable:1;
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -1823,6 +1825,12 @@ static inline void skb_zcopy_downgrade_managed(struct sk_buff *skb)
 		__skb_zcopy_downgrade_managed(skb);
 }
 
+/* Return true if frags in this skb are readable by the host. */
+static inline bool skb_frags_readable(const struct sk_buff *skb)
+{
+	return !skb->unreadable;
+}
+
 static inline void skb_mark_not_on_list(struct sk_buff *skb)
 {
 	skb->next = NULL;
@@ -2539,10 +2547,17 @@ static inline void skb_len_add(struct sk_buff *skb, int delta)
 static inline void __skb_fill_netmem_desc(struct sk_buff *skb, int i,
 					  netmem_ref netmem, int off, int size)
 {
-	struct page *page = netmem_to_page(netmem);
+	struct page *page;
 
 	__skb_fill_netmem_desc_noacc(skb_shinfo(skb), i, netmem, off, size);
 
+	if (netmem_is_net_iov(netmem)) {
+		skb->unreadable = true;
+		return;
+	}
+
+	page = netmem_to_page(netmem);
+
 	/* Propagate page pfmemalloc to the skb if we can. The problem is
 	 * that not all callers have unique ownership of the page but rely
 	 * on page_is_pfmemalloc doing the right thing(tm).
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2aac11e7e1cc..e8f6e602c2ad 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1060,7 +1060,7 @@ static inline int tcp_skb_mss(const struct sk_buff *skb)
 
 static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
 {
-	return likely(!TCP_SKB_CB(skb)->eor);
+	return likely(!TCP_SKB_CB(skb)->eor && skb_frags_readable(skb));
 }
 
 static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
@@ -1069,7 +1069,8 @@ static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 	/* skb_cmp_decrypted() not needed, use tcp_write_collapse_fence() */
 	return likely(tcp_skb_can_collapse_to(to) &&
 		      mptcp_skb_can_collapse(to, from) &&
-		      skb_pure_zcopy_same(to, from));
+		      skb_pure_zcopy_same(to, from) &&
+		      skb_frags_readable(to) == skb_frags_readable(from));
 }
 
 static inline bool tcp_skb_can_collapse_rx(const struct sk_buff *to,
diff --git a/net/core/datagram.c b/net/core/datagram.c
index a40f733b37d7..f0693707aece 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -407,6 +407,9 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 			return 0;
 	}
 
+	if (!skb_frags_readable(skb))
+		goto short_copy;
+
 	/* Copy paged appendix. Hmm... why does this look so complicated? */
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
@@ -623,6 +626,9 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 {
 	int frag = skb_shinfo(skb)->nr_frags;
 
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
+
 	while (length && iov_iter_count(from)) {
 		struct page *head, *last_head = NULL;
 		struct page *pages[MAX_SKB_FRAGS];
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7ea1508a1176..40e1ce99d635 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1972,6 +1972,9 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
 		return -EINVAL;
 
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
+
 	if (!num_frags)
 		goto release;
 
@@ -2145,6 +2148,9 @@ struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t gfp_mask)
 	unsigned int size;
 	int headerlen;
 
+	if (!skb_frags_readable(skb))
+		return NULL;
+
 	if (WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST))
 		return NULL;
 
@@ -2483,6 +2489,9 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 	struct sk_buff *n;
 	int oldheadroom;
 
+	if (!skb_frags_readable(skb))
+		return NULL;
+
 	if (WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST))
 		return NULL;
 
@@ -2827,6 +2836,9 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta)
 	 */
 	int i, k, eat = (skb->tail + delta) - skb->end;
 
+	if (!skb_frags_readable(skb))
+		return NULL;
+
 	if (eat > 0 || skb_cloned(skb)) {
 		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
 				     GFP_ATOMIC))
@@ -2980,6 +2992,9 @@ int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len)
 		to     += copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		goto fault;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 		skb_frag_t *f = &skb_shinfo(skb)->frags[i];
@@ -3168,6 +3183,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	/*
 	 * then map the fragments
 	 */
+	if (!skb_frags_readable(skb))
+		return false;
+
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
@@ -3391,6 +3409,9 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len)
 		from += copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		goto fault;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 		int end;
@@ -3470,6 +3491,9 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 		pos	= copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		return 0;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
@@ -3570,6 +3594,9 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		pos	= copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		return 0;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 
@@ -4061,6 +4088,7 @@ static inline void skb_split_inside_header(struct sk_buff *skb,
 		skb_shinfo(skb1)->frags[i] = skb_shinfo(skb)->frags[i];
 
 	skb_shinfo(skb1)->nr_frags = skb_shinfo(skb)->nr_frags;
+	skb1->unreadable	   = skb->unreadable;
 	skb_shinfo(skb)->nr_frags  = 0;
 	skb1->data_len		   = skb->data_len;
 	skb1->len		   += skb1->data_len;
@@ -4108,6 +4136,8 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 		pos += size;
 	}
 	skb_shinfo(skb1)->nr_frags = k;
+
+	skb1->unreadable = skb->unreadable;
 }
 
 /**
@@ -4345,6 +4375,9 @@ unsigned int skb_seq_read(unsigned int consumed, const u8 **data,
 		return block_limit - abs_offset;
 	}
 
+	if (!skb_frags_readable(st->cur_skb))
+		return 0;
+
 	if (st->frag_idx == 0 && !st->frag_data)
 		st->stepped_offset += skb_headlen(st->cur_skb);
 
@@ -5957,7 +5990,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	if (to->pp_recycle != from->pp_recycle)
 		return false;
 
-	if (len <= skb_tailroom(to)) {
+	if (skb_frags_readable(from) != skb_frags_readable(to))
+		return false;
+
+	if (len <= skb_tailroom(to) && skb_frags_readable(from)) {
 		if (len)
 			BUG_ON(skb_copy_bits(from, 0, skb_put(to, len), len));
 		*delta_truesize = 0;
@@ -6134,6 +6170,9 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
 	if (!pskb_may_pull(skb, write_len))
 		return -ENOMEM;
 
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
+
 	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
 		return 0;
 
@@ -6813,7 +6852,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		    skb_cloned(skb) || !skb_frags_readable(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 20a1b0333017..30e0aa38ba9b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2160,6 +2160,9 @@ static int tcp_zerocopy_receive(struct sock *sk,
 				skb = tcp_recv_skb(sk, seq, &offset);
 			}
 
+			if (!skb_frags_readable(skb))
+				break;
+
 			if (TCP_SKB_CB(skb)->has_rxtstamp) {
 				tcp_update_recv_tstamps(skb, tss);
 				zc->msg_flags |= TCP_CMSG_TS;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e37488d3453f..9f314dfa1490 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5391,6 +5391,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	for (end_of_skbs = true; skb != NULL && skb != tail; skb = n) {
 		n = tcp_skb_next(skb, list);
 
+		if (!skb_frags_readable(skb))
+			goto skip_this;
+
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
 			skb = tcp_collapse_one(sk, skb, list, root);
@@ -5411,17 +5414,20 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			break;
 		}
 
-		if (n && n != tail && tcp_skb_can_collapse_rx(skb, n) &&
+		if (n && n != tail && skb_frags_readable(n) &&
+		    tcp_skb_can_collapse_rx(skb, n) &&
 		    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq) {
 			end_of_skbs = false;
 			break;
 		}
 
+skip_this:
 		/* Decided to skip this, advance start seq. */
 		start = TCP_SKB_CB(skb)->end_seq;
 	}
 	if (end_of_skbs ||
-	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
+	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
+	    !skb_frags_readable(skb))
 		return;
 
 	__skb_queue_head_init(&tmp);
@@ -5463,7 +5469,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 				if (!skb ||
 				    skb == tail ||
 				    !tcp_skb_can_collapse_rx(nskb, skb) ||
-				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
+				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
+				    !skb_frags_readable(skb))
 					goto end;
 			}
 		}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index cdd0def14427..4fd746bd4d54 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2344,7 +2344,8 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
 
 		if (unlikely(TCP_SKB_CB(skb)->eor) ||
 		    tcp_has_tx_tstamp(skb) ||
-		    !skb_pure_zcopy_same(skb, next))
+		    !skb_pure_zcopy_same(skb, next) ||
+		    skb_frags_readable(skb) != skb_frags_readable(next))
 			return false;
 
 		len -= skb->len;
@@ -3264,6 +3265,8 @@ static bool tcp_can_collapse(const struct sock *sk, const struct sk_buff *skb)
 		return false;
 	if (skb_cloned(skb))
 		return false;
+	if (!skb_frags_readable(skb))
+		return false;
 	/* Some heuristics for collapsing over SACK'd could be invented */
 	if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
 		return false;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 4a364cdd445e..a705ec214254 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2216,7 +2216,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	snaplen = skb->len;
+	snaplen = skb_frags_readable(skb) ? skb->len : skb_headlen(skb);
 
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
@@ -2336,7 +2336,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	snaplen = skb->len;
+	snaplen = skb_frags_readable(skb) ? skb->len : skb_headlen(skb);
 
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
-- 
2.46.0.469.g59c65b2a67-goog


