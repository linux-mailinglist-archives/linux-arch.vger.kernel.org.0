Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82974E159
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 00:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjGJWea (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 18:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGJWeX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 18:34:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FBEE46
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:34:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c78d98b0213so2767532276.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689028442; x=1691620442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cs78TMZKTTsnyLaGsD47TqXXpiU8IKn3E+LzkzIF7BU=;
        b=3a5uxA+qQl4NZTJNL69iIkTvOyWVY7//EUdVncePAl7DuYdYysCLTB+Scqjs0DbaRb
         knVSDHY19O2jw3TmS+RU9Ak2mdsBgSK6tfW6u5GV1mUKkWyYVITRFk6IlJEv5ytnZkeh
         zBT9t0KymYJ4QcgVINn2Gq3UU2ZggoPreRx+Zv/eoJI962CJj+J+KIPmh9/akMc2ypBs
         hRWw+J3GhzD0inq7pRnsKc7SkPkoyPF2IBr7akov++47y3RLln3OTm3ZRyFBuMw9dTux
         qWTBDMWGCdy7dhQBGYAsQnhwui5piSP/JLPmLDeSdKvpAE1zn/5xU46UzOfFbxNEAau/
         kuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028442; x=1691620442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs78TMZKTTsnyLaGsD47TqXXpiU8IKn3E+LzkzIF7BU=;
        b=YXZ+wSHDw7+nvaN1k9AO6laJ//QbzwqhJNESXjB1VzqgWGcQS8nl9q1jcTGGiaAtB+
         RX6wXkspi6augaocKjsP0A7iEJoDU2rVORdOJ2IdWIKiZg0mM6BV9xzeD5hpBAbZIS0z
         l58tGn9RMhF4mTnd4yFbIzFsqXjfuVdQ27f6+FTK2PfherLIlfsJSOQ/ebxTTnP9sAPK
         Pr1BLCTYWt4Q9tSPF6dqEGmV/n+NyvSbgSY9orZKuAfoD47tn9v0VqdRHmaX5qQp49Zu
         s6NOp5gnqoxEjIyb7nWs0oSSt5OuBglXDIPolLu1pUG7kazWxb9oke6g68pAC5x+x/oN
         uMGQ==
X-Gm-Message-State: ABy/qLZOy8bJbyV9de0f3j7GBZtyhlZyK4V5LdmOjqWEoNU5onpmtRFy
        tUIv32cYRsMItDJpVDxpAyfMHH7hkaTmunanrA==
X-Google-Smtp-Source: APBJJlHdH7YiMUAwux3ndVFThsAxLjTWbqRUoy5A1wbBCVTRZZjWp0g5h005ViK1cG50WI4QslyEnITMzBCMfQV5rg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c0f:bfb6:9942:8c53])
 (user=almasrymina job=sendgmr) by 2002:a25:6c44:0:b0:c5d:b034:28e2 with SMTP
 id h65-20020a256c44000000b00c5db03428e2mr73516ybc.7.1689028442390; Mon, 10
 Jul 2023 15:34:02 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:32:56 -0700
In-Reply-To: <20230710223304.1174642-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230710223304.1174642-6-almasrymina@google.com>
Subject: [RFC PATCH 05/10] tcp: implement recvmsg() RX path for devmem TCP
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

In tcp_recvmsg_locked(), detect if the skb being received by the user
is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVMEM
flag - pass it to tcp_recvmsg_devmem() for custom handling.

tcp_recvmsg_devmem() copies any data in the skb header to the linear
buffer, and returns a cmsg to the user indicating the number of bytes
returned in the linear buffer.

tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
and returns to the user a cmsg_devmem indicating the location of the
data in the dmabuf device memory. cmsg_devmem contains this information:

1.  the offset into the dmabuf where the payload starts. 'frag_offset'.
2. the size of the frag. 'frag_size'.
3. an opaque token 'frag_token' to return to the kernel when the buffer
is to be released.

The pages awaiting freeing are stored in the newly added sk->sk_pagepool,
and each page passed to userspace is get_page()'d.  This reference is
dropped once the userspace indicates that it is done reading this page.
All pages are released when the socket is destroyed.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/socket.h            |   1 +
 include/net/sock.h                |   2 +
 include/uapi/asm-generic/socket.h |   5 +
 include/uapi/linux/uio.h          |   6 +
 net/core/datagram.c               |   3 +
 net/ipv4/tcp.c                    | 186 +++++++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c               |   8 ++
 7 files changed, 209 insertions(+), 2 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 13c3a237b9c9..12905b2f1215 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -326,6 +326,7 @@ struct ucred {
 					  * plain text and require encryption
 					  */
 
+#define MSG_SOCK_DEVMEM 0x2000000	/* Receive devmem skbs as cmsg */
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
 #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
diff --git a/include/net/sock.h b/include/net/sock.h
index 6f428a7f3567..c615666ff19a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -353,6 +353,7 @@ struct sk_filter;
   *	@sk_txtime_unused: unused txtime flags
   *	@ns_tracker: tracker for netns reference
   *	@sk_bind2_node: bind node in the bhash2 table
+  *	@sk_pagepool: page pool associated with this socket.
   */
 struct sock {
 	/*
@@ -545,6 +546,7 @@ struct sock {
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
 	struct hlist_node	sk_bind2_node;
+	struct xarray		sk_pagepool;
 };
 
 enum sk_pacing {
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 638230899e98..88f9234f78cb 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -132,6 +132,11 @@
 
 #define SO_RCVMARK		75
 
+#define SO_DEVMEM_HEADER	98
+#define SCM_DEVMEM_HEADER	SO_DEVMEM_HEADER
+#define SO_DEVMEM_OFFSET	99
+#define SCM_DEVMEM_OFFSET	SO_DEVMEM_OFFSET
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index 059b1a9147f4..8b0be0f50838 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -20,6 +20,12 @@ struct iovec
 	__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
 };
 
+struct cmsg_devmem {
+	__u32 frag_offset;
+	__u32 frag_size;
+	__u32 frag_token;
+};
+
 /*
  *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
  */
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 176eb5834746..3a82598aa6ed 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -455,6 +455,9 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 	skb_walk_frags(skb, frag_iter) {
 		int end;
 
+		if (frag_iter->devmem)
+			goto short_copy;
+
 		WARN_ON(start > offset + len);
 
 		end = start + frag_iter->len;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 51e8d5872670..a894b8a9dbb0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -279,6 +279,7 @@
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
 #include <net/busy_poll.h>
+#include <linux/dma-buf.h>
 
 /* Track pending CMSGs. */
 enum {
@@ -460,6 +461,7 @@ void tcp_init_sock(struct sock *sk)
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
+	xa_init_flags(&sk->sk_pagepool, XA_FLAGS_ALLOC);
 }
 EXPORT_SYMBOL(tcp_init_sock);
 
@@ -2408,6 +2410,165 @@ static int tcp_inq_hint(struct sock *sk)
 	return inq;
 }
 
+static int tcp_recvmsg_devmem(const struct sock *sk, const struct sk_buff *skb,
+			      unsigned int offset, struct msghdr *msg, int len)
+{
+	unsigned int start = skb_headlen(skb);
+	struct cmsg_devmem cmsg_devmem = { 0 };
+	unsigned int tokens_added_idx = 0;
+	int i, copy = start - offset, n;
+	struct sk_buff *frag_iter;
+	u32 *tokens_added;
+	int err = 0;
+
+	if (!skb->devmem)
+		return -ENODEV;
+
+	tokens_added = kzalloc(sizeof(u32) * skb_shinfo(skb)->nr_frags,
+			       GFP_KERNEL);
+
+	if (!tokens_added)
+		return -ENOMEM;
+
+	/* Copy header. */
+	if (copy > 0) {
+		copy = min(copy, len);
+
+		n = copy_to_iter(skb->data + offset, copy, &msg->msg_iter);
+		if (n != copy) {
+			err = -EFAULT;
+			goto err_release_pages;
+		}
+
+		offset += copy;
+		len -= copy;
+
+		/* First a cmsg_devmem for # bytes copied to user buffer */
+		cmsg_devmem.frag_size = copy;
+		err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_HEADER,
+			       sizeof(cmsg_devmem), &cmsg_devmem);
+		if (err)
+			goto err_release_pages;
+
+		if (len == 0)
+			goto out;
+	}
+
+	/* after that, send information of devmem pages through a sequence
+	 * of cmsg
+	 */
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		struct page *page = skb_frag_page(frag);
+		struct dma_buf_pages *priv;
+		u32 user_token, frag_offset;
+		struct page *dmabuf_pages;
+		int end;
+
+		/* skb->devmem should indicate that ALL the pages in this skb
+                 * are dma buf pages. We're checking for that flag above, but
+                 * also check individual pages here. If the driver is not
+                 * setting skb->devmem correctly, we still don't want to crash
+                 * here when accessing pgmap or priv below.
+                 */
+		if (!is_dma_buf_page(page)) {
+			net_err_ratelimited("Found non-devmem skb with dma_buf "
+					    "page");
+			err = -ENODEV;
+			goto err_release_pages;
+		}
+
+		end = start + skb_frag_size(frag);
+		copy = end - offset;
+		memset(&cmsg_devmem, 0, sizeof(cmsg_devmem));
+
+		if (copy > 0) {
+			copy = min(copy, len);
+
+			priv = (struct dma_buf_pages *)page->pp->mp_priv;
+
+			dmabuf_pages = priv->pages;
+			frag_offset = ((page - dmabuf_pages) << PAGE_SHIFT) +
+				      skb_frag_off(frag) + offset - start;
+			cmsg_devmem.frag_offset = frag_offset;
+			cmsg_devmem.frag_size = copy;
+			err = xa_alloc((struct xarray *)&sk->sk_pagepool,
+				       &user_token, page, xa_limit_31b,
+				       GFP_KERNEL);
+			if (err)
+				goto err_release_pages;
+
+			tokens_added[tokens_added_idx++] = user_token;
+
+			get_page(page);
+			cmsg_devmem.frag_token = user_token;
+
+			offset += copy;
+			len -= copy;
+
+			err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_OFFSET,
+				       sizeof(cmsg_devmem), &cmsg_devmem);
+			if (err) {
+				put_page(page);
+				goto err_release_pages;
+			}
+
+			if (len == 0)
+				goto out;
+		}
+		start = end;
+	}
+
+	if (!len)
+		goto out;
+
+	/* if len is not satisfied yet, we need to skb_walk_frags() to satisfy
+	 * len
+	 */
+	skb_walk_frags(skb, frag_iter)
+	{
+		int end;
+
+		if (!frag_iter->devmem) {
+			err = -EFAULT;
+			goto err_release_pages;
+		}
+
+		WARN_ON(start > offset + len);
+		end = start + frag_iter->len;
+		copy = end - offset;
+		if (copy > 0) {
+			if (copy > len)
+				copy = len;
+			err = tcp_recvmsg_devmem(sk, frag_iter, offset - start,
+						 msg, copy);
+			if (err)
+				goto err_release_pages;
+			len -= copy;
+			if (len == 0)
+				goto out;
+			offset += copy;
+		}
+		start = end;
+	}
+
+	if (len) {
+		err = -EFAULT;
+		goto err_release_pages;
+	}
+
+	goto out;
+
+err_release_pages:
+	for (i = 0; i < tokens_added_idx; i++)
+		put_page(xa_erase((struct xarray *)&sk->sk_pagepool,
+				  tokens_added[i]));
+
+out:
+	kfree(tokens_added);
+	return err;
+}
+
 /*
  *	This routine copies from a sock struct into the user buffer.
  *
@@ -2428,7 +2589,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 	int err;
 	int target;		/* Read at least this many bytes */
 	long timeo;
-	struct sk_buff *skb, *last;
+	struct sk_buff *skb, *last, *skb_last_copied = NULL;
 	u32 urg_hole = 0;
 
 	err = -ENOTCONN;
@@ -2593,7 +2754,27 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			}
 		}
 
-		if (!(flags & MSG_TRUNC)) {
+		if (skb_last_copied && skb_last_copied->devmem != skb->devmem)
+			break;
+
+		if (skb->devmem) {
+			if (!(flags & MSG_SOCK_DEVMEM)) {
+				/* skb->devmem skbs can only be received with
+				 * the MSG_SOCK_DEVMEM flag.
+				 */
+
+				copied = -EFAULT;
+				break;
+			}
+
+			err = tcp_recvmsg_devmem(sk, skb, offset, msg, used);
+			if (err) {
+				if (!copied)
+					copied = -EFAULT;
+				break;
+			}
+			skb_last_copied = skb;
+		} else if (!(flags & MSG_TRUNC)) {
 			err = skb_copy_datagram_msg(skb, offset, msg, used);
 			if (err) {
 				/* Exception. Bailout! */
@@ -2601,6 +2782,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 					copied = -EFAULT;
 				break;
 			}
+			skb_last_copied = skb;
 		}
 
 		WRITE_ONCE(*seq, *seq + used);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 06d2573685ca..d7dee38e0410 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2291,6 +2291,14 @@ void tcp_v4_destroy_sock(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
+	unsigned long index;
+	struct page *page;
+
+	xa_for_each(&sk->sk_pagepool, index, page)
+		put_page(page);
+
+	xa_destroy(&sk->sk_pagepool);
+
 	trace_tcp_destroy_sock(sk);
 
 	tcp_clear_xmit_timers(sk);
-- 
2.41.0.390.g38632f3daf-goog

