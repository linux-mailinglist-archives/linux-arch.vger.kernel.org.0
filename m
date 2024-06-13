Return-Path: <linux-arch+bounces-4871-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C044B9060F5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 03:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538C928161E
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 01:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC15135A5B;
	Thu, 13 Jun 2024 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4M/pV92A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F612B14B
	for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2024 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242590; cv=none; b=GNMaMcJae1updpVw3HTZPTWpAD1GVPvQWP4PQWNKfl52hrIQ0KtFUYwEX1AvlClg4qJrewBSn6x7ar/sXSS1tl6AXjIkGLOrMj2wAA7qDanUgp/yvdd7feKV3kTszv7i61mfitID6xfqVMTkiG9L/eEljo8fryepdz78W4ThFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242590; c=relaxed/simple;
	bh=qfiv6CG/zibyOu5rbobANckC5IvUY8cqbjvssLqtvgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CN5olVQ7C6tgSosADgYpdRY+UrqZnSSSWBsFIuraSj95X97xz10s+L7Cn7SxIDIulzZF7ecSPOiTPOlBIEPsG/7zO3zykMjYDXI1QiN41yjdM4Ar3E+lrv1aLY/E1Rdq/hCmn2yAylQBQykGIP8jJsjYVyxcl8uhYTuUglcAkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4M/pV92A; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df7bdb0455bso712120276.2
        for <linux-arch@vger.kernel.org>; Wed, 12 Jun 2024 18:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718242578; x=1718847378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Op3q2EoJsojR5uogj2CPjHmztrcTKOOETItdBggBRT0=;
        b=4M/pV92Ad45046J38YFOXHy9Za3ratFzaahhwK1CxTryiVgY8uNJoYYX+LiWNZ8b5A
         +2wOKDf913oHpnyXE8gPOY9D00BkA+9Y7I9bOS10vNQT9ClS+T1fgXdOv533tOTkIOe/
         U4Xyq74nLs8iyUuJeNaG/1m0QtqAOxYJKuwqQMv+LaRw7wnTHMZauSu0ZwHSWaXuBYdS
         j6khoCGMzyYQCA3/aOIXtbvCosGeThDRi/brqJj7lIVakuh65g/LdXlvyfp4N7/oLR4H
         OtpTUxrTFGOs1m9xAj5p0FRuXSyCLfh732I6El7Yy1MWxFTYglYN5oaeiy8j09Ptgnao
         TZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242578; x=1718847378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Op3q2EoJsojR5uogj2CPjHmztrcTKOOETItdBggBRT0=;
        b=cvZfr4GCoFjZzUVU8JMsInZrK3lqTrtrhnBfIcGQ2k4ezaDFDayFMZxptPXgtM5wgD
         zCBQQAskCRTtD8wUhXLhsJ4VzG6P7tPH8iOg0b0kjQMhv8mAuQiKeQCelCi47Cbw1Hci
         hhycszEPiXDJNLJUpS5ghaS+poEAT7bkld9ShVrRvNwKrSDb8/yzqcixk53XfGnbNDRq
         ZPzvlnmprm06yh6bvS9pw69m6eZQdZ5cW+pawV6iw1ofZsSOFmeg368xA8NVSYzsOqFj
         VOrZquG+K1orKmdT4SRfmAEgEYoxiyuMGiqxi359OpwWsbPYCCHA03srr8orU/051zMb
         4x+w==
X-Forwarded-Encrypted: i=1; AJvYcCUKbXWPGVUTh27CEIbKEjYILGsABXdERT7vHppO3cp5Iuaeg9vQEXrYp6LgcFcWD8/rKoTZFM7HjsuMcgZi+tYGL7AkGCEPY2nsCA==
X-Gm-Message-State: AOJu0Yxbh7toQybBMj2Y8ST/yXZf5/wxbtS1jL3V+0x7GJkg3LMWpG8u
	WWdAz5G8VEPxTvdxbkqnP5OPSd5qvkn9rl0f2HMYf7BTdll1uxvH+zNJa+mJmrLkf18eiaSF/ij
	qU1Iq/DH/NdT4fr63nwItjw==
X-Google-Smtp-Source: AGHT+IFP+2W3OD8iaXVoXOnyoCjUdnXIJu6VJvFlICTklMKvtmNZc0T+NC8kvv9IV5RUrJhVau5LzDS7z4hEMcMmUQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:83d1:0:b0:dfb:335:427f with SMTP
 id 3f1490d57ef6-dfe6655b5damr146375276.4.1718242577962; Wed, 12 Jun 2024
 18:36:17 -0700 (PDT)
Date: Thu, 13 Jun 2024 01:35:46 +0000
In-Reply-To: <20240613013557.1169171-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613013557.1169171-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613013557.1169171-10-almasrymina@google.com>
Subject: [PATCH net-next v12 09/13] net: add support for skbs with unreadable frags
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
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


---

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
 include/linux/skbuff.h | 19 +++++++++++++++--
 include/net/tcp.h      |  5 +++--
 net/core/datagram.c    |  6 ++++++
 net/core/skbuff.c      | 48 ++++++++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp.c         |  3 +++
 net/ipv4/tcp_input.c   | 13 +++++++++---
 net/ipv4/tcp_output.c  |  5 ++++-
 net/packet/af_packet.c |  4 ++--
 8 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0a4df0025e6dc..9c9be08f96aa7 100644
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
@@ -1800,6 +1802,12 @@ static inline void skb_zcopy_downgrade_managed(struct sk_buff *skb)
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
@@ -2516,10 +2524,17 @@ static inline void skb_len_add(struct sk_buff *skb, int delta)
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
index 2aac11e7e1cc5..e8f6e602c2ad4 100644
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
index e614cfd8e14a5..b29f881df0e83 100644
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
@@ -619,6 +622,9 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 	if (msg && msg->msg_ubuf && msg->sg_from_iter)
 		return msg->sg_from_iter(sk, skb, from, length);
 
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
+
 	frag = skb_shinfo(skb)->nr_frags;
 
 	while (length && iov_iter_count(from)) {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a0cd848a18dfa..852c7df3ce35a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1951,6 +1951,9 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
 		return -EINVAL;
 
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
+
 	if (!num_frags)
 		goto release;
 
@@ -2124,6 +2127,9 @@ struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t gfp_mask)
 	unsigned int size;
 	int headerlen;
 
+	if (!skb_frags_readable(skb))
+		return NULL;
+
 	if (WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST))
 		return NULL;
 
@@ -2462,6 +2468,9 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 	struct sk_buff *n;
 	int oldheadroom;
 
+	if (!skb_frags_readable(skb))
+		return NULL;
+
 	if (WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST))
 		return NULL;
 
@@ -2806,6 +2815,9 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta)
 	 */
 	int i, k, eat = (skb->tail + delta) - skb->end;
 
+	if (!skb_frags_readable(skb))
+		return NULL;
+
 	if (eat > 0 || skb_cloned(skb)) {
 		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
 				     GFP_ATOMIC))
@@ -2959,6 +2971,9 @@ int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len)
 		to     += copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		goto fault;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 		skb_frag_t *f = &skb_shinfo(skb)->frags[i];
@@ -3147,6 +3162,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	/*
 	 * then map the fragments
 	 */
+	if (!skb_frags_readable(skb))
+		return false;
+
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
@@ -3370,6 +3388,9 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len)
 		from += copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		goto fault;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 		int end;
@@ -3449,6 +3470,9 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 		pos	= copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		return 0;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
@@ -3549,6 +3573,9 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		pos	= copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		return 0;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 
@@ -4040,6 +4067,7 @@ static inline void skb_split_inside_header(struct sk_buff *skb,
 		skb_shinfo(skb1)->frags[i] = skb_shinfo(skb)->frags[i];
 
 	skb_shinfo(skb1)->nr_frags = skb_shinfo(skb)->nr_frags;
+	skb1->unreadable	   = skb->unreadable;
 	skb_shinfo(skb)->nr_frags  = 0;
 	skb1->data_len		   = skb->data_len;
 	skb1->len		   += skb1->data_len;
@@ -4054,6 +4082,7 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 {
 	int i, k = 0;
 	const int nfrags = skb_shinfo(skb)->nr_frags;
+	const int unreadable = skb->unreadable;
 
 	skb_shinfo(skb)->nr_frags = 0;
 	skb1->len		  = skb1->data_len = skb->len - len;
@@ -4087,6 +4116,12 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 		pos += size;
 	}
 	skb_shinfo(skb1)->nr_frags = k;
+
+	if (skb_shinfo(skb)->nr_frags)
+		skb->unreadable = unreadable;
+
+	if (skb_shinfo(skb1)->nr_frags)
+		skb1->unreadable = unreadable;
 }
 
 /**
@@ -4325,6 +4360,9 @@ unsigned int skb_seq_read(unsigned int consumed, const u8 **data,
 		return block_limit - abs_offset;
 	}
 
+	if (!skb_frags_readable(st->cur_skb))
+		return 0;
+
 	if (st->frag_idx == 0 && !st->frag_data)
 		st->stepped_offset += skb_headlen(st->cur_skb);
 
@@ -5937,7 +5975,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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
@@ -6114,6 +6155,9 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
 	if (!pskb_may_pull(skb, write_len))
 		return -ENOMEM;
 
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
+
 	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
 		return 0;
 
@@ -6793,7 +6837,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		    skb_cloned(skb) || !skb_frags_readable(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8050148d302b1..adc0eb9a9b5c3 100644
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
index d0a1e34d69f69..245138c9b8aa6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5353,6 +5353,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	for (end_of_skbs = true; skb != NULL && skb != tail; skb = n) {
 		n = tcp_skb_next(skb, list);
 
+		if (!skb_frags_readable(skb))
+			goto skip_this;
+
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
 			skb = tcp_collapse_one(sk, skb, list, root);
@@ -5373,17 +5376,20 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
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
@@ -5425,7 +5431,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
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
index 16c48df8df4cc..3678255e94ec2 100644
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
index fce3908875912..2ad47a6f37619 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2155,7 +2155,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	snaplen = skb->len;
+	snaplen = skb_frags_readable(skb) ? skb->len : skb_headlen(skb);
 
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
@@ -2275,7 +2275,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	snaplen = skb->len;
+	snaplen = skb_frags_readable(skb) ? skb->len : skb_headlen(skb);
 
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
-- 
2.45.2.505.gda0bf45e8d-goog


