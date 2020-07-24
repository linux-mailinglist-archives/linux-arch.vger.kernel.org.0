Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1422BB81
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGXB1A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgGXBZs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C2C0619E3;
        Thu, 23 Jul 2020 18:25:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT4-001GcB-KH; Fri, 24 Jul 2020 01:25:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 02/20] skb_copy_and_csum_bits(): don't bother with the last argument
Date:   Fri, 24 Jul 2020 02:25:28 +0100
Message-Id: <20200724012546.302155-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

it's always 0

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/ethernet/sun/sunvnet_common.c |  2 +-
 include/linux/skbuff.h                    |  2 +-
 net/core/skbuff.c                         | 11 ++++++-----
 net/ipv4/icmp.c                           |  2 +-
 net/ipv4/ip_output.c                      |  4 ++--
 net/ipv6/icmp.c                           |  4 ++--
 net/ipv6/ip6_output.c                     |  2 +-
 net/sunrpc/socklib.c                      |  2 +-
 8 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
index 8dc6c9ff22e1..80fde5f06fce 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -1168,7 +1168,7 @@ static inline struct sk_buff *vnet_skb_shape(struct sk_buff *skb, int ncookies)
 			*(__sum16 *)(skb->data + offset) = 0;
 			csum = skb_copy_and_csum_bits(skb, start,
 						      nskb->data + start,
-						      skb->len - start, 0);
+						      skb->len - start);
 
 			/* add in the header checksums */
 			if (skb->protocol == htons(ETH_P_IP)) {
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0c0377fc00c2..1dcd255c9a03 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3529,7 +3529,7 @@ int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags);
 int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len);
 int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len);
 __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset, u8 *to,
-			      int len, __wsum csum);
+			      int len);
 int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    struct pipe_inode_info *pipe, unsigned int len,
 		    unsigned int flags);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b8afefe6f6b6..9c0918651445 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2723,19 +2723,20 @@ EXPORT_SYMBOL(skb_checksum);
 /* Both of above in one bottle. */
 
 __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
-				    u8 *to, int len, __wsum csum)
+				    u8 *to, int len)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset;
 	struct sk_buff *frag_iter;
 	int pos = 0;
+	__wsum csum = 0;
 
 	/* Copy header. */
 	if (copy > 0) {
 		if (copy > len)
 			copy = len;
 		csum = csum_partial_copy_nocheck(skb->data + offset, to,
-						 copy, csum);
+						 copy, 0);
 		if ((len -= copy) == 0)
 			return csum;
 		offset += copy;
@@ -2791,7 +2792,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 				copy = len;
 			csum2 = skb_copy_and_csum_bits(frag_iter,
 						       offset - start,
-						       to, copy, 0);
+						       to, copy);
 			csum = csum_block_add(csum, csum2, pos);
 			if ((len -= copy) == 0)
 				return csum;
@@ -3011,7 +3012,7 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	csum = 0;
 	if (csstart != skb->len)
 		csum = skb_copy_and_csum_bits(skb, csstart, to + csstart,
-					      skb->len - csstart, 0);
+					      skb->len - csstart);
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		long csstuff = csstart + skb->csum_offset;
@@ -3933,7 +3934,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 					skb_copy_and_csum_bits(head_skb, offset,
 							       skb_put(nskb,
 								       len),
-							       len, 0);
+							       len);
 				SKB_GSO_CB(nskb)->csum_start =
 					skb_headroom(nskb) + doffset;
 			} else {
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 956a806649f7..62d7a2bfc9a3 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -352,7 +352,7 @@ static int icmp_glue_bits(void *from, char *to, int offset, int len, int odd,
 
 	csum = skb_copy_and_csum_bits(icmp_param->skb,
 				      icmp_param->offset + offset,
-				      to, len, 0);
+				      to, len);
 
 	skb->csum = csum_block_add(skb->csum, csum, odd);
 	if (icmp_pointers[icmp_param->data.icmph.type].error)
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 090d3097ee15..7fd164754519 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1120,7 +1120,7 @@ static int __ip_append_data(struct sock *sk,
 			if (fraggap) {
 				skb->csum = skb_copy_and_csum_bits(
 					skb_prev, maxfraglen,
-					data + transhdrlen, fraggap, 0);
+					data + transhdrlen, fraggap);
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
@@ -1405,7 +1405,7 @@ ssize_t	ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
 				skb->csum = skb_copy_and_csum_bits(skb_prev,
 								   maxfraglen,
 						    skb_transport_header(skb),
-								   fraggap, 0);
+								   fraggap);
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				pskb_trim_unique(skb_prev, maxfraglen);
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index fc5000370030..2ae42b4e0c1a 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -314,10 +314,10 @@ static int icmpv6_getfrag(void *from, char *to, int offset, int len, int odd, st
 {
 	struct icmpv6_msg *msg = (struct icmpv6_msg *) from;
 	struct sk_buff *org_skb = msg->skb;
-	__wsum csum = 0;
+	__wsum csum;
 
 	csum = skb_copy_and_csum_bits(org_skb, msg->offset + offset,
-				      to, len, csum);
+				      to, len);
 	skb->csum = csum_block_add(skb->csum, csum, odd);
 	if (!(msg->type & ICMPV6_INFOMSG_MASK))
 		nf_ct_attach(skb, org_skb);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8a8c2d0cfcc8..bf9367c2504b 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1613,7 +1613,7 @@ static int __ip6_append_data(struct sock *sk,
 			if (fraggap) {
 				skb->csum = skb_copy_and_csum_bits(
 					skb_prev, maxfraglen,
-					data + transhdrlen, fraggap, 0);
+					data + transhdrlen, fraggap);
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index 3fc8af8bb961..d52313af82bc 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -70,7 +70,7 @@ static size_t xdr_skb_read_and_csum_bits(struct xdr_skb_reader *desc, void *to,
 	if (len > desc->count)
 		len = desc->count;
 	pos = desc->offset;
-	csum2 = skb_copy_and_csum_bits(desc->skb, pos, to, len, 0);
+	csum2 = skb_copy_and_csum_bits(desc->skb, pos, to, len);
 	desc->csum = csum_block_add(desc->csum, csum2, pos);
 	desc->count -= len;
 	desc->offset += len;
-- 
2.11.0

