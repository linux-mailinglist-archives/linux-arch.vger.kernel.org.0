Return-Path: <linux-arch+bounces-6308-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA179561CF
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 05:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644B41C213C8
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 03:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3760156F33;
	Mon, 19 Aug 2024 03:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmOAfAN3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D714B95A
	for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039707; cv=none; b=McJnANbVh5gBcH/+y0Ej/rzks4Zk97zKf4K54UHNslnUg1TB7vNaLQA2BcRWKbmv7Vzwm5tb+HwXM3iO7P7o9M28Gmvku/wTmwn1S4YiW/a6Z/J8dZHhAosKjhr84f1RQLI1qAryfO2oMr1CVuhqOMNXJqim2GNHFx25bNVuIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039707; c=relaxed/simple;
	bh=gMN9AEGl/tU7mJguTQFnV5nWGn8nv97MDcUJNs0s0ME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XfhUvDV9TcHyyRaBXezCtUv0WqhWFIJ07eQcktOU54L6yE4gNl5PPbs5sM1UZd4VcUQ4H8swccC5eMEnuRO4ZWcfvrVZmFmQA7IvZcpObsJ6yibYYudeU80yU8kfMV40iA7U6UQoUBu3nLBszYWyoYMLKq1/kQIMqmwYuCi+Okc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmOAfAN3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b4270bdea3so13683997b3.3
        for <linux-arch@vger.kernel.org>; Sun, 18 Aug 2024 20:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724039699; x=1724644499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaYAK8NUJ6Kxi9S9kkAihNBpX/4rdMC3FgQhGObFsxI=;
        b=lmOAfAN3xmBRx9nVNomYysiAxe2paz6ACbI3s0pXTlYLREk2t6s9eJnYa5Ep2+ivGn
         aDe8uEHaqTU21aVP1fuW7cVj9utSGNXCNmUw4v3vFAzbn5NFKic1V3SLLXu+3WY6A9AB
         Ez2Wq5qwWsYp1p8PdFLX+aKjPEZzE5XBGLkAOdUdKgEgWLRO83B6rS0n9sraa9+NvwHQ
         f8jW87Y321ex8nunCI6M5quuYQ8O2IYmkBw/btmCFsFV78d3Fli8xBQfQdu3nFudM8Dv
         GCK+2WWos/Qy6+7R6sLhfTki1kuEHrVsn6BRgpruqJrKDcE7OB0PdlGdHG5imctfh7+5
         cVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724039699; x=1724644499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaYAK8NUJ6Kxi9S9kkAihNBpX/4rdMC3FgQhGObFsxI=;
        b=Ucjl1uSdOO9vysxzl93fner48yk61V6aoS9QXYecPy0KNQ/ZUQjfN9TNXaqXvQ4+Ud
         CN2qdjU5Qn0S+U6Jxo5dZ78m6u7cTFV1pNcpnz7chzur5YYF/RuJhoGvzH35LtzoxiUr
         T+oYyYFltIQOEVI7EKCKaPQYm/67UAFsQMQdNpMvKXEFTqlCgfh9/P5LRChUxZ8g1exb
         qMpBQEi0/yf3rzgP3yL2LnlpN7DcVZWlNBFAqXLYT91CmnH9c+zrZTUvFdKCITQGs7kh
         YPDVBxOeYzbJWPsLGF8eL8j61r44HHQm05dYWk8NUMHS34JID/mHLeCrkj6JCa0pN/pM
         aqPw==
X-Forwarded-Encrypted: i=1; AJvYcCUTPXWfDKkUS3pNVgVMQcGLsBYQ64DMbs8GeMFX/zJK52uMVOAAIOqUVWRg54d6OjPlHFG+AIwU4zZHvFwcmi4e3N6hYBSoDi45AQ==
X-Gm-Message-State: AOJu0YxoSR63QUUq85yF4Gen1XVpKL2bwnSESnG/Jf5wHyLPAvN8U/mE
	HQ/BTZyMg3XuufJy5cKIIsCWdqu2xJUdgRFHzXT41dzxqPScROlGBFyW1zePn9Xw9eoronA9ZaF
	g1O/xQQoK7n2jBAIMRaLEuQ==
X-Google-Smtp-Source: AGHT+IGmpGd8VmpawRHB7EK7PyrXkTm5AubyX+HOQbnVBA4HCYVQ5AdShKXZWwc4tILaIcgDffSD8u/Bo5MO8O/QGg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:4988:b0:690:8ad7:55f9 with
 SMTP id 00721157ae682-6b1b749f085mr9670647b3.2.1724039699477; Sun, 18 Aug
 2024 20:54:59 -0700 (PDT)
Date: Mon, 19 Aug 2024 03:54:40 +0000
In-Reply-To: <20240819035448.2473195-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819035448.2473195-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819035448.2473195-6-almasrymina@google.com>
Subject: [PATCH net-next v20 05/13] page_pool: devmem support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>
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
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

---

v19:
- Move page_pool_set_dma_addr(_netmem) to page_pool_priv.h
- Don't reset niov dma_addr on allocation/free. Instead, it's set once
  when the binding happens and it never changes (Jakub)

v17:
- Rename netmem_to_pfn to netmem_pfn_trace (Jakub)
- Move some low level netmem helpers to netmem_priv.h (Jakub).

v13:
- Move NET_IOV dependent changes to this patch.
- Fixed comment (Pavel)
- Applied Reviewed-by from Pavel.

v9: https://lore.kernel.org/netdev/20240403002053.2376017-8-almasrymina@google.com/
- Remove CONFIG checks in netmem_is_net_iov() (Pavel/David/Jens)

v7:
- Remove static_branch_unlikely from netmem_to_net_iov(). We're getting
  better results from the fast path in bench_page_pool_simple tests
  without the static_branch_unlikely, and the addition of
  static_branch_unlikely doesn't improve performance of devmem TCP.

  Additionally only check netmem_to_net_iov() if
  CONFIG_DMA_SHARED_BUFFER is enabled, otherwise dmabuf net_iovs cannot
  exist anyway.

  net-next base: 8 cycle fast path.
  with static_branch_unlikely: 10 cycle fast path.
  without static_branch_unlikely: 9 cycle fast path.
  CONFIG_DMA_SHARED_BUFFER disabled: 8 cycle fast path as baseline.

  Performance of devmem TCP is at 95% line rate is regardless of
  static_branch_unlikely or not.

v6:
- Rebased on top of the merged netmem_ref type.
- Rebased on top of the merged skb_pp_frag_ref() changes.

v5:
- Use netmem instead of page* with LSB set.
- Use pp_ref_count for refcounting net_iov.
- Removed many of the custom checks for netmem.

v1:
- Disable fragmentation support for iov properly.
- fix napi_pp_put_page() path (Yunsheng).
- Use pp_frag_count for devmem refcounting.

Cc: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>

---
 include/net/netmem.h             | 129 +++++++++++++++++++++++++++++--
 include/net/page_pool/helpers.h  |  39 ++--------
 include/trace/events/page_pool.h |  12 +--
 net/core/devmem.c                |   8 ++
 net/core/netmem_priv.h           |  31 ++++++++
 net/core/page_pool.c             |  25 +++---
 net/core/page_pool_priv.h        |  26 +++++++
 net/core/skbuff.c                |  23 +++---
 8 files changed, 224 insertions(+), 69 deletions(-)
 create mode 100644 net/core/netmem_priv.h

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 0fbc0999091a..284f84a312c2 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -9,13 +9,51 @@
 #define _NET_NETMEM_H
 
 #include <net/devmem.h>
+#include <net/net_debug.h>
 
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
+	unsigned long dma_addr;
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
@@ -46,20 +84,37 @@ net_iov_binding(const struct net_iov *niov)
  */
 typedef unsigned long __bitwise netmem_ref;
 
+static inline bool netmem_is_net_iov(const netmem_ref netmem)
+{
+	return (__force unsigned long)netmem & NET_IOV;
+}
+
 /* This conversion fails (returns NULL) if the netmem_ref is not struct page
  * backed.
- *
- * Currently struct page is the only possible netmem, and this helper never
- * fails.
  */
 static inline struct page *netmem_to_page(netmem_ref netmem)
 {
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return NULL;
+
 	return (__force struct page *)netmem;
 }
 
-/* Converting from page to netmem is always safe, because a page can always be
- * a netmem.
- */
+static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return (struct net_iov *)((__force unsigned long)netmem &
+					  ~NET_IOV);
+
+	DEBUG_NET_WARN_ON_ONCE(true);
+	return NULL;
+}
+
+static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
+{
+	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
+}
+
 static inline netmem_ref page_to_netmem(struct page *page)
 {
 	return (__force netmem_ref)page;
@@ -67,17 +122,77 @@ static inline netmem_ref page_to_netmem(struct page *page)
 
 static inline int netmem_ref_count(netmem_ref netmem)
 {
+	/* The non-pp refcount of net_iov is always 1. On net_iov, we only
+	 * support pp refcounting which uses the pp_ref_count field.
+	 */
+	if (netmem_is_net_iov(netmem))
+		return 1;
+
 	return page_ref_count(netmem_to_page(netmem));
 }
 
-static inline unsigned long netmem_to_pfn(netmem_ref netmem)
+static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
 {
+	if (netmem_is_net_iov(netmem))
+		return 0;
+
 	return page_to_pfn(netmem_to_page(netmem));
 }
 
+static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
+{
+	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
+}
+
+static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
+{
+	return __netmem_clear_lsb(netmem)->pp;
+}
+
+static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
+{
+	return &__netmem_clear_lsb(netmem)->pp_ref_count;
+}
+
+static inline bool netmem_is_pref_nid(netmem_ref netmem, int pref_nid)
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
 static inline netmem_ref netmem_compound_head(netmem_ref netmem)
 {
+	/* niov are never compounded */
+	if (netmem_is_net_iov(netmem))
+		return netmem;
+
 	return page_to_netmem(compound_head(netmem_to_page(netmem)));
 }
 
+static inline void *netmem_address(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return NULL;
+
+	return page_address(netmem_to_page(netmem));
+}
+
+static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
+{
+	return __netmem_clear_lsb(netmem)->dma_addr;
+}
+
 #endif /* _NET_NETMEM_H */
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 2b43a893c619..793e6fd78bc5 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -216,7 +216,7 @@ page_pool_get_dma_dir(const struct page_pool *pool)
 
 static inline void page_pool_fragment_netmem(netmem_ref netmem, long nr)
 {
-	atomic_long_set(&netmem_to_page(netmem)->pp_ref_count, nr);
+	atomic_long_set(netmem_get_pp_ref_count_ref(netmem), nr);
 }
 
 /**
@@ -244,7 +244,7 @@ static inline void page_pool_fragment_page(struct page *page, long nr)
 
 static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
 {
-	struct page *page = netmem_to_page(netmem);
+	atomic_long_t *pp_ref_count = netmem_get_pp_ref_count_ref(netmem);
 	long ret;
 
 	/* If nr == pp_ref_count then we have cleared all remaining
@@ -261,19 +261,19 @@ static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
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
@@ -282,7 +282,7 @@ static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
 	 * page_pool_unref_page() currently.
 	 */
 	if (unlikely(!ret))
-		atomic_long_set(&page->pp_ref_count, 1);
+		atomic_long_set(pp_ref_count, 1);
 
 	return ret;
 }
@@ -401,9 +401,7 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
 
 static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	dma_addr_t ret = page->dma_addr;
+	dma_addr_t ret = netmem_get_dma_addr(netmem);
 
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
 		ret <<= PAGE_SHIFT;
@@ -423,24 +421,6 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 	return page_pool_get_dma_addr_netmem(page_to_netmem((struct page *)page));
 }
 
-static inline bool page_pool_set_dma_addr_netmem(netmem_ref netmem,
-						 dma_addr_t addr)
-{
-	struct page *page = netmem_to_page(netmem);
-
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
-		page->dma_addr = addr >> PAGE_SHIFT;
-
-		/* We assume page alignment to shave off bottom bits,
-		 * if this "compression" doesn't work we need to drop.
-		 */
-		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
-	}
-
-	page->dma_addr = addr;
-	return false;
-}
-
 /**
  * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
  * @pool: &page_pool the @page belongs to
@@ -463,11 +443,6 @@ static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
 				      page_pool_get_dma_dir(pool));
 }
 
-static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
-{
-	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
-}
-
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
diff --git a/include/trace/events/page_pool.h b/include/trace/events/page_pool.h
index 543e54e432a1..31825ed30032 100644
--- a/include/trace/events/page_pool.h
+++ b/include/trace/events/page_pool.h
@@ -57,12 +57,12 @@ TRACE_EVENT(page_pool_state_release,
 		__entry->pool		= pool;
 		__entry->netmem		= (__force unsigned long)netmem;
 		__entry->release	= release;
-		__entry->pfn		= netmem_to_pfn(netmem);
+		__entry->pfn		= netmem_pfn_trace(netmem);
 	),
 
-	TP_printk("page_pool=%p netmem=%p pfn=0x%lx release=%u",
+	TP_printk("page_pool=%p netmem=%p is_net_iov=%lu pfn=0x%lx release=%u",
 		  __entry->pool, (void *)__entry->netmem,
-		  __entry->pfn, __entry->release)
+		  __entry->netmem & NET_IOV, __entry->pfn, __entry->release)
 );
 
 TRACE_EVENT(page_pool_state_hold,
@@ -83,12 +83,12 @@ TRACE_EVENT(page_pool_state_hold,
 		__entry->pool	= pool;
 		__entry->netmem	= (__force unsigned long)netmem;
 		__entry->hold	= hold;
-		__entry->pfn	= netmem_to_pfn(netmem);
+		__entry->pfn	= netmem_pfn_trace(netmem);
 	),
 
-	TP_printk("page_pool=%p netmem=%p pfn=0x%lx hold=%u",
+	TP_printk("page_pool=%p netmem=%p is_net_iov=%lu, pfn=0x%lx hold=%u",
 		  __entry->pool, (void *)__entry->netmem,
-		  __entry->pfn, __entry->hold)
+		  __entry->netmem & NET_IOV, __entry->pfn, __entry->hold)
 );
 
 TRACE_EVENT(page_pool_update_nid,
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 88d188149148..301f4250ca82 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -19,6 +19,8 @@
 #include <net/devmem.h>
 #include <net/netdev_queues.h>
 
+#include "page_pool_priv.h"
+
 /* Device memory support */
 
 /* Protected by rtnl_lock() */
@@ -83,6 +85,10 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	index = offset / PAGE_SIZE;
 	niov = &owner->niovs[index];
 
+	niov->pp_magic = 0;
+	niov->pp = NULL;
+	atomic_long_set(&niov->pp_ref_count, 0);
+
 	return niov;
 }
 
@@ -255,6 +261,8 @@ struct net_devmem_dmabuf_binding *net_devmem_bind_dmabuf(struct net_device *dev,
 		for (i = 0; i < owner->num_niovs; i++) {
 			niov = &owner->niovs[i];
 			niov->owner = owner;
+			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
+						      net_devmem_get_dma_addr(niov));
 		}
 
 		virtual += len;
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
new file mode 100644
index 000000000000..7eadb8393e00
--- /dev/null
+++ b/net/core/netmem_priv.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __NETMEM_PRIV_H
+#define __NETMEM_PRIV_H
+
+static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
+{
+	return __netmem_clear_lsb(netmem)->pp_magic;
+}
+
+static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
+{
+	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
+}
+
+static inline void netmem_clear_pp_magic(netmem_ref netmem)
+{
+	__netmem_clear_lsb(netmem)->pp_magic = 0;
+}
+
+static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
+{
+	__netmem_clear_lsb(netmem)->pp = pool;
+}
+
+static inline void netmem_set_dma_addr(netmem_ref netmem,
+				       unsigned long dma_addr)
+{
+	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
+}
+#endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2abe6e919224..13277f05aebd 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -25,6 +25,9 @@
 #include <trace/events/page_pool.h>
 
 #include "page_pool_priv.h"
+#include "netmem_priv.h"
+
+DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
 
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
@@ -358,7 +361,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 		if (unlikely(!netmem))
 			break;
 
-		if (likely(page_to_nid(netmem_to_page(netmem)) == pref_nid)) {
+		if (likely(netmem_is_pref_nid(netmem, pref_nid))) {
 			pool->alloc.cache[pool->alloc.count++] = netmem;
 		} else {
 			/* NUMA mismatch;
@@ -454,10 +457,8 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 
 static void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	page->pp = pool;
-	page->pp_magic |= PP_SIGNATURE;
+	netmem_set_pp(netmem, pool);
+	netmem_or_pp_magic(netmem, PP_SIGNATURE);
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -472,10 +473,8 @@ static void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 
 static void page_pool_clear_pp_info(netmem_ref netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	page->pp_magic = 0;
-	page->pp = NULL;
+	netmem_clear_pp_magic(netmem);
+	netmem_set_pp(netmem, NULL);
 }
 
 static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
@@ -692,8 +691,9 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
 
 static bool __page_pool_page_can_be_recycled(netmem_ref netmem)
 {
-	return page_ref_count(netmem_to_page(netmem)) == 1 &&
-	       !page_is_pfmemalloc(netmem_to_page(netmem));
+	return netmem_is_net_iov(netmem) ||
+	       (page_ref_count(netmem_to_page(netmem)) == 1 &&
+		!page_is_pfmemalloc(netmem_to_page(netmem)));
 }
 
 /* If the page refcnt == 1, this will try to recycle the page.
@@ -728,6 +728,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 		/* Page found as candidate for recycling */
 		return netmem;
 	}
+
 	/* Fallback/non-XDP mode: API user have elevated refcnt.
 	 *
 	 * Many drivers split up the page into fragments, and some
@@ -949,7 +950,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 	/* Empty recycle ring */
 	while ((netmem = (__force netmem_ref)ptr_ring_consume_bh(&pool->ring))) {
 		/* Verify the refcnt invariant of cached pages */
-		if (!(page_ref_count(netmem_to_page(netmem)) == 1))
+		if (!(netmem_ref_count(netmem) == 1))
 			pr_crit("%s() page_pool refcnt %d violation\n",
 				__func__, netmem_ref_count(netmem));
 
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 90665d40f1eb..2142caeddb7c 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -3,10 +3,36 @@
 #ifndef __PAGE_POOL_PRIV_H
 #define __PAGE_POOL_PRIV_H
 
+#include <net/page_pool/helpers.h>
+
+#include "netmem_priv.h"
+
 s32 page_pool_inflight(const struct page_pool *pool, bool strict);
 
 int page_pool_list(struct page_pool *pool);
 void page_pool_detached(struct page_pool *pool);
 void page_pool_unlist(struct page_pool *pool);
 
+static inline bool page_pool_set_dma_addr_netmem(netmem_ref netmem,
+						 dma_addr_t addr)
+{
+	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
+		netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);
+
+		/* We assume page alignment to shave off bottom bits,
+		 * if this "compression" doesn't work we need to drop.
+		 */
+		return addr != (dma_addr_t)netmem_get_dma_addr(netmem)
+				       << PAGE_SHIFT;
+	}
+
+	netmem_set_dma_addr(netmem, addr);
+	return false;
+}
+
+static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
+{
+	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
+}
+
 #endif
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index de2a044cc665..9e2b28342793 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -89,6 +89,7 @@
 
 #include "dev.h"
 #include "sock_destructor.h"
+#include "netmem_priv.h"
 
 #ifdef CONFIG_SKB_EXTENSIONS
 static struct kmem_cache *skbuff_ext_cache __ro_after_init;
@@ -920,9 +921,9 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
-static bool is_pp_page(struct page *page)
+static bool is_pp_netmem(netmem_ref netmem)
 {
-	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
+	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
 }
 
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
@@ -1020,9 +1021,7 @@ EXPORT_SYMBOL(skb_cow_data_for_xdp);
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 bool napi_pp_put_page(netmem_ref netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	page = compound_head(page);
+	netmem = netmem_compound_head(netmem);
 
 	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
 	 * in order to preserve any existing bits, such as bit 0 for the
@@ -1031,10 +1030,10 @@ bool napi_pp_put_page(netmem_ref netmem)
 	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
 	 * to avoid recycling the pfmemalloc page.
 	 */
-	if (unlikely(!is_pp_page(page)))
+	if (unlikely(!is_pp_netmem(netmem)))
 		return false;
 
-	page_pool_put_full_netmem(page->pp, page_to_netmem(page), false);
+	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
 
 	return true;
 }
@@ -1061,7 +1060,7 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data)
 static int skb_pp_frag_ref(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo;
-	struct page *head_page;
+	netmem_ref head_netmem;
 	int i;
 
 	if (!skb->pp_recycle)
@@ -1070,11 +1069,11 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
 	shinfo = skb_shinfo(skb);
 
 	for (i = 0; i < shinfo->nr_frags; i++) {
-		head_page = compound_head(skb_frag_page(&shinfo->frags[i]));
-		if (likely(is_pp_page(head_page)))
-			page_pool_ref_page(head_page);
+		head_netmem = netmem_compound_head(shinfo->frags[i].netmem);
+		if (likely(is_pp_netmem(head_netmem)))
+			page_pool_ref_netmem(head_netmem);
 		else
-			page_ref_inc(head_page);
+			page_ref_inc(netmem_to_page(head_netmem));
 	}
 	return 0;
 }
-- 
2.46.0.184.g6999bdac58-goog


