Return-Path: <linux-arch+bounces-1112-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DEF8164B3
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 03:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58AB41C220FB
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 02:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53EA1172D;
	Mon, 18 Dec 2023 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+qsBgna"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C510960
	for <linux-arch@vger.kernel.org>; Mon, 18 Dec 2023 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ddd64f83a4so18345797b3.0
        for <linux-arch@vger.kernel.org>; Sun, 17 Dec 2023 18:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702867246; x=1703472046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NYFi1E6S6T+SKvDHn8CGr+ocURXqvLv0Q7fBvZhwls=;
        b=Z+qsBgnasuuxs3iuFAJbsGsQM374fDMR0brqLTKWKFjaapuFgPqvOJ0VkuOnjkiNfX
         6LpdsXSZBslq2OPcwfyAML+csPOy6XU0ZnrmrJrwPO5Jvt0jLzBd+f1Cu6Ba0/fgjgaw
         6YO+kc/UtGdAhdDmlYS/ga7tGrCzi88z+PGLaUcOkbadMzBGrfJe2bUb8Wsa8vUb+9zl
         6S8MTKmFSMxOAarfMqgq7oXguACYEy2coXygqCLjE8sKppdvygbjdygh4H/dehOT3UMB
         TUA4SRoD7uE3e7iAIXj/byARQa+xlQNUe/m7cqlme/tKauksrlu79KBLP4QTxe31JsmO
         oIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867246; x=1703472046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NYFi1E6S6T+SKvDHn8CGr+ocURXqvLv0Q7fBvZhwls=;
        b=sNOXu8DA0kLKI6IwkIflDBu9R/s2OHoCKgjQ0dOfT2NVJxC2boGe+rTj4smbLVZtQ1
         /BDJFqJGY97TCa0B6B4MRqrF0aDQrUQwZJWrlpop3+tRYeCFuiD9WxBaIwQIffNETfZT
         1gUR+xl/vsMj0Srmh1jhNLopsyAb7WGCQamj0epquDGVkvtnUBQSf1NTUgsxmMk1bt/A
         uvq8IZeWgAIDmQBtFrDatrWfVNgivqyBq24LqzBF/y0xckQ66rDt+dySy84/JHnXjx9Z
         DqHUtTMWc2gH/hcyVmongrbcGAwYANSYHNurM7KOikF720TjsjN5OfBXzDqzatvcRjf2
         L3wA==
X-Gm-Message-State: AOJu0YzfiZoXktEeCnceyxpMw+DK/a/Lfw3YMT6n6kaSdwjcJEq4CwHl
	QTvlgsCTlTREBPAVA6SiI2Mv8PNIPdHv00a9TQ==
X-Google-Smtp-Source: AGHT+IE2XSqfv2CUNqqU64sA1WFOtidasTRZ6basBPuVSba7XJNyOKLZqJ4mltH4ukBLFHqO73jJyF5cXDhkelwyAw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:5cbf:3534:fb34:758e])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:1e:b0:5d7:545e:3bd0 with SMTP
 id bc30-20020a05690c001e00b005d7545e3bd0mr1609684ywb.4.1702867246059; Sun, 17
 Dec 2023 18:40:46 -0800 (PST)
Date: Sun, 17 Dec 2023 18:40:15 -0800
In-Reply-To: <20231218024024.3516870-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218024024.3516870-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218024024.3516870-9-almasrymina@google.com>
Subject: [RFC PATCH net-next v5 08/14] memory-provider: dmabuf devmem memory provider
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

Implement a memory provider that allocates dmabuf devmem in the form of
net_iov.

The provider receives a reference to the struct netdev_dmabuf_binding
via the pool->mp_priv pointer. The driver needs to set this pointer for
the provider in the net_iov.

The provider obtains a reference on the netdev_dmabuf_binding which
guarantees the binding and the underlying mapping remains alive until
the provider is destroyed.

Usage of PP_FLAG_DMA_MAP is required for this memory provide such that
the page_pool can provide the driver with the dma-addrs of the devmem.

Support for PP_FLAG_DMA_SYNC_DEV is omitted for simplicity & p.order !=
0.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:
- Disable devmem for p.order != 0

v1:
- static_branch check in page_is_page_pool_iov() (Willem & Paolo).
- PP_DEVMEM -> PP_IOV (David).
- Require PP_FLAG_DMA_MAP (Jakub).


memory provider

---
 include/net/netmem.h          | 14 ++++++
 include/net/page_pool/types.h |  2 +
 net/core/page_pool.c          | 93 +++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 7557aecc0f78..ab3824b7b789 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -97,6 +97,20 @@ static inline bool netmem_is_net_iov(const struct netmem *netmem)
 #endif
 }
 
+static inline struct net_iov *netmem_to_net_iov(struct netmem *netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return (struct net_iov *)((unsigned long)netmem & ~NET_IOV);
+
+	DEBUG_NET_WARN_ON_ONCE(true);
+	return NULL;
+}
+
+static inline struct netmem *net_iov_to_netmem(struct net_iov *niov)
+{
+	return (struct netmem *)((unsigned long)niov | NET_IOV);
+}
+
 static inline struct page *netmem_to_page(struct netmem *netmem)
 {
 	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 433ae9ae658b..3ddef7d7ba74 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -134,6 +134,8 @@ struct memory_provider_ops {
 	bool (*release_page)(struct page_pool *pool, struct netmem *netmem);
 };
 
+extern const struct memory_provider_ops dmabuf_devmem_ops;
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 173158a3dd61..231840112956 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -12,6 +12,7 @@
 
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
+#include <net/netdev_rx_queue.h>
 
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -20,12 +21,15 @@
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/genalloc.h>
+#include <net/devmem.h>
 
 #include <trace/events/page_pool.h>
 
 #include "page_pool_priv.h"
 
 DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+EXPORT_SYMBOL(page_pool_mem_providers);
 
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
@@ -175,6 +179,7 @@ static void page_pool_producer_unlock(struct page_pool *pool,
 static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
+	struct netdev_dmabuf_binding *binding = NULL;
 	unsigned int ring_qsize = 1024; /* Default */
 	int err;
 
@@ -237,6 +242,14 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
+	if (pool->p.queue)
+		binding = READ_ONCE(pool->p.queue->binding);
+
+	if (binding) {
+		pool->mp_ops = &dmabuf_devmem_ops;
+		pool->mp_priv = binding;
+	}
+
 	if (pool->mp_ops) {
 		err = pool->mp_ops->init(pool);
 		if (err) {
@@ -1055,3 +1068,83 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
+
+/*** "Dmabuf devmem memory provider" ***/
+
+static int mp_dmabuf_devmem_init(struct page_pool *pool)
+{
+	struct netdev_dmabuf_binding *binding = pool->mp_priv;
+
+	if (!binding)
+		return -EINVAL;
+
+	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
+		return -EOPNOTSUPP;
+
+	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		return -EOPNOTSUPP;
+
+	if (pool->p.order != 0)
+		return -E2BIG;
+
+	netdev_dmabuf_binding_get(binding);
+	return 0;
+}
+
+static struct netmem *mp_dmabuf_devmem_alloc_pages(struct page_pool *pool,
+						   gfp_t gfp)
+{
+	struct netdev_dmabuf_binding *binding = pool->mp_priv;
+	struct netmem *netmem;
+	struct net_iov *niov;
+	dma_addr_t dma_addr;
+
+	niov = netdev_alloc_dmabuf(binding);
+	if (!niov)
+		return NULL;
+
+	dma_addr = net_iov_dma_addr(niov);
+
+	netmem = net_iov_to_netmem(niov);
+
+	page_pool_set_pp_info(pool, netmem);
+
+	if (page_pool_set_dma_addr_netmem(netmem, dma_addr))
+		goto err_free;
+
+	pool->pages_state_hold_cnt++;
+	trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt);
+	return netmem;
+
+err_free:
+	netdev_free_dmabuf(niov);
+	return NULL;
+}
+
+static void mp_dmabuf_devmem_destroy(struct page_pool *pool)
+{
+	struct netdev_dmabuf_binding *binding = pool->mp_priv;
+
+	netdev_dmabuf_binding_put(binding);
+}
+
+static bool mp_dmabuf_devmem_release_page(struct page_pool *pool,
+					  struct netmem *netmem)
+{
+	WARN_ON_ONCE(!netmem_is_net_iov(netmem));
+
+	page_pool_clear_pp_info(netmem);
+
+	netdev_free_dmabuf(netmem_to_net_iov(netmem));
+
+	/* We don't want the page pool put_page()ing our net_iovs. */
+	return false;
+}
+
+const struct memory_provider_ops dmabuf_devmem_ops = {
+	.init			= mp_dmabuf_devmem_init,
+	.destroy		= mp_dmabuf_devmem_destroy,
+	.alloc_pages		= mp_dmabuf_devmem_alloc_pages,
+	.release_page		= mp_dmabuf_devmem_release_page,
+};
+EXPORT_SYMBOL(dmabuf_devmem_ops);
-- 
2.43.0.472.g3155946c3a-goog


