Return-Path: <linux-arch+bounces-3373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7BE896132
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 02:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B9DB25052
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 00:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBB85C613;
	Wed,  3 Apr 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQ9kO/MJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500F4F1F5
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103695; cv=none; b=tox+v+9awBtCkbdEKjUkqbh1vSYGyXQjyTJDSVZvSXZQfr7GTWG++5VK+FUDwaUITnrCXNuSlkopykV+KZYIsq8YY3+o4argdHqf0UFGx3byy2+6MHG6QiwSDfFUGX8DxXBEA+vpXIVdKrQaVOuFwam3ywf+mDbFDJCKG8KDWmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103695; c=relaxed/simple;
	bh=+J+k2QFSIAoPYQKC2EyzVE6kljNzdjsCEdDXN5r5WHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IgnRyiVUO45N+JJiGGsBA2YRGq0ryWfog3Gd4BMUZ9WmLaY+BkVRt7n+USYiFdIvK5gkfQCjc0rx2f0aGNIVwsjWSzQClfUfp4B01pFhcollPClHzmSooFLy8kCwcrCDKWfR08tLxLQwmb4vKzxqFrTxkwv2JWzx6k23m8Tj76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qQ9kO/MJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6150e36ca0dso28495657b3.1
        for <linux-arch@vger.kernel.org>; Tue, 02 Apr 2024 17:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712103687; x=1712708487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4w5qITpV1d5FGou7Xo3yiupSm0WoJIdYWlmv7WZBXdw=;
        b=qQ9kO/MJ4UIyPR6KcyF+BxRLYw+Uwo4iRcpuw7CkP3ezAuq6pxiWXUPHiPf0VHdbVI
         AxtzECkwOy46tO9WCNx7aKG154ZwKHZAiKNzwM6r21Ie5paAXo+wPdDfLh7pN7oKTSUr
         YHTP0efV8utoGrutsMbePzpCpqm7XavGu0rbGJmjxCEKDnckhJ6rA7fss79kPRqlbJEj
         sZZKE5I/mDVfUfC3oMeNbJFR4IWJ8kd9H7JzWmXbiHtYTUlXM87NTbigqgE22OtmFPO4
         C2KY4vsmhtzCHJZC5C/FO4C1R8WboD17tRjQWRNCyuHXKDzSgvmOvzcP6azmd9rryFT2
         rBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712103687; x=1712708487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4w5qITpV1d5FGou7Xo3yiupSm0WoJIdYWlmv7WZBXdw=;
        b=J+XOTeEBMVX22bbn+cZhGYuVNBGR1h3JMhih/067g3dF/p7aVkAOtIsU62h8hF+LS9
         wjkwHvNRelGjrkz3ld0A0hEWy7Pa2EZk6js3mjwvQMxjywX4EC2SMGD0LSmWrH6N7Cy3
         QKlzACzy+vHXd5LH/0eksN/MaNz581tABSohz/CEj0JxuTWasdA4PDTWh76HLlczXd+X
         kSf3DF91wLBphbn0iXnEmGJlBBqCZeNmn2GFJaHA5KbsVPMKXavDFFeX0Q0ezUk5k32z
         /XKWI1I4xRUEvCa9S5y34lr2pUhfWasutiMpHO193N1cckpUqeqcXK3BgU9qspbrzepi
         mTcA==
X-Forwarded-Encrypted: i=1; AJvYcCUPecBA0GD5euM0uIAfkD7Z/ssg5qK1olbjndbveiqMAi/SQ3XGxAPI2P47FY6RDggvghGtjbqVi9Ta07g//GdD+7ak+Rza1aCTDw==
X-Gm-Message-State: AOJu0YyddxW14/jKHJ1RQ4TMuiAXg2ErPW62iK6rgdZlr4QyV1Ma1nCL
	ES3vqBc/by315RoDSBE1m0jyNennWASo5VDz4dBaChOIropmLiXljieB4OYJAEPIz3LxMZGl0ZE
	3xYMyicWW1bRa/jc3FNwspw==
X-Google-Smtp-Source: AGHT+IGLf9hwcS6N+6nVMgmd/YppY+IZjPhI9dCSh/BcVvCG58GCKFCgnNIpiuTFDPTUulSlQ0+qLmmdsUNbBfCc2g==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a81:4c41:0:b0:610:f5e6:375a with SMTP
 id z62-20020a814c41000000b00610f5e6375amr3075309ywa.9.1712103687559; Tue, 02
 Apr 2024 17:21:27 -0700 (PDT)
Date: Tue,  2 Apr 2024 17:20:48 -0700
In-Reply-To: <20240403002053.2376017-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403002053.2376017-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403002053.2376017-12-almasrymina@google.com>
Subject: [RFC PATCH net-next v8 11/14] tcp: RX path for devmem TCP
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Florian Westphal <fw@strlen.de>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Aleksander Lobakin <aleksander.lobakin@intel.com>, Michael Lass <bevan@bi-co.net>, 
	Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

In tcp_recvmsg_locked(), detect if the skb being received by the user
is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVMEM
flag - pass it to tcp_recvmsg_devmem() for custom handling.

tcp_recvmsg_devmem() copies any data in the skb header to the linear
buffer, and returns a cmsg to the user indicating the number of bytes
returned in the linear buffer.

tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
and returns to the user a cmsg_devmem indicating the location of the
data in the dmabuf device memory. cmsg_devmem contains this information:

1. the offset into the dmabuf where the payload starts. 'frag_offset'.
2. the size of the frag. 'frag_size'.
3. an opaque token 'frag_token' to return to the kernel when the buffer
is to be released.

The pages awaiting freeing are stored in the newly added
sk->sk_user_frags, and each page passed to userspace is get_page()'d.
This reference is dropped once the userspace indicates that it is
done reading this page.  All pages are released when the socket is
destroyed.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v7:
- Updated the SO_DEVMEM_* uapi to use the next available entries (Arnd).
- Updated dmabuf_cmsg struct to be __u64 padded (Arnd).
- Squashed fix from Eric to initialize sk_user_frags for passive
  sockets (Eric).

v6
- skb->dmabuf -> skb->readable (Pavel)
- Fixed asm definitions of SO_DEVMEM_LINEAR/SO_DEVMEM_DMABUF not found
  on some archs.
- Squashed in locking optimizations from edumazet@google.com. With this
  change we lock the xarray once per per tcp_recvmsg_dmabuf() rather
  than once per frag in xa_alloc().

Changes in v1:
- Added dmabuf_id to dmabuf_cmsg (David/Stan).
- Devmem -> dmabuf (David).
- Change tcp_recvmsg_dmabuf() check to skb->dmabuf (Paolo).
- Use __skb_frag_ref() & napi_pp_put_page() for refcounting (Yunsheng).

RFC v3:
- Fixed issue with put_cmsg() failing silently.

---
 arch/alpha/include/uapi/asm/socket.h  |   5 +
 arch/mips/include/uapi/asm/socket.h   |   5 +
 arch/parisc/include/uapi/asm/socket.h |   5 +
 arch/sparc/include/uapi/asm/socket.h  |   5 +
 include/linux/socket.h                |   1 +
 include/net/netmem.h                  |  13 ++
 include/net/sock.h                    |   2 +
 include/uapi/asm-generic/socket.h     |   5 +
 include/uapi/linux/uio.h              |  13 ++
 net/ipv4/tcp.c                        | 248 +++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c                   |   9 +
 net/ipv4/tcp_minisocks.c              |   2 +
 12 files changed, 308 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index e94f621903fe..ef4656a41058 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -140,6 +140,11 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_DEVMEM_LINEAR	78
+#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF	79
+#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 60ebaed28a4c..414807d55e33 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -151,6 +151,11 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_DEVMEM_LINEAR	78
+#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF	79
+#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index be264c2b1a11..2b817efd4544 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -132,6 +132,11 @@
 #define SO_PASSPIDFD		0x404A
 #define SO_PEERPIDFD		0x404B
 
+#define SO_DEVMEM_LINEAR	78
+#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF	79
+#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 682da3714686..00248fc68977 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -133,6 +133,11 @@
 #define SO_PASSPIDFD             0x0055
 #define SO_PEERPIDFD             0x0056
 
+#define SO_DEVMEM_LINEAR         0x0057
+#define SCM_DEVMEM_LINEAR        SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF         0x0058
+#define SCM_DEVMEM_DMABUF        SO_DEVMEM_DMABUF
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 139c330ccf2c..f11ab541439e 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -326,6 +326,7 @@ struct ucred {
 					  * plain text and require encryption
 					  */
 
+#define MSG_SOCK_DEVMEM 0x2000000	/* Receive devmem skbs as cmsg */
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
 #define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 34aa1c80c1ca..c7fb1e4dc679 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -65,6 +65,19 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
 	return niov - net_iov_owner(niov)->niovs;
 }
 
+static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
+
+	return owner->base_virtual +
+	       ((unsigned long)net_iov_idx(niov) << PAGE_SHIFT);
+}
+
+static inline u32 net_iov_binding_id(const struct net_iov *niov)
+{
+	return net_iov_owner(niov)->binding->id;
+}
+
 /* This returns the absolute dma_addr_t calculated from
  * net_iov_owner(niov)->owner->base_dma_addr, not the page_pool-owned
  * niov->dma_addr.
diff --git a/include/net/sock.h b/include/net/sock.h
index 2253eefe2848..e4b134ca18dc 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -337,6 +337,7 @@ struct sk_filter;
   *	@sk_txtime_report_errors: set report errors mode for SO_TXTIME
   *	@sk_txtime_unused: unused txtime flags
   *	@ns_tracker: tracker for netns reference
+  *	@sk_user_frags: xarray of pages the user is holding a reference on.
   */
 struct sock {
 	/*
@@ -542,6 +543,7 @@ struct sock {
 #endif
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
+	struct xarray		sk_user_frags;
 };
 
 enum sk_pacing {
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 8ce8a39a1e5f..25a2f5255f52 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,11 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_DEVMEM_LINEAR	98
+#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF	99
+#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index 059b1a9147f4..3a22ddae376a 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -20,6 +20,19 @@ struct iovec
 	__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
 };
 
+struct dmabuf_cmsg {
+	__u64 frag_offset;	/* offset into the dmabuf where the frag starts.
+				 */
+	__u32 frag_size;	/* size of the frag. */
+	__u32 frag_token;	/* token representing this frag for
+				 * DEVMEM_DONTNEED.
+				 */
+	__u32  dmabuf_id;	/* dmabuf id this frag belongs to. */
+	__u32 flags;		/* Currently unused. Reserved for future
+				 * uses.
+				 */
+};
+
 /*
  *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
  */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9548fedf7966..d3e4ddecc537 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -462,6 +462,7 @@ void tcp_init_sock(struct sock *sk)
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
+	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
 }
 EXPORT_SYMBOL(tcp_init_sock);
 
@@ -2313,6 +2314,213 @@ static int tcp_inq_hint(struct sock *sk)
 	return inq;
 }
 
+/* batch __xa_alloc() calls and reduce xa_lock()/xa_unlock() overhead. */
+struct tcp_xa_pool {
+	u8		max; /* max <= MAX_SKB_FRAGS */
+	u8		idx; /* idx <= max */
+	__u32		tokens[MAX_SKB_FRAGS];
+	netmem_ref	netmems[MAX_SKB_FRAGS];
+};
+
+static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p,
+			       bool lock)
+{
+	int i;
+
+	if (!p->max)
+		return;
+	if (lock)
+		xa_lock_bh(&sk->sk_user_frags);
+	/* Commit part that has been copied to user space. */
+	for (i = 0; i < p->idx; i++)
+		__xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_ENTRY,
+			     (__force void *)p->netmems[i], GFP_KERNEL);
+	/* Rollback what has been pre-allocated and is no longer needed. */
+	for (; i < p->max; i++)
+		__xa_erase(&sk->sk_user_frags, p->tokens[i]);
+	if (lock)
+		xa_unlock_bh(&sk->sk_user_frags);
+	p->max = 0;
+	p->idx = 0;
+}
+
+static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
+			      unsigned int max_frags)
+{
+	int err, k;
+
+	if (p->idx < p->max)
+		return 0;
+
+	xa_lock_bh(&sk->sk_user_frags);
+
+	tcp_xa_pool_commit(sk, p, false);
+	for (k = 0; k < max_frags; k++) {
+		err = __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
+				 XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL);
+		if (err)
+			break;
+	}
+
+	xa_unlock_bh(&sk->sk_user_frags);
+
+	p->max = k;
+	p->idx = 0;
+	return k ? 0 : err;
+}
+
+/* On error, returns the -errno. On success, returns number of bytes sent to the
+ * user. May not consume all of @remaining_len.
+ */
+static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
+			      unsigned int offset, struct msghdr *msg,
+			      int remaining_len)
+{
+	struct dmabuf_cmsg dmabuf_cmsg = { 0 };
+	struct tcp_xa_pool tcp_xa_pool;
+	unsigned int start;
+	int i, copy, n;
+	int sent = 0;
+	int err = 0;
+
+	tcp_xa_pool.max = 0;
+	tcp_xa_pool.idx = 0;
+	do {
+		start = skb_headlen(skb);
+
+		if (skb->readable) {
+			err = -ENODEV;
+			goto out;
+		}
+
+		/* Copy header. */
+		copy = start - offset;
+		if (copy > 0) {
+			copy = min(copy, remaining_len);
+
+			n = copy_to_iter(skb->data + offset, copy,
+					 &msg->msg_iter);
+			if (n != copy) {
+				err = -EFAULT;
+				goto out;
+			}
+
+			offset += copy;
+			remaining_len -= copy;
+
+			/* First a dmabuf_cmsg for # bytes copied to user
+			 * buffer.
+			 */
+			memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
+			dmabuf_cmsg.frag_size = copy;
+			err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEAR,
+				       sizeof(dmabuf_cmsg), &dmabuf_cmsg);
+			if (err || msg->msg_flags & MSG_CTRUNC) {
+				msg->msg_flags &= ~MSG_CTRUNC;
+				if (!err)
+					err = -ETOOSMALL;
+				goto out;
+			}
+
+			sent += copy;
+
+			if (remaining_len == 0)
+				goto out;
+		}
+
+		/* after that, send information of dmabuf pages through a
+		 * sequence of cmsg
+		 */
+		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			struct net_iov *niov;
+			u64 frag_offset;
+			int end;
+
+			/* !skb->readable should indicate that ALL the frags in
+			 * this skb are dmabuf net_iovs. We're checking
+			 * for that flag above, but also check individual frags
+			 * here. If the tcp stack is not setting skb->readable
+			 * correctly, we still don't want to crash here when
+			 * accessing pgmap or priv below.
+			 */
+			if (!skb_frag_net_iov(frag)) {
+				net_err_ratelimited("Found non-dmabuf skb with net_iov");
+				err = -ENODEV;
+				goto out;
+			}
+
+			niov = skb_frag_net_iov(frag);
+			end = start + skb_frag_size(frag);
+			copy = end - offset;
+
+			if (copy > 0) {
+				copy = min(copy, remaining_len);
+
+				frag_offset = net_iov_virtual_addr(niov) +
+					      skb_frag_off(frag) + offset -
+					      start;
+				dmabuf_cmsg.frag_offset = frag_offset;
+				dmabuf_cmsg.frag_size = copy;
+				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
+							 skb_shinfo(skb)->nr_frags - i);
+				if (err)
+					goto out;
+
+				/* Will perform the exchange later */
+				dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
+				dmabuf_cmsg.dmabuf_id = net_iov_binding_id(niov);
+
+				offset += copy;
+				remaining_len -= copy;
+
+				err = put_cmsg(msg, SOL_SOCKET,
+					       SO_DEVMEM_DMABUF,
+					       sizeof(dmabuf_cmsg),
+					       &dmabuf_cmsg);
+				if (err || msg->msg_flags & MSG_CTRUNC) {
+					msg->msg_flags &= ~MSG_CTRUNC;
+					if (!err)
+						err = -ETOOSMALL;
+					goto out;
+				}
+
+				atomic_long_inc(&niov->pp_ref_count);
+				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+
+				sent += copy;
+
+				if (remaining_len == 0)
+					goto out;
+			}
+			start = end;
+		}
+
+		tcp_xa_pool_commit(sk, &tcp_xa_pool, true);
+		if (!remaining_len)
+			goto out;
+
+		/* if remaining_len is not satisfied yet, we need to go to the
+		 * next frag in the frag_list to satisfy remaining_len.
+		 */
+		skb = skb_shinfo(skb)->frag_list ?: skb->next;
+
+		offset = offset - start;
+	} while (skb);
+
+	if (remaining_len) {
+		err = -EFAULT;
+		goto out;
+	}
+
+out:
+	tcp_xa_pool_commit(sk, &tcp_xa_pool, true);
+	if (!sent)
+		sent = err;
+
+	return sent;
+}
+
 /*
  *	This routine copies from a sock struct into the user buffer.
  *
@@ -2326,6 +2534,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			      int *cmsg_flags)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	int last_copied_dmabuf = -1; /* uninitialized */
 	int copied = 0;
 	u32 peek_seq;
 	u32 *seq;
@@ -2503,15 +2712,44 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		if (!(flags & MSG_TRUNC)) {
-			err = skb_copy_datagram_msg(skb, offset, msg, used);
-			if (err) {
-				/* Exception. Bailout! */
-				if (!copied)
-					copied = -EFAULT;
+			if (last_copied_dmabuf != -1 &&
+			    last_copied_dmabuf != !skb->readable)
 				break;
+
+			if (skb->readable) {
+				err = skb_copy_datagram_msg(skb, offset, msg,
+							    used);
+				if (err) {
+					/* Exception. Bailout! */
+					if (!copied)
+						copied = -EFAULT;
+					break;
+				}
+			} else {
+				if (!(flags & MSG_SOCK_DEVMEM)) {
+					/* dmabuf skbs can only be received
+					 * with the MSG_SOCK_DEVMEM flag.
+					 */
+					if (!copied)
+						copied = -EFAULT;
+
+					break;
+				}
+
+				err = tcp_recvmsg_dmabuf(sk, skb, offset, msg,
+							 used);
+				if (err <= 0) {
+					if (!copied)
+						copied = -EFAULT;
+
+					break;
+				}
+				used = err;
 			}
 		}
 
+		last_copied_dmabuf = !skb->readable;
+
 		WRITE_ONCE(*seq, *seq + used);
 		copied += used;
 		len -= used;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1e0a9762f92e..1d82bffe959c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2498,6 +2498,15 @@ static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
 void tcp_v4_destroy_sock(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	__maybe_unused unsigned long index;
+	__maybe_unused void *netmem;
+
+#ifdef CONFIG_PAGE_POOL
+	xa_for_each(&sk->sk_user_frags, index, netmem)
+		WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem, false));
+#endif
+
+	xa_destroy(&sk->sk_user_frags);
 
 	trace_tcp_destroy_sock(sk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 5b21a07ddf9a..a4c398c25572 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -625,6 +625,8 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
 
+	xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
+
 	return newsk;
 }
 EXPORT_SYMBOL(tcp_create_openreq_child);
-- 
2.44.0.478.gd926399ef9-goog


