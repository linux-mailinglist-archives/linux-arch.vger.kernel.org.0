Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8794722BB7F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGXB04 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgGXBZs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018EBC0619E4;
        Thu, 23 Jul 2020 18:25:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT4-001GcH-N8; Fri, 24 Jul 2020 01:25:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 03/20] icmp_push_reply(): reorder adding the checksum up
Date:   Fri, 24 Jul 2020 02:25:29 +0100
Message-Id: <20200724012546.302155-3-viro@ZenIV.linux.org.uk>
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

do csum_partial_copy_nocheck() on the first fragment, then
add the rest to it.  Equivalent transformation.

That was the only caller of csum_partial_copy_nocheck() that
might pass it non-zero as the last argument.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/ipv4/icmp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 62d7a2bfc9a3..f93317157549 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -376,15 +376,15 @@ static void icmp_push_reply(struct icmp_bxm *icmp_param,
 		ip_flush_pending_frames(sk);
 	} else if ((skb = skb_peek(&sk->sk_write_queue)) != NULL) {
 		struct icmphdr *icmph = icmp_hdr(skb);
-		__wsum csum = 0;
+		__wsum csum;
 		struct sk_buff *skb1;
 
+		csum = csum_partial_copy_nocheck((void *)&icmp_param->data,
+						 (char *)icmph,
+						 icmp_param->head_len, 0);
 		skb_queue_walk(&sk->sk_write_queue, skb1) {
 			csum = csum_add(csum, skb1->csum);
 		}
-		csum = csum_partial_copy_nocheck((void *)&icmp_param->data,
-						 (char *)icmph,
-						 icmp_param->head_len, csum);
 		icmph->checksum = csum_fold(csum);
 		skb->ip_summed = CHECKSUM_NONE;
 		ip_push_pending_frames(sk, fl4);
-- 
2.11.0

