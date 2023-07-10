Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EC274E162
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 00:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGJWe7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 18:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGJWe5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 18:34:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BA010C0
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:34:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c5a17bfb38bso4295271276.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689028450; x=1691620450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZRt6IHRVYwjrDgVxc5BdSo0qSi/7hDrkUlzlo5nha0=;
        b=F1oYk6PYa7tb7uIVT7ncRImo9dzRRTMW5Ebj/UOQML5cCAoP1bLxMrobu7CbsW0S0Y
         /G53r5rrIvyYyG7hi6OPzXlzkrD5CGMaY2hGiwXxL/WiSz79VteXRkiY81i7pEKLwp3l
         17i21BWEE+TiQROAnL1CRW8Ot45TQa2M7Zp54xbYqCQ+Shk7eiW886z2C/Mfw+okEbQ3
         +Ztb3SAnWz8mhB7hcleaQBtg3wQ1hi2zzpD2QPLMozZVO5zAIhJQh5CKSeVrTq/Oq2dZ
         VwWPCjINgVuULzor/doPFvcq/lk4R/bGAoXL66l0NggTBvJcD8v6CnyLUTPM0bsChWTJ
         PBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028450; x=1691620450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZRt6IHRVYwjrDgVxc5BdSo0qSi/7hDrkUlzlo5nha0=;
        b=EZvlsKY4BSw1vL07s0tZtV7qV7uTqTvq7S6DOs+YYPhHSSEXUO33uB3KQPuIzVX7Q+
         ekJlLrRWMSH7j+OQZQ8tc/kIgRDl6qiQHVb2QFGkgBQX01+vwx0rz+KI+xgmDmdDRveb
         Ejdb+nXw3w2AFc3sr0QkC0V3cb4wQ3FxeEZkyDA/M510e2KauKolRWNxDxZDOr6ZcstV
         YdumBNR3S3xPjxkk4rY6GHnHwrhUC1hLLXFTH3DzNzZtsEAIk+fQlHpyR6B/rXr6TaT/
         ajwt/nE0OQcsCOay0rWwm7i71uSROGt3PYXqjX4wrGc00wfAHeaDzLJGH1FLbVF4wd/R
         SxOg==
X-Gm-Message-State: ABy/qLbtX1YatFqeoWmn5ix7H1pNBq6xO519vqiWk0LWOQ8d2P4F3WYI
        P82oZ2nwULzUnBDg+HCjr9ewWiylhIEc9Cqynw==
X-Google-Smtp-Source: APBJJlGwcwSQfIa1k2C4AKA9b3D+Y30QHjPYL3qtWa/GF75GmX5sDpCzR7Nk3qYThT2cxoPLhXyLaIWlt8Ip9FM82g==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c0f:bfb6:9942:8c53])
 (user=almasrymina job=sendgmr) by 2002:a25:c902:0:b0:c61:7151:6727 with SMTP
 id z2-20020a25c902000000b00c6171516727mr76617ybf.10.1689028449938; Mon, 10
 Jul 2023 15:34:09 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:32:58 -0700
In-Reply-To: <20230710223304.1174642-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230710223304.1174642-8-almasrymina@google.com>
Subject: [RFC PATCH 07/10] tcp: implement sendmsg() TX path for for devmem tcp
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

For device memory TCP, we let the user provide the kernel with a cmsg
container 2 items:

1. the dmabuf pages fd that the user would like to send data from.
2. the offset into this dmabuf that the user would like to start sending
   from.

In tcp_sendmsg_locked(), if this cmsg is provided, we send the data
using the dmabuf NET_TX pages bio_vec.

Also provide drivers with a new skb_devmem_frag_dma_map() helper. This
helper is similar to skb_frag_dma_map(), but it first checks whether the
frag being mapped is backed by dmabuf NET_TX pages, and provides the
correct dma_addr if so.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/skbuff.h | 19 +++++++++--
 include/net/sock.h     |  2 ++
 net/core/skbuff.c      |  8 ++---
 net/core/sock.c        |  6 ++++
 net/ipv4/tcp.c         | 73 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f5e03aa84160..ad4e7bfcab07 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1660,8 +1660,8 @@ static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
 }
 
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
-			     struct msghdr *msg, int len,
-			     struct ubuf_info *uarg);
+			     struct msghdr *msg, struct iov_iter *iov_iter,
+			     int len, struct ubuf_info *uarg);
 
 /* Internal */
 #define skb_shinfo(SKB)	((struct skb_shared_info *)(skb_end_pointer(SKB)))
@@ -3557,6 +3557,21 @@ static inline dma_addr_t skb_frag_dma_map(struct device *dev,
 			    skb_frag_off(frag) + offset, size, dir);
 }
 
+/* Similar to skb_frag_dma_map, but handles devmem skbs correctly. */
+static inline dma_addr_t skb_devmem_frag_dma_map(struct device *dev,
+						 const struct sk_buff *skb,
+						 const skb_frag_t *frag,
+						 size_t offset, size_t size,
+						 enum dma_data_direction dir)
+{
+	if (unlikely(skb->devmem && is_dma_buf_page(skb_frag_page(frag)))) {
+		dma_addr_t dma_addr =
+			dma_buf_page_to_dma_addr(skb_frag_page(frag));
+		return dma_addr + skb_frag_off(frag) + offset;
+	}
+	return skb_frag_dma_map(dev, frag, offset, size, dir);
+}
+
 static inline struct sk_buff *pskb_copy(struct sk_buff *skb,
 					gfp_t gfp_mask)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index c615666ff19a..733865f89635 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1890,6 +1890,8 @@ struct sockcm_cookie {
 	u64 transmit_time;
 	u32 mark;
 	u32 tsflags;
+	u32 devmem_fd;
+	u32 devmem_offset;
 };
 
 static inline void sockcm_init(struct sockcm_cookie *sockc,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9b83da794641..b1e28e7ad6a8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1685,8 +1685,8 @@ void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
 EXPORT_SYMBOL_GPL(msg_zerocopy_put_abort);
 
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
-			     struct msghdr *msg, int len,
-			     struct ubuf_info *uarg)
+			     struct msghdr *msg, struct iov_iter *iov_iter,
+			     int len, struct ubuf_info *uarg)
 {
 	struct ubuf_info *orig_uarg = skb_zcopy(skb);
 	int err, orig_len = skb->len;
@@ -1697,12 +1697,12 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 	if (orig_uarg && uarg != orig_uarg)
 		return -EEXIST;
 
-	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len);
+	err = __zerocopy_sg_from_iter(msg, sk, skb, iov_iter, len);
 	if (err == -EFAULT || (err == -EMSGSIZE && skb->len == orig_len)) {
 		struct sock *save_sk = skb->sk;
 
 		/* Streams do not free skb on error. Reset to prev state. */
-		iov_iter_revert(&msg->msg_iter, skb->len - orig_len);
+		iov_iter_revert(iov_iter, skb->len - orig_len);
 		skb->sk = sk;
 		___pskb_trim(skb, orig_len);
 		skb->sk = save_sk;
diff --git a/net/core/sock.c b/net/core/sock.c
index f9b9d9ec7322..854624bee5d0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2813,6 +2813,12 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 			return -EINVAL;
 		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
 		break;
+	case SCM_DEVMEM_OFFSET:
+		if (cmsg->cmsg_len != CMSG_LEN(2 * sizeof(u32)))
+			return -EINVAL;
+		sockc->devmem_fd = ((u32 *)CMSG_DATA(cmsg))[0];
+		sockc->devmem_offset = ((u32 *)CMSG_DATA(cmsg))[1];
+		break;
 	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a894b8a9dbb0..85d6cdc832ef 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -280,6 +280,7 @@
 #include <asm/ioctls.h>
 #include <net/busy_poll.h>
 #include <linux/dma-buf.h>
+#include <uapi/linux/dma-buf.h>
 
 /* Track pending CMSGs. */
 enum {
@@ -1216,6 +1217,52 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 	return err;
 }
 
+static int tcp_prepare_devmem_data(struct msghdr *msg, int devmem_fd,
+				   unsigned int devmem_offset,
+				   struct file **devmem_file,
+				   struct iov_iter *devmem_tx_iter, size_t size)
+{
+	struct dma_buf_pages *priv;
+	int err = 0;
+
+	*devmem_file = fget_raw(devmem_fd);
+	if (!*devmem_file) {
+		err = -EINVAL;
+		goto err;
+	}
+
+	if (!is_dma_buf_pages_file(*devmem_file)) {
+		err = -EBADF;
+		goto err_fput;
+	}
+
+	priv = (*devmem_file)->private_data;
+	if (!priv) {
+		WARN_ONCE(!priv, "dma_buf_pages_file has no private_data");
+		err = -EINTR;
+		goto err_fput;
+	}
+
+	if (!(priv->type & DMA_BUF_PAGES_NET_TX))
+		return -EINVAL;
+
+	if (devmem_offset + size > priv->dmabuf->size) {
+		err = -ENOSPC;
+		goto err_fput;
+	}
+
+	*devmem_tx_iter = priv->net_tx.iter;
+	iov_iter_advance(devmem_tx_iter, devmem_offset);
+
+	return 0;
+
+err_fput:
+	fput(*devmem_file);
+	*devmem_file = NULL;
+err:
+	return err;
+}
+
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1227,6 +1274,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	int process_backlog = 0;
 	bool zc = false;
 	long timeo;
+	struct file *devmem_file = NULL;
+	struct iov_iter devmem_tx_iter;
 
 	flags = msg->msg_flags;
 
@@ -1295,6 +1344,14 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		}
 	}
 
+	if (sockc.devmem_fd) {
+		err = tcp_prepare_devmem_data(msg, sockc.devmem_fd,
+					      sockc.devmem_offset, &devmem_file,
+					      &devmem_tx_iter, size);
+		if (err)
+			goto out_err;
+	}
+
 	/* This should be in poll */
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
@@ -1408,7 +1465,17 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 					goto wait_for_space;
 			}
 
-			err = skb_zerocopy_iter_stream(sk, skb, msg, copy, uarg);
+			if (devmem_file) {
+				err = skb_zerocopy_iter_stream(sk, skb, msg,
+							       &devmem_tx_iter,
+							       copy, uarg);
+				if (err > 0)
+					iov_iter_advance(&msg->msg_iter, err);
+			} else {
+				err = skb_zerocopy_iter_stream(sk, skb, msg,
+							       &msg->msg_iter,
+							       copy, uarg);
+			}
 			if (err == -EMSGSIZE || err == -EEXIST) {
 				tcp_mark_push(tp, skb);
 				goto new_segment;
@@ -1462,6 +1529,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	}
 out_nopush:
 	net_zcopy_put(uarg);
+	if (devmem_file)
+		fput(devmem_file);
 	return copied + copied_syn;
 
 do_error:
@@ -1470,6 +1539,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	if (copied + copied_syn)
 		goto out;
 out_err:
+	if (devmem_file)
+		fput(devmem_file);
 	net_zcopy_put_abort(uarg, true);
 	err = sk_stream_error(sk, flags, err);
 	/* make sure we wake any epoll edge trigger waiter */
-- 
2.41.0.390.g38632f3daf-goog

