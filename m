Return-Path: <linux-arch+bounces-770-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D249980980D
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 01:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0216E1C20CCB
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 00:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9574C522A;
	Fri,  8 Dec 2023 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tItI9ksJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721271717
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 16:53:16 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3911218b3so17599457b3.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 16:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701996795; x=1702601595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPnDX1rYMAtCe+hQ8qdPonfWEnFnkE5EPZQcdSbkY2c=;
        b=tItI9ksJxKZZeSA4cIlz1awMH257FvktV3a5FQasmksOiVe6EDUTdc38DlVmY9AMUv
         1yUbt++nhyY11JmQKVKMdqq/CKI60A8ETh2zdhXhofyLY1NvfvxI27vAS+LaBEfcsC0m
         dMAr4tkoEokr4qCBaTMo4v6nkfqhHxyI7j+wwuw3MRT2niwmzCRi6fGzm0jpDy+wGnvE
         PZvJaSLBlM5QaFpeBtM0oCVky9+C8Jg5N9L//cguRIlLlMuU524zOQUz7g3+6xyaACVK
         H4SLrLLPCGbX164C9j9lRBfetzidTop22PysOSNLg7487MDm0dggC/tegdH5rd8KCgry
         Sp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996795; x=1702601595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPnDX1rYMAtCe+hQ8qdPonfWEnFnkE5EPZQcdSbkY2c=;
        b=pUY/G5W0sj6ExTnu1aW2kIA1FRAr3rKutQYtBGxaFJQcoLxHYYzTnMz2rGCO4u9Idc
         XHkL5xnnrQGr5yRcFyH0zyxvnHEcPxwcBRoZs748AXXZK+Wm79LQivLM1A8CnXLNFLc1
         GDjUxOKzlGXMJqo7OPPpgMiPzUN2+0Lt8Tqzdw7r43P8CWVdq1OoVIGa6BGTGiaJznOJ
         55a/3hkvchuUB+YooySACwwzgUiTSNayuSbZg6GwnqN4xNpbqSxAkBo7DP7WHvxgE570
         cvghTRDQAWUk7pNF2hCkyXNLxI86hjlKImz5Ftc3JQ00s0eDcYj3WHkxWrQm1UkBLt7C
         Dn3A==
X-Gm-Message-State: AOJu0YyzsMb5Z4916o8jgbzerxWqlZcPMfYZY+hYtATmS6mEyY2/dgeO
	RWk0y5Ta1cqH+985btH9O6n3ZtvFX16iNpo67Q==
X-Google-Smtp-Source: AGHT+IEKP0wg/owThAA3/mC6Vxrn1R6Pw24Bozp4eJkoXp2s6/m2Qgw2X1bYwO4di4FgizGGC3rWfu0KjgUDlNjaXA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:f1cf:c733:235b:9fff])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:4707:b0:5d4:ce2:e908 with
 SMTP id gz7-20020a05690c470700b005d40ce2e908mr53364ywb.3.1701996795620; Thu,
 07 Dec 2023 16:53:15 -0800 (PST)
Date: Thu,  7 Dec 2023 16:52:41 -0800
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208005250.2910004-11-almasrymina@google.com>
Subject: [net-next v1 10/16] page_pool: don't release iov on elevanted refcount
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
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently the page_pool behavior is that a page is considered for
recycling only once, the first time __page_pool_put_page() is called on
it.

This works because in practice the net stack only holds 1 reference to
the skb frags. In that case, the page_pool recycling works as expected,
as the skb frags will have 1 reference on the pages from the net stack
when __page_pool_put_page() is called (if the driver is not holding
extra references for recycling), and so the page will be recycled.

However, this is not compatible with devmem TCP. For devmem TCP, the net
stack holds 2 references for each frag, 1 reference is part of the SKB,
and the second reference is for the user holding the frag until they
call SO_DEVMEM_DONTNEED. This causes a bug in the page_pool recycling
where, when the skb is freed, the reference count goes from 2->1, the
page_pool sees a pending reference, releases the page, and so no devmem
iovs get recycled.

To fix this, don't release iovs on elevated refcount.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f0148d66371b..dc2a148f5b06 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -731,6 +731,29 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 		/* Page found as candidate for recycling */
 		return page;
 	}
+
+	if (page_is_page_pool_iov(page)) {
+		/* With devmem TCP and ppiovs, we can't release pages if the
+		 * refcount is > 1. This is because the net stack holds
+		 * 2 references:
+		 *	- 1 for the skb, and
+		 *	- 1 for the user until they call SO_DEVMEM_DONTNEED.
+		 * Releasing pages for elevated refcounts completely disables
+		 * page_pool recycling. Instead, simply don't release pages and
+		 * the next call to napi_pp_put_page() via SO_DEVMEM_DONTNEED
+		 * will consider the page again for recycling. As a result,
+		 * devmem TCP incompatible with drivers doing refcnt based
+		 * recycling unless those drivers:
+		 *
+		 * - don't mark skb_mark_for_recycle()
+		 * - are sure to release the last reference with
+		 *   page_pool_put_full_page() to consider the page for
+		 *   page_pool recycling.
+		 */
+		page_pool_page_put_many(page, 1);
+		return NULL;
+	}
+
 	/* Fallback/non-XDP mode: API user have elevated refcnt.
 	 *
 	 * Many drivers split up the page into fragments, and some
-- 
2.43.0.472.g3155946c3a-goog


