Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A457E18EF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 03:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjKFCps (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Nov 2023 21:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjKFCpT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Nov 2023 21:45:19 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255D1700
        for <linux-arch@vger.kernel.org>; Sun,  5 Nov 2023 18:44:43 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afbcffe454so81307357b3.3
        for <linux-arch@vger.kernel.org>; Sun, 05 Nov 2023 18:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238682; x=1699843482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeiiEJbRtsTNAyw99p8ZCn3Vjnqo19hTPl7OEJ2oi/s=;
        b=jwEd6cs1Lg6YMrqKN8qfTAgdifr0auIiim0QBzwHITxKPJEqfJ5KZ57PSEJePl4+Nj
         shqMCrYBWgK1YX1VglxN66HvQBiQYSK3/VUSNq5wqEavBmIvl586WZn0Vv/FJsHh9n4r
         dHFr8UHhTSrChwcxYIy6iXJkXMZwoiCiX2Gw0/TBliwVWNNIPRBp7KfJVENRhdsimbyI
         LoIf47hQfFhuuwUolfRrIoQDWbiYnDf7+0fhTmJqtNWfMifUVHUR6vWlD8TF1bQVCGJb
         urkN/kt632R3lJqWZwWXq7yYzl8c4wVx9cPt+qicqaeLs/GJyLfR8uAW2tx9EFCEqTn+
         qxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238682; x=1699843482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeiiEJbRtsTNAyw99p8ZCn3Vjnqo19hTPl7OEJ2oi/s=;
        b=n/vl0/XwA8+6D6vVCZiHF33HekLkaaM0B7vfvxV8IdO6+2lwWJ5HtcVD2stkl9jJCs
         gjqiwM3DaoTF71z2tgOU6LJrEc4+5ImWSJ/0DBfOuvMIh58k39yvlP1IWFExMqvR6qW6
         ZOU0pq1wOMNreHzUKbp/34BjFyi7AU1GZyKwfX2TE01bpjfXvhXmUXpITYIFiCivZzte
         eNh5SxW8n4/GQlPIlc2QUJUMAwfNPRQaQbQLTLQRbYfZHI6uqm32utuPy+U0gkUjfOSg
         NUKbmSjDo+F9/yEvjr5GQmtTiJI5Dvu/r2RmM+DsL+ixFRrRdCGXMtgiJaqdJeRTQFp9
         vAXg==
X-Gm-Message-State: AOJu0YxmWeGA64QuXSzXnAxrOIealIG4pHctIjMRm4RIgNrfylr80YoF
        rWMDOmyV1vvgeSQqN4i3p12r+gYekBmyQWg0sw==
X-Google-Smtp-Source: AGHT+IGXB1Wk5WKMXZr8HTN6imbMYrfy8ASdQjy/ozkx0p4xonXE7b4iNBr/Mhu3s45eIhJrmpU89xDxoCb7QfNOog==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:828d:0:b0:d9a:4421:6ec5 with SMTP
 id r13-20020a25828d000000b00d9a44216ec5mr537997ybk.3.1699238682207; Sun, 05
 Nov 2023 18:44:42 -0800 (PST)
Date:   Sun,  5 Nov 2023 18:44:10 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-12-almasrymina@google.com>
Subject: [RFC PATCH v3 11/12] net: add SO_DEVMEM_DONTNEED setsockopt to
 release RX pages
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add an interface for the user to notify the kernel that it is done
reading the NET_RX dmabuf pages returned as cmsg. The kernel will
drop the reference on the NET_RX pages to make them available for
re-use.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/uapi/asm-generic/socket.h |  1 +
 include/uapi/linux/uio.h          |  4 ++++
 net/core/sock.c                   | 36 +++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index aacb97f16b78..eb93b43394d4 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,7 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_DEVMEM_DONTNEED	97
 #define SO_DEVMEM_HEADER	98
 #define SCM_DEVMEM_HEADER	SO_DEVMEM_HEADER
 #define SO_DEVMEM_OFFSET	99
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index ae94763b1963..71314bf41590 100644
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
index 1d28e3e87970..4ddc6b11d915 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1051,6 +1051,39 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	return 0;
 }
 
+static noinline_for_stack int
+sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	struct devmemtoken tokens[128];
+	unsigned int num_tokens, i, j;
+	int ret;
+
+	if (sk->sk_type != SOCK_STREAM || sk->sk_protocol != IPPROTO_TCP)
+		return -EBADF;
+
+	if (optlen % sizeof(struct devmemtoken) || optlen > sizeof(tokens))
+		return -EINVAL;
+
+	num_tokens = optlen / sizeof(struct devmemtoken);
+	if (copy_from_sockptr(tokens, optval, optlen))
+		return -EFAULT;
+
+	ret = 0;
+	for (i = 0; i < num_tokens; i++) {
+		for (j = 0; j < tokens[i].token_count; j++) {
+			struct page *page = xa_erase(&sk->sk_user_pages,
+						     tokens[i].token_start + j);
+
+			if (page) {
+				page_pool_page_put_many(page, 1);
+				ret++;
+			}
+		}
+	}
+
+	return ret;
+}
+
 void sockopt_lock_sock(struct sock *sk)
 {
 	/* When current->bpf_ctx is set, the setsockopt is called from
@@ -1538,6 +1571,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 
+	case SO_DEVMEM_DONTNEED:
+		ret = sock_devmem_dontneed(sk, optval, optlen);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 		break;
-- 
2.42.0.869.gea05f2083d-goog

