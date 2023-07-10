Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC2D74E15C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 00:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGJWek (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 18:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjGJWed (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 18:34:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C940510F0
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:34:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57745160c1dso59536147b3.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689028447; x=1691620447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eMznknX6LhCZzxkpGK1anYqC2AReGQzyhNKGt0dhRMs=;
        b=BtdvUbd29zwhezN9vWnqcJKpf0bV2LKN/+c8VWC9oiyT99FFcNEJDOvUA5o+m21DRJ
         e9aNejKksk1rdwKl8O1MZ9yP/O1OkMbpULehfNB94qYTmzji2HykYi+osFgOuhdAF+qD
         KGUZyMgcGBl8J91gT7Vb/XlYX07mdXJEBkEmKhCq++SE1RIb3ka/J0r4X0WZmUp1LyEo
         SjYNX6E3UyUwTUHmBfJ7fNPviqSEF3jRznivgjuuqoMmWVaZBvnRoFgKdOZiBTRle0wA
         2DGPZWSVDlrn2z8oZhGDAjAlxNPaIc+/JHcTW0CD86xRjmhJfySPnG/Os836KYedkH0U
         WpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028447; x=1691620447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMznknX6LhCZzxkpGK1anYqC2AReGQzyhNKGt0dhRMs=;
        b=EWl/cXq8TaBDlUKAstybhNzP+kPAHq3vsSE3ft2pAKdjiGPW7d+Uw/BmLWWa58jb9M
         X6V/rfXmt9FAlt2oDeuxV7gDdYCpntriQIswO/UXZXBnRXVVB9QH0PWYXr2NdWhatbzw
         PcPItx/ZdLrOgNJyCIHF5/U+hujLlZQRlyuYrjbO6e4WsOS7SrMCWby10GmJGtElBggz
         2OXfycyxFT1EPwBqbWgOf8IOBn2TtPIxG4fVbgB6WjwRr8ajqozUYFIyrdm93DlpPKMG
         1kAzdaEzTW3xol8FL9rrS9eCIZ/iTEn5tTU61pdW4zcxyVEuXFIJKKrUZqCIWRp0RVMU
         pZLQ==
X-Gm-Message-State: ABy/qLZDuqKTlBnkSMNVDKt/CyXtEeJZ2kKF5zSe7O2R8DBTP7CaTimm
        Zs0PZpI9sooS0TVXRFopnd9nlEGWQJKV5ScdKQ==
X-Google-Smtp-Source: APBJJlHZxtTyAip5d5fJgZLpVb+rUoGbj/Pap2HolJ5oEOujITpsR+hl7i9eHYLZIaU+exV6ykL+cfJhHKzieUdutg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c0f:bfb6:9942:8c53])
 (user=almasrymina job=sendgmr) by 2002:a81:e90b:0:b0:573:285a:c2a3 with SMTP
 id d11-20020a81e90b000000b00573285ac2a3mr95478ywm.1.1689028446916; Mon, 10
 Jul 2023 15:34:06 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:32:57 -0700
In-Reply-To: <20230710223304.1174642-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230710223304.1174642-7-almasrymina@google.com>
Subject: [RFC PATCH 06/10] net: add SO_DEVMEM_DONTNEED setsockopt to release
 RX pages
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add an interface for the user to notify the kernel that it is done reading
the NET_RX dmabuf pages returned as cmsg. The kernel will drop the
reference on the NET_RX pages to make them available for re-use.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/uapi/asm-generic/socket.h |  1 +
 include/uapi/linux/uio.h          |  4 +++
 net/core/sock.c                   | 41 +++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 88f9234f78cb..2a5a7f5da358 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -132,6 +132,7 @@
 
 #define SO_RCVMARK		75
 
+#define SO_DEVMEM_DONTNEED	97
 #define SO_DEVMEM_HEADER	98
 #define SCM_DEVMEM_HEADER	SO_DEVMEM_HEADER
 #define SO_DEVMEM_OFFSET	99
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index 8b0be0f50838..faaa765fd5a4 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -26,6 +26,10 @@ struct cmsg_devmem {
 	__u32 frag_token;
 };
 
+struct devmemtoken {
+	__u32 token_start;
+	__u32 token_count;
+};
 /*
  *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
  */
diff --git a/net/core/sock.c b/net/core/sock.c
index 24f2761bdb1d..f9b9d9ec7322 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1531,7 +1531,48 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		/* Paired with READ_ONCE() in tcp_rtx_synack() */
 		WRITE_ONCE(sk->sk_txrehash, (u8)val);
 		break;
+	case SO_DEVMEM_DONTNEED: {
+		struct devmemtoken tokens[128];
+		unsigned int num_tokens, i, j;
 
+		if (sk->sk_type != SOCK_STREAM ||
+		    sk->sk_protocol != IPPROTO_TCP) {
+			ret = -EBADF;
+			break;
+		}
+
+		if (optlen % sizeof(struct devmemtoken) ||
+		    optlen > sizeof(tokens)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		num_tokens = optlen / sizeof(struct devmemtoken);
+		if (copy_from_sockptr(tokens, optval, optlen)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = 0;
+
+		for (i = 0; i < num_tokens; i++) {
+			for (j = 0; j < tokens[i].token_count; j++) {
+				struct page *pg = xa_erase(&sk->sk_pagepool,
+							   tokens[i].token_start + j);
+
+				if (pg)
+					put_page(pg);
+				else
+					/* -EINTR here notifies the userspace
+					 * that not all tokens passed to it have
+					 * been freed.
+					 */
+					ret = -EINTR;
+			}
+		}
+
+		break;
+	}
 	default:
 		ret = -ENOPROTOOPT;
 		break;
-- 
2.41.0.390.g38632f3daf-goog

