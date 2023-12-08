Return-Path: <linux-arch+bounces-767-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499D8097F9
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 01:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179561F21337
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 00:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851A3210D;
	Fri,  8 Dec 2023 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q95z+wyk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A21988
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 16:53:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db084a0a2e9so1907663276.2
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996789; x=1702601589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdsQlA52rmqBL7OXbh7npWQi67Syf8S/UwksNo2UDhs=;
        b=q95z+wyk4H31xzCDd2pjmnTHHhFDhyJRKmdJ59urvQwlbJlWHRMLKw1kdiGNp8Dplp
         pdgZF2KZZf1mSoDEH9v+iSK7zkalHdgB7c8SDCI3LvY3RZP6jzvSnmteLY4DXOXGU4h+
         uMyyFz1mwB8H05lV/zqEauumoXhvaEWLEkVmsdICX7e2oHFSHySbsvXO3Z3pNjD5Uww3
         mYpRE2V/fkzJ/hnfYi2oWBnnPHNIfkGa8HxPhaJGbvFYZO5L8Dfc8O75E6yc+6yqwdH7
         iHGapPKuvH2M8YrXT9T/WA9TGGkxNvM7UFnIEwLgeEV1Ir4o1bpsh+nKq9geSemdJ/rz
         UR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996789; x=1702601589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdsQlA52rmqBL7OXbh7npWQi67Syf8S/UwksNo2UDhs=;
        b=bz34k1TG0cT/o8TiUjFAN0vTmfQKjPpJ0ULK3yrSMB7moilWtax2GyLAK9E0rmkCt/
         F8PBgLZdOqqKRVlLEpQQiXRRziK0PO2rUlHaMc38yHegxO9N6u1ErTZ3sJFeRnk/+hr1
         hu02GMeRqhZ7VPc4++WB9V4W4fmCiYj5G4wljPCAUSH2idl49+8msDTy05rPCETxxPSa
         J6ARD+W0VAuDA4ekR6XJHpXjlNhdKDD/yjXMyuCtwbR1NOl75vwteCr0Xt9ZQvt9XMGB
         +0sJUZdCHHuoOiXsHGJJhyUI4y/ztbqJBaKLwhbh2px3QaF3CIcq0S8qe2Nqpw7hxluc
         +B5w==
X-Gm-Message-State: AOJu0YwaATZtJBoEZUO4+FE+pllu3RNy5Rsq6V1USc5yt3gaTi6a/0Cu
	07uqqj7gfvrZuMVZipvitF9EQNptsG5lK6hI3Q==
X-Google-Smtp-Source: AGHT+IH/gfYr5EUfMzd/NX+8vXC/GoT0BalxzSTTls31g4lmQqKZy/8eIFEENuQk1BoM56tiXZ2me83KTuMQvZ3iJQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a25:7690:0:b0:db4:6936:48b7 with SMTP
 id r138-20020a257690000000b00db4693648b7mr52142ybc.2.1701996789635; Thu, 07
 Dec 2023 16:53:09 -0800 (PST)
Date: Thu,  7 Dec 2023 16:52:38 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-8-almasrymina@google.com>
Subject: [net-next v1 07/16] netdev: netdevice devmem allocator
From: Mina Almasry <almasrymina@google.com>
To: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement netdev devmem allocator. The allocator takes a given struct
netdev_dmabuf_binding as input and allocates page_pool_iov from that
binding.

The allocation simply delegates to the binding's genpool for the
allocation logic and wraps the returned memory region in a page_pool_iov
struct.

page_pool_iov are refcounted and are freed back to the binding when the
refcount drops to 0.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v1:
- Rename devmem -> dmabuf (David).

---
 include/net/devmem.h            | 13 ++++++++++++
 include/net/page_pool/helpers.h | 28 +++++++++++++++++++++++++
 net/core/dev.c                  | 37 ++++++++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/net/devmem.h b/include/net/devmem.h
index 29ff125f9815..29bc337c7743 100644
--- a/include/net/devmem.h
+++ b/include/net/devmem.h
@@ -48,6 +48,9 @@ struct netdev_dmabuf_binding {
 };
 
 #ifdef CONFIG_DMA_SHARED_BUFFER
+struct page_pool_iov *
+netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding);
+void netdev_free_dmabuf(struct page_pool_iov *ppiov);
 void __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		       struct netdev_dmabuf_binding **out);
@@ -55,6 +58,16 @@ void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding);
 int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				struct netdev_dmabuf_binding *binding);
 #else
+static inline struct page_pool_iov *
+netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding)
+{
+	return NULL;
+}
+
+static inline void netdev_free_dmabuf(struct page_pool_iov *ppiov)
+{
+}
+
 static inline void
 __netdev_dmabuf_binding_free(struct netdev_dmabuf_binding *binding)
 {
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 7dc65774cde5..8bfc2d43efd4 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -79,6 +79,34 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 }
 #endif
 
+/* page_pool_iov support */
+
+static inline struct dmabuf_genpool_chunk_owner *
+page_pool_iov_owner(const struct page_pool_iov *ppiov)
+{
+	return ppiov->owner;
+}
+
+static inline unsigned int page_pool_iov_idx(const struct page_pool_iov *ppiov)
+{
+	return ppiov - page_pool_iov_owner(ppiov)->ppiovs;
+}
+
+static inline dma_addr_t
+page_pool_iov_dma_addr(const struct page_pool_iov *ppiov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = page_pool_iov_owner(ppiov);
+
+	return owner->base_dma_addr +
+	       ((dma_addr_t)page_pool_iov_idx(ppiov) << PAGE_SHIFT);
+}
+
+static inline struct netdev_dmabuf_binding *
+page_pool_iov_binding(const struct page_pool_iov *ppiov)
+{
+	return page_pool_iov_owner(ppiov)->binding;
+}
+
 /**
  * page_pool_dev_alloc_pages() - allocate a page.
  * @pool:	pool from which to allocate
diff --git a/net/core/dev.c b/net/core/dev.c
index b8c8be5a912e..30667e4c3b95 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -155,8 +155,8 @@
 #include <net/netdev_rx_queue.h>
 #include <linux/genalloc.h>
 #include <linux/dma-buf.h>
-#include <net/page_pool/types.h>
 #include <net/devmem.h>
+#include <net/page_pool/helpers.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -2120,6 +2120,41 @@ static int netdev_restart_rx_queue(struct net_device *dev, int rxq_idx)
 	return err;
 }
 
+struct page_pool_iov *netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding)
+{
+	struct dmabuf_genpool_chunk_owner *owner;
+	struct page_pool_iov *ppiov;
+	unsigned long dma_addr;
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
+	ppiov = &owner->ppiovs[index];
+
+	netdev_dmabuf_binding_get(binding);
+
+	return ppiov;
+}
+
+void netdev_free_dmabuf(struct page_pool_iov *ppiov)
+{
+	struct netdev_dmabuf_binding *binding = page_pool_iov_binding(ppiov);
+	unsigned long dma_addr = page_pool_iov_dma_addr(ppiov);
+
+	refcount_set(&ppiov->refcount, 1);
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


