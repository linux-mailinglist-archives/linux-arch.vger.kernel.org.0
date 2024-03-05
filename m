Return-Path: <linux-arch+bounces-2795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E357D8712F5
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 03:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953E9287852
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91717E76D;
	Tue,  5 Mar 2024 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GX69k/BQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691018050
	for <linux-arch@vger.kernel.org>; Tue,  5 Mar 2024 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604140; cv=none; b=n828/dT2K/W8AA4MZ1x+kERHhrVPdXoa0BSAHDVv1SGfjihk/fm++t8XTJehdLbTiaOzqgdml9MVbouqFbv5ZtT5hsux1C1CoAnFBQLhLaiB5qrstRI5INSCCiyQCYw9eQfEWM0AMRo4RBSBdfczCxRprbC1hV/Hc7VClSapRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604140; c=relaxed/simple;
	bh=Vv2jizFlOVkzYAt1FWGab7kiyqGN9r23pAJY49WnOXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=unvevw9Pg3QQELsKRq+3CxrEtfELqm5SbXqssjrIuxHMB9zq1GH+zj6T7yqfN/ZXcWSkSassXZ6b/iYbUs2iNNaCcOWcopx2x84VjJMCJY5eIZpkXvNNEptYLKaRQ6Q9No+kOjYV7biDaN8YWcVzupNCJ70c3dvqFEWxIhPLyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GX69k/BQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608d6ffc64eso73702027b3.0
        for <linux-arch@vger.kernel.org>; Mon, 04 Mar 2024 18:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709604133; x=1710208933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WoUKCLTApgXq+a8H0e+d6dQSKUG0H9nVqJcTPXo5myc=;
        b=GX69k/BQpoMxPy0dTRT9KZ14ioij0FTyQtrFgQqX9puZOnJPEU3TR0YnUlPfzZ5UNr
         4wyY4lu2SppDUjJUatL3BoI9wuA7b0KVlL8OEgy936DOs66dNQXM2mT6Ty2veBsLD2vY
         wvtoXR1UOOYnKtEew2X9jNHe56fCISaDsFsEnn6turAsr3IPKSgPDCwVtpZgnpLb3gYO
         hWeVfuR64i5xdZfYdUO+OrRV+Jb09dC/PtZ8xIkMWAxTSbWEHYbdXxIMj0lj1hp99sGb
         CuKSU+KTVfYwdueFI4v4tPNZaB2j7e/TueGLaR5dGUcR3/LM+oBAzXTmZ+CkFcymfTqf
         EaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604133; x=1710208933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoUKCLTApgXq+a8H0e+d6dQSKUG0H9nVqJcTPXo5myc=;
        b=GEjh+1WKMZT+9YWT8ub/XLBxm5KEzmsDB92Kqyb9liauxoZFiJY8InO1a+L7tKKcYX
         xti67Xc6XmAnh6kERBczoKcxMUSP4sb+pmlX1KzNpw83BmebTMoWP9QYEMtN14HLXMiW
         EtZ186u2fPWtiUIV690beFWF/HfRiNI2MkMLrM08vCN3cSxICxogBkdzi9R5uB7buAdi
         /CXMmCkCiZ3MP8rkcr4lKKJR0ewg72B3XH4g2d8ATWpEHJpdbsHjQ6xA5Jgj0grvtLuN
         TrqrMk5XOa+xDX3ihJkAkjsDdfc71shOVHHdq5ZGkSfYiR8dkgnVfb+26bIENdrx+JWF
         Zs8w==
X-Forwarded-Encrypted: i=1; AJvYcCUWhrDKGgUtYBpG0u+yHL9ZaFm4ys6c1skceXwpU3l7ccVieHaa3ZQCgGbX9CW3iUeb2ZbG95q9A4FW75nm4tt/ZrzXdkmR7XiBpQ==
X-Gm-Message-State: AOJu0Yx1fdm2tLbth8awh7yE2OV7xZdNPTUpYynAMBgEA1m33Re63cwS
	UxjNLj3hs7tElKJHQnOxUkpPQA5QNzErYtyL2+5fmCOd5Xz99neW5LF156bjRq1EPwSJTO9FJV1
	HrjMy/yPFPezYhk0RQwnqGg==
X-Google-Smtp-Source: AGHT+IFszfuUqxdsD+UsJ1LJDW7/3ZCBzE/018WgwSejEd1b5iuiNk77QPN+nlnf7d7IsR5EJgwQdTmnF0V71dATpg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b614:914c:63cd:3830])
 (user=almasrymina job=sendgmr) by 2002:a0d:cc52:0:b0:609:3a1f:e852 with SMTP
 id o79-20020a0dcc52000000b006093a1fe852mr242979ywd.2.1709604132756; Mon, 04
 Mar 2024 18:02:12 -0800 (PST)
Date: Mon,  4 Mar 2024 18:01:42 -0800
In-Reply-To: <20240305020153.2787423-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305020153.2787423-8-almasrymina@google.com>
Subject: [RFC PATCH net-next v6 07/15] page_pool: convert to use netmem
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
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

Abstrace the memory type from the page_pool so we can later add support
for new memory types. Convert the page_pool to use the new netmem type
abstraction, rather than use struct page directly.

As of this patch the netmem type is a no-op abstraction: it's always a
struct page underneath. All the page pool internals are converted to
use struct netmem instead of struct page, and the page pool now exports
2 APIs:

1. The existing struct page API.
2. The new struct netmem API.

Keeping the existing API is transitional; we do not want to refactor all
the current drivers using the page pool at once.

The netmem abstraction is currently a no-op. The page_pool uses
page_to_netmem() to convert allocated pages to netmem, and uses
netmem_to_page() to convert the netmem back to pages to pass to mm APIs,

Follow up patches to this series add non-paged netmem support to the
page_pool. This change is factored out on its own to limit the code
churn to this 1 patch, for ease of code review.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v6:

- Rebased on top of the merged netmem_ref type.

---
 include/linux/skbuff.h           |   4 +-
 include/net/netmem.h             |  15 ++
 include/net/page_pool/helpers.h  | 122 +++++++++----
 include/net/page_pool/types.h    |  17 +-
 include/trace/events/page_pool.h |  29 +--
 net/bpf/test_run.c               |   5 +-
 net/core/page_pool.c             | 303 +++++++++++++++++--------------
 net/core/skbuff.c                |   7 +-
 8 files changed, 302 insertions(+), 200 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d577e0bee18d..ca29d1fd4561 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3504,7 +3504,7 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom);
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 			 struct bpf_prog *prog);
-bool napi_pp_put_page(struct page *page, bool napi_safe);
+bool napi_pp_put_page(netmem_ref netmem, bool napi_safe);
 
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
@@ -3512,7 +3512,7 @@ napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 	struct page *page = skb_frag_page(frag);
 
 #ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page, napi_safe))
+	if (recycle && napi_pp_put_page(page_to_netmem(page), napi_safe))
 		return;
 #endif
 	put_page(page);
diff --git a/include/net/netmem.h b/include/net/netmem.h
index ca17ea1d33f8..21f53b29e5fe 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -88,4 +88,19 @@ static inline netmem_ref page_to_netmem(struct page *page)
 	return (__force netmem_ref)page;
 }
 
+static inline int netmem_ref_count(netmem_ref netmem)
+{
+	return page_ref_count(netmem_to_page(netmem));
+}
+
+static inline unsigned long netmem_to_pfn(netmem_ref netmem)
+{
+	return page_to_pfn(netmem_to_page(netmem));
+}
+
+static inline netmem_ref netmem_compound_head(netmem_ref netmem)
+{
+	return page_to_netmem(compound_head(netmem_to_page(netmem)));
+}
+
 #endif /* _NET_NETMEM_H */
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 1d397c1a0043..61814f91a458 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -53,6 +53,8 @@
 #define _NET_PAGE_POOL_HELPERS_H
 
 #include <net/page_pool/types.h>
+#include <net/net_debug.h>
+#include <net/netmem.h>
 
 #ifdef CONFIG_PAGE_POOL_STATS
 /* Deprecated driver-facing API, use netlink instead */
@@ -101,7 +103,7 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
  * Get a page fragment from the page allocator or page_pool caches.
  *
  * Return:
- * Return allocated page fragment, otherwise return NULL.
+ * Return allocated page fragment, otherwise return 0.
  */
 static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 						    unsigned int *offset,
@@ -112,22 +114,22 @@ static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 	return page_pool_alloc_frag(pool, offset, size, gfp);
 }
 
-static inline struct page *page_pool_alloc(struct page_pool *pool,
-					   unsigned int *offset,
-					   unsigned int *size, gfp_t gfp)
+static inline netmem_ref page_pool_alloc(struct page_pool *pool,
+					 unsigned int *offset,
+					 unsigned int *size, gfp_t gfp)
 {
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
-	struct page *page;
+	netmem_ref netmem;
 
 	if ((*size << 1) > max_size) {
 		*size = max_size;
 		*offset = 0;
-		return page_pool_alloc_pages(pool, gfp);
+		return page_pool_alloc_netmem(pool, gfp);
 	}
 
-	page = page_pool_alloc_frag(pool, offset, *size, gfp);
-	if (unlikely(!page))
-		return NULL;
+	netmem = page_pool_alloc_frag_netmem(pool, offset, *size, gfp);
+	if (unlikely(!netmem))
+		return 0;
 
 	/* There is very likely not enough space for another fragment, so append
 	 * the remaining size to the current fragment to avoid truesize
@@ -138,7 +140,7 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
 		pool->frag_offset = max_size;
 	}
 
-	return page;
+	return netmem;
 }
 
 /**
@@ -152,7 +154,7 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
  * utilization and performance penalty.
  *
  * Return:
- * Return allocated page or page fragment, otherwise return NULL.
+ * Return allocated page or page fragment, otherwise return 0.
  */
 static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
 					       unsigned int *offset,
@@ -160,7 +162,7 @@ static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
 {
 	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
 
-	return page_pool_alloc(pool, offset, size, gfp);
+	return netmem_to_page(page_pool_alloc(pool, offset, size, gfp));
 }
 
 static inline void *page_pool_alloc_va(struct page_pool *pool,
@@ -170,9 +172,10 @@ static inline void *page_pool_alloc_va(struct page_pool *pool,
 	struct page *page;
 
 	/* Mask off __GFP_HIGHMEM to ensure we can use page_address() */
-	page = page_pool_alloc(pool, &offset, size, gfp & ~__GFP_HIGHMEM);
+	page = netmem_to_page(
+		page_pool_alloc(pool, &offset, size, gfp & ~__GFP_HIGHMEM));
 	if (unlikely(!page))
-		return NULL;
+		return 0;
 
 	return page_address(page) + offset;
 }
@@ -187,7 +190,7 @@ static inline void *page_pool_alloc_va(struct page_pool *pool,
  * it returns va of the allocated page or page fragment.
  *
  * Return:
- * Return the va for the allocated page or page fragment, otherwise return NULL.
+ * Return the va for the allocated page or page fragment, otherwise return 0.
  */
 static inline void *page_pool_dev_alloc_va(struct page_pool *pool,
 					   unsigned int *size)
@@ -210,6 +213,11 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
 	return pool->p.dma_dir;
 }
 
+static inline void page_pool_fragment_netmem(netmem_ref netmem, long nr)
+{
+	atomic_long_set(&netmem_to_page(netmem)->pp_ref_count, nr);
+}
+
 /**
  * page_pool_fragment_page() - split a fresh page into fragments
  * @page:	page to split
@@ -230,11 +238,12 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
  */
 static inline void page_pool_fragment_page(struct page *page, long nr)
 {
-	atomic_long_set(&page->pp_ref_count, nr);
+	page_pool_fragment_netmem(page_to_netmem(page), nr);
 }
 
-static inline long page_pool_unref_page(struct page *page, long nr)
+static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
 {
+	struct page *page = netmem_to_page(netmem);
 	long ret;
 
 	/* If nr == pp_ref_count then we have cleared all remaining
@@ -277,15 +286,41 @@ static inline long page_pool_unref_page(struct page *page, long nr)
 	return ret;
 }
 
+static inline long page_pool_unref_page(struct page *page, long nr)
+{
+	return page_pool_unref_netmem(page_to_netmem(page), nr);
+}
+
+static inline void page_pool_ref_netmem(netmem_ref netmem)
+{
+	atomic_long_inc(&netmem_to_page(netmem)->pp_ref_count);
+}
+
 static inline void page_pool_ref_page(struct page *page)
 {
-	atomic_long_inc(&page->pp_ref_count);
+	page_pool_ref_netmem(page_to_netmem(page));
 }
 
-static inline bool page_pool_is_last_ref(struct page *page)
+static inline bool page_pool_is_last_ref(netmem_ref netmem)
 {
 	/* If page_pool_unref_page() returns 0, we were the last user */
-	return page_pool_unref_page(page, 1) == 0;
+	return page_pool_unref_netmem(netmem, 1) == 0;
+}
+
+static inline void page_pool_put_netmem(struct page_pool *pool,
+					netmem_ref netmem,
+					unsigned int dma_sync_size,
+					bool allow_direct)
+{
+	/* When page_pool isn't compiled-in, net/core/xdp.c doesn't
+	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
+	 */
+#ifdef CONFIG_PAGE_POOL
+	if (!page_pool_is_last_ref(netmem))
+		return;
+
+	page_pool_put_unrefed_netmem(pool, netmem, dma_sync_size, allow_direct);
+#endif
 }
 
 /**
@@ -306,15 +341,15 @@ static inline void page_pool_put_page(struct page_pool *pool,
 				      unsigned int dma_sync_size,
 				      bool allow_direct)
 {
-	/* When page_pool isn't compiled-in, net/core/xdp.c doesn't
-	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
-	 */
-#ifdef CONFIG_PAGE_POOL
-	if (!page_pool_is_last_ref(page))
-		return;
+	page_pool_put_netmem(pool, page_to_netmem(page), dma_sync_size,
+			     allow_direct);
+}
 
-	page_pool_put_unrefed_page(pool, page, dma_sync_size, allow_direct);
-#endif
+static inline void page_pool_put_full_netmem(struct page_pool *pool,
+					     netmem_ref netmem,
+					     bool allow_direct)
+{
+	page_pool_put_netmem(pool, netmem, -1, allow_direct);
 }
 
 /**
@@ -329,7 +364,7 @@ static inline void page_pool_put_page(struct page_pool *pool,
 static inline void page_pool_put_full_page(struct page_pool *pool,
 					   struct page *page, bool allow_direct)
 {
-	page_pool_put_page(pool, page, -1, allow_direct);
+	page_pool_put_netmem(pool, page_to_netmem(page), -1, allow_direct);
 }
 
 /**
@@ -363,6 +398,18 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
 	page_pool_put_page(pool, virt_to_head_page(va), -1, allow_direct);
 }
 
+static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
+{
+	struct page *page = netmem_to_page(netmem);
+
+	dma_addr_t ret = page->dma_addr;
+
+	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
+		ret <<= PAGE_SHIFT;
+
+	return ret;
+}
+
 /**
  * page_pool_get_dma_addr() - Retrieve the stored DMA address.
  * @page:	page allocated from a page pool
@@ -372,16 +419,14 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
  */
 static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
 {
-	dma_addr_t ret = page->dma_addr;
-
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
-		ret <<= PAGE_SHIFT;
-
-	return ret;
+	return page_pool_get_dma_addr_netmem(page_to_netmem(page));
 }
 
-static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
+static inline bool page_pool_set_dma_addr_netmem(netmem_ref netmem,
+						 dma_addr_t addr)
 {
+	struct page *page = netmem_to_page(netmem);
+
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
 		page->dma_addr = addr >> PAGE_SHIFT;
 
@@ -395,6 +440,11 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 	return false;
 }
 
+static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
+{
+	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
+}
+
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ffe5f31fb0da..68a24c5ae827 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -40,7 +40,7 @@
 #define PP_ALLOC_CACHE_REFILL	64
 struct pp_alloc_cache {
 	u32 count;
-	struct page *cache[PP_ALLOC_CACHE_SIZE];
+	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 };
 
 /**
@@ -73,7 +73,7 @@ struct page_pool_params {
 	struct_group_tagged(page_pool_params_slow, slow,
 		struct net_device *netdev;
 /* private: used by test code only */
-		void (*init_callback)(struct page *page, void *arg);
+		void (*init_callback)(netmem_ref netmem, void *arg);
 		void *init_arg;
 	);
 };
@@ -131,8 +131,8 @@ struct page_pool_stats {
 struct memory_provider_ops {
 	int (*init)(struct page_pool *pool);
 	void (*destroy)(struct page_pool *pool);
-	struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
-	bool (*release_page)(struct page_pool *pool, struct page *page);
+	netmem_ref (*alloc_pages)(struct page_pool *pool, gfp_t gfp);
+	bool (*release_page)(struct page_pool *pool, netmem_ref netmem);
 };
 
 struct page_pool {
@@ -142,7 +142,7 @@ struct page_pool {
 	bool has_init_callback;
 
 	long frag_users;
-	struct page *frag_page;
+	netmem_ref frag_page;
 	unsigned int frag_offset;
 	u32 pages_state_hold_cnt;
 
@@ -214,8 +214,12 @@ struct page_pool {
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
+netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp);
 struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
 				  unsigned int size, gfp_t gfp);
+netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
+				       unsigned int *offset, unsigned int size,
+				       gfp_t gfp);
 struct page_pool *page_pool_create(const struct page_pool_params *params);
 struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
 					  int cpuid);
@@ -245,6 +249,9 @@ static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 }
 #endif
 
+void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
+				  unsigned int dma_sync_size,
+				  bool allow_direct);
 void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
 				unsigned int dma_sync_size,
 				bool allow_direct);
diff --git a/include/trace/events/page_pool.h b/include/trace/events/page_pool.h
index 6834356b2d2a..c5b6383ff276 100644
--- a/include/trace/events/page_pool.h
+++ b/include/trace/events/page_pool.h
@@ -42,51 +42,52 @@ TRACE_EVENT(page_pool_release,
 TRACE_EVENT(page_pool_state_release,
 
 	TP_PROTO(const struct page_pool *pool,
-		 const struct page *page, u32 release),
+		 netmem_ref netmem, u32 release),
 
-	TP_ARGS(pool, page, release),
+	TP_ARGS(pool, netmem, release),
 
 	TP_STRUCT__entry(
 		__field(const struct page_pool *,	pool)
-		__field(const struct page *,		page)
+		__field(netmem_ref,			netmem)
 		__field(u32,				release)
 		__field(unsigned long,			pfn)
 	),
 
 	TP_fast_assign(
 		__entry->pool		= pool;
-		__entry->page		= page;
+		__entry->netmem		= netmem;
 		__entry->release	= release;
-		__entry->pfn		= page_to_pfn(page);
+		__entry->pfn		= netmem_to_pfn(netmem);
 	),
 
-	TP_printk("page_pool=%p page=%p pfn=0x%lx release=%u",
-		  __entry->pool, __entry->page, __entry->pfn, __entry->release)
+	TP_printk("page_pool=%p netmem=%lu pfn=0x%lx release=%u",
+		  __entry->pool, (__force unsigned long)__entry->netmem,
+		  __entry->pfn, __entry->release)
 );
 
 TRACE_EVENT(page_pool_state_hold,
 
 	TP_PROTO(const struct page_pool *pool,
-		 const struct page *page, u32 hold),
+		 netmem_ref netmem, u32 hold),
 
-	TP_ARGS(pool, page, hold),
+	TP_ARGS(pool, netmem, hold),
 
 	TP_STRUCT__entry(
 		__field(const struct page_pool *,	pool)
-		__field(const struct page *,		page)
+		__field(netmem_ref,			netmem)
 		__field(u32,				hold)
 		__field(unsigned long,			pfn)
 	),
 
 	TP_fast_assign(
 		__entry->pool	= pool;
-		__entry->page	= page;
+		__entry->netmem	= netmem;
 		__entry->hold	= hold;
-		__entry->pfn	= page_to_pfn(page);
+		__entry->pfn	= netmem_to_pfn(netmem);
 	),
 
-	TP_printk("page_pool=%p page=%p pfn=0x%lx hold=%u",
-		  __entry->pool, __entry->page, __entry->pfn, __entry->hold)
+	TP_printk("page_pool=%p netmem=%lu pfn=0x%lx hold=%u",
+		  __entry->pool, __entry->netmem, __entry->pfn, __entry->hold)
 );
 
 TRACE_EVENT(page_pool_update_nid,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 5535f9adc658..bc8f7ab88f86 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -126,9 +126,10 @@ struct xdp_test_data {
 #define TEST_XDP_FRAME_SIZE (PAGE_SIZE - sizeof(struct xdp_page_head))
 #define TEST_XDP_MAX_BATCH 256
 
-static void xdp_test_run_init_page(struct page *page, void *arg)
+static void xdp_test_run_init_page(netmem_ref netmem, void *arg)
 {
-	struct xdp_page_head *head = phys_to_virt(page_to_phys(page));
+	struct xdp_page_head *head =
+		phys_to_virt(page_to_phys(netmem_to_page(netmem)));
 	struct xdp_buff *new_ctx, *orig_ctx;
 	u32 headroom = XDP_PACKET_HEADROOM;
 	struct xdp_test_data *xdp = arg;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index fe9de4ecce94..24d5236b2efc 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -329,19 +329,18 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
 }
 EXPORT_SYMBOL(page_pool_create);
 
-static void page_pool_return_page(struct page_pool *pool, struct page *page);
+static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem);
 
-noinline
-static struct page *page_pool_refill_alloc_cache(struct page_pool *pool)
+static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 {
 	struct ptr_ring *r = &pool->ring;
-	struct page *page;
+	netmem_ref netmem;
 	int pref_nid; /* preferred NUMA node */
 
 	/* Quicker fallback, avoid locks when ring is empty */
 	if (__ptr_ring_empty(r)) {
 		alloc_stat_inc(pool, empty);
-		return NULL;
+		return 0;
 	}
 
 	/* Softirq guarantee CPU and thus NUMA node is stable. This,
@@ -356,56 +355,56 @@ static struct page *page_pool_refill_alloc_cache(struct page_pool *pool)
 
 	/* Refill alloc array, but only if NUMA match */
 	do {
-		page = __ptr_ring_consume(r);
-		if (unlikely(!page))
+		netmem = (__force netmem_ref)__ptr_ring_consume(r);
+		if (unlikely(!netmem))
 			break;
 
-		if (likely(page_to_nid(page) == pref_nid)) {
-			pool->alloc.cache[pool->alloc.count++] = page;
+		if (likely(page_to_nid(netmem_to_page(netmem)) == pref_nid)) {
+			pool->alloc.cache[pool->alloc.count++] = netmem;
 		} else {
 			/* NUMA mismatch;
 			 * (1) release 1 page to page-allocator and
 			 * (2) break out to fallthrough to alloc_pages_node.
 			 * This limit stress on page buddy alloactor.
 			 */
-			page_pool_return_page(pool, page);
+			page_pool_return_page(pool, netmem);
 			alloc_stat_inc(pool, waive);
-			page = NULL;
+			netmem = 0;
 			break;
 		}
 	} while (pool->alloc.count < PP_ALLOC_CACHE_REFILL);
 
 	/* Return last page */
 	if (likely(pool->alloc.count > 0)) {
-		page = pool->alloc.cache[--pool->alloc.count];
+		netmem = pool->alloc.cache[--pool->alloc.count];
 		alloc_stat_inc(pool, refill);
 	}
 
-	return page;
+	return netmem;
 }
 
 /* fast path */
-static struct page *__page_pool_get_cached(struct page_pool *pool)
+static netmem_ref __page_pool_get_cached(struct page_pool *pool)
 {
-	struct page *page;
+	netmem_ref netmem;
 
 	/* Caller MUST guarantee safe non-concurrent access, e.g. softirq */
 	if (likely(pool->alloc.count)) {
 		/* Fast-path */
-		page = pool->alloc.cache[--pool->alloc.count];
+		netmem = pool->alloc.cache[--pool->alloc.count];
 		alloc_stat_inc(pool, fast);
 	} else {
-		page = page_pool_refill_alloc_cache(pool);
+		netmem = page_pool_refill_alloc_cache(pool);
 	}
 
-	return page;
+	return netmem;
 }
 
 static void page_pool_dma_sync_for_device(struct page_pool *pool,
-					  struct page *page,
+					  netmem_ref netmem,
 					  unsigned int dma_sync_size)
 {
-	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
+	dma_addr_t dma_addr = page_pool_get_dma_addr_netmem(netmem);
 
 	dma_sync_size = min(dma_sync_size, pool->p.max_len);
 	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
@@ -413,7 +412,7 @@ static void page_pool_dma_sync_for_device(struct page_pool *pool,
 					 pool->p.dma_dir);
 }
 
-static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
+static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 {
 	dma_addr_t dma;
 
@@ -422,18 +421,18 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	 * into page private data (i.e 32bit cpu with 64bit DMA caps)
 	 * This mapping is kept for lifetime of page, until leaving pool.
 	 */
-	dma = dma_map_page_attrs(pool->p.dev, page, 0,
-				 (PAGE_SIZE << pool->p.order),
-				 pool->p.dma_dir, DMA_ATTR_SKIP_CPU_SYNC |
-						  DMA_ATTR_WEAK_ORDERING);
+	dma = dma_map_page_attrs(pool->p.dev, netmem_to_page(netmem), 0,
+				 (PAGE_SIZE << pool->p.order), pool->p.dma_dir,
+				 DMA_ATTR_SKIP_CPU_SYNC |
+					 DMA_ATTR_WEAK_ORDERING);
 	if (dma_mapping_error(pool->p.dev, dma))
 		return false;
 
-	if (page_pool_set_dma_addr(page, dma))
+	if (page_pool_set_dma_addr_netmem(netmem, dma))
 		goto unmap_failed;
 
 	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
-		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
+		page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
 
 	return true;
 
@@ -445,9 +444,10 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	return false;
 }
 
-static void page_pool_set_pp_info(struct page_pool *pool,
-				  struct page *page)
+static void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
+	struct page *page = netmem_to_page(netmem);
+
 	page->pp = pool;
 	page->pp_magic |= PP_SIGNATURE;
 
@@ -457,13 +457,15 @@ static void page_pool_set_pp_info(struct page_pool *pool,
 	 * is dirtying the same cache line as the page->pp_magic above, so
 	 * the overhead is negligible.
 	 */
-	page_pool_fragment_page(page, 1);
+	page_pool_fragment_netmem(netmem, 1);
 	if (pool->has_init_callback)
-		pool->slow.init_callback(page, pool->slow.init_arg);
+		pool->slow.init_callback(netmem, pool->slow.init_arg);
 }
 
-static void page_pool_clear_pp_info(struct page *page)
+static void page_pool_clear_pp_info(netmem_ref netmem)
 {
+	struct page *page = netmem_to_page(netmem);
+
 	page->pp_magic = 0;
 	page->pp = NULL;
 }
@@ -479,34 +481,34 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 		return NULL;
 
 	if ((pool->p.flags & PP_FLAG_DMA_MAP) &&
-	    unlikely(!page_pool_dma_map(pool, page))) {
+	    unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
 		put_page(page);
 		return NULL;
 	}
 
 	alloc_stat_inc(pool, slow_high_order);
-	page_pool_set_pp_info(pool, page);
+	page_pool_set_pp_info(pool, page_to_netmem(page));
 
 	/* Track how many pages are held 'in-flight' */
 	pool->pages_state_hold_cnt++;
-	trace_page_pool_state_hold(pool, page, pool->pages_state_hold_cnt);
+	trace_page_pool_state_hold(pool, page_to_netmem(page),
+				   pool->pages_state_hold_cnt);
 	return page;
 }
 
 /* slow path */
-noinline
-static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
-						 gfp_t gfp)
+static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
+							gfp_t gfp)
 {
 	const int bulk = PP_ALLOC_CACHE_REFILL;
 	unsigned int pp_flags = pool->p.flags;
 	unsigned int pp_order = pool->p.order;
-	struct page *page;
+	netmem_ref netmem;
 	int i, nr_pages;
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-		return __page_pool_alloc_page_order(pool, gfp);
+		return page_to_netmem(__page_pool_alloc_page_order(pool, gfp));
 
 	/* Unnecessary as alloc cache is empty, but guarantees zero count */
 	if (unlikely(pool->alloc.count > 0))
@@ -515,60 +517,67 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk_array */
 	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
 
-	nr_pages = alloc_pages_bulk_array_node(gfp, pool->p.nid, bulk,
-					       pool->alloc.cache);
+	nr_pages = alloc_pages_bulk_array_node(gfp,
+					       pool->p.nid, bulk,
+					       (struct page **)pool->alloc.cache);
 	if (unlikely(!nr_pages))
-		return NULL;
+		return 0;
 
 	/* Pages have been filled into alloc.cache array, but count is zero and
 	 * page element have not been (possibly) DMA mapped.
 	 */
 	for (i = 0; i < nr_pages; i++) {
-		page = pool->alloc.cache[i];
+		netmem = pool->alloc.cache[i];
 		if ((pp_flags & PP_FLAG_DMA_MAP) &&
-		    unlikely(!page_pool_dma_map(pool, page))) {
-			put_page(page);
+		    unlikely(!page_pool_dma_map(pool, netmem))) {
+			put_page(netmem_to_page(netmem));
 			continue;
 		}
 
-		page_pool_set_pp_info(pool, page);
-		pool->alloc.cache[pool->alloc.count++] = page;
+		page_pool_set_pp_info(pool, netmem);
+		pool->alloc.cache[pool->alloc.count++] = netmem;
 		/* Track how many pages are held 'in-flight' */
 		pool->pages_state_hold_cnt++;
-		trace_page_pool_state_hold(pool, page,
+		trace_page_pool_state_hold(pool, netmem,
 					   pool->pages_state_hold_cnt);
 	}
 
 	/* Return last page */
 	if (likely(pool->alloc.count > 0)) {
-		page = pool->alloc.cache[--pool->alloc.count];
+		netmem = pool->alloc.cache[--pool->alloc.count];
 		alloc_stat_inc(pool, slow);
 	} else {
-		page = NULL;
+		netmem = 0;
 	}
 
 	/* When page just alloc'ed is should/must have refcnt 1. */
-	return page;
+	return netmem;
 }
 
 /* For using page_pool replace: alloc_pages() API calls, but provide
  * synchronization guarantee for allocation side.
  */
-struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
+netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
 {
-	struct page *page;
+	netmem_ref netmem;
 
 	/* Fast-path: Get a page from cache */
-	page = __page_pool_get_cached(pool);
-	if (page)
-		return page;
+	netmem = __page_pool_get_cached(pool);
+	if (netmem)
+		return netmem;
 
 	/* Slow-path: cache empty, do real allocation */
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
-		page = pool->mp_ops->alloc_pages(pool, gfp);
+		netmem = pool->mp_ops->alloc_pages(pool, gfp);
 	else
-		page = __page_pool_alloc_pages_slow(pool, gfp);
-	return page;
+		netmem = __page_pool_alloc_pages_slow(pool, gfp);
+	return netmem;
+}
+EXPORT_SYMBOL(page_pool_alloc_netmem);
+
+struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
+{
+	return netmem_to_page(page_pool_alloc_netmem(pool, gfp));
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
 
@@ -596,8 +605,8 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 	return inflight;
 }
 
-static __always_inline
-void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
+static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
+							 netmem_ref netmem)
 {
 	dma_addr_t dma;
 
@@ -607,13 +616,13 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
 		 */
 		return;
 
-	dma = page_pool_get_dma_addr(page);
+	dma = page_pool_get_dma_addr_netmem(netmem);
 
 	/* When page is unmapped, it cannot be returned to our pool */
 	dma_unmap_page_attrs(pool->p.dev, dma,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
-	page_pool_set_dma_addr(page, 0);
+	page_pool_set_dma_addr_netmem(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -621,26 +630,26 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
  * a regular page (that will eventually be returned to the normal
  * page-allocator via put_page).
  */
-void page_pool_return_page(struct page_pool *pool, struct page *page)
+void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 {
 	int count;
 	bool put;
 
 	put = true;
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
-		put = pool->mp_ops->release_page(pool, page);
+		put = pool->mp_ops->release_page(pool, netmem);
 	else
-		__page_pool_release_page_dma(pool, page);
+		__page_pool_release_page_dma(pool, netmem);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
 	 */
 	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
-	trace_page_pool_state_release(pool, page, count);
+	trace_page_pool_state_release(pool, netmem, count);
 
 	if (put) {
-		page_pool_clear_pp_info(page);
-		put_page(page);
+		page_pool_clear_pp_info(netmem);
+		put_page(netmem_to_page(netmem));
 	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
@@ -648,14 +657,14 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
 	 */
 }
 
-static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
+static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
 {
 	int ret;
 	/* BH protection not needed if current is softirq */
 	if (in_softirq())
-		ret = ptr_ring_produce(&pool->ring, page);
+		ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
 	else
-		ret = ptr_ring_produce_bh(&pool->ring, page);
+		ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
 
 	if (!ret) {
 		recycle_stat_inc(pool, ring);
@@ -670,7 +679,7 @@ static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
  *
  * Caller must provide appropriate safe context.
  */
-static bool page_pool_recycle_in_cache(struct page *page,
+static bool page_pool_recycle_in_cache(netmem_ref netmem,
 				       struct page_pool *pool)
 {
 	if (unlikely(pool->alloc.count == PP_ALLOC_CACHE_SIZE)) {
@@ -679,14 +688,15 @@ static bool page_pool_recycle_in_cache(struct page *page,
 	}
 
 	/* Caller MUST have verified/know (page_ref_count(page) == 1) */
-	pool->alloc.cache[pool->alloc.count++] = page;
+	pool->alloc.cache[pool->alloc.count++] = netmem;
 	recycle_stat_inc(pool, cached);
 	return true;
 }
 
-static bool __page_pool_page_can_be_recycled(const struct page *page)
+static bool __page_pool_page_can_be_recycled(netmem_ref netmem)
 {
-	return page_ref_count(page) == 1 && !page_is_pfmemalloc(page);
+	return page_ref_count(netmem_to_page(netmem)) == 1 &&
+	       !page_is_pfmemalloc(netmem_to_page(netmem));
 }
 
 /* If the page refcnt == 1, this will try to recycle the page.
@@ -695,8 +705,8 @@ static bool __page_pool_page_can_be_recycled(const struct page *page)
  * If the page refcnt != 1, then the page will be returned to memory
  * subsystem.
  */
-static __always_inline struct page *
-__page_pool_put_page(struct page_pool *pool, struct page *page,
+static __always_inline netmem_ref
+__page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 		     unsigned int dma_sync_size, bool allow_direct)
 {
 	lockdep_assert_no_hardirq();
@@ -710,19 +720,19 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	 * page is NOT reusable when allocated when system is under
 	 * some pressure. (page_is_pfmemalloc)
 	 */
-	if (likely(__page_pool_page_can_be_recycled(page))) {
+	if (likely(__page_pool_page_can_be_recycled(netmem))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
 		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
-			page_pool_dma_sync_for_device(pool, page,
+			page_pool_dma_sync_for_device(pool, netmem,
 						      dma_sync_size);
 
 		if (allow_direct && in_softirq() &&
-		    page_pool_recycle_in_cache(page, pool))
-			return NULL;
+		    page_pool_recycle_in_cache(netmem, pool))
+			return 0;
 
 		/* Page found as candidate for recycling */
-		return page;
+		return netmem;
 	}
 	/* Fallback/non-XDP mode: API user have elevated refcnt.
 	 *
@@ -738,21 +748,30 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	 * will be invoking put_page.
 	 */
 	recycle_stat_inc(pool, released_refcnt);
-	page_pool_return_page(pool, page);
+	page_pool_return_page(pool, netmem);
 
-	return NULL;
+	return 0;
 }
 
-void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
-				unsigned int dma_sync_size, bool allow_direct)
+void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
+				  unsigned int dma_sync_size, bool allow_direct)
 {
-	page = __page_pool_put_page(pool, page, dma_sync_size, allow_direct);
-	if (page && !page_pool_recycle_in_ring(pool, page)) {
+	netmem =
+		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
+	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
-		page_pool_return_page(pool, page);
+		page_pool_return_page(pool, netmem);
 	}
 }
+EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
+
+void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
+				unsigned int dma_sync_size, bool allow_direct)
+{
+	page_pool_put_unrefed_netmem(pool, page_to_netmem(page), dma_sync_size,
+				     allow_direct);
+}
 EXPORT_SYMBOL(page_pool_put_unrefed_page);
 
 /**
@@ -777,16 +796,16 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	bool in_softirq;
 
 	for (i = 0; i < count; i++) {
-		struct page *page = virt_to_head_page(data[i]);
+		netmem_ref netmem = page_to_netmem(virt_to_head_page(data[i]));
 
 		/* It is not the last user for the page frag case */
-		if (!page_pool_is_last_ref(page))
+		if (!page_pool_is_last_ref(netmem))
 			continue;
 
-		page = __page_pool_put_page(pool, page, -1, false);
+		netmem = __page_pool_put_page(pool, netmem, -1, false);
 		/* Approved for bulk recycling in ptr_ring cache */
-		if (page)
-			data[bulk_len++] = page;
+		if (netmem)
+			data[bulk_len++] = (__force void *)netmem;
 	}
 
 	if (unlikely(!bulk_len))
@@ -812,100 +831,108 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	 * since put_page() with refcnt == 1 can be an expensive operation
 	 */
 	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, data[i]);
+		page_pool_return_page(pool, (__force netmem_ref)data[i]);
 }
 EXPORT_SYMBOL(page_pool_put_page_bulk);
 
-static struct page *page_pool_drain_frag(struct page_pool *pool,
-					 struct page *page)
+static netmem_ref page_pool_drain_frag(struct page_pool *pool,
+				       netmem_ref netmem)
 {
 	long drain_count = BIAS_MAX - pool->frag_users;
 
 	/* Some user is still using the page frag */
-	if (likely(page_pool_unref_page(page, drain_count)))
-		return NULL;
+	if (likely(page_pool_unref_netmem(netmem, drain_count)))
+		return 0;
 
-	if (__page_pool_page_can_be_recycled(page)) {
+	if (__page_pool_page_can_be_recycled(netmem)) {
 		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
-			page_pool_dma_sync_for_device(pool, page, -1);
+			page_pool_dma_sync_for_device(pool, netmem, -1);
 
-		return page;
+		return netmem;
 	}
 
-	page_pool_return_page(pool, page);
-	return NULL;
+	page_pool_return_page(pool, netmem);
+	return 0;
 }
 
 static void page_pool_free_frag(struct page_pool *pool)
 {
 	long drain_count = BIAS_MAX - pool->frag_users;
-	struct page *page = pool->frag_page;
+	netmem_ref netmem = pool->frag_page;
 
-	pool->frag_page = NULL;
+	pool->frag_page = 0;
 
-	if (!page || page_pool_unref_page(page, drain_count))
+	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
 		return;
 
-	page_pool_return_page(pool, page);
+	page_pool_return_page(pool, netmem);
 }
 
-struct page *page_pool_alloc_frag(struct page_pool *pool,
-				  unsigned int *offset,
-				  unsigned int size, gfp_t gfp)
+netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
+				       unsigned int *offset, unsigned int size,
+				       gfp_t gfp)
 {
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
-	struct page *page = pool->frag_page;
+	netmem_ref netmem = pool->frag_page;
 
 	if (WARN_ON(size > max_size))
-		return NULL;
+		return 0;
 
 	size = ALIGN(size, dma_get_cache_alignment());
 	*offset = pool->frag_offset;
 
-	if (page && *offset + size > max_size) {
-		page = page_pool_drain_frag(pool, page);
-		if (page) {
+	if (netmem && *offset + size > max_size) {
+		netmem = page_pool_drain_frag(pool, netmem);
+		if (netmem) {
 			alloc_stat_inc(pool, fast);
 			goto frag_reset;
 		}
 	}
 
-	if (!page) {
-		page = page_pool_alloc_pages(pool, gfp);
-		if (unlikely(!page)) {
-			pool->frag_page = NULL;
-			return NULL;
+	if (!netmem) {
+		netmem = page_pool_alloc_netmem(pool, gfp);
+		if (unlikely(!netmem)) {
+			pool->frag_page = 0;
+			return 0;
 		}
 
-		pool->frag_page = page;
+		pool->frag_page = netmem;
 
 frag_reset:
 		pool->frag_users = 1;
 		*offset = 0;
 		pool->frag_offset = size;
-		page_pool_fragment_page(page, BIAS_MAX);
-		return page;
+		page_pool_fragment_netmem(netmem, BIAS_MAX);
+		return netmem;
 	}
 
 	pool->frag_users++;
 	pool->frag_offset = *offset + size;
 	alloc_stat_inc(pool, fast);
-	return page;
+	return netmem;
+}
+EXPORT_SYMBOL(page_pool_alloc_frag_netmem);
+
+struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
+				  unsigned int size, gfp_t gfp)
+{
+	return netmem_to_page(page_pool_alloc_frag_netmem(pool, offset, size,
+							  gfp));
 }
 EXPORT_SYMBOL(page_pool_alloc_frag);
 
 static void page_pool_empty_ring(struct page_pool *pool)
 {
-	struct page *page;
+	netmem_ref netmem;
 
 	/* Empty recycle ring */
-	while ((page = ptr_ring_consume_bh(&pool->ring))) {
+	while ((netmem = (__force netmem_ref)ptr_ring_consume_bh(&pool->ring))) {
 		/* Verify the refcnt invariant of cached pages */
-		if (!(page_ref_count(page) == 1))
+		if (!(page_ref_count(netmem_to_page(netmem)) == 1))
 			pr_crit("%s() page_pool refcnt %d violation\n",
-				__func__, page_ref_count(page));
+				__func__, netmem_ref_count(netmem));
 
-		page_pool_return_page(pool, page);
+		page_pool_return_page(pool, netmem);
 	}
 }
 
@@ -927,7 +954,7 @@ static void __page_pool_destroy(struct page_pool *pool)
 
 static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 {
-	struct page *page;
+	netmem_ref netmem;
 
 	if (pool->destroy_cnt)
 		return;
@@ -937,8 +964,8 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 	 * call concurrently.
 	 */
 	while (pool->alloc.count) {
-		page = pool->alloc.cache[--pool->alloc.count];
-		page_pool_return_page(pool, page);
+		netmem = pool->alloc.cache[--pool->alloc.count];
+		page_pool_return_page(pool, netmem);
 	}
 }
 
@@ -1044,15 +1071,15 @@ EXPORT_SYMBOL(page_pool_destroy);
 /* Caller must provide appropriate safe context, e.g. NAPI. */
 void page_pool_update_nid(struct page_pool *pool, int new_nid)
 {
-	struct page *page;
+	netmem_ref netmem;
 
 	trace_page_pool_update_nid(pool, new_nid);
 	pool->p.nid = new_nid;
 
 	/* Flush pool alloc cache, as refill will check NUMA node */
 	while (pool->alloc.count) {
-		page = pool->alloc.cache[--pool->alloc.count];
-		page_pool_return_page(pool, page);
+		netmem = pool->alloc.cache[--pool->alloc.count];
+		page_pool_return_page(pool, netmem);
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1f918e602bc4..e1118b637085 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1006,8 +1006,9 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 EXPORT_SYMBOL(skb_cow_data_for_xdp);
 
 #if IS_ENABLED(CONFIG_PAGE_POOL)
-bool napi_pp_put_page(struct page *page, bool napi_safe)
+bool napi_pp_put_page(netmem_ref netmem, bool napi_safe)
 {
+	struct page *page = netmem_to_page(netmem);
 	bool allow_direct = false;
 	struct page_pool *pp;
 
@@ -1044,7 +1045,7 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
 	 * The page will be returned to the pool here regardless of the
 	 * 'flipped' fragment being in use or not.
 	 */
-	page_pool_put_full_page(pp, page, allow_direct);
+	page_pool_put_full_netmem(pp, page_to_netmem(page), allow_direct);
 
 	return true;
 }
@@ -1055,7 +1056,7 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 {
 	if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
 		return false;
-	return napi_pp_put_page(virt_to_page(data), napi_safe);
+	return napi_pp_put_page(page_to_netmem(virt_to_page(data)), napi_safe);
 }
 
 /**
-- 
2.44.0.rc1.240.g4c46232300-goog


