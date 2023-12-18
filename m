Return-Path: <linux-arch+bounces-1109-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C5816492
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 03:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2551F21F84
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 02:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE2F9CD;
	Mon, 18 Dec 2023 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lIpbQZcf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD2D537
	for <linux-arch@vger.kernel.org>; Mon, 18 Dec 2023 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5caf61210e3so24217517b3.0
        for <linux-arch@vger.kernel.org>; Sun, 17 Dec 2023 18:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702867239; x=1703472039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G5EYHEqOKeBIt6a6HG2bP5krFWMMN/+OHgJTydxcJRs=;
        b=lIpbQZcfuqP3JtQ401jtG4I3k87ZCKgaW15mU6wFw+45qGNLTPweH0v5X2a9yQgEEm
         RPSuUpkmAPz/6yf0DEuEUHCaWWBWk5y/8bLF7hvDswQPQBxo3mjuAiEt6B5cddvflN10
         JODtQuJwoqODrN9hwR8vEIiL9uGgxPG8mZhEJcGxAzxs3oU/uaOFmax/Kt7uT7bEj2nh
         8Aq0MqPrZTNtpCnFVhDtIMY/qIodsj6Ze5TjqyOCky7AkBDZUAGmujLSFLF5WBzJkKxD
         StooB142ipw2GENTpmuY9NCcHCFQqb5j2kyZCTCcijDYDMs8ZfaM8XuofZsgpWnmfo3+
         Dcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867239; x=1703472039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5EYHEqOKeBIt6a6HG2bP5krFWMMN/+OHgJTydxcJRs=;
        b=e6ZOs7TzjxEQ8aajs5PRiYKc2E7snQwsvHWMXjq3RdgZURxzr4yQR1lAUVUnXXEzIp
         3uLLStTvXKQFzixi4wdMNN13lBit79tws0E22oe0fGwdv/7Ut3HvrQkun1rLJkAxWUDT
         GtVCtB6neZjyq+yO/xy6M4p3x+IYuAO/oswAI3kRzQXu2GI0xcaKYW8Jmu98W/A5cjAl
         /Y5t/s7YyzGlFZB3BdlBOHHkucPQhnLfiAhcFrkMjQ9yUyGSU0D8SmW0/SGXi5uLBT6a
         TVZeJDAx42pvaz+UpzfruQePdrZRfsdj7UlrAa2Ke4OW1Wb92/oWSS3GE4pK1yFTERRV
         8/ag==
X-Gm-Message-State: AOJu0YxVLtnnDyoId5IhxmhuD+oc6XuibAqVhCtdHzZ/+1Z5VoQAqeDi
	h3FkwiGE59/qYIUwwGXsMue4uQok8fW8I4o3sQ==
X-Google-Smtp-Source: AGHT+IGjcfEevp++Pd2H3pj+I2hiqHNx52lPAjqohjA2+exixRnO7jGoi61uq7cn0OD2rKiPydADTKL/EYRx+QoP2A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:5cbf:3534:fb34:758e])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:338f:b0:5e3:b47a:2912 with
 SMTP id fl15-20020a05690c338f00b005e3b47a2912mr1365708ywb.6.1702867239583;
 Sun, 17 Dec 2023 18:40:39 -0800 (PST)
Date: Sun, 17 Dec 2023 18:40:12 -0800
In-Reply-To: <20231218024024.3516870-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218024024.3516870-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218024024.3516870-6-almasrymina@google.com>
Subject: [RFC PATCH net-next v5 05/14] netdev: netdevice devmem allocator
From: Mina Almasry <almasrymina@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement netdev devmem allocator. The allocator takes a given struct
netdev_dmabuf_binding as input and allocates net_iov from that
binding.

The allocation simply delegates to the binding's genpool for the
allocation logic and wraps the returned memory region in a net_iov
struct.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v1:
- Rename devmem -> dmabuf (David).

---
 include/net/devmem.h | 12 ++++++++++++
 include/net/netmem.h | 26 ++++++++++++++++++++++++++
 net/core/dev.c       | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/include/net/devmem.h b/include/net/devmem.h
index 85ccbbe84c65..4207adadc2bb 100644
--- a/include/net/devmem.h
+++ b/include/net/devmem.h
@@ -67,6 +67,8 @@ struct dmabuf_genpool_chunk_owner {
 };
 
 #ifdef CONFIG_DMA_SHARED_BUFFER
+struct net_iov *netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding);
+void netdev_free_dmabuf(struct net_iov *ppiov);
 void __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		       struct netdev_dmabuf_binding **out);
@@ -74,6 +76,16 @@ void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				struct netdev_dmabuf_binding *binding);
 #else
+static inline struct net_iov *
+netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding)
+{
+	return NULL;
+}
+
+static inline void netdev_free_dmabuf(struct net_iov *ppiov)
+{
+}
+
 static inline void
 __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding)
 {
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 45eb42d9990b..7fce2efc8707 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -14,8 +14,34 @@
 
 struct net_iov {
 	struct dmabuf_genpool_chunk_owner *owner;
+	unsigned long dma_addr;
 };
 
+static inline struct dmabuf_genpool_chunk_owner *
+net_iov_owner(const struct net_iov *niov)
+{
+	return niov->owner;
+}
+
+static inline unsigned int net_iov_idx(const struct net_iov *niov)
+{
+	return niov - net_iov_owner(niov)->niovs;
+}
+
+static inline dma_addr_t net_iov_dma_addr(const struct net_iov *niov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
+
+	return owner->base_dma_addr +
+	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
+}
+
+static inline struct netdev_dmabuf_binding *
+net_iov_binding(const struct net_iov *niov)
+{
+	return net_iov_owner(niov)->binding;
+}
+
 /* netmem */
 
 struct netmem {
diff --git a/net/core/dev.c b/net/core/dev.c
index 2e474099267a..20ba528ef426 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2119,6 +2119,44 @@ static int netdev_restart_rx_queue(struct net_device *dev, int rxq_idx)
 	return err;
 }
 
+struct net_iov *netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding)
+{
+	struct dmabuf_genpool_chunk_owner *owner;
+	unsigned long dma_addr;
+	struct net_iov *niov;
+	ssize_t offset;
+	ssize_t index;
+
+	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
+					(void **)&owner);
+	if (!dma_addr)
+		return NULL;
+
+	offset = dma_addr - owner->base_dma_addr;
+	index = offset / PAGE_SIZE;
+	niov = &owner->niovs[index];
+
+	niov->pp_magic = 0;
+	niov->pp = NULL;
+	niov->dma_addr = 0;
+	atomic_long_set(&niov->pp_ref_count, 0);
+
+	netdev_dmabuf_binding_get(binding);
+
+	return niov;
+}
+
+void netdev_free_dmabuf(struct net_iov *niov)
+{
+	struct netdev_dmabuf_binding *binding = net_iov_binding(niov);
+	unsigned long dma_addr = net_iov_dma_addr(niov);
+
+	if (gen_pool_has_addr(binding->chunk_pool, dma_addr, PAGE_SIZE))
+		gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
+
+	netdev_dmabuf_binding_put(binding);
+}
+
 /* Protected by rtnl_lock() */
 static DEFINE_XARRAY_FLAGS(netdev_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
-- 
2.43.0.472.g3155946c3a-goog


