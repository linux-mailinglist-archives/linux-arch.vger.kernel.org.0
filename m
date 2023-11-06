Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AA97E18E8
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 03:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjKFCp2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 21:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKFCpR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 21:45:17 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA310D3
        for <linux-arch@vger.kernel.org>; Sun,  5 Nov 2023 18:44:38 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bbe0a453so45016777b3.0
        for <linux-arch@vger.kernel.org>; Sun, 05 Nov 2023 18:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238678; x=1699843478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=usFyJYQLl60eSImLOMHMcBI1gyuI+rh6zXVKki6RWDo=;
        b=Sw2Qxo6hljiPC+R/aCGYaxTwhtItTCveRcTmoasNYc7C7x6QeFiSh4R5eitD5oc1gb
         4eUcOhMUOsA28IVds/lpf0wz2TDqIIHsMIpuUviKqWoXEJmhsBQXiPHfbMn+Qc6l3Yx5
         eL/QQK7UQk2HIrfuBD6geyfbNaAOjnokdXgx7iTP4ek5yEtnQfBDLal6xtGBnL7MdAzI
         HX7cMoA6puYwu8hM3KPxBa/Fc0VrzmEYPgyn0AnJhhHe54IrvJzcf/dNWbd1TXNKayHp
         mJ8DONV1yZ07W4sqTOjPt15TGtvxtMz4VEoHaG7zAVDyi8IvpAH6+rA7V08frAq1owVx
         Rl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238678; x=1699843478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usFyJYQLl60eSImLOMHMcBI1gyuI+rh6zXVKki6RWDo=;
        b=WHOxwdcVwl0e9BRXpVJKAN2ajNcK9WycpWCXRN09Wus3sh1Pk2lfH6RyvaMrxPgIOA
         XMDqQ26i7WCDI6r4rkoQaLxpai4VW7CWA/E0xAOm36/5kTow3L1p8f0gHJ8/RbEXHVus
         y443o6p22PZtZhQO5NKGO9DBIqqMNhscjHpB0QgmY5XPSQDv/ORCI9FppbKggubIMNfY
         V78oRhtqICY7QKWIHCQmOClOzyrQh2MMPS29xLXRmr/HzMsSG4BaidFmXKiprpion4+d
         obr+cDezlg+SbIVqT5QNwdwFbfaQOnCeHVSYcSjZRspU1XwdocCsZq7TQw8fNVGmrQKB
         qFvw==
X-Gm-Message-State: AOJu0YzJG3qZ4/JAU2RSGbc1D53gpWtRkk+9gZM0cVGfjEXDFfw1UU/+
        FHXbF0rNCbYV+O2bcRLYBHP9dEASgPdtkORCUQ==
X-Google-Smtp-Source: AGHT+IGFzaww7K6GTVlkYabYZVQ/DHd33JCFtvf+myhctclpL+tEkg4setZAgR1l/9MfPCl9O10WIL+ZUo9GXmVivA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a81:5215:0:b0:5a7:acc1:5142 with SMTP
 id g21-20020a815215000000b005a7acc15142mr176056ywb.8.1699238677822; Sun, 05
 Nov 2023 18:44:37 -0800 (PST)
Date:   Sun,  5 Nov 2023 18:44:08 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-10-almasrymina@google.com>
Subject: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
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
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For device memory TCP, we expect the skb headers to be available in host
memory for access, and we expect the skb frags to be in device memory
and unaccessible to the host. We expect there to be no mixing and
matching of device memory frags (unaccessible) with host memory frags
(accessible) in the same skb.

Add a skb->devmem flag which indicates whether the frags in this skb
are device memory frags or not.

__skb_fill_page_desc() now checks frags added to skbs for page_pool_iovs,
and marks the skb as skb->devmem accordingly.

Add checks through the network stack to avoid accessing the frags of
devmem skbs and avoid coalescing devmem skbs with non devmem skbs.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/skbuff.h | 14 +++++++-
 include/net/tcp.h      |  5 +--
 net/core/datagram.c    |  6 ++++
 net/core/gro.c         |  5 ++-
 net/core/skbuff.c      | 77 ++++++++++++++++++++++++++++++++++++------
 net/ipv4/tcp.c         |  6 ++++
 net/ipv4/tcp_input.c   | 13 +++++--
 net/ipv4/tcp_output.c  |  5 ++-
 net/packet/af_packet.c |  4 +--
 9 files changed, 115 insertions(+), 20 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1fae276c1353..8fb468ff8115 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_data_t;
  *	@csum_level: indicates the number of consecutive checksums found in
  *		the packet minus one that have been verified as
  *		CHECKSUM_UNNECESSARY (max 3)
+ *	@devmem: indicates that all the fragments in this skb are backed by
+ *		device memory.
  *	@dst_pending_confirm: need to confirm neighbour
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
@@ -991,7 +993,7 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_not_inet:1;
 #endif
-
+	__u8			devmem:1;
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrade_managed(struct sk_buff *skb)
 		__skb_zcopy_downgrade_managed(skb);
 }
 
+/* Return true if frags in this skb are not readable by the host. */
+static inline bool skb_frags_not_readable(const struct sk_buff *skb)
+{
+	return skb->devmem;
+}
+
 static inline void skb_mark_not_on_list(struct sk_buff *skb)
 {
 	skb->next = NULL;
@@ -2468,6 +2476,10 @@ static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
 					struct page *page, int off, int size)
 {
 	__skb_fill_page_desc_noacc(skb_shinfo(skb), i, page, off, size);
+	if (page_is_page_pool_iov(page)) {
+		skb->devmem = true;
+		return;
+	}
 
 	/* Propagate page pfmemalloc to the skb if we can. The problem is
 	 * that not all callers have unique ownership of the page but rely
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 39b731c900dd..1ae62d1e284b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1012,7 +1012,7 @@ static inline int tcp_skb_mss(const struct sk_buff *skb)
 
 static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
 {
-	return likely(!TCP_SKB_CB(skb)->eor);
+	return likely(!TCP_SKB_CB(skb)->eor && !skb_frags_not_readable(skb));
 }
 
 static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
@@ -1020,7 +1020,8 @@ static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 {
 	return likely(tcp_skb_can_collapse_to(to) &&
 		      mptcp_skb_can_collapse(to, from) &&
-		      skb_pure_zcopy_same(to, from));
+		      skb_pure_zcopy_same(to, from) &&
+		      skb_frags_not_readable(to) == skb_frags_not_readable(from));
 }
 
 /* Events passed to congestion control interface */
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 176eb5834746..cdd4fb129968 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -425,6 +425,9 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 			return 0;
 	}
 
+	if (skb_frags_not_readable(skb))
+		goto short_copy;
+
 	/* Copy paged appendix. Hmm... why does this look so complicated? */
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
@@ -616,6 +619,9 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 {
 	int frag;
 
+	if (skb_frags_not_readable(skb))
+		return -EFAULT;
+
 	if (msg && msg->msg_ubuf && msg->sg_from_iter)
 		return msg->sg_from_iter(sk, skb, from, length);
 
diff --git a/net/core/gro.c b/net/core/gro.c
index 42d7f6755f32..56046d65386a 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -390,6 +390,9 @@ static void gro_pull_from_frag0(struct sk_buff *skb, int grow)
 {
 	struct skb_shared_info *pinfo = skb_shinfo(skb);
 
+	if (WARN_ON_ONCE(skb_frags_not_readable(skb)))
+		return;
+
 	BUG_ON(skb->end - skb->tail < grow);
 
 	memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);
@@ -411,7 +414,7 @@ static void gro_try_pull_from_frag0(struct sk_buff *skb)
 {
 	int grow = skb_gro_offset(skb) - skb_headlen(skb);
 
-	if (grow > 0)
+	if (grow > 0 && !skb_frags_not_readable(skb))
 		gro_pull_from_frag0(skb, grow);
 }
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 13eca4fd25e1..f01673ed2eff 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1230,6 +1230,14 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 		struct page *p;
 		u8 *vaddr;
 
+		if (skb_frag_is_page_pool_iov(frag)) {
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
@@ -1807,6 +1815,9 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
 		return -EINVAL;
 
+	if (skb_frags_not_readable(skb))
+		return -EFAULT;
+
 	if (!num_frags)
 		goto release;
 
@@ -1977,8 +1988,12 @@ struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t gfp_mask)
 {
 	int headerlen = skb_headroom(skb);
 	unsigned int size = skb_end_offset(skb) + skb->data_len;
-	struct sk_buff *n = __alloc_skb(size, gfp_mask,
-					skb_alloc_rx_flag(skb), NUMA_NO_NODE);
+	struct sk_buff *n;
+
+	if (skb_frags_not_readable(skb))
+		return NULL;
+
+	n = __alloc_skb(size, gfp_mask, skb_alloc_rx_flag(skb), NUMA_NO_NODE);
 
 	if (!n)
 		return NULL;
@@ -2304,14 +2319,16 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
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
+	if (skb_frags_not_readable(skb))
+		return NULL;
+
+	/* Allocate the copy buffer */
+	n = __alloc_skb(newheadroom + skb->len + newtailroom, gfp_mask,
+			skb_alloc_rx_flag(skb), NUMA_NO_NODE);
 
 	if (!n)
 		return NULL;
@@ -2650,6 +2667,9 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta)
 	 */
 	int i, k, eat = (skb->tail + delta) - skb->end;
 
+	if (skb_frags_not_readable(skb))
+		return NULL;
+
 	if (eat > 0 || skb_cloned(skb)) {
 		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
 				     GFP_ATOMIC))
@@ -2803,6 +2823,9 @@ int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len)
 		to     += copy;
 	}
 
+	if (skb_frags_not_readable(skb))
+		goto fault;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 		skb_frag_t *f = &skb_shinfo(skb)->frags[i];
@@ -2991,6 +3014,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	/*
 	 * then map the fragments
 	 */
+	if (skb_frags_not_readable(skb))
+		return false;
+
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
@@ -3214,6 +3240,9 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len)
 		from += copy;
 	}
 
+	if (skb_frags_not_readable(skb))
+		goto fault;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 		int end;
@@ -3293,6 +3322,9 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 		pos	= copy;
 	}
 
+	if (skb_frags_not_readable(skb))
+		return 0;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
@@ -3393,6 +3425,9 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		pos	= copy;
 	}
 
+	if (skb_frags_not_readable(skb))
+		return 0;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 
@@ -3883,7 +3918,9 @@ static inline void skb_split_inside_header(struct sk_buff *skb,
 		skb_shinfo(skb1)->frags[i] = skb_shinfo(skb)->frags[i];
 
 	skb_shinfo(skb1)->nr_frags = skb_shinfo(skb)->nr_frags;
+	skb1->devmem		   = skb->devmem;
 	skb_shinfo(skb)->nr_frags  = 0;
+	skb->devmem		   = 0;
 	skb1->data_len		   = skb->data_len;
 	skb1->len		   += skb1->data_len;
 	skb->data_len		   = 0;
@@ -3897,6 +3934,7 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 {
 	int i, k = 0;
 	const int nfrags = skb_shinfo(skb)->nr_frags;
+	const int devmem = skb->devmem;
 
 	skb_shinfo(skb)->nr_frags = 0;
 	skb1->len		  = skb1->data_len = skb->len - len;
@@ -3930,6 +3968,16 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 		pos += size;
 	}
 	skb_shinfo(skb1)->nr_frags = k;
+
+	if (skb_shinfo(skb)->nr_frags)
+		skb->devmem = devmem;
+	else
+		skb->devmem = 0;
+
+	if (skb_shinfo(skb1)->nr_frags)
+		skb1->devmem = devmem;
+	else
+		skb1->devmem = 0;
 }
 
 /**
@@ -4165,6 +4213,9 @@ unsigned int skb_seq_read(unsigned int consumed, const u8 **data,
 		return block_limit - abs_offset;
 	}
 
+	if (skb_frags_not_readable(st->cur_skb))
+		return 0;
+
 	if (st->frag_idx == 0 && !st->frag_data)
 		st->stepped_offset += skb_headlen(st->cur_skb);
 
@@ -5779,7 +5830,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	    (from->pp_recycle && skb_cloned(from)))
 		return false;
 
-	if (len <= skb_tailroom(to)) {
+	if (skb_frags_not_readable(from) != skb_frags_not_readable(to))
+		return false;
+
+	if (len <= skb_tailroom(to) && !skb_frags_not_readable(from)) {
 		if (len)
 			BUG_ON(skb_copy_bits(from, 0, skb_put(to, len), len));
 		*delta_truesize = 0;
@@ -5954,6 +6008,9 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
 	if (!pskb_may_pull(skb, write_len))
 		return -ENOMEM;
 
+	if (skb_frags_not_readable(skb))
+		return -EFAULT;
+
 	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
 		return 0;
 
@@ -6608,7 +6665,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		    skb_cloned(skb) || skb_frags_not_readable(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 23b29dc49271..5c6fed52ed0e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2138,6 +2138,9 @@ static int tcp_zerocopy_receive(struct sock *sk,
 				skb = tcp_recv_skb(sk, seq, &offset);
 			}
 
+			if (skb_frags_not_readable(skb))
+				break;
+
 			if (TCP_SKB_CB(skb)->has_rxtstamp) {
 				tcp_update_recv_tstamps(skb, tss);
 				zc->msg_flags |= TCP_CMSG_TS;
@@ -4411,6 +4414,9 @@ int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *hp,
 	if (crypto_ahash_update(req))
 		return 1;
 
+	if (skb_frags_not_readable(skb))
+		return 1;
+
 	for (i = 0; i < shi->nr_frags; ++i) {
 		const skb_frag_t *f = &shi->frags[i];
 		unsigned int offset = skb_frag_off(f);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 18b858597af4..64643dad5e1a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5264,6 +5264,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	for (end_of_skbs = true; skb != NULL && skb != tail; skb = n) {
 		n = tcp_skb_next(skb, list);
 
+		if (skb_frags_not_readable(skb))
+			goto skip_this;
+
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
 			skb = tcp_collapse_one(sk, skb, list, root);
@@ -5284,17 +5287,20 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			break;
 		}
 
-		if (n && n != tail && mptcp_skb_can_collapse(skb, n) &&
+		if (n && n != tail && !skb_frags_not_readable(n) &&
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
+	    skb_frags_not_readable(skb))
 		return;
 
 	__skb_queue_head_init(&tmp);
@@ -5338,7 +5344,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 				if (!skb ||
 				    skb == tail ||
 				    !mptcp_skb_can_collapse(nskb, skb) ||
-				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
+				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
+				    skb_frags_not_readable(skb))
 					goto end;
 #ifdef CONFIG_TLS_DEVICE
 				if (skb->decrypted != nskb->decrypted)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2866ccbccde0..60df27f6c649 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2309,7 +2309,8 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
 
 		if (unlikely(TCP_SKB_CB(skb)->eor) ||
 		    tcp_has_tx_tstamp(skb) ||
-		    !skb_pure_zcopy_same(skb, next))
+		    !skb_pure_zcopy_same(skb, next) ||
+		    skb_frags_not_readable(skb) != skb_frags_not_readable(next))
 			return false;
 
 		len -= skb->len;
@@ -3193,6 +3194,8 @@ static bool tcp_can_collapse(const struct sock *sk, const struct sk_buff *skb)
 		return false;
 	if (skb_cloned(skb))
 		return false;
+	if (skb_frags_not_readable(skb))
+		return false;
 	/* Some heuristics for collapsing over SACK'd could be invented */
 	if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
 		return false;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a84e00b5904b..8f6cca683939 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2156,7 +2156,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	snaplen = skb->len;
+	snaplen = skb_frags_not_readable(skb) ? skb_headlen(skb) : skb->len;
 
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
@@ -2279,7 +2279,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	snaplen = skb->len;
+	snaplen = skb_frags_not_readable(skb) ? skb_headlen(skb) : skb->len;
 
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
-- 
2.42.0.869.gea05f2083d-goog

