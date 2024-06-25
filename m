Return-Path: <linux-arch+bounces-5134-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA09171D9
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 21:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413D21C20B6A
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F717F4FA;
	Tue, 25 Jun 2024 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZTqJGYZn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB33180A82
	for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345283; cv=none; b=JREifyW8bhuxgRVnDct7nTEW7E0xDhQ1fcfhMNPW1PjWRv3vt2ba0q6HlsFJfWrnI6mRP2vnyNrHvRqUVTJJAOkhuQ4hH5rzV68O8+EIyiAJvFeML+2Ly/315gmMTiRci3m7SlSpka5BlSY5wBVUzIKWO1JmxX+6I/AMZO01QE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345283; c=relaxed/simple;
	bh=m3ZrCpA4iGOGEwTjOi2A7jZ1gSinTJ3Ms+w9lOZ2j44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tmhhj3eG84fRtwAVqY4+OAuDQU13ow694cPTSwvCrnF3NyEe+mTDtaoF6XuKFB/x31D5aqnDRXd6nblP5pernpsj+IPzbaLm12lwAwlRVoGA1T44/xs8PD1WAKyyfyqJSey4YCxOUGEQ/FHCoyEdxj7BaZuecR4+Uo0MyjIHBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZTqJGYZn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63bf23f8fbcso134697657b3.0
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2024 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719345271; x=1719950071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwzym0FwQ/rpSoAlwAPKIHf1/qVj+EbPSE9irYNrCpU=;
        b=ZTqJGYZnHgnn4/VKjF+NvwrVpBePoKS7GalVKngMW7rY+/ZnPo1WOo/ClNI20+rrp1
         1lA2tI/cXXbyX77v2jnkeRZ/PobwcyRHQYkh2JQMVjM6n8qR7gLmIfyXbkJk8X1y0p1F
         ggkeucOHLgtMePK6CI4jGr7Uqilfr8Tzw3hDgZnQK7ghCoysD62NnG6AfQTK/L4M9MoV
         zmv1j1YM/UdWFJqIEdnTdbRQs2f3a6+PNudWuxEeLR16Wvf60nEaXbvx+sI9IyWDfx79
         bz8OppvodruMCOLVGszUM8wb/GpWWY11BRR1veAlgrqE1fDKw0y2YY8xkFYw96vXHFx6
         04OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719345271; x=1719950071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwzym0FwQ/rpSoAlwAPKIHf1/qVj+EbPSE9irYNrCpU=;
        b=QJLrkVwwg2LHMc+I6QTa97eqGj7GHQ1ullWoLgKEiJ/OqcNOLznxNTL0lp5+IB5Lv1
         MrIMmQORaN7d01a1p7CHKrYu0m3FX0iMRprxGoBGT0MxRuav38tVhbefhZbiPZ5frLp9
         kOPRP7qfqdUdhZwPl2bQqR26Qs3s8lzE4nyg7gTJc+G3FSQMEKJ6h8Ny6jGwjXL2ua/C
         E40f+jgtD14aFAvkTiZeC9w5N3VAjFKh/zGvm7GdW21TcxiZTsDBSN9HXWckyGViC0pl
         7NqMoloTzdoz+Lx/5WYvze/kvW0OcX/7kvRWDZyJ84Pphxjd8blyY2sjIW+PdST97+tl
         APTA==
X-Forwarded-Encrypted: i=1; AJvYcCW9LVwe2B2TDdeaf7ceZyIFQN3zZnlpG38ww1AiPsPnRHl6Eq1ualH7w/uHslUW649HXdc7Gcpwny8gdb0hga/v+VOSdPlW+u6b7A==
X-Gm-Message-State: AOJu0YznDlI5U94FSTTN7F9Pcx82Dy1QBx3OJpe1EUdzBhbcyH/mAcrc
	3eKYAvgOT40g3QFVDGM4+icDX5MlUs7FmYDH1Z6DfMR+N+FLTQQ4+DHmXTxNNSiL8zOvu7yXA0U
	ptTvCRJ1IEErO5OAQcdGXtQ==
X-Google-Smtp-Source: AGHT+IHYOLBMRZdrsgyDd0g5lutCin7LfI+HPaLJ/PFqnpgHbKnZ0268paxaoOS4QsiXSjFL7dC6EutWc+anciKPHw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:6f08:b0:62a:2a39:ccd9 with
 SMTP id 00721157ae682-643ad9aa0bfmr5406447b3.6.1719345271288; Tue, 25 Jun
 2024 12:54:31 -0700 (PDT)
Date: Tue, 25 Jun 2024 19:53:59 +0000
In-Reply-To: <20240625195407.1922912-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625195407.1922912-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625195407.1922912-12-almasrymina@google.com>
Subject: [PATCH net-next v14 11/13] net: add SO_DEVMEM_DONTNEED setsockopt to
 release RX frags
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
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
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
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

---

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
 net/core/sock.c                       | 61 +++++++++++++++++++++++++++
 7 files changed, 70 insertions(+)

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
index 25a2f5255f523..1acb77780f103 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,7 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_DEVMEM_DONTNEED	97
 #define SO_DEVMEM_LINEAR	98
 #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
 #define SO_DEVMEM_DMABUF	99
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
index 9abc4fe259535..040c66ac26244 100644
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
@@ -1049,6 +1050,62 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	return 0;
 }
 
+#ifdef CONFIG_PAGE_POOL
+static noinline_for_stack int
+sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	unsigned int num_tokens, i, j, k, netmem_num = 0;
+	struct dmabuf_token *tokens;
+	netmem_ref netmems[16];
+	int ret = 0;
+
+	if (sk->sk_type != SOCK_STREAM || sk->sk_protocol != IPPROTO_TCP)
+		return -EBADF;
+
+	if (optlen % sizeof(struct dmabuf_token) ||
+	    optlen > sizeof(*tokens) * 128)
+		return -EINVAL;
+
+	tokens = kvmalloc_array(128, sizeof(*tokens), GFP_KERNEL);
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
@@ -1211,6 +1268,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
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
2.45.2.741.gdbec12cfda-goog


