Return-Path: <linux-arch+bounces-1111-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A93A8164A4
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 03:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42439282A65
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 02:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F611193;
	Mon, 18 Dec 2023 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyYSQKtF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6483107B0
	for <linux-arch@vger.kernel.org>; Mon, 18 Dec 2023 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e33a2f0cacso33240237b3.0
        for <linux-arch@vger.kernel.org>; Sun, 17 Dec 2023 18:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702867244; x=1703472044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WAQl5To9gZeZg04k9RKne/w/YD27VjCykmzukQziJw=;
        b=tyYSQKtFvQdhDHZLHoEzB3ycseBxonirtAkhvU/6OPGVIbufpFocrSGO7mITr0wpYn
         m2q6ANbgfK/z+q4iLC/ZaqJJJvHzCGwPA099qzhudTNTdgqew1EsySqUt5PU7MS/2mwF
         gUMn3Wq/qNwSVOGYGwagskQR9kqwqxWnQqy4WfbNXtR89NpnNRiohxD+EhpsnOETaOKO
         JcFLOQsT4sX6pGJbGvsBsyELOrnLXVUak5nmY3wkHKzym6N91ER4ugZp2D57Xf2mTFBf
         jOhkneOq8CuyYil+9rutbfxDF5XxZ2L0fxh5W7k6F4a3GFnqKz2kWHIHmIDCnAvCSo9i
         wwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867244; x=1703472044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WAQl5To9gZeZg04k9RKne/w/YD27VjCykmzukQziJw=;
        b=l6o/lCKguO9zYEX7KrJkpNksFFXcxSeh2f59K6+EQzcQilYIlHXAEuz3f8hythD+1c
         DP4V8Yw4ZxzDciGQ4TJMaO6t4RvO+nNfh6X229cjsPJOqZQW6gRvbo9JNj2TZuJLx1xd
         yRjLl07U/L+QlDTfTaUhJ+pMVA27obwYmdUfhNYYWfUxAzLqL078+2M/0qGEOPqug4Sh
         cungrioubBa1RoGFcD8bFqmO/zo4HFdhFArXwKUSSkWbt6y1K01/CVHa87MV1eQbMXK/
         Lf3AEN2V8dxQet4fW4dwLmPhwwGrNpJ/gd5R/mB5uCZk3UgwmM262xMrhq604PQf4p7W
         lbIA==
X-Gm-Message-State: AOJu0Yw2KwAMn5zGY0QgXqJjgS4MovcaJCToy84F2WGi0T8O5DOw3tEy
	B2lDxEdKRHZsQ9+Aizpms+u6xlIRszgwNYB2tQ==
X-Google-Smtp-Source: AGHT+IG4o0/u6jj2sY6hzNxNgfbfFnoyYGxvTDtjSJ/2dwPgbKbqHO2CYUtpMHvNCCWNbCxCwZmFbwb+UJDWfwjhIw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:5cbf:3534:fb34:758e])
 (user=almasrymina job=sendgmr) by 2002:a5b:8c9:0:b0:dbc:decd:3c7d with SMTP
 id w9-20020a5b08c9000000b00dbcdecd3c7dmr1366927ybq.6.1702867244023; Sun, 17
 Dec 2023 18:40:44 -0800 (PST)
Date: Sun, 17 Dec 2023 18:40:14 -0800
In-Reply-To: <20231218024024.3516870-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218024024.3516870-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218024024.3516870-8-almasrymina@google.com>
Subject: [RFC PATCH net-next v5 07/14] page_pool: devmem support
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
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

Convert netmem to be a union of struct page and struct netmem. Overload
the LSB of struct netmem* to indicate that it's a net_iov, otherwise
it's a page.

Currently these entries in struct page are rented by the page_pool and
used exclusively by the net stack:

struct {
	unsigned long pp_magic;
	struct page_pool *pp;
	unsigned long _pp_mapping_pad;
	unsigned long dma_addr;
	atomic_long_t pp_ref_count;
};

Mirror these (and only these) entries into struct net_iov and implement
netmem helpers that can access these common fields regardless of
whether the underlying type is page or net_iov.

Implement checks for net_iov in netmem helpers which delegate to mm
APIs, to ensure net_iov are never passed to the mm stack.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

RFCv5:
- Use netmem instead of page* with LSB set.
- Use pp_ref_count for refcounting net_iov.
- Removed many of the custom checks for netmem.

v1:
- Disable fragmentation support for iov properly.
- fix napi_pp_put_page() path (Yunsheng).
- Use pp_frag_count for devmem refcounting.

---
 include/net/netmem.h            | 145 ++++++++++++++++++++++++++++++--
 include/net/page_pool/helpers.h |  25 +++---
 net/core/page_pool.c            |  26 +++---
 net/core/skbuff.c               |   9 +-
 4 files changed, 164 insertions(+), 41 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 31f338f19da0..7557aecc0f78 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -12,11 +12,47 @@
 
 /* net_iov */
 
+DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
+/*  We overload the LSB of the struct page pointer to indicate whether it's
+ *  a page or net_iov.
+ */
+#define NET_IOV 0x01UL
+
 struct net_iov {
+	unsigned long __unused_padding;
+	unsigned long pp_magic;
+	struct page_pool *pp;
 	struct dmabuf_genpool_chunk_owner *owner;
 	unsigned long dma_addr;
+	atomic_long_t pp_ref_count;
 };
 
+/* These fields in struct page are used by the page_pool and net stack:
+ *
+ *	struct {
+ *		unsigned long pp_magic;
+ *		struct page_pool *pp;
+ *		unsigned long _pp_mapping_pad;
+ *		unsigned long dma_addr;
+ *		atomic_long_t pp_ref_count;
+ *	};
+ *
+ * We mirror the page_pool fields here so the page_pool can access these fields
+ * without worrying whether the underlying fields belong to a page or net_iov.
+ *
+ * The non-net stack fields of struct page are private to the mm stack and must
+ * never be mirrored to net_iov.
+ */
+#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
+	static_assert(offsetof(struct page, pg) == \
+		      offsetof(struct net_iov, iov))
+NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
+NET_IOV_ASSERT_OFFSET(pp, pp);
+NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
+NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
+#undef NET_IOV_ASSERT_OFFSET
+
 static inline struct dmabuf_genpool_chunk_owner *
 net_iov_owner(const struct net_iov *niov)
 {
@@ -47,19 +83,25 @@ net_iov_binding(const struct net_iov *niov)
 struct netmem {
 	union {
 		struct page page;
-
-		/* Stub to prevent compiler implicitly converting from page*
-		 * to netmem_t* and vice versa.
-		 *
-		 * Other memory type(s) net stack would like to support
-		 * can be added to this union.
-		 */
-		void *addr;
+		struct net_iov niov;
 	};
 };
 
+static inline bool netmem_is_net_iov(const struct netmem *netmem)
+{
+#ifdef CONFIG_PAGE_POOL
+	return static_branch_unlikely(&page_pool_mem_providers) &&
+	       (unsigned long)netmem & NET_IOV;
+#else
+	return false;
+#endif
+}
+
 static inline struct page *netmem_to_page(struct netmem *netmem)
 {
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return NULL;
+
 	return &netmem->page;
 }
 
@@ -70,17 +112,104 @@ static inline struct netmem *page_to_netmem(struct page *page)
 
 static inline int netmem_ref_count(struct netmem *netmem)
 {
+	/* The non-pp refcount of netmem is always 1. On netmem, we only support
+	 * pp refcounting.
+	 */
+	if (netmem_is_net_iov(netmem))
+		return 1;
+
 	return page_ref_count(netmem_to_page(netmem));
 }
 
 static inline unsigned long netmem_to_pfn(struct netmem *netmem)
 {
+	if (netmem_is_net_iov(netmem))
+		return 0;
+
 	return page_to_pfn(netmem_to_page(netmem));
 }
 
+static inline struct net_iov *__netmem_clear_lsb(struct netmem *netmem)
+{
+	return (struct net_iov *)((unsigned long)netmem & ~NET_IOV);
+}
+
+static inline unsigned long netmem_get_pp_magic(struct netmem *netmem)
+{
+	return __netmem_clear_lsb(netmem)->pp_magic;
+}
+
+static inline void netmem_or_pp_magic(struct netmem *netmem,
+				      unsigned long pp_magic)
+{
+	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
+}
+
+static inline void netmem_clear_pp_magic(struct netmem *netmem)
+{
+	__netmem_clear_lsb(netmem)->pp_magic = 0;
+}
+
+static inline struct page_pool *netmem_get_pp(struct netmem *netmem)
+{
+	return __netmem_clear_lsb(netmem)->pp;
+}
+
+static inline void netmem_set_pp(struct netmem *netmem, struct page_pool *pool)
+{
+	__netmem_clear_lsb(netmem)->pp = pool;
+}
+
+static inline unsigned long netmem_get_dma_addr(struct netmem *netmem)
+{
+	return __netmem_clear_lsb(netmem)->dma_addr;
+}
+
+static inline void netmem_set_dma_addr(struct netmem *netmem,
+				       unsigned long dma_addr)
+{
+	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
+}
+
+static inline atomic_long_t *netmem_get_pp_ref_count_ref(struct netmem *netmem)
+{
+	return &__netmem_clear_lsb(netmem)->pp_ref_count;
+}
+
+static inline bool netmem_is_pref_nid(struct netmem *netmem, int pref_nid)
+{
+	/* Assume net_iov are on the preferred node without actually
+	 * checking...
+	 *
+	 * This check is only used to check for recycling memory in the page
+	 * pool's fast paths. Currently the only implementation of net_iov
+	 * is dmabuf device memory. It's a deliberate decision by the user to
+	 * bind a certain dmabuf to a certain netdev, and the netdev rx queue
+	 * would not be able to reallocate memory from another dmabuf that
+	 * exists on the preferred node, so, this check doesn't make much sense
+	 * in this case. Assume all net_iovs can be recycled for now.
+	 */
+	if (netmem_is_net_iov(netmem))
+		return true;
+
+	return page_to_nid(netmem_to_page(netmem)) == pref_nid;
+}
+
 static inline struct netmem *netmem_compound_head(struct netmem *netmem)
 {
+	/* niov are never compounded */
+	if (netmem_is_net_iov(netmem))
+		return netmem;
+
 	return page_to_netmem(compound_head(netmem_to_page(netmem)));
 }
 
+static inline void *netmem_address(struct netmem *netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return NULL;
+
+	return page_address(netmem_to_page(netmem));
+}
+
 #endif /* _NET_NETMEM_H */
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index c71969279284..8827518379a8 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -215,7 +215,7 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
 
 static inline void page_pool_fragment_netmem(struct netmem *netmem, long nr)
 {
-	atomic_long_set(&netmem_to_page(netmem)->pp_ref_count, nr);
+	atomic_long_set(netmem_get_pp_ref_count_ref(netmem), nr);
 }
 
 /**
@@ -243,7 +243,7 @@ static inline void page_pool_fragment_page(struct page *page, long nr)
 
 static inline long page_pool_unref_netmem(struct netmem *netmem, long nr)
 {
-	struct page *page = netmem_to_page(netmem);
+	atomic_long_t *pp_ref_count = netmem_get_pp_ref_count_ref(netmem);
 	long ret;
 
 	/* If nr == pp_ref_count then we have cleared all remaining
@@ -260,19 +260,19 @@ static inline long page_pool_unref_netmem(struct netmem *netmem, long nr)
 	 * initially, and only overwrite it when the page is partitioned into
 	 * more than one piece.
 	 */
-	if (atomic_long_read(&page->pp_ref_count) == nr) {
+	if (atomic_long_read(pp_ref_count) == nr) {
 		/* As we have ensured nr is always one for constant case using
 		 * the BUILD_BUG_ON(), only need to handle the non-constant case
 		 * here for pp_ref_count draining, which is a rare case.
 		 */
 		BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
 		if (!__builtin_constant_p(nr))
-			atomic_long_set(&page->pp_ref_count, 1);
+			atomic_long_set(pp_ref_count, 1);
 
 		return 0;
 	}
 
-	ret = atomic_long_sub_return(nr, &page->pp_ref_count);
+	ret = atomic_long_sub_return(nr, pp_ref_count);
 	WARN_ON(ret < 0);
 
 	/* We are the last user here too, reset pp_ref_count back to 1 to
@@ -281,7 +281,7 @@ static inline long page_pool_unref_netmem(struct netmem *netmem, long nr)
 	 * page_pool_unref_page() currently.
 	 */
 	if (unlikely(!ret))
-		atomic_long_set(&page->pp_ref_count, 1);
+		atomic_long_set(pp_ref_count, 1);
 
 	return ret;
 }
@@ -391,9 +391,7 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
 
 static inline dma_addr_t page_pool_get_dma_addr_netmem(struct netmem *netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	dma_addr_t ret = page->dma_addr;
+	dma_addr_t ret = netmem_get_dma_addr(netmem);
 
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
 		ret <<= PAGE_SHIFT;
@@ -416,18 +414,17 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
 static inline bool page_pool_set_dma_addr_netmem(struct netmem *netmem,
 						 dma_addr_t addr)
 {
-	struct page *page = netmem_to_page(netmem);
-
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
-		page->dma_addr = addr >> PAGE_SHIFT;
+		netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);
 
 		/* We assume page alignment to shave off bottom bits,
 		 * if this "compression" doesn't work we need to drop.
 		 */
-		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
+		return addr != (dma_addr_t)netmem_get_dma_addr(netmem)
+				       << PAGE_SHIFT;
 	}
 
-	page->dma_addr = addr;
+	netmem_set_dma_addr(netmem, addr);
 	return false;
 }
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 965a7bc0a407..173158a3dd61 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -25,7 +25,7 @@
 
 #include "page_pool_priv.h"
 
-static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
 
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
@@ -334,7 +334,7 @@ page_pool_refill_alloc_cache(struct page_pool *pool)
 		if (unlikely(!netmem))
 			break;
 
-		if (likely(page_to_nid(netmem_to_page(netmem)) == pref_nid)) {
+		if (likely(netmem_is_pref_nid(netmem, pref_nid))) {
 			pool->alloc.cache[pool->alloc.count++] = netmem;
 		} else {
 			/* NUMA mismatch;
@@ -421,10 +421,8 @@ static bool page_pool_dma_map(struct page_pool *pool, struct netmem *netmem)
 
 static void page_pool_set_pp_info(struct page_pool *pool, struct netmem *netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	page->pp = pool;
-	page->pp_magic |= PP_SIGNATURE;
+	netmem_set_pp(netmem, pool);
+	netmem_or_pp_magic(netmem, PP_SIGNATURE);
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -439,10 +437,8 @@ static void page_pool_set_pp_info(struct page_pool *pool, struct netmem *netmem)
 
 static void page_pool_clear_pp_info(struct netmem *netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	page->pp_magic = 0;
-	page->pp = NULL;
+	netmem_clear_pp_magic(netmem);
+	netmem_set_pp(netmem, NULL);
 }
 
 static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
@@ -670,8 +666,9 @@ static bool page_pool_recycle_in_cache(struct netmem *netmem,
 
 static bool __page_pool_page_can_be_recycled(struct netmem *netmem)
 {
-	return page_ref_count(netmem_to_page(netmem)) == 1 &&
-	       !page_is_pfmemalloc(netmem_to_page(netmem));
+	return netmem_is_net_iov(netmem) ||
+	       (page_ref_count(netmem_to_page(netmem)) == 1 &&
+		!page_is_pfmemalloc(netmem_to_page(netmem)));
 }
 
 /* If the page refcnt == 1, this will try to recycle the page.
@@ -693,7 +690,7 @@ __page_pool_put_page(struct page_pool *pool, struct netmem *netmem,
 	 * refcnt == 1 means page_pool owns page, and can recycle it.
 	 *
 	 * page is NOT reusable when allocated when system is under
-	 * some pressure. (page_is_pfmemalloc)
+	 * some pressure. (page_pool_page_is_pfmemalloc)
 	 */
 	if (likely(__page_pool_page_can_be_recycled(netmem))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
@@ -709,6 +706,7 @@ __page_pool_put_page(struct page_pool *pool, struct netmem *netmem,
 		/* Page found as candidate for recycling */
 		return netmem;
 	}
+
 	/* Fallback/non-XDP mode: API user have elevated refcnt.
 	 *
 	 * Many drivers split up the page into fragments, and some
@@ -906,7 +904,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 	/* Empty recycle ring */
 	while ((netmem = ptr_ring_consume_bh(&pool->ring))) {
 		/* Verify the refcnt invariant of cached pages */
-		if (!(page_ref_count(netmem_to_page(netmem)) == 1))
+		if (!(netmem_ref_count(netmem) == 1))
 			pr_crit("%s() page_pool refcnt %d violation\n",
 				__func__, netmem_ref_count(netmem));
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab86799b7fe4..96f85543f1dc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -901,11 +901,10 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 bool napi_pp_put_page(struct netmem *netmem, bool napi_safe)
 {
-	struct page *page = netmem_to_page(netmem);
 	bool allow_direct = false;
 	struct page_pool *pp;
 
-	page = compound_head(page);
+	netmem = netmem_compound_head(netmem);
 
 	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
 	 * in order to preserve any existing bits, such as bit 0 for the
@@ -914,10 +913,10 @@ bool napi_pp_put_page(struct netmem *netmem, bool napi_safe)
 	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
 	 * to avoid recycling the pfmemalloc page.
 	 */
-	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
+	if (unlikely((netmem_get_pp_magic(netmem) & ~0x3UL) != PP_SIGNATURE))
 		return false;
 
-	pp = page->pp;
+	pp = netmem_get_pp(netmem);
 
 	/* Allow direct recycle if we have reasons to believe that we are
 	 * in the same context as the consumer would run, so there's
@@ -937,7 +936,7 @@ bool napi_pp_put_page(struct netmem *netmem, bool napi_safe)
 	 * The page will be returned to the pool here regardless of the
 	 * 'flipped' fragment being in use or not.
 	 */
-	page_pool_put_full_netmem(pp, page_to_netmem(page), allow_direct);
+	page_pool_put_full_netmem(pp, netmem, allow_direct);
 
 	return true;
 }
-- 
2.43.0.472.g3155946c3a-goog


