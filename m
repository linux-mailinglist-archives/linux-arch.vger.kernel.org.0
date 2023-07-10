Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3D74E153
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 00:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGJWeR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 18:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjGJWeL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 18:34:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC6E73
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:33:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c5c8d00ce50so4453028276.1
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689028436; x=1691620436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QDPrrkJolhYj8+JA2ecQJjxVsJNIQec1wNqvH72xEAE=;
        b=bliRqYBYA7SP+SPxK2IjcbatX7Omsm+v4X2DL5ulNehUSHXhYkbBCjCoPA4+lde/+r
         Mv4vn1NPHsq9zQaJ/BS5q4yOT28xnB+GR7b90+Msgrod+u9besvi+CHAzr3d2lqkB/AA
         yxX32+4hCEHv/rYkC3zNVkxpRlZhCActP39jEwWjryIEygF1XkF2wIN5uXGWgJII1qn3
         4AzQQnHnn+AHSw/qKKc5jLJMbzVKVGyCcgjIEEOOjxsfJU/XS8Za+1qyJC6zoQp8SC9Z
         eZmHcI7zYkSKm3we5mSp3N6GMumLtl7F3sh7WJbaYkTjS79SpPYbISoFN9wtRlENHs+q
         GjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028436; x=1691620436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDPrrkJolhYj8+JA2ecQJjxVsJNIQec1wNqvH72xEAE=;
        b=cTUkBI7c0mxVgoOXHWmQ22H1P/Fz8721U9LS5jEXXu+GuDsmPczE/fq5Q5slrMKpff
         Ewd5OCO+9nhQHbd341d6W/lngMbANjOFUxchP7LFIiKg9TiE46G1IIn7HcqRyFsR+rJO
         Z1lSBNOcqsCxRzBB93tQ7E39mKMppuL2HtX+FsS7JzEgjb4bDl+K1beQSRAfkew9uH6W
         d3IQPKae4a0TC4YJUoNUJKz6ztoFllbnRi67LdgFzwOkqkzfl1Npv5AK6UMo8ToCueM0
         fJOVtgA/NZoTs11JKRfEgYhum9QEZR1iKZ8zFWeqhM56VpTSSXNORW925RM4ch0JIvFu
         Ikmw==
X-Gm-Message-State: ABy/qLYCohBmERvDifQj/In+dZRPJoF+ajkevmK5JbkUbkMZ04KXxCBE
        BpLm2/mklvPGQhIhutcFKLD0W1c00ZNOHyn7cA==
X-Google-Smtp-Source: APBJJlG3bwEoPIkQ3o2GIl51Ddf3aoB7B54zxP7HixWCIvf2JZmkwqiiEqZGTtJ7VvQ3rxT2A7pGP8pckAgyDOt8qg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c0f:bfb6:9942:8c53])
 (user=almasrymina job=sendgmr) by 2002:a25:41ca:0:b0:c6b:c65d:6d02 with SMTP
 id o193-20020a2541ca000000b00c6bc65d6d02mr65909yba.9.1689028435810; Mon, 10
 Jul 2023 15:33:55 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:32:55 -0700
In-Reply-To: <20230710223304.1174642-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230710223304.1174642-5-almasrymina@google.com>
Subject: [RFC PATCH 04/10] net: add support for skbs with unreadable frags
From:   Mina Almasry <almasrymina@google.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Mina Almasry <almasrymina@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For device memory TCP, we expect the skb headers to be available in host
memory for access, and we expect the skb frags to be in device memory
and unaccessible to the host. We expect there to be no mixing and matching
of device memory frags (unaccessible) with host memory frags
(accessible) in the same skb.

Add a skb->devmem flag which indicates whether the frags in this skb
are device memory frags or not.

__skb_fill_page_desc() & skb_fill_page_desc_noacc() now checks frags
added to skbs for dmabuf pages, and marks the skb as skb->devmem if the
page is a device memory page.

Add checks through the network stack to avoid accessing the frags of
devmem skbs and avoid coallescing devmem skbs with non devmem skbs.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/skbuff.h | 15 +++++++++
 include/net/tcp.h      |  6 ++--
 net/core/skbuff.c      | 73 ++++++++++++++++++++++++++++++++++--------
 net/ipv4/tcp.c         |  3 ++
 net/ipv4/tcp_input.c   | 13 ++++++--
 net/ipv4/tcp_output.c  |  5 ++-
 net/packet/af_packet.c |  4 +--
 7 files changed, 97 insertions(+), 22 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0b40417457cd..f5e03aa84160 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -38,6 +38,7 @@
 #endif
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <linux/dma-buf.h>
 
 /**
  * DOC: skb checksums
@@ -805,6 +806,8 @@ typedef unsigned char *sk_buff_data_t;
  *	@csum_level: indicates the number of consecutive checksums found in
  *		the packet minus one that have been verified as
  *		CHECKSUM_UNNECESSARY (max 3)
+ *	@devmem: indicates that all the fragments in this skb is backed by
+ *		device memory.
  *	@dst_pending_confirm: need to confirm neighbour
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
@@ -992,6 +995,7 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 
+	__u8			devmem:1;
 #ifdef CONFIG_NET_SCHED
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -1766,6 +1770,12 @@ static inline void skb_zcopy_downgrade_managed(struct sk_buff *skb)
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
@@ -2469,6 +2479,8 @@ static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
 	page = compound_head(page);
 	if (page_is_pfmemalloc(page))
 		skb->pfmemalloc	= true;
+	if (is_dma_buf_page(page))
+		skb->devmem = true;
 }
 
 /**
@@ -2511,6 +2523,9 @@ static inline void skb_fill_page_desc_noacc(struct sk_buff *skb, int i,
 
 	__skb_fill_page_desc_noacc(shinfo, i, page, off, size);
 	shinfo->nr_frags = i + 1;
+
+	if (is_dma_buf_page(page))
+		skb->devmem = true;
 }
 
 void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5066e4586cf0..6d86ed3736ad 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -986,7 +986,7 @@ static inline int tcp_skb_mss(const struct sk_buff *skb)
 
 static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
 {
-	return likely(!TCP_SKB_CB(skb)->eor);
+	return likely(!TCP_SKB_CB(skb)->eor && !skb_frags_not_readable(skb));
 }
 
 static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
@@ -994,7 +994,9 @@ static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 {
 	return likely(tcp_skb_can_collapse_to(to) &&
 		      mptcp_skb_can_collapse(to, from) &&
-		      skb_pure_zcopy_same(to, from));
+		      skb_pure_zcopy_same(to, from) &&
+		      skb_frags_not_readable(to) ==
+			skb_frags_not_readable(from));
 }
 
 /* Events passed to congestion control interface */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cea28d30abb5..9b83da794641 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1191,11 +1191,16 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 				      skb_frag_size(frag), p, p_off, p_len,
 				      copied) {
 			seg_len = min_t(int, p_len, len);
-			vaddr = kmap_atomic(p);
-			print_hex_dump(level, "skb frag:     ",
-				       DUMP_PREFIX_OFFSET,
-				       16, 1, vaddr + p_off, seg_len, false);
-			kunmap_atomic(vaddr);
+			if (!is_dma_buf_page(p)) {
+				vaddr = kmap_atomic(p);
+				print_hex_dump(level, "skb frag:     ",
+					       DUMP_PREFIX_OFFSET, 16, 1,
+					       vaddr + p_off, seg_len, false);
+				kunmap_atomic(vaddr);
+			} else {
+				printk("%sskb frag: devmem", level);
+			}
+
 			len -= seg_len;
 			if (!len)
 				break;
@@ -1764,6 +1769,9 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
 		return -EINVAL;
 
+	if (skb_frags_not_readable(skb))
+		return -EFAULT;
+
 	if (!num_frags)
 		goto release;
 
@@ -1934,8 +1942,10 @@ struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t gfp_mask)
 {
 	int headerlen = skb_headroom(skb);
 	unsigned int size = skb_end_offset(skb) + skb->data_len;
-	struct sk_buff *n = __alloc_skb(size, gfp_mask,
-					skb_alloc_rx_flag(skb), NUMA_NO_NODE);
+	struct sk_buff *n = skb_frags_not_readable(skb) ? NULL :
+					  __alloc_skb(size, gfp_mask,
+						      skb_alloc_rx_flag(skb),
+						      NUMA_NO_NODE);
 
 	if (!n)
 		return NULL;
@@ -2266,9 +2276,10 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 	/*
 	 *	Allocate the copy buffer
 	 */
-	struct sk_buff *n = __alloc_skb(newheadroom + skb->len + newtailroom,
-					gfp_mask, skb_alloc_rx_flag(skb),
-					NUMA_NO_NODE);
+	struct sk_buff *n = skb_frags_not_readable(skb) ? NULL :
+			      __alloc_skb(newheadroom + skb->len + newtailroom,
+					  gfp_mask, skb_alloc_rx_flag(skb),
+					  NUMA_NO_NODE);
 	int oldheadroom = skb_headroom(skb);
 	int head_copy_len, head_copy_off;
 
@@ -2609,6 +2620,9 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta)
 	 */
 	int i, k, eat = (skb->tail + delta) - skb->end;
 
+	if (skb_frags_not_readable(skb))
+		return NULL;
+
 	if (eat > 0 || skb_cloned(skb)) {
 		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
 				     GFP_ATOMIC))
@@ -2762,6 +2776,9 @@ int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len)
 		to     += copy;
 	}
 
+	if (skb_frags_not_readable(skb))
+		goto fault;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 		skb_frag_t *f = &skb_shinfo(skb)->frags[i];
@@ -2835,7 +2852,7 @@ static struct page *linear_to_page(struct page *page, unsigned int *len,
 {
 	struct page_frag *pfrag = sk_page_frag(sk);
 
-	if (!sk_page_frag_refill(sk, pfrag))
+	if (!sk_page_frag_refill(sk, pfrag) || is_dma_buf_page(pfrag->page))
 		return NULL;
 
 	*len = min_t(unsigned int, *len, pfrag->size - pfrag->offset);
@@ -3164,6 +3181,9 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len)
 		from += copy;
 	}
 
+	if (skb_frags_not_readable(skb))
+		goto fault;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 		int end;
@@ -3243,6 +3263,9 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 		pos	= copy;
 	}
 
+	if (skb_frags_not_readable(skb))
+		return 0;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
@@ -3343,6 +3366,9 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		pos	= copy;
 	}
 
+	if (skb_frags_not_readable(skb))
+		return 0;
+
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;
 
@@ -3800,7 +3826,9 @@ static inline void skb_split_inside_header(struct sk_buff *skb,
 		skb_shinfo(skb1)->frags[i] = skb_shinfo(skb)->frags[i];
 
 	skb_shinfo(skb1)->nr_frags = skb_shinfo(skb)->nr_frags;
+	skb1->devmem		   = skb->devmem;
 	skb_shinfo(skb)->nr_frags  = 0;
+	skb->devmem		   = 0;
 	skb1->data_len		   = skb->data_len;
 	skb1->len		   += skb1->data_len;
 	skb->data_len		   = 0;
@@ -3814,11 +3842,13 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 {
 	int i, k = 0;
 	const int nfrags = skb_shinfo(skb)->nr_frags;
+	const int devmem = skb->devmem;
 
 	skb_shinfo(skb)->nr_frags = 0;
 	skb1->len		  = skb1->data_len = skb->len - len;
 	skb->len		  = len;
 	skb->data_len		  = len - pos;
+	skb->devmem		  = skb1->devmem = 0;
 
 	for (i = 0; i < nfrags; i++) {
 		int size = skb_frag_size(&skb_shinfo(skb)->frags[i]);
@@ -3847,6 +3877,12 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 		pos += size;
 	}
 	skb_shinfo(skb1)->nr_frags = k;
+
+	if (skb_shinfo(skb)->nr_frags)
+		skb->devmem = devmem;
+
+	if (skb_shinfo(skb1)->nr_frags)
+		skb1->devmem = devmem;
 }
 
 /**
@@ -4082,6 +4118,9 @@ unsigned int skb_seq_read(unsigned int consumed, const u8 **data,
 		return block_limit - abs_offset;
 	}
 
+	if (skb_frags_not_readable(st->cur_skb))
+		return 0;
+
 	if (st->frag_idx == 0 && !st->frag_data)
 		st->stepped_offset += skb_headlen(st->cur_skb);
 
@@ -5681,7 +5720,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
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
@@ -5997,6 +6039,9 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
 	if (!pskb_may_pull(skb, write_len))
 		return -ENOMEM;
 
+	if (skb_frags_not_readable(skb))
+		return -EFAULT;
+
 	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
 		return 0;
 
@@ -6656,8 +6701,8 @@ EXPORT_SYMBOL(pskb_extract);
 void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
-		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		if (skb->data_len > skb->end - skb->tail || skb_cloned(skb) ||
+		    skb_frags_not_readable(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8d20d9221238..51e8d5872670 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4520,6 +4520,9 @@ int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *hp,
 	if (crypto_ahash_update(req))
 		return 1;
 
+	if (skb_frags_not_readable(skb))
+		return 1;
+
 	for (i = 0; i < shi->nr_frags; ++i) {
 		const skb_frag_t *f = &shi->frags[i];
 		unsigned int offset = skb_frag_off(f);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bf8b22218dd4..8d28d96a3c24 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5188,6 +5188,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	for (end_of_skbs = true; skb != NULL && skb != tail; skb = n) {
 		n = tcp_skb_next(skb, list);
 
+		if (skb_frags_not_readable(skb))
+			goto skip_this;
+
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
 			skb = tcp_collapse_one(sk, skb, list, root);
@@ -5208,17 +5211,20 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
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
@@ -5262,7 +5268,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
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
index cfe128b81a01..eddade864c7f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2310,7 +2310,8 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
 
 		if (unlikely(TCP_SKB_CB(skb)->eor) ||
 		    tcp_has_tx_tstamp(skb) ||
-		    !skb_pure_zcopy_same(skb, next))
+		    !skb_pure_zcopy_same(skb, next) ||
+		    skb->devmem != next->devmem)
 			return false;
 
 		len -= skb->len;
@@ -3087,6 +3088,8 @@ static bool tcp_can_collapse(const struct sock *sk, const struct sk_buff *skb)
 		return false;
 	if (skb_cloned(skb))
 		return false;
+	if (skb_frags_not_readable(skb))
+		return false;
 	/* Some heuristics for collapsing over SACK'd could be invented */
 	if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
 		return false;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a2dbeb264f26..9b31f688163c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2152,7 +2152,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	snaplen = skb->len;
+	snaplen = skb_frags_not_readable(skb) ? skb_headlen(skb) : skb->len;
 
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
@@ -2275,7 +2275,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	snaplen = skb->len;
+	snaplen = skb_frags_not_readable(skb) ? skb_headlen(skb) : skb->len;
 
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
-- 
2.41.0.390.g38632f3daf-goog

