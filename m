Return-Path: <linux-arch+bounces-3211-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7E688D20E
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 23:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635991F811A1
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 22:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE000142903;
	Tue, 26 Mar 2024 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+QiPX0L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1DE1420D4
	for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493484; cv=none; b=TzSK7L/K5L6qaR0GNbqODo8YEvCIs1mAq0+7doEtD57nwg8R/s1StwX6kG51lDUzLMRge9hKbEVG6WL10uxGyh+Sw3ERJGU7g5pY/SG9zhOl4hjve9Sna4XWBTQq4X0hWsuz3v2LP+wVTtONWdIyvTWbC0Z7iokvfjHwz2EYE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493484; c=relaxed/simple;
	bh=0048wSkq9GBO6eLPgwdMZh8W7Hs51xiA895DAfi18S0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q2B6nSr8h6TG/53+uQbW9MluxvF2+VuJYRdlrlObSWCG+MCC5kxqGDLYkjdraRLyuZ1pZ6NFLpR5sTOZjlVXlSwM9bpkW/DjWb+qg3NEmfAJ6Eqkn8UAzvv3cBqSVddn/bv0GrmPH/++5ZDIbwul8B1Fr1ttn1MB4Qgh0VnwQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+QiPX0L; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so7985188276.2
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711493477; x=1712098277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsRVLiLoihygBmaMp4ExoTPkR9+eB9pZzr1SW1q0924=;
        b=Q+QiPX0LP67s+IIdUxwR/dnlr7hnxPhMHGkS8a1krq/mAv9uD1OiGkDWOrBdE9auB7
         UJLR4HUjq9oyJHqkWCqrXlHeoNech2H9gK1j8f+jWMvcsbPRhMT+P5DV0pdIqTylsZuk
         VN8ILEmuaXtqIXYxT/CBzO6utf2vX38Q7Jrm7MEtNXLjyWmvveecdhKOrbRgJUL76HXb
         w9fbWilqL7wcnmwDhFAth8KURjlXheqLD4SjIAbnXd9Jl5Ka2cZDDxcZyS9zgFqWG6aD
         LIqTJFsber9yYTSnp1jkmSFuJKXfmcbaKZJIU01FCouxryhjdi8rJ9Puy21fxbRFnf7T
         YV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493477; x=1712098277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsRVLiLoihygBmaMp4ExoTPkR9+eB9pZzr1SW1q0924=;
        b=aWq0BmbJ3wmoXDBLD7Vj4kqKEnzdmRIciWHzOJpUDhBLPkZlRU+BUvq4kIBmByTkTa
         bPDhejl15xIXbv8UavM4XCoGe+CxxFwBYY+zVd1Vtilp108xavwOhqOiOPW3qn8xRaCQ
         mr1dypF1RVwN64acI+ppN4cErsF/kWwUxLHaX3EG2qB2pBQwORekjI8/ACtxCtcxhHl/
         MqaI+nZWI6z775P/lgsMvzNkd16o4mTUSdWqwfl1ZEe+KhsBWreZsV5rhrhcHzI0Sv7E
         tnW5YGxbK8hgSK4qx3tSFxYmhBTKnrOLOusAo5II2++E5d5f1v6xoSRa6HqDS7FhuWk0
         YU8A==
X-Forwarded-Encrypted: i=1; AJvYcCVvjzgTgibAlq5NQL1uoEGtoea6V2+GYYeZJzLQEn06a5pK9V7OP9T0lhvL2oABRFtNDnyblQlNId/cfBvHJqZWG7iVhx5wOk1RMg==
X-Gm-Message-State: AOJu0Yz4GQvwsV4y5ilOEyDAp6m6Hc5y4JLNxkJ0p5ei7Dg4SD8fpSKj
	65LzVAuGKK/98MEe8HqQmq9RRUsRVvHGWZV1TgMLpZiH/SNCvH+vxol8x38LSoMWSkVN2MigDNm
	Q1iyfNjpSeLL1V0mc71Cvlw==
X-Google-Smtp-Source: AGHT+IE1vpzUtC2vMi8EVmVK+zSRmGZ6FWgW8164AOuA8JI6efKB0FW9f12JZbX7j1rGBQ7bb2sO64+GnfFArbxFJg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:c51e:bdd0:7cc8:695c])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1141:b0:dd1:38ec:905d with
 SMTP id p1-20020a056902114100b00dd138ec905dmr557163ybu.11.1711493477096; Tue,
 26 Mar 2024 15:51:17 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:50:41 -0700
In-Reply-To: <20240326225048.785801-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326225048.785801-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326225048.785801-11-almasrymina@google.com>
Subject: [RFC PATCH net-next v7 10/14] net: add support for skbs with
 unreadable frags
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
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
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
 include/linux/skbuff.h | 18 ++++++++--
 include/net/tcp.h      |  5 +--
 net/core/datagram.c    |  6 ++++
 net/core/gro.c         |  5 ++-
 net/core/skbuff.c      | 75 +++++++++++++++++++++++++++++++++++-------
 net/ipv4/tcp.c         |  3 ++
 net/ipv4/tcp_input.c   | 13 ++++++--
 net/ipv4/tcp_output.c  |  5 ++-
 net/packet/af_packet.c |  4 +--
 9 files changed, 112 insertions(+), 22 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8143aee8d911..d7245540e67a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -818,6 +818,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@csum_level: indicates the number of consecutive checksums found in
  *		the packet minus one that have been verified as
  *		CHECKSUM_UNNECESSARY (max 3)
+ *	@readable: indicates that all the fragments in this skb are readable.
  *	@dst_pending_confirm: need to confirm neighbour
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
@@ -1004,7 +1005,7 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_not_inet:1;
 #endif
-
+	__u8			readable:1;
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -1796,6 +1797,12 @@ static inline void skb_zcopy_downgrade_managed(struct sk_buff *skb)
 		__skb_zcopy_downgrade_managed(skb);
 }
 
+/* Return true if frags in this skb are readable by the host. */
+static inline bool skb_frags_readable(const struct sk_buff *skb)
+{
+	return skb->readable;
+}
+
 static inline void skb_mark_not_on_list(struct sk_buff *skb)
 {
 	skb->next = NULL;
@@ -2512,10 +2519,17 @@ static inline void skb_len_add(struct sk_buff *skb, int delta)
 static inline void __skb_fill_netmem_desc(struct sk_buff *skb, int i,
 					  netmem_ref netmem, int off, int size)
 {
-	struct page *page = netmem_to_page(netmem);
+	struct page *page;
 
 	__skb_fill_netmem_desc_noacc(skb_shinfo(skb), i, netmem, off, size);
 
+	if (netmem_is_net_iov(netmem)) {
+		skb->readable = false;
+		return;
+	}
+
+	page = netmem_to_page(netmem);
+
 	/* Propagate page pfmemalloc to the skb if we can. The problem is
 	 * that not all callers have unique ownership of the page but rely
 	 * on page_is_pfmemalloc doing the right thing(tm).
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ae35199d3b3..8f086e14b21d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1062,7 +1062,7 @@ static inline int tcp_skb_mss(const struct sk_buff *skb)
 
 static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
 {
-	return likely(!TCP_SKB_CB(skb)->eor);
+	return likely(!TCP_SKB_CB(skb)->eor && skb_frags_readable(skb));
 }
 
 static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
@@ -1070,7 +1070,8 @@ static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 {
 	return likely(tcp_skb_can_collapse_to(to) &&
 		      mptcp_skb_can_collapse(to, from) &&
-		      skb_pure_zcopy_same(to, from));
+		      skb_pure_zcopy_same(to, from) &&
+		      skb_frags_readable(to) == skb_frags_readable(from));
 }
 
 /* Events passed to congestion control interface */
diff --git a/net/core/datagram.c b/net/core/datagram.c
index e614cfd8e14a..b29f881df0e8 100644
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
diff --git a/net/core/gro.c b/net/core/gro.c
index eef20c82c5c3..b015da20cd9e 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -394,6 +394,9 @@ static void gro_pull_from_frag0(struct sk_buff *skb, int grow)
 {
 	struct skb_shared_info *pinfo = skb_shinfo(skb);
 
+	if (WARN_ON_ONCE(!skb_frags_readable(skb)))
+		return;
+
 	BUG_ON(skb->end - skb->tail < grow);
 
 	memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);
@@ -415,7 +418,7 @@ static void gro_try_pull_from_frag0(struct sk_buff *skb)
 {
 	int grow = skb_gro_offset(skb) - skb_headlen(skb);
 
-	if (grow > 0)
+	if (grow > 0 && skb_frags_readable(skb))
 		gro_pull_from_frag0(skb, grow);
 }
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b4ea842ac9c7..30137434d408 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -692,6 +692,8 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 		refcount_set(&fclones->fclone_ref, 1);
 	}
 
+	skb->readable = true;
+
 	return skb;
 
 nodata:
@@ -764,6 +766,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	if (pfmemalloc)
 		skb->pfmemalloc = 1;
 	skb->head_frag = 1;
+	skb->readable = true;
 
 skb_success:
 	skb_reserve(skb, NET_SKB_PAD);
@@ -852,6 +855,7 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 	if (pfmemalloc)
 		skb->pfmemalloc = 1;
 	skb->head_frag = 1;
+	skb->readable = true;
 
 skb_success:
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
@@ -1377,7 +1381,7 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 
 		if (skb_frag_is_net_iov(frag)) {
 			printk("%sskb frag %d: not readable\n", level, i);
-			len -= frag->bv_len;
+			len -= skb_frag_size(frag);
 			if (!len)
 				break;
 			continue;
@@ -1962,6 +1966,9 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
 		return -EINVAL;
 
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
+
 	if (!num_frags)
 		goto release;
 
@@ -2133,8 +2140,12 @@ struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t gfp_mask)
 {
 	int headerlen = skb_headroom(skb);
 	unsigned int size = skb_end_offset(skb) + skb->data_len;
-	struct sk_buff *n = __alloc_skb(size, gfp_mask,
-					skb_alloc_rx_flag(skb), NUMA_NO_NODE);
+	struct sk_buff *n;
+
+	if (!skb_frags_readable(skb))
+		return NULL;
+
+	n = __alloc_skb(size, gfp_mask, skb_alloc_rx_flag(skb), NUMA_NO_NODE);
 
 	if (!n)
 		return NULL;
@@ -2460,14 +2471,16 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 				int newheadroom, int newtailroom,
 				gfp_t gfp_mask)
 {
-	/*
-	 *	Allocate the copy buffer
-	 */
-	struct sk_buff *n = __alloc_skb(newheadroom + skb->len + newtailroom,
-					gfp_mask, skb_alloc_rx_flag(skb),
-					NUMA_NO_NODE);
 	int oldheadroom = skb_headroom(skb);
 	int head_copy_len, head_copy_off;
+	struct sk_buff *n;
+
+	if (!skb_frags_readable(skb))
+		return NULL;
+
+	/* Allocate the copy buffer */
+	n = __alloc_skb(newheadroom + skb->len + newtailroom, gfp_mask,
+			skb_alloc_rx_flag(skb), NUMA_NO_NODE);
 
 	if (!n)
 		return NULL;
@@ -2806,6 +2819,9 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta)
 	 */
 	int i, k, eat = (skb->tail + delta) - skb->end;
 
+	if (!skb_frags_readable(skb))
+		return NULL;
+
 	if (eat > 0 || skb_cloned(skb)) {
 		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
 				     GFP_ATOMIC))
@@ -2959,6 +2975,9 @@ int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len)
 		to     += copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		goto fault;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 		skb_frag_t *f = &skb_shinfo(skb)->frags[i];
@@ -3147,6 +3166,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	/*
 	 * then map the fragments
 	 */
+	if (!skb_frags_readable(skb))
+		return false;
+
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
@@ -3370,6 +3392,9 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len)
 		from += copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		goto fault;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 		int end;
@@ -3449,6 +3474,9 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 		pos	= copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		return 0;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
@@ -3549,6 +3577,9 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		pos	= copy;
 	}
 
+	if (!skb_frags_readable(skb))
+		return 0;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 
@@ -4040,7 +4071,9 @@ static inline void skb_split_inside_header(struct sk_buff *skb,
 		skb_shinfo(skb1)->frags[i] = skb_shinfo(skb)->frags[i];
 
 	skb_shinfo(skb1)->nr_frags = skb_shinfo(skb)->nr_frags;
+	skb1->readable		   = skb->readable;
 	skb_shinfo(skb)->nr_frags  = 0;
+	skb->readable		   = 1;
 	skb1->data_len		   = skb->data_len;
 	skb1->len		   += skb1->data_len;
 	skb->data_len		   = 0;
@@ -4054,6 +4087,7 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 {
 	int i, k = 0;
 	const int nfrags = skb_shinfo(skb)->nr_frags;
+	const int readable = skb->readable;
 
 	skb_shinfo(skb)->nr_frags = 0;
 	skb1->len		  = skb1->data_len = skb->len - len;
@@ -4087,6 +4121,16 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 		pos += size;
 	}
 	skb_shinfo(skb1)->nr_frags = k;
+
+	if (skb_shinfo(skb)->nr_frags)
+		skb->readable = readable;
+	else
+		skb->readable = 1;
+
+	if (skb_shinfo(skb1)->nr_frags)
+		skb1->readable = readable;
+	else
+		skb1->readable = 1;
 }
 
 /**
@@ -4322,6 +4366,9 @@ unsigned int skb_seq_read(unsigned int consumed, const u8 **data,
 		return block_limit - abs_offset;
 	}
 
+	if (!skb_frags_readable(st->cur_skb))
+		return 0;
+
 	if (st->frag_idx == 0 && !st->frag_data)
 		st->stepped_offset += skb_headlen(st->cur_skb);
 
@@ -5934,7 +5981,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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
@@ -6111,6 +6161,9 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
 	if (!pskb_may_pull(skb, write_len))
 		return -ENOMEM;
 
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
+
 	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
 		return 0;
 
@@ -6790,7 +6843,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		    skb_cloned(skb) || !skb_frags_readable(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9f6497c53d61..2d09dea38639 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2150,6 +2150,9 @@ static int tcp_zerocopy_receive(struct sock *sk,
 				skb = tcp_recv_skb(sk, seq, &offset);
 			}
 
+			if (!skb_frags_readable(skb))
+				break;
+
 			if (TCP_SKB_CB(skb)->has_rxtstamp) {
 				tcp_update_recv_tstamps(skb, tss);
 				zc->msg_flags |= TCP_CMSG_TS;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5d874817a78d..799501fefccc 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5331,6 +5331,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	for (end_of_skbs = true; skb != NULL && skb != tail; skb = n) {
 		n = tcp_skb_next(skb, list);
 
+		if (!skb_frags_readable(skb))
+			goto skip_this;
+
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
 			skb = tcp_collapse_one(sk, skb, list, root);
@@ -5351,17 +5354,20 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			break;
 		}
 
-		if (n && n != tail && mptcp_skb_can_collapse(skb, n) &&
+		if (n && n != tail && skb_frags_readable(n) &&
+		    mptcp_skb_can_collapse(skb, n) &&
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
@@ -5405,7 +5411,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 				if (!skb ||
 				    skb == tail ||
 				    !mptcp_skb_can_collapse(nskb, skb) ||
-				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
+				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
+				    !skb_frags_readable(skb))
 					goto end;
 #ifdef CONFIG_TLS_DEVICE
 				if (skb->decrypted != nskb->decrypted)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..30f53de14a24 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2343,7 +2343,8 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
 
 		if (unlikely(TCP_SKB_CB(skb)->eor) ||
 		    tcp_has_tx_tstamp(skb) ||
-		    !skb_pure_zcopy_same(skb, next))
+		    !skb_pure_zcopy_same(skb, next) ||
+		    skb_frags_readable(skb) != skb_frags_readable(next))
 			return false;
 
 		len -= skb->len;
@@ -3227,6 +3228,8 @@ static bool tcp_can_collapse(const struct sock *sk, const struct sk_buff *skb)
 		return false;
 	if (skb_cloned(skb))
 		return false;
+	if (!skb_frags_readable(skb))
+		return false;
 	/* Some heuristics for collapsing over SACK'd could be invented */
 	if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
 		return false;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 18f616f487ea..d3380484d4d8 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2156,7 +2156,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	snaplen = skb->len;
+	snaplen = skb_frags_readable(skb) ? skb->len : skb_headlen(skb);
 
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
@@ -2276,7 +2276,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	snaplen = skb->len;
+	snaplen = skb_frags_readable(skb) ? skb->len : skb_headlen(skb);
 
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
-- 
2.44.0.396.g6e790dbe36-goog


