Return-Path: <linux-arch+bounces-1106-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CF0816475
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 03:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E900D1C2207B
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 02:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7C6FB5;
	Mon, 18 Dec 2023 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KiDuVyBp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB8539C
	for <linux-arch@vger.kernel.org>; Mon, 18 Dec 2023 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e471b1915dso29974057b3.2
        for <linux-arch@vger.kernel.org>; Sun, 17 Dec 2023 18:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702867233; x=1703472033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=goaaxpdo4bsNfCqF/IRbg9OCDHUZobJiFZIImpZ+yx8=;
        b=KiDuVyBpSqAKZrXxIilkzfl0cIDoRr8K2tNUpCk96bIY3jZlBZ3owgVr+8xxrMA4xD
         PEQ6gYqYaWutJFGoAZqVd96kn8iCfMvff8epiyGuWh8Y6EhM4OLH2gf49lxm5mT6lhir
         PVlh3GHgdja4tPnHgCrb8MAr30phqimI0FNSj8sIM/QvNPdeBPqENdKkVVfPwtwZvNXS
         Vkd52KPOGUDGseTKG5zWL9vq/HGu5AlXF2ltdh/EABWBVn79dszDVJfDdLF2wQbXT/zE
         tQfHitMpxSL+ZGcfuOrtSZczEL5Bi/sbdvI6ayCBsgZTZjc5o8bsDjdvUmqOObHVakQo
         7QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867233; x=1703472033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goaaxpdo4bsNfCqF/IRbg9OCDHUZobJiFZIImpZ+yx8=;
        b=JMFwxPwLLSW/ZqbPT0Ffu2rHm+UKy84v34gI2ZjDUsfaVxw6t2t2+oHLWFjjmBCTBB
         ucN9ANFfOeXBsf4aS6iABPux6upycSAc9pC+64P7IAvurse2fzeQ7YxKFePh3YSHUDMu
         fnrI3DgY4BZXcKzxrEeJTkcsltvzmFw7EXxEfkCdp/xsF+Fdt45qtc09yBhZIqgIceSD
         IwG+pORsFqSn08d81DeG3HV7G31KXN99V/3UpjxPSY4D3n+SL7oMHDMe9m1clltk87tJ
         qaPJv+SznBM9DYWpSpJUaNtAR5GkRWNeZfJRyODzwLLV2XR5IWVIgxiCPcBfhBKEgliK
         hMyg==
X-Gm-Message-State: AOJu0YyHEe9SW8ztmipIrtXC1AKZ6rs7uL/Tu7Ds+mHGH18WULvkoszw
	N4m9jYnOhwQFtAmaETN1S631GsNkwljg46VkCw==
X-Google-Smtp-Source: AGHT+IFUY8BpU9FYiO3qXLsrixI3f2KRzrpKPFLWGggPIyswomFyP7axWioDJ25jeinUYLtcPCBUeHTO/ThFJJoKRA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:5cbf:3534:fb34:758e])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:83:b0:5d7:29d7:8a35 with SMTP
 id be3-20020a05690c008300b005d729d78a35mr1936565ywb.5.1702867232915; Sun, 17
 Dec 2023 18:40:32 -0800 (PST)
Date: Sun, 17 Dec 2023 18:40:09 -0800
In-Reply-To: <20231218024024.3516870-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218024024.3516870-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218024024.3516870-3-almasrymina@google.com>
Subject: [RFC PATCH net-next v5 02/14] net: page_pool: factor out page_pool
 recycle check
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

The check is duplicated in 2 places, factor it out into a common helper.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 45bb4210412d..0edb9251d98d 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -657,6 +657,11 @@ static bool page_pool_recycle_in_cache(struct page *page,
 	return true;
 }
 
+static bool __page_pool_page_can_be_recycled(const struct page *page)
+{
+	return page_ref_count(page) == 1 && !page_is_pfmemalloc(page);
+}
+
 /* If the page refcnt == 1, this will try to recycle the page.
  * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
  * the configured size min(dma_sync_size, pool->max_len).
@@ -678,7 +683,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	 * page is NOT reusable when allocated when system is under
 	 * some pressure. (page_is_pfmemalloc)
 	 */
-	if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
+	if (likely(__page_pool_page_can_be_recycled(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
 		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
@@ -793,7 +798,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 	if (likely(page_pool_unref_page(page, drain_count)))
 		return NULL;
 
-	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
+	if (__page_pool_page_can_be_recycled(page)) {
 		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
 			page_pool_dma_sync_for_device(pool, page, -1);
 
-- 
2.43.0.472.g3155946c3a-goog


