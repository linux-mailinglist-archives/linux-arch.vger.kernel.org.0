Return-Path: <linux-arch+bounces-5336-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84C192C76D
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 02:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3799FB224FB
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 00:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C6A8288F;
	Wed, 10 Jul 2024 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8lNWk0g"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03756458
	for <linux-arch@vger.kernel.org>; Wed, 10 Jul 2024 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570699; cv=none; b=iCPc0oMk9kF1UFrH088WNBXtrW2nO8Ef9J47k5Oqe1shO87/ZFIe5H9HT/QpXhKCj/vH8xaccVy9+VnHxZFSjQfslMPGsk5X3lu4il2rFoBQvI4zBqA5vKYS5zHnhGCqp6OLzv4ewG6qYzrBUhI9VbiN6iLLNmXtU4GEIXLS6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570699; c=relaxed/simple;
	bh=GuhVEQ9cPKwV1YOxe3RhyBdTr/kKa3K1YTdg2kWcpjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=acUog15MOVVp/KsQg/+WkLi8KAhZHPTuah/WL74seSiV/Msyt2XAbLj+7bG3/C83obfY8mdUubfGjB8+FuaFXVuFgdApXmRdwjqjer2sjAjRAdpsqydUB421r18przQNIfGL02u0e+kv4BW3LA3qD0Jldxb1N/6N6Jpva9GILi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z8lNWk0g; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-65194ea3d4dso95905847b3.0
        for <linux-arch@vger.kernel.org>; Tue, 09 Jul 2024 17:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720570691; x=1721175491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzpTzbMtPWQegc0PnpdJ1jHFVVk3yM4HCq8hvChz4BY=;
        b=Z8lNWk0gm1KKi9TnvlcNs0ttDEmhSARrqr4dJ4+1UFLMuzaJoMYG0JMo3Ix9Hs1DDP
         PKQZpm3CTG0pMimbMxggDfQRwmUSpAWKoHcObewyL1YJ3IiCTp+Co10wphsXe8Jym8gD
         lOn3/tIBwfYDqtnCZJwtGWV7h1uexa7kD3W2/d55EmLMKLRkjV9aME6anpmZBIPvSCeQ
         ulEOdDccI9qmwqs2Nq20ZkbhSzy0E0ZgcM3OjZE/7Jv03Bgy3nNxgZSUQtMRO2WOQ2Ry
         DAbLP8bTryYh/WYClc7drB2mxZ7oL3JxECFflyRLJDQ0H5hLa3FevYzuJlvp7YhYkiZV
         AicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720570691; x=1721175491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzpTzbMtPWQegc0PnpdJ1jHFVVk3yM4HCq8hvChz4BY=;
        b=QaWSSoY1Yj3pPcAz8KZI/MSE4hmXdc7kDcIWWJSjW8yotT1ukrvhdi3fwB85Pb4aUX
         V4+4Y6ZZekUBqv96e+KXkaFGmG8+VX8m1l7PAlIeynkHN5H3n1GsZqgw6TFJsOFaFfNF
         s6H4i2yj/nMgWC0qvSSIquvYj1ZR6b8DBmm2C/4LXq+djSZbsb1ttIZtoSRe1P2qFGcX
         CUyh9jwvLXjjJjDKjsbzzEh2BIZoo0bX+tLlW49gRCD/iWriixz0x0flEQo6AXpdb108
         mc8ORGNouTovWOqyEzyvIMfNIuMM+nblFp3uK/tpyWOx+30ttigEi/XYOuDL9zkwUanJ
         JcNg==
X-Forwarded-Encrypted: i=1; AJvYcCXuhP3FQy/QdYwWkc/yZZlxRR+ccUSXDYafZBHaQzqVfeZ4DwfOslUj2Vr63EToyXuc02FImXmDdaRRLGL6WBjF10eDiKVzJgX+hw==
X-Gm-Message-State: AOJu0Yxk4zk/dxoUqsZqaak4OraIL/Kg7JhjNZMZOFuR/E/Fk7oQi1Mf
	tNP/53oBdlkXYFGHkPtJTrl/D6PHH/hmBEdssgyAMpUXPJ+jV0p1PLCxRtFz9rrpUZ2QorXDB6Z
	pdesSuu/13Uz87Qz6DZXXwQ==
X-Google-Smtp-Source: AGHT+IGaC3Qq/1wnib4kEfOXueASVACsR1bB71FTbwOgR8hczc44H0Yygn1A0e8rycelThgDM6BiwU21Xiy/M+7wfA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:ece:b0:62f:f535:f41 with SMTP
 id 00721157ae682-658f0bc9050mr2557637b3.9.1720570691186; Tue, 09 Jul 2024
 17:18:11 -0700 (PDT)
Date: Wed, 10 Jul 2024 00:17:43 +0000
In-Reply-To: <20240710001749.1388631-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710001749.1388631-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710001749.1388631-11-almasrymina@google.com>
Subject: [PATCH net-next v16 10/13] net: add SO_DEVMEM_DONTNEED setsockopt to
 release RX frags
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an interface for the user to notify the kernel that it is done
reading the devmem dmabuf frags returned as cmsg. The kernel will
drop the reference on the frags to make them available for reuse.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---

v16:
- Use sk_is_tcp().
- Fix unnamed 128 DONTNEED limit (David).
- Fix kernel allocating for 128 tokens even if the user didn't ask for
  that much (Eric).
- Fix number assignement (Arnd).

v10:
- Fix leak of tokens (Nikolay).

v7:
- Updated SO_DEVMEM_* uapi to use the next available entry (Arnd).

v6:
- Squash in locking optimizations from edumazet@google.com. With his
  changes we lock the xarray once per sock_devmem_dontneed operation
  rather than once per frag.

Changes in v1:
- devmemtoken -> dmabuf_token (David).
- Use napi_pp_put_page() for refcounting (Yunsheng).
- Fix build error with missing socket options on other asms.

---
 arch/alpha/include/uapi/asm/socket.h  |  1 +
 arch/mips/include/uapi/asm/socket.h   |  1 +
 arch/parisc/include/uapi/asm/socket.h |  1 +
 arch/sparc/include/uapi/asm/socket.h  |  1 +
 include/uapi/asm-generic/socket.h     |  1 +
 include/uapi/linux/uio.h              |  4 ++
 net/core/sock.c                       | 68 +++++++++++++++++++++++++++
 7 files changed, 77 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index ef4656a41058a..251b73c5481ea 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -144,6 +144,7 @@
 #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
 #define SO_DEVMEM_DMABUF	79
 #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+#define SO_DEVMEM_DONTNEED	80
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 414807d55e33f..8ab7582291abf 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -155,6 +155,7 @@
 #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
 #define SO_DEVMEM_DMABUF	79
 #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+#define SO_DEVMEM_DONTNEED	80
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 2b817efd45444..38fc0b188e084 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -136,6 +136,7 @@
 #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
 #define SO_DEVMEM_DMABUF	79
 #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+#define SO_DEVMEM_DONTNEED	80
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 00248fc689773..57084ed2f3c4e 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -137,6 +137,7 @@
 #define SCM_DEVMEM_LINEAR        SO_DEVMEM_LINEAR
 #define SO_DEVMEM_DMABUF         0x0058
 #define SCM_DEVMEM_DMABUF        SO_DEVMEM_DMABUF
+#define SO_DEVMEM_DONTNEED       0x0059
 
 #if !defined(__KERNEL__)
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index e993edc9c0ee6..3b4e3e8156025 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -139,6 +139,7 @@
 #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
 #define SO_DEVMEM_DMABUF	79
 #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+#define SO_DEVMEM_DONTNEED	80
 
 #if !defined(__KERNEL__)
 
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index 3a22ddae376a2..d17f8fcd93ec9 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -33,6 +33,10 @@ struct dmabuf_cmsg {
 				 */
 };
 
+struct dmabuf_token {
+	__u32 token_start;
+	__u32 token_count;
+};
 /*
  *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
  */
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe259535..df2a2dd6409da 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -124,6 +124,7 @@
 #include <linux/netdevice.h>
 #include <net/protocol.h>
 #include <linux/skbuff.h>
+#include <linux/skbuff_ref.h>
 #include <net/net_namespace.h>
 #include <net/request_sock.h>
 #include <net/sock.h>
@@ -1049,6 +1050,69 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	return 0;
 }
 
+#ifdef CONFIG_PAGE_POOL
+
+/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED in
+ * 1 syscall. The limit exists to limit the amount of memory the kernel
+ * allocates to copy these tokens.
+ */
+#define MAX_DONTNEED_TOKENS 128
+
+static noinline_for_stack int
+sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	unsigned int num_tokens, i, j, k, netmem_num = 0;
+	struct dmabuf_token *tokens;
+	netmem_ref netmems[16];
+	int ret = 0;
+
+	if (!sk_is_tcp(sk))
+		return -EBADF;
+
+	if (optlen % sizeof(struct dmabuf_token) ||
+	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
+		return -EINVAL;
+
+	tokens = kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
+	if (!tokens)
+		return -ENOMEM;
+
+	num_tokens = optlen / sizeof(struct dmabuf_token);
+	if (copy_from_sockptr(tokens, optval, optlen)) {
+		kvfree(tokens);
+		return -EFAULT;
+	}
+
+	xa_lock_bh(&sk->sk_user_frags);
+	for (i = 0; i < num_tokens; i++) {
+		for (j = 0; j < tokens[i].token_count; j++) {
+			netmem_ref netmem = (__force netmem_ref)__xa_erase(
+				&sk->sk_user_frags, tokens[i].token_start + j);
+
+			if (netmem &&
+			    !WARN_ON_ONCE(!netmem_is_net_iov(netmem))) {
+				netmems[netmem_num++] = netmem;
+				if (netmem_num == ARRAY_SIZE(netmems)) {
+					xa_unlock_bh(&sk->sk_user_frags);
+					for (k = 0; k < netmem_num; k++)
+						WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+					netmem_num = 0;
+					xa_lock_bh(&sk->sk_user_frags);
+				}
+				ret++;
+			}
+		}
+	}
+
+	xa_unlock_bh(&sk->sk_user_frags);
+	for (k = 0; k < netmem_num; k++)
+		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+
+	kvfree(tokens);
+	return ret;
+}
+#endif
+
 void sockopt_lock_sock(struct sock *sk)
 {
 	/* When current->bpf_ctx is set, the setsockopt is called from
@@ -1211,6 +1275,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			ret = -EOPNOTSUPP;
 		return ret;
 		}
+#ifdef CONFIG_PAGE_POOL
+	case SO_DEVMEM_DONTNEED:
+		return sock_devmem_dontneed(sk, optval, optlen);
+#endif
 	}
 
 	sockopt_lock_sock(sk);
-- 
2.45.2.803.g4e1b14247a-goog


